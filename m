Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011061.outbound.protection.outlook.com [52.101.70.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354AE388368;
	Tue,  3 Mar 2026 10:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534899; cv=fail; b=aEPq73f8yzVqDrX7+0KnX3eOh3w1Nr0n3ZnQIbHQ+E4oSpDC73GO45zb2FLCjmcvaDSMYY12mkzXdeW41Oh7oWZsixqcVKgwZAsxHaA56nllES7Ne8Tkh5U05dSrMaQt4v1DZaR0ZHIVNj4/HkWi5z4IaEAyS6CgfD6edaxqoLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534899; c=relaxed/simple;
	bh=GG+utUuOzRQUVMUs57Mr1Wjvv8rTMme77hkqIdkEMCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L1XJH+5nNeyF6w08JBgK6W/zsE/MB24eu5GOtFL+Tj87xPjUnGI1x+2O/m0bHRXkIh/gnb1KV4ZS5AZQOpndFsR7Lt7VQrMd4106IaJ9whLK5QgOJrdXwaoPbKUc3g5nTMAjHhgLybDz97UE/FcDcwrEEEbgoSM9+3DrMXZmOqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DQIXN5Ye; arc=fail smtp.client-ip=52.101.70.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DQIXN5Ye"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNRSq/VO8rKqXKLWLCc1GAv/8Sux4e7XHwjLZUzjyG2Nv/SfCv7UPWK6VQ6sJL1q9oJJkokc36Y78K+v15LpSdD+TSM9TWUBGUpVSsa2+gAHbiW6bCb8KZddr9B7uFbpj+dmKkRB6rgJixIiRQD1yDfhVksz3V3QqDoEvoUCAwaaZuzt30MxpTEXlHuMaI1d/ybNISdqqskKnJluhC7tJZ8yjZQ2HJAFdaQJBk6Qw7MIbgM4BMPM0zZZHkGpMIgQMgcPB49E02s7MA+tYSFSmEA/Ul3QMzXu1HxYI/QkGDLveBeIpbV4X/0fi4G/xSOG6JnGecc3RGMI1AIFqttWeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQ/RJDWocaqP9WzBJbJeYW6vIxbTktJ9ZgBuNHhJbnI=;
 b=ZS6uIY9jYlvmHAQCMa6nG86K3xm0+z8/ka8Onfa3+pGJ3++LmqNxEy6t7jeeAPeNWbaL0FpNh0hC060ZQu2L7OTJ8opYeiEErBjsRSGRMvF3aWkHYPf3lcR/uIWUzukXOQFbE1VIPLQ1cNzkeZ4oaMaUciu5nKgtGPjAija4f3T1hq+JOUNW4ZOs7EeKp1pgPokMOEefJewKV+OZbhQ0zAL17X4NeuzZwDPE+8S7alikqfA8ugxcfe+6PpmyFk+zlckNwd5v2bTAV2gvMYBjybXPEufQ4RZRir/78JuQrULDJ3sCEOS5AfzckLRKCxBI+rLQ+JoqGacv2htbF89uOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQ/RJDWocaqP9WzBJbJeYW6vIxbTktJ9ZgBuNHhJbnI=;
 b=DQIXN5YeH/GrqeDLGHJbBVYCUpcSoCTPiYyLoAOMvKcn2tgD5vV7fG2GOlgtaekeL0Z/8IQTrJLVTVqxVtdM+DwQpcs5XFMxQGmuQfM/lxi8Y/wkaQNmDN3XU9wfIdzyq8DJBlA1lLdS2YtrQW2NoSWq5avcEV3zxkuVkP+E+tcLuNj3qkXp9wnRbqK4zf7Ht9uqhawwhq4DJzywnTgBtgwiROh+lq4B8fJhyQGcY4ipH0gq94RExoUuqXqDyQRRNIKRzcUToFq2azzuMd+CAvvoypRvhuNTDmtJTIu+nulkYfJacWnp6mZe81ZIr7tMcDlKd0fqmaSEhZW60sLiig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by DU4PR04MB11926.eurprd04.prod.outlook.com (2603:10a6:10:628::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 10:48:11 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%6]) with mapi id 15.20.9654.015; Tue, 3 Mar 2026
 10:48:10 +0000
