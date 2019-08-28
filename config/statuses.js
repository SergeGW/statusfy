export const statusesInfo = $t => {
  // Important order of relevance
  const keys = [
    "system-unavailable",
    "operational"
  ];

  let i18nKeys;
  if ($t) {
    i18nKeys = keys.reduce((acc, cur) => {
      acc[cur] = $t(`statuses.${cur}`);
      return acc;
    }, {});
  }

  const icons = {
    "system-unavailable": "minus-circle-solid",
    operational: "check-circle-solid"
  };

  return {
    keys,
    i18nKeys,
    icons
  };
};

export const getStatusInfo = ($t, status) => {
  const statuses = statusesInfo($t);

  return {
    title: statuses.i18nKeys[status],
    icon: statuses.icons[status]
  };
};
