Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011017.outbound.protection.outlook.com [40.107.130.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974E53C0A07;
	Fri,  3 Jul 2026 10:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075178; cv=fail; b=dOF8b/hUVoVbpkbiIIPa6Oajy3LrxOu3to8weIk2HsDYEF/qn+ZVZYV1XrlPfizuc4SoD5pjz6WGukyqKWgNSjzIvcv/7Ts5RMJ09jn1ZpCYuZ7pCV62VveOYOkIBCe5/7Gw8lHr+B19IFWmfsJhOLfZD3AQl8I7M3fKqsV0ZnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075178; c=relaxed/simple;
	bh=QB7y1+XV0w6m/GaughjAyrmPQBhj3Af7rZ+i/StcCP8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oW7SHSkscTxSnrMiK74b4rMYV8GlmVnpi8a8quHeDgEmV3sZfqVhLmzQoWq+cho+LuF71/G4zqwFLgs+/XKF7fBrdI+pkACmeeHZjPBtAjmsE7J3vh6zaPzzi/ZzH8W1b3L++gwczEx02tFIToFnx0+4IpkvAeYEf6Mu8CGZCVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dlezDnJ6; arc=fail smtp.client-ip=40.107.130.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dlezDnJ6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bU9PsSrLZejvYsq3D9XkwoJgn51bFHGLZzSs379y5YH91E8uSaqhdRpX893Bz5FMorW7qhdb0CdncpQ+h/SmP1MC4VpQ0AMtDO3LYhynUISX9t5tJ6Ctdu1qpzOM6hiW2YdyFVHbm4qWAQKj44X6Fg7XpHC1f6gMxC7oRzVlgAyrjW/3VvASPH1YFolh2gHIoLPJisaboBxqjq8chQurGPoHlkzj4SaD2HI8yzmYN1LhF/E16BdlNzDoIM4wh7ot9rSpF4CgIuHgRjMXiWIWj431WeTATBXNpJBj3STPH2i0O/KNQ4p4RUHxdYnkkT1q+rnlDvaKn6jTfb7lMxo1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJf/AGCikrD1tAzz4S/hYBGqFkxIH4NtqC/fOoP7vlw=;
 b=Tqd+tRXVdTyn9zHIeN7iuIhNbikF90WOUvlMrp1LlIX2WagfmhdEhNAEIJLK8CVe1xwIg2ShYi2wTc+jHsq8IkYG6FjUxuUaBHsZP2Oy+9xLcTgDT94T42AmDLlKBzXXqSmwkG22N81R6vvNxdsZuhhDTS1dqeafY7Nv8YMxw49IsnM+ay0i16GfDIBNSQ0fk1K351N2s9czYajwU/pU9Unn2WfewNNvzWkC+NEdNGlFN4UKjlVNK8H35wBfEb0s6tLv4fuWosYIKxqxXFiyju+ile9kc2l9xQAWFHuioZKGm44dnu3NJeaCMLQvhIj5+ny5ZNa9KcA/8KvvOoqhmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJf/AGCikrD1tAzz4S/hYBGqFkxIH4NtqC/fOoP7vlw=;
 b=dlezDnJ6YUoaiYCARafCdIF4AGnSEjNuC6lk4kes4R41+LCUINgNqr9zoCDZIybrXjxmItv8PWJK6v4kPM9kHzemiXgfPFjxh6OD6HcI+I6yEB9egoHsbGYDtyVKDWDdL/CpHsQrtFKWucFS9Mvmv4p+TJDka83ZYpyXd6qtAnF67VIh4L3H0B7n3QHzqqmvlCOvP/BkFYfsXTSzL2izXKqFDsEuqit0Lf/NaFXP70UQJIDOce43LTE5qDX6GCnpHlujvOFa3LSqLogFs9Qy5ZOfuWf0Tct+tDWVtNTYrKGzhC/736E5eWmIe/9Nwe+qZ2cX8O5YplvtzI0D4FwMVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by AM9PR04MB8667.eurprd04.prod.outlook.com (2603:10a6:20b:43e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 10:39:33 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 10:39:32 +0000
From: ziniu.wang_1@oss.nxp.com
To: adrian.hunter@intel.com,
	ulfh@kernel.org,
	haibo.chen@nxp.com,
	Frank.Li@nxp.com
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/7] mmc: sdhci-esdhc-imx: fix SDIO suspend/resume issues
Date: Fri,  3 Jul 2026 18:42:01 +0800
Message-Id: <20260703104208.3426374-1-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::12) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|AM9PR04MB8667:EE_
X-MS-Office365-Filtering-Correlation-Id: c88b7a3d-cf52-41dc-fc9a-08ded8ef5e68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|19092799006|18002099003|56012099006|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	8UFVHOVJtcN1nGM+Rpfq0YN7mzJYASQK2HEbrzE+/wO7B+/25ijQx2gsbanGwsBSy7rVTBTC/HX9/qSM2bFtoQFOgs0wdT6y3TSPIF2UL1GEBpdYqysqFboZ4YsIOCbB01PErghyWx9PwnhFMVpoNCyb6RXGEVOlmSH324NbErzAcKBO+4m3ffTz9EpuCg4AVPmm6Nzg9ZNHmEiaybzaU5rcVN/tSn8bRekAK0koU3ypMjhMgoGnlhmZtsTSvJOV8z0kt+sIewrWzPR4ytvQp1Jz8g8KeXxiQ5x6k5d/LVuwM+nD+iO0Jjc8KctB8DbTwfJKQTAZ3iwA7zZ4yp06OVaN3EnUy9zGrbTzeE6nzkJv6NQwEA1qDJ1yVTwmZZOik51cK7M0dBmQWYvUqON0Lj0IUJ3LdOuHmen+qgdv8dKXZDjF5o6ztyDQ7BQFOuwXbhx0XR+LzPMqrz3PbzBM3lWWx2Qy8L3Li1IQdEg7rNGvA8QW5GrFjhOkJiChwMaHAxF0UIPW6IWR64ayP0cfp1hj8Kau6fpBHIPdigJHPGhdHpHTACqCqa81GLfMr3bZAPkbWI8YAUzrMxyNIV5avGi4bHc7SxK6kbB5z+sl/osvjXI46aDNBXElkdRfZsEwcrvZ+doEx/uypnaIcgH6vnoA3El+7oekaTSn/7ZVhkA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(19092799006)(18002099003)(56012099006)(11063799006)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yzWiGewQYUipP/iqx/Bzt5Ibdk4ldBmPXtyTkWnhLsCUhPeB/NbTD1hrgnOc?=
 =?us-ascii?Q?DoVOLR4F2YSSjTvNLz3XRu1Ls3wol1Q75BQLb2PZzN0aTVpLBM5FAZnS15Ec?=
 =?us-ascii?Q?aoCv4rNpheWBi430bWXfTNuGC7VXQYwZPFhO6rDQIUOS6DVHilV4vXMGvSBr?=
 =?us-ascii?Q?OfFGshX0j+Ynat9EO9eS741E6f6UBv33JcbUj40pvutDiW6y4RZO3oGy1nTw?=
 =?us-ascii?Q?TiWPn5+27oN7w7MstYUd5JTMA5TqA/U7/mspbQOHtHUzCuVfj/+LEnZcdC/Q?=
 =?us-ascii?Q?2ZXtqIEpwqsoYorMQxbsdFsS7ZV4qqyehtkqI/1x473aTIytL9WmfHUVNGSM?=
 =?us-ascii?Q?QpAuy+qLnVW8xWodnSg33vqAPmizwaonDc/uqXlljNA/QfWEgrcUN+W3KWNX?=
 =?us-ascii?Q?xAW5Un0f5RbHgHumrDWG61ofWOqMpQ0Spwfo0t+6LDSFsBHFk/jEdBA5ZRg4?=
 =?us-ascii?Q?xi7LVfjv5DI3/+lRglaId29GX7pVz/eKwy5j8j9DsAkgcMFaPOgqORhDZcDm?=
 =?us-ascii?Q?5ViDBiIBii1xhxNLs3MYaHrLKNEroGRdqUTp3CO0Ce3hB2RrFZLDkFc6iJHn?=
 =?us-ascii?Q?RQFQcjUvvGZhoYVigZyUuHE4okBQVOt6+HVER0rCosGqBKN4shME+Br/VS6f?=
 =?us-ascii?Q?kvfFXvYS/X3pRL3vxmb83Wx9kAFxOtqAHMJEaGrSe6xcS/iDxLmmTa7R/tdm?=
 =?us-ascii?Q?gnlCV8RmLy8bpaBl+VTUREEqe3GdohhnZM9Sgh8buB3245z/8B/M17XLF7SX?=
 =?us-ascii?Q?csW12H9mzeF8XCknBkIzONlvoWEnvqVOE7Jp3UniP1ACSMFwTszUo5eHPeaC?=
 =?us-ascii?Q?qIASEewr84HO60Kngtmr5Pzx1r/FPlVx4KqAiRKJI7lVCwoNAzoiXyTaCKUU?=
 =?us-ascii?Q?PW7NelSE3lwnrybqvDb7XGrqB8dMDoI7itHrbrb9eCmut9rdt4ifYvEj0yf9?=
 =?us-ascii?Q?swu7SqIhWl9JIEuPYQLcRfzrirZFWkdmyTKwyGxUNjaqXVTlLJIMk6PwGdfr?=
 =?us-ascii?Q?ZcOQQGO4ALRkURh51W1sxyE1RDHpalHvcRp6WXO38X2QqwoTK+8huBPU7laQ?=
 =?us-ascii?Q?e7CfTPyMD8gqVhW57Dc7+e9DRQlo8y2jJLIEtjd9C9LBvdcjpLAaHWzg8Y9H?=
 =?us-ascii?Q?nmmapIh7QDhTesG44Ac7Ko2ZBpnPgV7PFWFbAysVkkzN9ATP0JMknoVAHusX?=
 =?us-ascii?Q?KA4Ru7O+TiLwwvuiR4m4e7uxWrbpyVDdQlTQWJPax/XrYCeXGGA0RaPfpSQ7?=
 =?us-ascii?Q?mB/ijnGC14nHf4XfuJjLM+vVVW+vUqHONnELF1GghAaSzjXe+YghFszhCfsY?=
 =?us-ascii?Q?3Xfc6S6IGtRHuAaOV4yf5QTebGybntMJoTKWqicHx6Y9MNHgUbGgTARjoeO8?=
 =?us-ascii?Q?10livGoov841brjxSIuMzuzNglWKE6QtRtV75jJ9A+dBbTDW/WJ5OZhazYC/?=
 =?us-ascii?Q?oim2ihcjqvO7F24Y4olsM5QxII35DVaq7N+i/eBxh6e/mj+ZIA+AhuHMWCcH?=
 =?us-ascii?Q?ml57E84xOD8BoEO/7si1X8n36RCXDYwDEwnD7hC6BHDAKGbm/GKMw2MEbF1C?=
 =?us-ascii?Q?rEIspc3DzujLQo8ZnczNGPqzQvlDdCxDuaI0AzHLUj8dznCXtqx/788r7EVi?=
 =?us-ascii?Q?9Y2ntlf9QzteQMkMgNy9O+PaQMORy0D8cCIUfUJS7pvI5km72r805sDXhxok?=
 =?us-ascii?Q?MfVD2iAA2tfsP8AHtNmtFXrVda/PNUTGmPpp3uaTm2B9vrvrtbmWvGIGwvL3?=
 =?us-ascii?Q?LNa5GzXFezg/PpdlXzDRPuOy+hCFkgEiPeQRAsljSr2RPkz63Iw5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c88b7a3d-cf52-41dc-fc9a-08ded8ef5e68
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:39:32.8153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VedqnYGneqckf/rp7wwd43KG2mVSjfew8HjFY5fn/hLdjHd83Z6yCbd9diArU+NpMp0ncwDL2p8caWxT8jjMRDRiU6XlNL0AfCB31fxy7HnUaonyviqUU7Euio8qZsdQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8667

