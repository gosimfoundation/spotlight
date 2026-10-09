import type { Locale } from "../i18n/translations";

interface SelectedProject {
  name: string;
  url: string;
  image?: string;
  imagePosition?: string;
  description: Record<Locale, string>;
}

// Published selection, in announcement order. Numbers do not indicate ranking.
// Add each project’s image and optional imagePosition here when its photo is ready.
export const shenzhenSelectedProjects: SelectedProject[] = [
  {
    name: "Fugleramme",
    image: "/images/shenzhen2026/projects/fugleramme.png",
    imagePosition: "center 60%",
    url: "https://github.com/arnegiacomo/fugleramme",
    description: {
      zh: "在本地识别鸟鸣，并在电子墨水相框上呈现对应鸟类的自然史插画。",
      en: "An e-ink picture frame that identifies birdsong locally and displays natural-history illustrations.",
      fr: "Un cadre à encre électronique qui reconnaît les chants d’oiseaux localement et affiche des illustrations naturalistes.",
    },
  },
  {
    name: "Tiny Engineer",
    image: "/images/shenzhen2026/projects/tiny-engineer.png",
    imagePosition: "center",
    url: "https://github.com/jamro/tiny-engineer",
    description: {
      zh: "把 AI 编程 Agent 的工作状态，转成桌面机器人的动作、表情、灯光和声音。",
      en: "A desktop robot that turns a coding agent’s status into movements, expressions, lights, and sounds.",
      fr: "Un robot de bureau qui traduit l’état d’un agent de programmation en mouvements, expressions, lumières et sons.",
    },
  },
  {
    name: "XLeRobot",
    image: "/images/shenzhen2026/projects/xlerobot.png",
    imagePosition: "center",
    url: "https://xlerobot.readthedocs.io/en/latest/",
    description: {
      zh: "低成本开源双臂移动机器人，通过语音与视觉 Agent 执行导航、抓取和整理任务。",
      en: "A low-cost, open-source mobile robot with two arms and a voice-and-vision agent for navigation and manipulation.",
      fr: "Un robot mobile open source à deux bras, piloté par un agent vocal et visuel pour naviguer et manipuler des objets.",
    },
  },
  {
    name: "很 Local 实时翻译",
    image: "/images/shenzhen2026/projects/hen-local.png",
    imagePosition: "center 44%",
    url: "https://henlocal.com/",
    description: {
      zh: "利用 Apple Silicon 端侧算力，将现场演讲持续转换为双语字幕，为本次 GOSIM 提供实时翻译。",
      en: "Local live translation on Apple Silicon, turning conference speech into bilingual subtitles for GOSIM.",
      fr: "Une traduction en direct sur Apple Silicon qui transforme les interventions de GOSIM en sous-titres bilingues.",
    },
  },
  {
    name: "VibeKeys",
    url: "https://vibekeys.dev",
    description: {
      zh: "AI 编程助手的实体遥控器：通过按键、旋钮、语音和状态屏，随时查看进展并回应 Agent。",
      en: "A physical remote for coding agents, with buttons, a dial, voice input, and a status display.",
      fr: "Une télécommande physique pour agents de programmation, avec touches, molette, voix et écran d’état.",
    },
  },
  {
    name: "事务官座机",
    url: "https://www.aibooo.cn/",
    description: {
      zh: "连接电脑、手机与实体听筒，为独立工作者安排 AI 分工、跟进进展，并通过电话补充任务。",
      en: "A desk-phone interface connecting a computer, phone, and handset to coordinate AI work and follow progress.",
      fr: "Une interface de téléphone de bureau reliant ordinateur, mobile et combiné pour coordonner le travail des agents IA.",
    },
  },
  {
    name: "第三红岸 Redbank III",
    url: "https://redbank-iii.org/sim/",
    description: {
      zh: "会自己值守的开源望远镜集群，由 AI Agent 接收天文警报、调度分布各地的低成本节点协同观测。",
      en: "An open-source telescope network whose AI agent receives astronomy alerts and coordinates distributed observing nodes.",
      fr: "Un réseau de télescopes open source dont l’agent IA reçoit des alertes astronomiques et coordonne les observations.",
    },
  },
  {
    name: "橘一下 reset",
    url: "https://www.resetcat.xyz/#real-demo",
    description: {
      zh: "通过语音、视觉和实体交互，把用户的注意力从屏幕带回身体与现实世界的 Transition Agent。",
      en: "A transition agent using voice, vision, and physical interaction to guide attention from screens back to the real world.",
      fr: "Un agent de transition utilisant voix, vision et interactions physiques pour ramener l’attention vers le monde réel.",
    },
  },
  {
    name: "虾盘 Xiapan USB",
    url: "https://usb.u-claw.org.cn/",
    description: {
      zh: "把 AI 维护员装进 U 盘，读取电脑真实状态、调用维护工具，并让对话、报告和设置随盘带走。",
      en: "A portable AI computer-maintenance assistant on a USB drive, carrying tools, conversations, reports, and settings.",
      fr: "Un assistant IA de maintenance informatique sur clé USB, avec outils, conversations, rapports et réglages portables.",
    },
  },
  {
    name: "PhyAgentOS",
    url: "https://phy-agent-os.x-era.com/",
    description: {
      zh: "面向物理 Agent 的开源运行框架，支持异构机器人接入、Skill 组合，以及执行、反思和改进。",
      en: "An open-source runtime for physical agents, combining robot integration, reusable skills, execution, and reflection.",
      fr: "Un framework open source pour agents physiques, combinant intégration de robots, compétences réutilisables et réflexion.",
    },
  },
  {
    name: "Meiso Glass",
    url: "https://drive.google.com/file/d/1McSmbIymFyLMlMP6jSEKJtLBvM3ihgrt/view",
    description: {
      zh: "面向日常 AI 助手的无线分体式 AR 平台，探索物体识别、空间面板、语音交互与更轻的佩戴体验。",
      en: "A wireless split AR platform exploring object recognition, spatial panels, voice interaction, and everyday AI assistance.",
      fr: "Une plateforme AR sans fil explorant reconnaissance d’objets, panneaux spatiaux, interaction vocale et assistance IA.",
    },
  },
  {
    name: "Ingora · Qrio",
    url: "https://www.alipan.com/s/NUPgSx13cmG",
    description: {
      zh: "面向 6–12 岁儿童的语音优先 AI 口语学伴，根据语言水平、兴趣和学习状态提供个性化练习。",
      en: "A voice-first AI language companion for children aged 6–12, adapting practice to their level, interests, and progress.",
      fr: "Un compagnon linguistique IA vocal pour les 6–12 ans, adaptant les exercices au niveau, aux intérêts et aux progrès.",
    },
  },
  {
    name: "PoopSense 便知",
    url: "https://poopsense.org/",
    description: {
      zh: "面向家庭的马桶侧传感设备与 AI Agent，减少手动记录负担，将排便特征转化为直观记录和长期回看。",
      en: "A toilet-side sensor and AI agent that reduces manual logging and helps families review everyday patterns over time.",
      fr: "Un capteur et un agent IA près des toilettes pour réduire la saisie manuelle et suivre les habitudes quotidiennes.",
    },
  },
  {
    name: "Mira Light",
    url: "https://mira-light.notion.site/lunchbox",
    description: {
      zh: "面向桌面场景的灯形陪伴机器人，通过多模态感知与拟人化运动，探索更自然的人机互动。",
      en: "A lamp-shaped desktop companion exploring natural interaction through multimodal sensing and expressive movement.",
      fr: "Un compagnon de bureau en forme de lampe, explorant l’interaction naturelle par perception multimodale et mouvement.",
    },
  },
  {
    name: "Octos Learn",
    url: "https://learn.pitun.cc",
    description: {
      zh: "结合语音提问、手写与摄像头输入的 AI 数学白板，将讲解转成可探索的交互式可视化。",
      en: "An AI math whiteboard combining spoken questions, handwriting, and camera input with interactive visual explanations.",
      fr: "Un tableau blanc IA pour les maths, combinant questions orales, écriture et caméra avec des explications visuelles interactives.",
    },
  },
  {
    name: "Agentero",
    url: "https://agentero.app",
    description: {
      zh: "面向科研阅读的 Agent 友好文献阅读器，让 AI Agent 参与文献阅读的完整流程。",
      en: "An agent-friendly research-paper reader bringing AI agents into the full literature-reading workflow.",
      fr: "Un lecteur d’articles scientifiques conçu pour intégrer les agents IA dans tout le parcours de lecture.",
    },
  },
];

