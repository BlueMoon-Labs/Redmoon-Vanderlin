// tgui/packages/tgui/interfaces/InteractMenu.tsx

import { useState } from 'react';
import {
  Box,
  Button,
  ProgressBar,
  Section,
  Stack,
  ByondUi,
} from 'tgui-core/components';
import { Window } from '../layouts';
import { useBackend } from '../backend';

type TabId = 'main' | 'builder';

const BODY_PART_LABELS: Record<BodyPartId, string> = {
  head: 'Голова',
  chest: 'Торс',
  groin: 'Пах',
  left_arm: 'Левая рука',
  right_arm: 'Правая рука',
  left_leg: 'Левая нога',
  right_leg: 'Правая нога',
  tail: 'Хвост',
};

type BodyPartId =
  | 'head'
  | 'chest'
  | 'groin'
  | 'left_arm'
  | 'right_arm'
  | 'left_leg'
  | 'right_leg'
  | 'tail';

interface InteractionAction {
  id: string;          // byond path или уникальный id
  name: string;        // отображаемое название действия
}

type InteractionActionsByPart = {
  [K in BodyPartId]?: InteractionAction[];
};

interface InteractMenuData {
  entity_from: string;
  entity_to: string;
  character_ref: any;
  actions_by_part: InteractionActionsByPart;
  all_actions_by_part?: InteractionActionsByPart;
  favorite_actions?: string[];
  lust?: number;
  lust_max?: number;
  lust_progress?: number;
  auto_running?: boolean;
  auto_action_id?: string;
  auto_interval?: number;
}

