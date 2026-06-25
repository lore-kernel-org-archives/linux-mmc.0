Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011005.outbound.protection.outlook.com [52.101.65.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F379739B482;
	Thu, 25 Jun 2026 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782385036; cv=fail; b=iTCHaWDDVBXbYofAtbA6xTQITkVubWkJ6yMeZFSQnaHEFI2NvsmoynXpq2VRiz2x24coIwMjWIBJsm69LgnKtm5oKJbuKbR972nEunipQumwcKXxZeb5fzDq54SALpFgeVzJ3MYO+wYBBYRsP+pxMnYXf88G1MMZYktlDU0Rv7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782385036; c=relaxed/simple;
	bh=poKf9QHokjVklyh8S6ZL+4RivfD8NijaalirR01oENs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=K488r+fcvSmLjgiX9SkXkOxPIdDbqcYQheMGPPM7nbYEI3jBxECnSL+hmWVq4b16KPLmeshCPBYV/jgEfpDexCkotpfA1AOTqg6rgSrwIbKG4QgfI1w+Ye0B/32+xPTCBG7Px9IVlh5Ww3ERqLGP3UVBFc1VScMv8wAZz/R0DDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rttT+aE1; arc=fail smtp.client-ip=52.101.65.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rttT+aE1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbKqLko9zTwcnl1ASClaQlujdqXYq1l16mQ5G0SYLt/fiyYWKcYSxfhXTzz4+chcLViVIcUd6YSepaHg8+cIzPqjJ9SPcYJyEHQAPomtt/C+t/msjpBhrSXBrUtJM9CXLzG109ErIRwd8qZCEXbX9hGMThF0HbKgZqTmZCyQGZZkfmxDLT7hpmyb0gq6G3SMeEQbTNLKERzsqJZAuwbLM0vC9TgM7csw5u7NU8/c//FqhRWwi6OhsUtR0Eex8ecX4+nCJJZR7rNNX10k+ODZIHgaKksZM6eRukQGKMLvqHn3Co6SOdx84fEAjMeXfywboj/CfevrGmB/OKHJbw7SLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBOG+IUj42HBS16TwqdWSbXNw4Fe8K0nkYLWswCPo5w=;
 b=F66gnZhvAUXnGIPPV4Ba3E6i04EVP1qQDpFTEkD5HxV4zmAVTSotQSO+nUIuEIXVY71/8GcbBAQcbdOmTL6ZIBX4fQwr8eVTmcZ+pwa+cpupC9omPfYVjHxmYwI2Zrea8UyqE6Glbhrg25Wl7gN3a/RP7Cdc5lRUBGFZSrNoF5uIIGcAcffjiWOpfOKRcv1A3P7SNVKKhon4oDr+Sy3GIVUvuCP1DH1JhSOrVpnSPbu7hVQrFslxC7Ykxd7EOyo570WaM7OVD02eE1BbNiy/ZPVqpM42fERrHfwckvfVpEo6yf6g4AXzAQnPkpKmuDpGEZTAMG+9LK5QS8zhUfdwiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBOG+IUj42HBS16TwqdWSbXNw4Fe8K0nkYLWswCPo5w=;
 b=rttT+aE1vX7dMDGVzp+WZhV0CqTbbnSm0Wl6p+FrU09UGfpler77CVD1DMd3NrCi83D7jw+G+hdvjnSLtUZ8C60LclFiH9bkOAojS7wbjkf9LG616Ivxu2C4qfMBeb/JGXp46S6nHkYfe0fRxWGaYe3zekD+1KhiPT5etz3wHHgDXKZpjgO8gtlLGTnOAvJq8T3Zir2HcWSMr1RVz4h/HZ0qpYu/6tpiVlSB8gfzeNvMwU2wCoD//SPlRmivIkMEk5RKcU3/sMK9yLRq5dNuT3BUp/HZTT2uS8jsIz7FhKIDIevaiUw2UaLIssXQlZec1s4ZTdomHskdbR1b9jvuBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by FRWPR04MB11283.eurprd04.prod.outlook.com (2603:10a6:d10:19e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Thu, 25 Jun
 2026 10:57:09 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 10:57:09 +0000
From: ziniu.wang_1@oss.nxp.com
To: adrian.hunter@intel.com,
	ulfh@kernel.org,
	haibo.chen@nxp.com
Cc: Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] mmc: sdhci-esdhc-imx: fix SDIO suspend/resume issues
Date: Thu, 25 Jun 2026 18:59:29 +0800
Message-Id: <20260625105934.2890635-1-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|FRWPR04MB11283:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f2175c-02c0-45cf-9503-08ded2a880e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|23010399003|1800799024|376014|11063799006|3023799007|6133799003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	AdFS8uxl0rK2hcxlgCU6xqwgKffsoBTdbOU1e1YnRb0MKyFvx5+wPELqQHFDXmFi331pK5SQbIEwosnIxzr/Gfct4l97w9Y2XreH8mVVk+nyWWvR7+OLxZdAreJZf1g9oQnq5ltGdBabpUOAretrVgSyNUKNEE2QmCEDPGfdulMoFPlamLkhpe7UIiXKY3ITBC/zo+bfIaWKZNl3WGvox501bdFu6je91xrDbGy4iddnQ99ENMWUrNP6JBD9vZw+Ty28XFgpzpJKsxWYjhl/xouY3czDf4xl2GrkiUjuFfJ/3ODbPWk2d5DRYBaQ3Z9gFXEScdkSMZ9ZGM/aTDopb3IoUESPUjB0kXyiEgeA9y8Y4fddTOMjU0XrjJpyLjHiP2xY3iUGCo3oE+mj7Ijho/bbyNW5wMUDVGto6wgE2H4zfCsB3B7D/5yOycxJyR1quMJMyl8Je8Okk4vKAwCFG52clyBFVSXSIPsp6Fo4tkIrQvErEO1oCUAIsepUytRsIESr+O7eU+rEEBd1r91xBTuG/FnO3nmbcGJXi7Cw27Vpo5ynqxj7ePcwvGp/1zkdPzn30YXlS3lARtA2oR5jHXyQ7w/Qw1IWgdqyM4s6ikZIhR97+67/9AUyl9etw7dKI7MVqJr2psGKmCKMU0kH+I2apFGT/SQadJFpd5tQHd0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(23010399003)(1800799024)(376014)(11063799006)(3023799007)(6133799003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wMl3N+RuCJK62UYww8YKhjD+ZmU/9dDdN4sR4D1YyUbLV2JVGHtMX1La4piC?=
 =?us-ascii?Q?bdCALwTup5oGoAT0iCsBy7dYn+hHLR5p+QicWAswNRIPmaEdNcXv9SQctDT6?=
 =?us-ascii?Q?VGBESVuzC0+NrWghAH8dL3n+C+axTweG6epg3ee6AYXllx1lPk1qbubauZ0b?=
 =?us-ascii?Q?61Y8PCK1MDya0u3RbVtWe76M5utx7x2lVRTMUPeoFSEW1VIiDazigdWlVFf3?=
 =?us-ascii?Q?2J1efSnlSLpCsN5L3WzGPUi8/w4Ek6bQ1cqMUmUkTdgAYZYYauUjpHdLSZpw?=
 =?us-ascii?Q?eX9it+/wuyjS9/kBiFsvtYjS668gG6a9Nx88uDV1RvnlCJJHi3n7NbRaJb4b?=
 =?us-ascii?Q?N3efl/rx9+ZYYZgHRkHEUCEBWyMsD85AcR5UWKu/eyf5r7gQ8XavAbTlENBC?=
 =?us-ascii?Q?oKfmyERMLe5LetwjzbE50KmRHYlCJ+8caoCHsKFzz7Q5cIj/JJuT7PuM04AF?=
 =?us-ascii?Q?xK7lRulCkSYKugyuPk7rhgWNz9BvK6C2tgfoox8eFgKTC2CirvKGpSSrz5xz?=
 =?us-ascii?Q?qoY5HGYQI0bVhNMSyKVFRCaGC2uFD/DygmzUfwdZvf8kbUoNExH+gHoOlCnB?=
 =?us-ascii?Q?bQm1pwOckbs6sbYzQnx+9GJRNd/1dx+0Z2kvNsUa4QNxQb/4Z4NRzeeJ9j4S?=
 =?us-ascii?Q?1/WeNME/LqctbjqkxsXk8OFjaDGPn9EGNprd3YT5+bI0pJLzb3nv2RZvLJ0c?=
 =?us-ascii?Q?nWJMG3CruqnQZ4lWzhw61Jgl+ANnXPD7VoEIdDPcumlNXqJgVgdWTLxncjjn?=
 =?us-ascii?Q?BaomPGvSFyf0HoscC2Utlf/8PMRQfCtDxwBCaZW0kD+5ue/675Me4KbAo7nP?=
 =?us-ascii?Q?f671+11hGrjhCenrplRHWdE4UtqUTKutVikEmtkYCQxhSkH9Zr0x0CVmfS1o?=
 =?us-ascii?Q?CZPOz9AfHhy+tEeVgO1Qk5gscRlCGMjvpT3McZj/4f8QR4XbhO5dUwIUR9st?=
 =?us-ascii?Q?AUTX6xDFvS+6fc273ppaU7M0Bs57LfmX3Y13X/xgjhcJQGXpHAXYEhuGVlMt?=
 =?us-ascii?Q?x3m5+MiRBd9z1KsDS9ndFeRNXasuLP4goVOYGomy/go3hTRA0nxkaSC6Akjr?=
 =?us-ascii?Q?4/sUdvMJCGgM3NqsUKbV7QKhCLajniGycVlRrsUVVpa7SFrFJtobsp8w5M5+?=
 =?us-ascii?Q?KqS1WW3zh3lzny1kv4r87F2QKB94SbiP5nFvMEhpZLlKqsGT0BAGobmDFxM7?=
 =?us-ascii?Q?Rin3sDZKv7WoE6CD53fg2s7WJo9LWzFnIYHtml6vNV3x1CyrOY8G7hb91SZ/?=
 =?us-ascii?Q?qCTTMAEIvJ9rP0jk6EA0/jyuoQkRlUKIyQr9ZF8iTUZC/+cqAdfd5NhDhfR0?=
 =?us-ascii?Q?vQ1teTye2ViR7DeknTp82l9FaG754zKKBI7vvZWw46KyAF/Er7EF3wt6T5S1?=
 =?us-ascii?Q?op/xTiJoYt7u7eKy07oeKL7UaW/MrIdMFeiq/V2s1TNyYGbCkY8dpLwNMiEe?=
 =?us-ascii?Q?IxxRkusJXGLh35rfuCPjPoLLG5VHnObF8Qmf5rOnnVzn3YHIKPlDL0xK2CYB?=
 =?us-ascii?Q?ikh0Q2plJWydbuQEPkcUpPzk/bkLGvyYOEr8w58skFv3yokEam35ePTTa40J?=
 =?us-ascii?Q?S4vmrI6zFFmndXD6TZ6hmq60ScaIlmI+JaDaEBkpmr4rhkSRKDpyxMjSUu3P?=
 =?us-ascii?Q?roCRZ8qkJ4IIGTqtp+NaY1p6Jy3uASGKEFTWEeR2Gvh04hpg1jXYYCqpfjZQ?=
 =?us-ascii?Q?z32AyKxsWPnOWCd2OU1JlALfajstr0P9Hqt5rOgVcGLEQORT5WtHI1igyecV?=
 =?us-ascii?Q?vnlQb5GIALZX0bHIL3+vpXWk829fRwaHcf86yPc8gz5G+VLVvoxt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f2175c-02c0-45cf-9503-08ded2a880e8
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 10:57:09.3410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 72jnp0GedUGW56cW5oMzmhHyoG1+q1AHmzJXWJez4n+RjZOMFRKgTOE+00ot3EcU4y1AZYSdTfg4NTxRHC4F2FhdBKYkl5vFXm4enr7h26ON2KcJ1hmw+5a4+vOCwIdw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11283

From: Luke Wang <ziniu.wang_1@nxp.com>

This series fixes several issues with SDIO suspend/resume on i.MX
platforms using the sdhci-esdhc-imx driver:

1. Remove unnecessary mmc_card_wake_sdio_irq() check that prevented
   tuning save/restore for non-SDIO cards that keep power during PM.

2. Restore DLL override settings for DDR50/DDR52 modes on resume,
   since sdhci_esdhc_imx_hwinit() unconditionally clears ESDHC_DLL_CTRL.

3. Restore pinctrl state based on current timing mode before
   pm_runtime_force_resume() on resume. Only for non-wakeup devices
   to avoid glitching SD bus pins for powered SDIO cards.

4. Move disable_irq() before the wakeup check in suspend to prevent
   unhandled interrupts during the suspend sequence.

5. Fix error handling in suspend/resume paths: use
   pm_runtime_resume_and_get(), make non-critical failures non-fatal,
   and properly handle pm_runtime_force_resume() failure.

Changes since v1:
- Added patch 5 to fix error handling issues identified during review
- Use pm_runtime_resume_and_get() instead of pm_runtime_get_sync()
- Make pinctrl and cd-wake failures non-fatal (dev_warn only)
- Use esdhc_change_pinstate() instead of pinctrl_pm_select_default_state()
  in resume to restore correct pin state based on timing mode
- Skip pinctrl restore for wakeup devices to avoid SD bus glitch
- Check pm_runtime_force_resume() return value in resume

Luke Wang (5):
  mmc: sdhci-esdhc-imx: remove unnecessary mmc_card_wake_sdio_irq check
    for tuning save/restore
  mmc: sdhci-esdhc-imx: restore DLL override for DDR modes on resume
  mmc: sdhci-esdhc-imx: restore pinctrl before restoring ios timing on
    resume
  mmc: sdhci-esdhc-imx: disable irq during suspend to fix unhandled
    interrupt
  mmc: sdhci-esdhc-imx: fix suspend/resume error handling

 drivers/mmc/host/sdhci-esdhc-imx.c | 75 ++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 24 deletions(-)

-- 
2.34.1

