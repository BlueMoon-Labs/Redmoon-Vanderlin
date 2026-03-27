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

type BodyPartId =
  | 'head'
  | 'chest'
  | 'groin'
  | 'left_arm'
  | 'right_arm'
  | 'left_leg'
  | 'right_leg'
  | 'tail';

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

const BODY_PART_ACTIONS: Record<BodyPartId, string[]> = {
  head: ['Погладить по голове', 'Повернуть голову', 'Осмотреть лицо'],
  chest: ['Потрогать грудь1', 'Проверить дыхание'],
  groin: ['1'],
  left_arm: ['Пожать руку', 'Поднять руку'],
  right_arm: ['Пожать руку', 'Опустить руку'],
  left_leg: ['Пнуть', 'Поднять ногу'],
  right_leg: ['Пнуть', 'Пошевелить стопой'],
  tail: ['1'],
};

interface InteractMenuData {
  entity_from: string;
  entity_to: string;
  character_ref: any;
}

// Обёртка для hover (обычный div, чтобы TS не ругался)
const HoverWrapper = (props: {
  onHoverChange?: (hovered: boolean) => void;
  children: React.ReactNode;
}) => {
  const { onHoverChange, children } = props;
  return (
    <div
      onMouseEnter={() => onHoverChange?.(true)}
      onMouseLeave={() => onHoverChange?.(false)}
      style={{ width: '100%', height: '100%' }}
    >
      {children}
    </div>
  );
};

export const InteractMenu = (props, context) => {
  const { data, config } = useBackend<InteractMenuData>();
  const { entity_from, entity_to, character_ref } = data;

  const [selectedPart, setSelectedPart] = useState<BodyPartId>('chest');
  const [activeTab, setActiveTab] = useState<TabId>('main');
  const [showHitboxes, setShowHitboxes] = useState(false);

  const progressValue = 50;

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

  // Массив действий, добавленных в избранное
  const [favorites, setFavorites] = useState<Record<BodyPartId, string[]>>({
    head: [],
    chest: [],
    groin: [],
    left_arm: [],
    right_arm: [],
    left_leg: [],
    right_leg: [],
    tail: [],
  });

  const baseActions = BODY_PART_ACTIONS[selectedPart] || [];
  const favForPart = favorites[selectedPart] || [];

  // Список действий: сначала избранные, затем остальные
  const actions = [
    ...favForPart.filter((a) => baseActions.includes(a)),
    ...baseActions.filter((a) => !favForPart.includes(a)),
  ];

  const toggleFavorite = (part: BodyPartId, action: string) => {
    setFavorites((prev) => {
      const list = prev[part] || [];
      const isFav = list.includes(action);
      const nextList = isFav
        ? list.filter((a) => a !== action)
        : [...list, action];
      return { ...prev, [part]: nextList };
    });
  };

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
                  <HoverWrapper onHoverChange={setShowHitboxes}>
                    <Section title="Тело" fill textAlign="center">
                      <Box
                        position="relative"
                        style={{
                          width: '150px',
                          height: '150px',
                          margin: '0 auto',
                        }}
                      >
                        {/* Пока не наведено — показываем ByondUi */}
                        {!showHitboxes && (
                          <ByondUi
                            height="128px"
                            width="128px"
                            params={{ id: character_ref, type: 'map' }}
                          />
                        )}

                        {/* При hover — скрываем ByondUi, показываем слой хитбоксов */}
                        {showHitboxes && (
                          <Box
                            position="absolute"
                            style={{
                              inset: 0,
                              background: 'rgba(0, 0, 0, 0.6)',
                            }}
                          >
                            {/* Голова */}
                            <Box
                              position="absolute"
                              style={{
                                background: 'rgba(255, 255, 255, 0.6)',
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
                                background: 'rgba(255, 255, 255, 0.6)',
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
                                background: 'rgba(255, 255, 255, 0.6)',
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
                                background: 'rgba(255, 255, 255, 0.6)',
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
                                background: 'rgba(255, 255, 255, 0.6)',
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
                                background: 'rgba(255, 255, 255, 0.6)',
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
                                background: 'rgba(255, 255, 255, 0.6)',
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
                                background: 'rgba(255, 255, 255, 0.6)',
                                right: '63%',
                                bottom: '-6%',
                                width: '34%',
                                height: '25%',
                                clipPath:
                                  'polygon(100% 23%, 0% 100%, 100% 100%)',
                                cursor: 'pointer',
                              }}
                              onClick={() => setSelectedPart('tail')}
                              onMouseOver={handleMouseOver}
                              onMouseLeave={handleMouseLeave}
                            />
                          </Box>
                        )}
                      </Box>
                    </Section>
                  </HoverWrapper>
                </Stack.Item>

                {/* Правая колонка: действия */}
                <Stack.Item grow={1}>
                  <Section title={`Действия: ${BODY_PART_LABELS[selectedPart]}`}>
                    {actions.length === 0 ? (
                      <Box color="label">
                        Нет доступных действий (заглушка).
                      </Box>
                    ) : (
                      <Stack vertical>
                        {actions.map((action, i) => {
                          const isFav =
                            favorites[selectedPart]?.includes(action);
                          return (
                            <Stack.Item key={i}>
                              <Stack align="center">
                                {/* Кнопка слева: play */}
                                <Stack.Item>
                                  <Button
                                    icon="play"
                                    onClick={() => null}
                                    width="24px"
                                  />
                                </Stack.Item>

                                {/* Центральная большая кнопка действия */}
                                <Stack.Item grow>
                                  <Button fluid onClick={() => null}>
                                    {action}
                                  </Button>
                                </Stack.Item>

                                {/* Кнопка справа: избранное (звезда) */}
                                <Stack.Item>
                                  <Button
                                    icon={isFav ? 'star' : 'star-o'}
                                    onClick={() =>
                                      toggleFavorite(selectedPart, action)
                                    }
                                    width="24px"
                                  />
                                </Stack.Item>
                              </Stack>
                            </Stack.Item>
                          );
                        })}
                      </Stack>
                    )}
                  </Section>
                </Stack.Item>
              </Stack>
            ) : (
              <Section title="Конструктор действий" fill>
                <Stack vertical>
                  <Stack.Item>
                    <Box color="label">
                      Здесь будет конструктор действий для этого юзера.
                    </Box>
                  </Stack.Item>
                  <Stack.Item>
                    <Button icon="plus" onClick={() => null}>
                      Добавить новое действие
                    </Button>
                  </Stack.Item>
                  <Stack.Item>
                    <Box color="label">
                      Пока это только визуальная заглушка без логики.
                    </Box>
                  </Stack.Item>
                </Stack>
              </Section>
            )}
          </Stack.Item>

          {/* Нижняя шкала времени */}
          <Stack.Item>
            <Section title="Скорость автоматических действий" fill>
              <Stack align="center">
                <Stack.Item>
                  <Box width={6} textAlign="right">
                    {duration.toFixed(1)} с
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
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