From: Luke Wang <ziniu.wang_1@nxp.com>

This series fixes several suspend/resume issues in the sdhci-esdhc-imx
driver, primarily affecting SDIO devices (e.g., WiFi).

Issues fixed:
- Tuning delay values not saved/restored for out-of-band wakeup devices
- DLL override lost after resume for DDR modes
- Pinctrl not restored before DDR_EN is set, causing CRC errors
- Unhandled interrupt during resume causing "nobody cared" warning
- Various error handling issues in suspend/resume paths

Changes since v3:
- Patch 2: Remove unused 'boarddata' variable in esdhc_set_uhs_signaling()
- Patch 7: Expand commit message to document intentional skip of enable_irq()
  and sdhci_disable_irq_wakeups() on early return, and explain why the
  PM runtime usage counter leak is acceptable (Sashiko)

Changes since v2:
- Patch 3: Updated commit message to explain the SoC IP integration
  detail about internal loopback path change when switching pinctrl
  from GPIO to USDHC function (per Bough Chen suggestion)
- Patch 5 (v2): Split into three separate patches (5/6/7) so each
  patch fixes one problem (per Frank Li suggestion)

Changes since v1:
- Added patch 5 to fix error handling issues identified during review
- Use pm_runtime_resume_and_get() instead of pm_runtime_get_sync()
- Make pinctrl and cd-wake failures non-fatal (dev_warn only)
- Use esdhc_change_pinstate() instead of pinctrl_pm_select_default_state()
  in resume to restore correct pin state based on timing mode
- Skip pinctrl restore for wakeup devices to avoid SD bus glitch
- Check pm_runtime_force_resume() return value in resume

Luke Wang (7):
  mmc: sdhci-esdhc-imx: remove unnecessary mmc_card_wake_sdio_irq check
    for tuning save/restore
  mmc: sdhci-esdhc-imx: restore DLL override for DDR modes on resume
  mmc: sdhci-esdhc-imx: restore pinctrl before restoring ios timing on
    resume
  mmc: sdhci-esdhc-imx: disable irq during suspend to fix unhandled
    interrupt
  mmc: sdhci-esdhc-imx: use pm_runtime_resume_and_get() in suspend
  mmc: sdhci-esdhc-imx: make non-fatal errors non-blocking in suspend
  mmc: sdhci-esdhc-imx: fix resume error handling

 drivers/mmc/host/sdhci-esdhc-imx.c | 76 ++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 25 deletions(-)

-- 
2.34.1