From: ziniu.wang_1@nxp.com
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
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
Subject: [PATCH v2 1/4] mmc: sdhci: fix timing selection for 1-bit bus width
Date: Tue,  3 Mar 2026 18:50:03 +0800
Message-Id: <20260303105006.989339-2-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303105006.989339-1-ziniu.wang_1@nxp.com>
References: <20260303105006.989339-1-ziniu.wang_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0302CA0033.eurprd03.prod.outlook.com
 (2603:10a6:205:2::46) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|DU4PR04MB11926:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ce1e50-df71-4ba8-6ea1-08de79125c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	Fd7z7AJVOj7kI85gi6PxmnxQUal0y7HVNAtyqIM+t5AVUZKSJpYQ4LvST10Xrv6ES+QGYdMdYXlxjJ5wvx6C1eMJY/GnKl7qPOnl7Mlt87ICKQM140WhIqwSxefh+HHl/ii1kt+gUbWPQvW1hsz1WCey1iwZbxyHIspBWkRJ5DncnunQp/BioL7r22Ct6KWzMPm7J7KbhB4CIa33/QJ8kIUtQFRDFF+bCeqK45YYNCKU8S/V2t78QBAKfFe1f4youAMkBtgGxySZUeWpy5vdKvCEYCRsZJRqqw+kD2LGU3L0RsvaZw8gUK+Lpu9OL+2a76yQFBXLk76AxuHorbRzicPkPJUWPj9tTimlH0CvQ9VQeXV+4RbE14VVxsc2RQrbXi8Z2S7PQXnnu/rHQuqzuPq/4HqppNPzHeitJGwOxNbXICUcKFhval8JzB0ckiVWsCTgvqUftQqB2a7KN6b+CJvQZomj6V490Jt33XchUQ1fRt7kXlRTLGh34EgtZbPaG/ILt9BAsXcmGXARuBy2m9STjbbqFH5hHlEzSWKPXr/64aYeIZ5S6hCiOoaqfUSxS8t2ZJVBwj9AfcoIbER7FodxQEAe0OeCwyYUEn/1VrXReO6SFQUjDsi8Sx7uwQjpIrI4wkPQXjNgOpdRbwZCV/obyc2luv0pd7fMGh939GdIMkH9rKHUhR2VC0o4n5575pXD7V3nTfpf8YtemouL3JAZ/fp16a2vFTbsX/HmlBnxZ1FyP/6rQ62Y/fPV0gihWeDtuj/J9rtJH4EatxDHfu0rEXNvfUronT2UY/m1qks=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LkHswQR2iNWNa4KvTmhOLpq1TNbBhuN34H2zeWTuv1oCHOKFdMOoXx+Bm3EH?=
 =?us-ascii?Q?+T+/jJawsWncLSeSf8MZwu5HUxiGksdzn7p5ghqS0Ro2JWY8glsedXBwuTC+?=
 =?us-ascii?Q?8toUp2OtyqNjMfZ3alBzzwnMj991tqa5jKUCkoO0o3iivEWMFMjaV5VQtvnc?=
 =?us-ascii?Q?6lEyY/d0fHSJ2WrKdw/rJA0zuGtL7PtqYIWhPMt7TZQcC8muuOEC8aYZG+Ew?=
 =?us-ascii?Q?cFt1N/3zyg3wlB+3QGzlqPH0wWAgX3CWTAQL26lni4hjUERGHpW8TbwmgcuY?=
 =?us-ascii?Q?fqGNk2kdh1vvDI/MY4fkcYwFLnSL5euZgRs33Es6WEqUa3gRAxVAXwr170m/?=
 =?us-ascii?Q?1JWZpqGwpgCD4nar0o8X2TOA9I4HGVpdTaNSxq7TXnknlAOoswMPXIHzOD9Z?=
 =?us-ascii?Q?q9xFsGw4UZcy+LJoRokW2HClPnR3RclFcXjo/MEEUKtm3eD38Lv5tpZb6S00?=
 =?us-ascii?Q?Msy3ITKEQd+O49/Tv6Jy/+oUss9HW92WBX8NEiPFSNaGQfkSVThkskajnY0U?=
 =?us-ascii?Q?aCkvRjDqQbk1TRFz36pqh5SekQN1CpIGb/st8DzBUC9NN+VH58oTOiJxVJzh?=
 =?us-ascii?Q?RUqidGtAT98Y+6j04r6P0CEzKXYtRYUR/jlRq/joPNFMmpbe7zInWZUfdNzc?=
 =?us-ascii?Q?YgStHbdLelSOxuxOoukf2kjbuFni4oUAAK8jwWfs+X8qjRuqO1p3vgMV5yNJ?=
 =?us-ascii?Q?NCXv79QtnIEsnM12xx5Ve3IeZcVpAuaI7/r89IyEOcAS23u0QZJOtH8PJx3h?=
 =?us-ascii?Q?hLY0gqvoKjAAsh5iUsZ414sLWQLdW31L6a5mpFuH4ulYqk1Ma7AVHEvBAzdO?=
 =?us-ascii?Q?ZRw+bW0Y8yKm4xoshRDgugbuW5aYYZJF9cZiHeIfC0OBaFrAKUt2dBAwACXI?=
 =?us-ascii?Q?QvJuU3dpn+YKEr2OqIOb6FaX5QKgWzmARAcaDXVx6k68TtHA78fNA6k4Bw5/?=
 =?us-ascii?Q?NmPQiXPQng2dfWiEKYcKlhi9tbW+6G35PdHqwVMmksolhWER8oeQW4YGz79N?=
 =?us-ascii?Q?EM2SGYqxNteYkOqjXPeaNOhSHour1o1s4F7qtf54snTLNn71RL29Py6LANrp?=
 =?us-ascii?Q?D+qwFi+7rs45P3gnflbG2MqcD6NBEunEKEX4EGrZhAeCQPJ18508nXqWCT9k?=
 =?us-ascii?Q?oT5k2tY+56a3V2ifOtu++6gVkpNjkfFYsH0aszraaGGRjPZvKd4m4tnicuN3?=
 =?us-ascii?Q?j64RzGf5M401Tw+nlWpQSQC4jQKC5kvewCy086YykJ/DJSWXzlBLxwiCrgt1?=
 =?us-ascii?Q?P1HmWY517RnFiN0fa10se7MkUld1T+aMhDs1DypPTiuhDwnWB8cXSx+dczPQ?=
 =?us-ascii?Q?V4/cRt47+UzHrKxxRHd48CZGiug1fRUemNSYQhlQBdTQFT+G+tN9Ne4VnthK?=
 =?us-ascii?Q?YjbnVDt7iiHYTheAt/gh/UdvbfRoe2IDuSlVVk62c3i9m1GLIAZ+GdwFD+3J?=
 =?us-ascii?Q?Pc71zvF8PE7ZHYC0NsTPvGbwc/t3/8H0z9Rd7ueB8ALq6gGKfJptt2o75siM?=
 =?us-ascii?Q?8DL4a3l/1QhREQdlSzkYC3Le/TUdIkOsDr5N0+28smwjlTcnIfh1iF7njDKQ?=
 =?us-ascii?Q?v4R1UefPSadi0GHWbZ3WV42HjJ7vT9poivWoClElgdifRE28K9e+Xd1pB9xs?=
 =?us-ascii?Q?esGAfMHUcAQlzvfeF8wmpxW79esR1rLF19UzZocmBUwvuhZr8vts1nyRPNwm?=
 =?us-ascii?Q?tH8CQYn+xlMYEX7GobM0lD6fjm7B8G+9nER2g/WiZLqH+QUS6xl4p4dYJFLM?=
 =?us-ascii?Q?pB3hvpaxuA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ce1e50-df71-4ba8-6ea1-08de79125c58
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 10:48:10.2913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFxxcHv1afyj43k/TkLRCt13Cb82Fb3VgQotiexqEh9R65C5q6gTAcRwSTagwoSxCI2jTmZ5jBf0hQ2ZguIthg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11926