export const shenzhenSelectionCopy = {
  zh: {
    title: "入选项目，聚光登场。",
    description: "16 个项目入选 Spotlight Shenzhen 2026。从机器人、智能设备到日常 AI 助手，探索下一代 AI 原生产品。",
    status: "已停止提交",
    closed: "本届项目征集已结束，入选名单现已公布。",
    count: "个入选项目",
    note: "名单展示顺序不代表排名",
    topic: "下一代 AI 原生产品",
    date: "2026 年 10 月 16—17 日 · 中国深圳",
    projectLink: "查看项目",
    conference: "访问 GOSIM Shenzhen 2026",
    archive: "征集说明与原评选要求",
    archiveIntro: "本届征集已结束。以下保留原征集说明，供查阅。",
    closedTitle: "已停止提交",
    closedDescription: "Spotlight Shenzhen 2026 的海外及国内项目征集均已截止，现已停止接收新申请及修改。欢迎查看本届入选项目。",
    viewSelection: "查看入选项目",
  },
  en: {
    title: "Selected projects. Center stage.",
    description: "Meet the 16 projects selected for Spotlight Shenzhen 2026, exploring next-generation AI-native products through robotics, smart devices, and everyday AI assistants.",
    status: "Submissions closed",
    closed: "Applications have ended. The selected projects are now announced.",
    count: "selected projects",
    note: "Display order does not indicate ranking",
    topic: "Next-generation AI-native products",
    date: "October 16–17, 2026 · Shenzhen, China",
    projectLink: "Explore project",
    conference: "Visit GOSIM Shenzhen 2026",
    archive: "Open call & original selection requirements",
    archiveIntro: "Applications have closed. The original program information is retained here for reference.",
    closedTitle: "Submissions closed",
    closedDescription: "International and China applications for Spotlight Shenzhen 2026 have ended. New applications and edits are closed. Explore this edition’s selected projects.",
    viewSelection: "View selected projects",
  },
  fr: {
    title: "Les projets sélectionnés à l’honneur.",
    description: "Découvrez les 16 projets sélectionnés pour Spotlight Shenzhen 2026 : robotique, appareils intelligents et assistants IA du quotidien.",
    status: "Candidatures closes",
    closed: "L’appel à projets est terminé. La sélection est désormais annoncée.",
    count: "projets sélectionnés",
    note: "L’ordre d’affichage ne constitue pas un classement",
    topic: "Produits natifs IA de nouvelle génération",
    date: "16–17 octobre 2026 · Shenzhen, Chine",
    projectLink: "Découvrir le projet",
    conference: "Visiter GOSIM Shenzhen 2026",
    archive: "Appel à projets et critères de sélection initiaux",
    archiveIntro: "Les candidatures sont closes. Les informations initiales du programme restent consultables ici.",
    closedTitle: "Candidatures closes",
    closedDescription: "Les candidatures internationales et chinoises à Spotlight Shenzhen 2026 sont closes, y compris les nouvelles demandes et les modifications. Découvrez les projets sélectionnés.",
    viewSelection: "Voir les projets sélectionnés",
  },
} as const;