export const InteractMenu = (props, context) => {
  const { data, config, act } = useBackend<InteractMenuData>();
  const { entity_from, entity_to, character_ref } = data;

  const [selectedPart, setSelectedPart] = useState<BodyPartId>('chest');
  const [activeTab, setActiveTab] = useState<TabId>('main');
  const [showHitboxes, setShowHitboxes] = useState(false);

  const progressValue =
    typeof data.lust_progress === 'number' ? data.lust_progress : 0;
  const autoRunning = !!data.auto_running;
  const autoActionId = data.auto_action_id || '';

  const runAction = (actionId: string) => {
    if (autoRunning && autoActionId === actionId && duration > 0) {
      act('stop_auto_action');
      return;
    }
    act('run_action_once', {
      part: selectedPart,
      action_id: actionId,
      duration,
    });
  };

  const handleMouseOver = (e: React.MouseEvent<HTMLDivElement>) => {
    e.currentTarget.style.border = '2px solid #fff';
  };

  const handleMouseLeave = (e: React.MouseEvent<HTMLDivElement>) => {
    e.currentTarget.style.border = '2px solid transparent';
  };

  // Длительность действия (слайдер снизу)
  const [duration, setDuration] = useState(0.0);

  if (config.status < 2) {
    return null;
  }
  const actions = data.actions_by_part?.[selectedPart] || [];
  const allActionsForPart = data.all_actions_by_part?.[selectedPart] || [];
  const favoriteActions = Array.isArray(data.favorite_actions)
    ? data.favorite_actions
    : [];
  const favoriteSet = new Set(favoriteActions);
  const preferredActionsForPart = allActionsForPart.filter((action) =>
    favoriteSet.has(action.id),
  );
  const availableActionsForPart = allActionsForPart.filter(
    (action) => !favoriteSet.has(action.id),
  );

  return (
    <Window title="Взаимодействие с телом" width={1000} height={800}>
      <Window.Content>
        <Stack vertical fill>
          {/* Верхняя панель */}
          <Stack.Item>
            <Section>
              <Stack vertical>
                <Stack.Item>
                  <Box textAlign="center" bold>
                    {(entity_from || 'Сущность 1') +
                      ' --> ' +
                      (entity_to || 'Сущность 2')}
                  </Box>
                </Stack.Item>
                <Stack.Item>
                  <ProgressBar
                    value={progressValue}
                    minValue={0}
                    maxValue={100}
                  />
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>

          {/* Вкладки */}
          <Stack.Item>
            <Stack>
              <Stack.Item>
                <Button
                  selected={activeTab === 'main'}
                  onClick={() => setActiveTab('main')}
                >
                  Основное
                </Button>
              </Stack.Item>
              <Stack.Item>
                <Button
                  selected={activeTab === 'builder'}
                  onClick={() => setActiveTab('builder')}
                >
                  Конструктор
                </Button>
              </Stack.Item>
            </Stack>
          </Stack.Item>

          {/* Центральная область */}
          <Stack.Item grow>
            {activeTab === 'main' ? (
              <Stack fill>
                {/* Левая колонка: модель персонажа / хитбоксы */}
                <Stack.Item grow={0}>
                <Section title="Тело" textAlign="center">
                  <Stack vertical align="center">
                    {/* Верх: ByondUi с персонажем */}
                    <Stack.Item>
                      <Box
                        position="relative"
                        style={{
                          width: '128px',
                          height: '128px',
                          margin: '0 auto',
                        }}
                      >
                        <ByondUi
                          height="128px"
                          width="128px"
                          params={{ id: character_ref, type: 'map' }}
                        />
                        {showHitboxes && (
                          <Box
                            position="absolute"
                            style={{
                              width: '128px',
                              height: '128px',
                              left: 0,
                              top: 0,
                              zIndex: 2,
                            }}
                          >
                        {/* Голова */}
                        <Box
                          position="absolute"
                          style={{
                            background:
                              selectedPart === 'head'
                                ? 'rgba(255, 255, 255, 0.9)'
                                : 'rgba(255, 255, 255, 0.4)',
                            left: '40%',
                            top: '7%',
                            width: '20%',
                            height: '20%',
                            clipPath:
                              'polygon(50% 0%, 100% 40%, 80% 100%, 20% 100%, 0% 40%)',
                            cursor: 'pointer',
                          }}
                          onClick={() => setSelectedPart('head')}
                          onMouseOver={handleMouseOver}
                          onMouseLeave={handleMouseLeave}
                        />

                        {/* Грудь */}
                        <Box
                          position="absolute"
                          style={{
                            background:
                              selectedPart === 'chest'
                                ? 'rgba(255, 255, 255, 0.9)'
                                : 'rgba(255, 255, 255, 0.4)',
                            left: '35%',
                            top: '30%',
                            width: '30%',
                            height: '25%',
                            borderRadius: '20%',
                            cursor: 'pointer',
                          }}
                          onClick={() => setSelectedPart('chest')}
                          onMouseOver={handleMouseOver}
                          onMouseLeave={handleMouseLeave}
                        />

                        {/* Пах */}
                        <Box
                          position="absolute"
                          style={{
                            background:
                              selectedPart === 'groin'
                                ? 'rgba(255, 255, 255, 0.9)'
                                : 'rgba(255, 255, 255, 0.4)',
                            left: '36%',
                            top: '55%',
                            width: '28%',
                            height: '15%',
                            borderRadius: '20%',
                            cursor: 'pointer',
                          }}
                          onClick={() => setSelectedPart('groin')}
                          onMouseOver={handleMouseOver}
                          onMouseLeave={handleMouseLeave}
                        />

                        {/* Левая рука */}
                        <Box
                          position="absolute"
                          style={{
                            background:
                              selectedPart === 'left_arm'
                                ? 'rgba(255, 255, 255, 0.9)'
                                : 'rgba(255, 255, 255, 0.4)',
                            left: '25%',
                            top: '34%',
                            width: '9%',
                            height: '30%',
                            cursor: 'pointer',
                          }}
                          onClick={() => setSelectedPart('left_arm')}
                          onMouseOver={handleMouseOver}
                          onMouseLeave={handleMouseLeave}
                        />

                        {/* Правая рука */}
                        <Box
                          position="absolute"
                          style={{
                            background:
                              selectedPart === 'right_arm'
                                ? 'rgba(255, 255, 255, 0.9)'
                                : 'rgba(255, 255, 255, 0.4)',
                            right: '25%',
                            top: '34%',
                            width: '9%',
                            height: '30%',
                            cursor: 'pointer',
                          }}
                          onClick={() => setSelectedPart('right_arm')}
                          onMouseOver={handleMouseOver}
                          onMouseLeave={handleMouseLeave}
                        />

                        {/* Левая нога */}
                        <Box
                          position="absolute"
                          style={{
                            background:
                              selectedPart === 'left_leg'
                                ? 'rgba(255, 255, 255, 0.9)'
                                : 'rgba(255, 255, 255, 0.4)',
                            left: '51%',
                            bottom: '-6%',
                            width: '12%',
                            height: '35%',
                            cursor: 'pointer',
                          }}
                          onClick={() => setSelectedPart('left_leg')}
                          onMouseOver={handleMouseOver}
                          onMouseLeave={handleMouseLeave}
                        />

                        {/* Правая нога */}
                        <Box
                          position="absolute"
                          style={{
                            background:
                              selectedPart === 'right_leg'
                                ? 'rgba(255, 255, 255, 0.9)'
                                : 'rgba(255, 255, 255, 0.4)',
                            right: '51%',
                            bottom: '-6%',
                            width: '12%',
                            height: '35%',
                            cursor: 'pointer',
                          }}
                          onClick={() => setSelectedPart('right_leg')}
                          onMouseOver={handleMouseOver}
                          onMouseLeave={handleMouseLeave}
                        />

                        {/* Хвост */}
                        <Box
                          position="absolute"
                          style={{
                            background:
                              selectedPart === 'tail'
                                ? 'rgba(255, 255, 255, 0.9)'
                                : 'rgba(255, 255, 255, 0.4)',
                            right: '63%',
                            bottom: '-6%',
                            width: '34%',
                            height: '25%',
                            clipPath: 'polygon(100% 23%, 0% 100%, 100% 100%)',
                            cursor: 'pointer',
                          }}
                          onClick={() => setSelectedPart('tail')}
                          onMouseOver={handleMouseOver}
                          onMouseLeave={handleMouseLeave}
                        />
                          </Box>
                        )}
                      </Box>
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        selected={showHitboxes}
                        icon={showHitboxes ? 'eye-slash' : 'eye'}
                        onClick={() => setShowHitboxes(!showHitboxes)}
                      >
                        {showHitboxes ? 'Скрыть хитбоксы' : 'Показать хитбоксы'}
                      </Button>
                    </Stack.Item>
                  </Stack>
                </Section>
              </Stack.Item>
                {/* Правая колонка: действия */}
                <Stack.Item grow={1}>
                  <Section title={`Действия: ${BODY_PART_LABELS[selectedPart]}`} fill>
                    {actions.length === 0 ? (
                      <Box color="label">
                        Нет доступных действий (заглушка).
                      </Box>
                    ) : (
                      // Оборачиваем список в Box с прокруткой
                      <Box
                        style={{
                          maxHeight: '500px',        // подбери под своё окно
                          overflowY: 'auto',
                        }}
                      >
                        <Stack vertical>
                          {actions.map((action) => {
                            const isFav = favoriteSet.has(action.id);
                            const isAuto =
                              autoRunning && autoActionId === action.id;
                            return (
                              <Stack.Item key={action.id}>
                                <Stack align="center">
                                  <Stack.Item>
                                    <Button
                                      icon={isAuto ? 'stop' : 'play'}
                                      color={isAuto ? 'red' : undefined}
                                      onClick={() => runAction(action.id)}
                                      width="24px"
                                    />
                                  </Stack.Item>

                                  <Stack.Item grow>
                                    <Button
                                      fluid
                                      selected={isAuto}
                                      onClick={() => runAction(action.id)}
                                    >
                                      {action.name}
                                    </Button>
                                  </Stack.Item>

                                  <Stack.Item>
                                    <Button
                                      icon={isFav ? 'star' : 'star-o'}
                                      onClick={() =>
                                        act('toggle_preferred_action', {
                                          action_id: action.id,
                                        })
                                      }
                                      width="24px"
                                    />
                                  </Stack.Item>
                                </Stack>
                              </Stack.Item>
                            );
                          })}
                        </Stack>
                      </Box>
                    )}
                  </Section>
                </Stack.Item>
              </Stack>
            ) : (
              <Section title="Конструктор действий" fill>
                <Stack vertical>
                  <Stack.Item>
                    <Box color="label">
                      Настройка порядка действий для части тела:{' '}
                      <b>{BODY_PART_LABELS[selectedPart]}</b>
                    </Box>
                  </Stack.Item>
                  <Stack.Item>
                    <Section title="Избранные (приоритет сверху вниз)" fill>
                      {!preferredActionsForPart.length ? (
                        <Box color="label">Для этой части тела избранных действий пока нет.</Box>
                      ) : (
                        <Stack vertical>
                          {preferredActionsForPart.map((action, index) => (
                            <Stack.Item key={action.id}>
                              <Stack align="center">
                                <Stack.Item grow>
                                  <Button
                                    fluid
                                    onClick={() =>
                                      act('toggle_preferred_action', {
                                        action_id: action.id,
                                      })
                                    }
                                  >
                                    {action.name}
                                  </Button>
                                </Stack.Item>
                                <Stack.Item>
                                  <Button
                                    icon="arrow-up"
                                    disabled={index === 0}
                                    onClick={() =>
                                      act('move_preferred_action', {
                                        action_id: action.id,
                                        direction: 'up',
                                      })
                                    }
                                  />
                                </Stack.Item>
                                <Stack.Item>
                                  <Button
                                    icon="arrow-down"
                                    disabled={index === preferredActionsForPart.length - 1}
                                    onClick={() =>
                                      act('move_preferred_action', {
                                        action_id: action.id,
                                        direction: 'down',
                                      })
                                    }
                                  />
                                </Stack.Item>
                                <Stack.Item>
                                  <Button
                                    icon="times"
                                    color="red"
                                    onClick={() =>
                                      act('toggle_preferred_action', {
                                        action_id: action.id,
                                      })
                                    }
                                  />
                                </Stack.Item>
                              </Stack>
                            </Stack.Item>
                          ))}
                        </Stack>
                      )}
                    </Section>
                  </Stack.Item>
                  <Stack.Item>
                    <Section title="Доступные для добавления" fill>
                      {!availableActionsForPart.length ? (
                        <Box color="label">Все действия этой части тела уже в избранном.</Box>
                      ) : (
                        <Stack vertical>
                          {availableActionsForPart.map((action) => (
                            <Stack.Item key={action.id}>
                              <Button
                                fluid
                                icon="plus"
                                onClick={() =>
                                  act('toggle_preferred_action', {
                                    action_id: action.id,
                                  })
                                }
                              >
                                {action.name}
                              </Button>
                            </Stack.Item>
                          ))}
                        </Stack>
                      )}
                    </Section>
                  </Stack.Item>
                  <Stack.Item>
                    <Button
                      icon="trash"
                      color="red"
                      disabled={!favoriteActions.length}
                      onClick={() => act('clear_preferred_actions')}
                    >
                      Очистить все избранные действия
                    </Button>
                  </Stack.Item>
                </Stack>
              </Section>
            )}
          </Stack.Item>

          {/* Нижняя шкала времени */}
          <Stack.Item>
            <Section title="Скорость автоматических действий" fill>
              <Stack vertical>
                {duration > 0 && (
                  <Stack.Item>
                    <Box color="good">
                      {autoRunning
                        ? `Автоповтор каждые ${(data.auto_interval ?? duration).toFixed(1)} с — нажмите ■ чтобы остановить`
                        : `Автоповтор: каждые ${duration.toFixed(1)} с — нажмите ▶ на действии`}
                    </Box>
                  </Stack.Item>
                )}
                <Stack.Item>
                  <Stack align="center">
                    <Stack.Item>
                      <Box width={6} textAlign="right">
                        {duration <= 0 ? 'выкл.' : `${duration.toFixed(1)} с`}
                      </Box>
                    </Stack.Item>
                    <Stack.Item grow>
                      <input
                        type="range"
                        min={0}
                        max={4}
                        step={0.1}
                        value={duration}
                        style={{ width: '100%' }}
                        onChange={(e) => setDuration(Number(e.target.value))}
                      />
                    </Stack.Item>
                  </Stack>
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