From: Luke Wang <ziniu.wang_1@nxp.com>

When 1-bit bus width is used with HS200/HS400 capabilities set,
mmc_select_hs200() returns 0 without actually switching. This
causes mmc_select_timing() to skip mmc_select_hs(), leaving eMMC
in legacy mode (26MHz) instead of High Speed SDR (52MHz).

Per JEDEC eMMC spec section 5.3.2, 1-bit mode supports High Speed
SDR. Drop incompatible HS200/HS400/UHS/DDR caps early so timing
selection falls through to mmc_select_hs() correctly.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b1a3cd574c84..3e163f14a640 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4539,8 +4539,14 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 * their platform code before calling sdhci_add_host(), and we
 	 * won't assume 8-bit width for hosts without that CAP.
 	 */
-	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
+	if (host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA) {
+		host->caps1 &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
+				 SDHCI_SUPPORT_DDR50 | SDHCI_SUPPORT_HS400);
+		mmc->caps2 &= ~(MMC_CAP2_HS200 | MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
+		mmc->caps &= ~(MMC_CAP_DDR | MMC_CAP_UHS);
+	} else {
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
+	}
 
 	if (host->quirks2 & SDHCI_QUIRK2_HOST_NO_CMD23)
 		mmc->caps &= ~MMC_CAP_CMD23;
-- 
2.34.1

