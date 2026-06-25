Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011035.outbound.protection.outlook.com [52.101.70.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DE4396585;
	Thu, 25 Jun 2026 10:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782385054; cv=fail; b=mu7zAIifpqgwiDjLx+9XThgiYL3MUBSyM27Wuz7P2cObgNjryepWIxHUtZwJg0D/jA6eUT2F+lq3d4t0bfrAwpxyoSdaiel76I8pzrWaspNIfSCC4NGcxSGMmOCM4n77En29cQ/b44W4SQQU7SpcfdAmW16l9zasJneYizFrRNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782385054; c=relaxed/simple;
	bh=usqzYFo/GTogJWvMS8aRBToOP1gL6qaX5xcTm40vWLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P6TwYI7LcrWA/pgqX5XiQJCfFkw9o/ykQqjLm75keHvQocnOSQWD2eTZN24ZB7SbjYijLJpR1CPM90Pf26OMpweivlRB+v13awziRIiOBqUquzC+17gLXa/0dBopOd1WhMtXwjneP1OnOpKXgzW8aoE41aCRIZWwkty2Dcjd4Z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=i2Yr1coi; arc=fail smtp.client-ip=52.101.70.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="i2Yr1coi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFyWLPBUbT+H1bJKXx3C+PqVtAfPPEG1MutDTpO45HSbTY9o6iWdSgXVZ0p9b3CKT7toHlq82pVZLm6pUe3dA6jtg5w2lQNhVRIfu7DzefVRnLHMas7mv4HlCNiUseu1xpdYrhwK/VJ9wsIZld763I5p6TB5tR56dYgt3M4WLHHa1G8iab5STIMAO2UGPfbwgNobzFNSn/jad1DN3wanALFzi2vz2CkT+SJaSVt7Rstrctq4dJCQu8PXMAL0Azdd4rdiJqzQ4cxVeKLl0hPpHLun4B85NHEq5qpLZmbk4LEkbjQW4Ep2wq4+og10lKtrsRqjdUfWvmpa9Q7WXkufzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QYBMWfjBA5IGj6SKBSNSYejqNOcMQLd0WdmHR1QT6k=;
 b=A7h5zjD+Lx6xXXSGeA4Rt7NBj09IcbFogub++EGj/kSDvjNobT9mNC9Jgqer3MKRQhSHpRuCO2Lb6aVyX/yrVhSyoOjCAENAQT1iisGVoyYymETPKCm6Da2gE7hDuoCb0YC6W/vvlhdKvP+bsL9i6jQYnAWKljUTXOcFHqV7EuiKPoOCGGFFulvoc06bcUVUjH97Mm3JqhasD5Fqmf18/DTzwpnDCFtLM0obdA73Mu6BFrsHb6w/k3+F0oR7vmnCR1PRnwWY9KsKoX2xLyMxXBeH65QLhVaCkzJUZa0t2HZu3R3nNyLYzi+4WAUC+InkNGVBhjSduB1zarV7gEgbIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QYBMWfjBA5IGj6SKBSNSYejqNOcMQLd0WdmHR1QT6k=;
 b=i2Yr1coiwh+7OeDwQ/YA4MsP6SCd6OQgdFtlqoIxA2MHlBQmozpKSvEnFckL5PXkWCRdyMeOve9btnzqrw7UUdFg36MeMuXCpQVJB62mHPJkI+x7G0gFNOmMyIgnxZFWU94rJZ0WSSBeI0sn5JL0NMQ1ARb9SmhCcxzxciqkAbdDz1IVK6jl2SLTI0B1Rf2oPMHonjpk0MQ/jNWSBNAffK8PT2mdiPrs9nmSl1hXwcIPuzImH7r6gh0BNAn8F3GckG0lBtzcKlVOoWyQU6CoRl2db5U9NVoWGHaD8Zud6IQn8oEwVQ3n5Gl0g7u9JkCXYBJIwoievSZ38CEFSOXIHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by DUZPR04MB9823.eurprd04.prod.outlook.com (2603:10a6:10:4d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Thu, 25 Jun
 2026 10:57:26 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 10:57:26 +0000
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
Subject: [PATCH v2 3/5] mmc: sdhci-esdhc-imx: restore pinctrl before restoring ios timing on resume
Date: Thu, 25 Jun 2026 18:59:32 +0800
Message-Id: <20260625105934.2890635-4-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625105934.2890635-1-ziniu.wang_1@oss.nxp.com>
References: <20260625105934.2890635-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|DUZPR04MB9823:EE_
X-MS-Office365-Filtering-Correlation-Id: 10981b4e-ed35-4ef8-1c22-08ded2a88b35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|19092799006|56012099006|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	H4hScOoSHgOMY+FhxaVnPrsCxSY5B2mdETYl6Lv8/UQpxRmok7Ix3Ip3oidy9UmBKOad4+gUvH+9zU6Bo9kAfNXCCzVcyq+Xdi/fxt6KvDnMp8X1U4YbkzjmrTGK6tL7wsSzZ9LSgNptLlcZqXEEct1LZJ8eBUWa7pSKzKihX9tGkIyrpLEFS3PcLRwMe6PXhSInC5SLY6/P78mMcPK5gWtA99O1HnyTqh35/yAYGdy6S822jg0nyFgYlzNnJWbJNSskR9EVhQJTTnQKG1mOwhMPpBt4fNXzuM4xzCNfOVyePoYW5GSzsUIjX3fHdU6v0tUMOgxM+c/mKBKUj8mRoRn6gI+v5ZYeJN1EOzXEU3woScNa5/G8tvc3/OuVGMNpbMwGJhxmj5t5s04WwdT00oN2BXRf8iQrt3sKl4aqoo2BGiXd3rOL3gur5WMznO2VBpB/nk2JMcCVQFP+BJmMsyBKVJQptoAdHMBSIOHkELGs2NlOZShv22IQwKOu05a+yhRHFP3VoYXmkHeA2ZfSXEzEy1c+KSO5DjSdX67CERVTbzcUrvdRKgTEVamNEUigQataT7rwqI2UIjLyIpDXvGyoZFNHQvNO7VgqtuEOVFnG+R9pfpbAJ0UN50v+SS+EelkIsge7G4rkuzRetqMXcNKIbN5KL1Gm7/c/c/npZzY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(19092799006)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kt1fmh9QC+L0Hu+lIgsA199+NU7h35CPVbpR+g86UFpIHRSBAd9BSHkPJyod?=
 =?us-ascii?Q?FznycH14deqDfyegPFY8uQiOOne8Ltc4EsUzJ7vo1d96cEa/nSeZz/7sBN/n?=
 =?us-ascii?Q?dcXkitj4+mtkUGD1UCSJw0zkOGrJV6yXFCiKfqbL8atcu1Cx4SnAqr9V1Kyg?=
 =?us-ascii?Q?D1VmGsB+22LO5z4MbUABoejFxSOwTx3q/gTKGvmhAzBaE54HhBPm9kk9iL+P?=
 =?us-ascii?Q?Dmcvp4feNcGd+/cAnfwVaHvMRFAZfwmthXq81eCRr0zhToMD0Dj9npcBgPRI?=
 =?us-ascii?Q?978fxT4HFZPJGSauNLqrScdtyeRRb0uPYfYxEiMWvk1VHnZwzVTyikKe+sxa?=
 =?us-ascii?Q?0jHwjpk+of/OFy2Vuj1O61itE7JnYsEUuJoSYTwguNfVXMcqUDPUmFV0cMdf?=
 =?us-ascii?Q?y3Fd0v/oE9x7dLKjElwMzZX5SW7XjFxmc+GN4Sg9gNWHT+ujmo7KUOzZkYJv?=
 =?us-ascii?Q?DMhIFp72CI1VYo+ASzWzgBBseoDrSmGablg6nZ+dLVqDljy71oxcyudC66BQ?=
 =?us-ascii?Q?2OYnnnLn0mJa5RbLlLCUNogCegZnHOwKI2YghB/8mZheHp9v0Kj3hzvFTyq7?=
 =?us-ascii?Q?UAKvfktJ8IcOrvTh+gKrOmza2icEmQ9Epw3H4rGbPFrIlFYwEUdSwNQCbG0G?=
 =?us-ascii?Q?Ov2r60CVVKW/wZALyLBp9AzJW5qc54JgPJUaWdW144+FnXikORIsg6LFj6pS?=
 =?us-ascii?Q?qMmZnj19TrLpMUG6tSAl070UNsvKutDFauKBotkJYlPb+nRtrzS3eSeqqWyH?=
 =?us-ascii?Q?kQBpf2LRtoCQux+EkGdv7BVkJranWPzKBNyM0m+9PxjV8LFd2yGQcyrBvI9z?=
 =?us-ascii?Q?woStR6hDxK1z0+vAtq0RoGKDRvPgDsPJ/ccicCSzJim5msX0b569SP/HYy/K?=
 =?us-ascii?Q?Ch+kyx4LeuYC9b82yo0CN2DcgWzVoGd92pzVduIkmc1+MIrB7TXguUkH7gku?=
 =?us-ascii?Q?+vpd0+EDxGKQYO8hTHc4maJYYv+uMy7Dw7kQrcKF79lY1u+21//kfbQ7uwfy?=
 =?us-ascii?Q?kt8wVO3fEH3fdZB3rX0debO7BSPsE1jkhRiYZE9gQhIUlSGnpEoRg/sNIv7K?=
 =?us-ascii?Q?+1KM5G9lPJyn0at1c6fZXJVK4lAP7L8oqaphAaHbUr41+NvWMNMeg7D5W9bK?=
 =?us-ascii?Q?VLZBeBNHdz7nZeb3cmuCmtUmMe3YEuSp9TLDydYvzv/8mwIvQAjh4kvazxap?=
 =?us-ascii?Q?Z8vEY1MH2AiLBnruSeCS39RoYHWB8qUeIjAuGoR8MgzgU7jnAmxgYTj1KXAx?=
 =?us-ascii?Q?R5d9/NM0VroRKRF+ajLirzSRH4Be9aEoFA9Dd6cHq3ILfvAeKpiDvLQVvyXL?=
 =?us-ascii?Q?bVNJkXM/G4CeSD2ndnc9KwlcRaqzyIhXQNhlsWXXQA6k0jnmVn52Lj/V/+N7?=
 =?us-ascii?Q?IHFcDoRzLx7ACEqP77OL602DHqk9sinb1GLnlT0CDe4+uV8cyTRhHv0fiq3+?=
 =?us-ascii?Q?Abao7+pnq42PRTKVYnN7ezM4QVI8v79WIGg1qcCVOkO5znxanhwo/XaqXIdW?=
 =?us-ascii?Q?1l2bBmN+F5JCgJy+BulcdhKSlNPJ1Y4NW+JJAVVOx3D/rCA0A3hyGj/xcQO9?=
 =?us-ascii?Q?Luhf4T1ri4A3XehpoG2jQvQBwYQA4frGDmE/mzPTHa5k7rEl83oMSaIaOetS?=
 =?us-ascii?Q?OZD6zjFHLHcZaHfidJ+lWoFCKt0kvRfhINTSKcz4u++QH1FqUqhJxEBeqOfW?=
 =?us-ascii?Q?BtGCB17kDdBCWKPyN45x3UO0D2Scg/nXFrPel5jOeYTqtjTyiio7g1fONMqS?=
 =?us-ascii?Q?SbbHix4uAgIJxg8gks01I0H13eo4lyEYn7gJrSvk1M8FpDeyWiZR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10981b4e-ed35-4ef8-1c22-08ded2a88b35
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 10:57:26.6175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xy3qVoSnnAMhXSKOUACHzrztErkOK1H7XW5GM9Nzotu17p5ICSG5prW0o71JLPwGsmsdllM62sRZIMfx/8kQSCS6nbea/4VqD9ZgGe07udJWKaa/ghWHCaSGAjY3ro6w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9823

From: Luke Wang <ziniu.wang_1@nxp.com>

SDIO devices such as WiFi may keep power during suspend, so the MMC
core skips full card re-initialization on resume and directly restores
the host controller's ios timing to match the card. For DDR mode,
pm_runtime_force_resume() sets DDR_EN before the pin configuration is
restored from sleep state. When DDR_EN is set while the pinctrl is still
muxed to GPIO or other non-uSDHC function, the loopback clock from the
external pad is not valid, resulting in an incorrect internal sampling
point being selected. This causes persistent read CRC errors on subsequent
data transfers, even after the pinctrl is later configured correctly.

SD/eMMC running in DDR mode are unaffected as they are fully re-initialized
from legacy timing after resume.

Fix this by restoring the pinctrl state based on current timing mode
using esdhc_change_pinstate() before pm_runtime_force_resume(). This
ensures the correct pin configuration (e.g., 100/200MHz for UHS modes)
is applied. Only restore for non-wakeup devices since wakeup devices
kept their active pin state during suspend to avoid glitching the SD
bus pins for powered SDIO cards.

Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a944351dbcdf..7fcaecdd4ec6 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -2114,6 +2114,12 @@ static int sdhci_esdhc_resume(struct device *dev)
 	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
+	if (!device_may_wakeup(dev)) {
+		ret = esdhc_change_pinstate(host, host->timing);
+		if (ret)
+			dev_warn(dev, "Failed to restore pinctrl state\n");
+	}
+
 	pm_runtime_force_resume(dev);
 
 	ret = mmc_gpio_set_cd_wake(host->mmc, false);
-- 
2.34.1

