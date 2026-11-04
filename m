Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.125
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793791643;
	b=1ACVVmJc4ibmTP72zeRy+0PzGleNvnRyX/Th/LCxtzkXv6E6OqP+9p359ojh5zQ7cAOT
	 qQMFq2sOYY5GRAZ3WW3gngpVkoer4/sPwasAln29oWQ+0gVtzukfWstWrEcjNyRteUF1d
	 1cHnoyD8Vn/iExz058Tv4yPQfL5RFDnNCl502HjGeL+XalPGs6riTnL97a0Xbr26mPLXH
	 xJzX6vXt0hE4Nwwn8BctziuR+u3tp+ciPikk9HbpFaHRVYNMVoZm3SthbeJ87DuysGsr4
	 o9yeFCGq9M48q9pikco+jy97R12yn7/Eu4vyFLyBFmFilcp4Pkz06Zz3iIHth2QyKUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793791643;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=719IE6IGPTurqyYMntECg3euF+3obwPsa9T6X/oN+mQ=;
	b=WQF0NVLsw1lJTW73eFHRni4+9ykm937CXmlb5hzE3CMIIusqLljPlWndOPGlqFQABz/X
	 wPPWi7myW799iciDvUjoC5mbf1wLeGmkH4JZJolxLcst51/zTEP1YllNzEYPn2FMveRaI
	 /Qyu7/+jcMpj6opRMjnXlpdwRadAyUkI6ZHDO/G7gdkFRJ1IBDMaYw5ePaJNx1H3xk3NG
	 jU/6zl3+9ftFuyzWxI+wZI1vXwv9YkbBPxAR2v0YvW+GFbEhk7l7p9xCZWup8pksinIJE
	 aX0jG9z6xfA2zoSCNvQ7Eby0ykxSHe/7TrpV/6Jb66A8P0/qrFieRqlyI+eYwWB5IZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=starfivetech.com;
	spf=pass smtp.mailfrom=starfivetech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.125
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2125.outbound.protection.partner.outlook.cn [139.219.17.125])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6D6606D814;
	Wed,  4 Nov 2026 11:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A6D6606D814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAip5a7MHUaclqW+kqG6UeOlY6A+JiOjtyNSs3UUFwbVrGFhDh0ZQwVO7B2O2l65qYijB9cu1cBSrbSzKx36zvtdudooy8P1mtAjCCTECtb/zMZ42dPlXee2AVzUuvxXVOSQppU7H2XKbF7Kt+S3FvQJVocKx7vZNpwpAOsNSJphnin6R399tcFtlt/4HTdItdUAe6CgPNcvYZwPpU4zWaeAZ50ffKX1ptrKzspKCd3ETCdbEZU1pnE3BMDIxu8pwkfHouWs4MT3JzDCFDxYAbqERaQmx/pFJAJjG/8UoXJdsTMce+6pIUuRIXCL/P3f6uWfnEG26SZvfvEYgPZBZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=719IE6IGPTurqyYMntECg3euF+3obwPsa9T6X/oN+mQ=;
 b=jnBYk99v9lR6lUkft7LhGQNfHKrf9rVdHbElcTwtPt0xKvDamJaozr8ypBX2xfRWJ0zD4/Nuxh8sqf1rIzMsJSINFyhKkDaUZkL7HkxCAVYZXcfLH6I95rThPyV8rLSrXrL5NI57MaFDEZOKmCMT+Dewv/mQKEVAzsgereWe78GXy/df91h72yjz5LxQD17mMogLO8rLSjSbZ2iBfMDiXxxjQgp96uIZblXJa3c5NCi+iO+lti6gX6sKmH0yZkWreXYPQsRfOL8P17D9QXm92OaJs9NSvENq3vuuLR9BJ8BJXZ/nblkNH1Jo5vJQd1e1EckFpoGBcmCFYelq9N27xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1218.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 11:27:05 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0592.009; Wed, 4 Nov 2026 11:27:05 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Asutosh Das <quic_asutoshd@quicinc.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v2 2/2] mmc: sdhci-of-dwcmshc: Set CQHCI command idle time for StarFive JHB100
Date: Wed,  4 Nov 2026 03:26:57 -0800
Message-Id: <20261104112657.110536-3-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261104112657.110536-1-changhuang.liang@starfivetech.com>
References: <20261104112657.110536-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0007.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::19) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1218:EE_
X-MS-Office365-Filtering-Correlation-Id: d41a810d-7092-4114-7a10-08df3a668e46
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|52116014|1800799024|10067099003|18002099003|22082099003|38350700014|56012099006|261026121527099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	cfaaP6m3ZJFOg0JqrJQOSrpCoWXqgE206tY3zsM6dDu1OX4/eo17/XQYSpM+Z+utn0B+/OAWqkK1pQnS/kuhNv6wIc/vrOwrqo2LLvNukHFN+lyA5/hoMaNAH/bHJE1a9NCCEC5gdIprtYyhSquLh3GxyonVoYnFUWgeCcM9T5PeHtlnPBdkqRVHfFmozSXDMc1MICOlTSHk3gRQOuIjH1UzteUwovSTk9ZdidowSk3rNOYez1GocC2CdXjoh5x8fviRREWmIyhQJyRnHQcpfu4AWTan/jiPhqWAllOQvVgNtV7M700INsPuLgk+hf5/8YG6IHLgAyQaWIYoYd6ytd3zDx4XOci/Sechzp+XY1Gub0ovJzO8uNXTl2moib1DrkC9V2UU1rbiB8vIgZpmmDaEmyMm00e+oeAG+H01/xJmRhxsOcPhd9yKi2bpvWyV4WgGJKNk/GE9wlnJ5A3iFpenijtnXcShuwaCERp3C3904w+3pc18i4rRcJo65xwh8d4TlXSjkS2TSHCeCsbIbklFriAxGXH2epb4Ega99E/uuWhSC++CkDYay/KZF0vW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(52116014)(1800799024)(10067099003)(18002099003)(22082099003)(38350700014)(56012099006)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DSbtvh05VsB3iq63EMVybUkXc60r2wYm8HjvGcECdQbpN6SZe1UoTcbaSl8b?=
 =?us-ascii?Q?PVG8FBsqzBYCBr0U/epgU9ydMu3eC/5fZzE9T9jh2/cfA8n7K1i/fhS39+BB?=
 =?us-ascii?Q?z0nzCQXgMGDXfvcQqOQg/8BNVG6Ah6cbHfXl2BvRhNHIqGPwdOVyCRlUw6G+?=
 =?us-ascii?Q?Ul0FxI3IEfcT+zgKdWDiuf6UoOSUithb/hRrunVSYxuZyTC50PpN2XIHusPD?=
 =?us-ascii?Q?/AT3cGOady69UqAFM2v0+PIQSzE54dH8S5FOiEs8pDWhSKgisRFjBeLKuozQ?=
 =?us-ascii?Q?BoDP26SLjE22THZwNI1m0Y84KCfcy2ciEY5Ix7kRE9NVUAmmbsp4YfsLEGRI?=
 =?us-ascii?Q?/ppxd0aEwPeqwZ0aRJ5dADQ7WD2iHFZb92yr7SqBlUU1l/YEzocIa910scac?=
 =?us-ascii?Q?S2uIwvs60VIgfRxImryc3HLrkiXBQqZVJr8Yb5x80ro2ICP3YGx8+4AOE2kX?=
 =?us-ascii?Q?nA0Gf+Ca852BkqtfM7ex07WXTuQmGsiSI4l5M6iqnllrQI9WRZbWqbtIQg4M?=
 =?us-ascii?Q?zhsHa0UJF8Pm92jYv1T0U7sth0HtXvC00rYqstEe7KH8TqXOGK7w7EpvKEPg?=
 =?us-ascii?Q?Jw8gEZvXobEq/sY8T5uFSM3CDe79eHhJYS5TgwsU8cCiqJzZxD66DCJ8edon?=
 =?us-ascii?Q?F8EDGRQeB09E+M9ZUyQWIsLijpSGqlSGVZbQ/9PDept8CocUIypf2k62itFj?=
 =?us-ascii?Q?bBMWfXYKXjcoyCe/iNuIY1kmR2as7M39tj2NtfS65fZf1bQymNQqM4WHihSv?=
 =?us-ascii?Q?r1ADUQj1IlY4eyDzApUrF2f2PmeuVCnN+oXsDYp32g2N7dSpv1CpG86gL+bB?=
 =?us-ascii?Q?Sy05bo9CW/y04Bv/4TuFCZiqATUs2WkHAI00BokiFFIdm4NSRcYz+Jn3VkjO?=
 =?us-ascii?Q?LsGm69XV4vzwNh0EbCh/6FFUZ8u6KzIvUyiCwy90qakS/3BekGUDUmDK0RVo?=
 =?us-ascii?Q?2hIRPUehp9Taj/kdt+m5TuHQB2sDVifoIWkxnUrgUe/R1VKvuBuGWOZsgins?=
 =?us-ascii?Q?N52WZokTPxeqpHYGMsBRcb5HgJyeZeAZFn6rMGc2tU+otEQ/LYPogWF4Csj3?=
 =?us-ascii?Q?lZ8GnH2nks5UBKl8QgOkkyK6uvjuG50RL3Tu316VbsxD5zmHQRO5qMlg29nY?=
 =?us-ascii?Q?mqZ164jZNgNUADceUAs/RE5iEV6XtPZ9YVZrkZZnSb93xELjno6Vf/rsz2e1?=
 =?us-ascii?Q?OtkJyflrxkU6ulwS1pkD7uv1caTGfnhvmQ8qN6+zj6bHWsOmgIEGUbUrsITU?=
 =?us-ascii?Q?dCngS+TBP5Z26en+ze4L6QJLlhCqm6PmI+909pQRtaasKgZKAFPdydp0Jb9e?=
 =?us-ascii?Q?JGLy5xTnqVkY065HFTNI5WhfqCQxasaYCo6LpAGyKx/HgGBzZ6Ckq967HQvd?=
 =?us-ascii?Q?5SFPPFRoiii/hZ88JVQqCq3gUKh8FVbeRxf3UlgNtTiXpDgeJXPxA5eH6sj/?=
 =?us-ascii?Q?IBwf4a81X4ct/8qgOi+IHsdcF10miciiwGNKd8F2tTsJ2bWo+bxn5faGynAo?=
 =?us-ascii?Q?HimTnXAtJi4dyfBxuF/gUW3tR4rRyVQfViIf+X49On4swbTN6JjdHV1xZwSZ?=
 =?us-ascii?Q?7o7wezcn5AWVuLJW2xexxSJob1IpUcYWLdG3GMwliGgtyd92/NLpTwfsHB+2?=
 =?us-ascii?Q?jTjvDgBXESVt1FMQ2Hlad90IJDpCo/h0c6mZxeiXgDh8DFvjU4eWRm8dzY46?=
 =?us-ascii?Q?3Zt5OJKdOP1sTO+5VpX97MuFg0+SihR8TEjdCQIhHdpl/vS4Chmgix51QFVb?=
 =?us-ascii?Q?X8TD4w0iYjqcIET8tbcQfiJrwW4H/Q9G5pITYYCYic15rmcs+jxS?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41a810d-7092-4114-7a10-08df3a668e46
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:27:05.8922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: in1JB0ybdbHlOuWJSxXnC30EfQio4FSYJCo3ly3Ss2rHUgoIwgH3katFN1nfV/FRaS+RhkosMsF2tQFGMINK0+qSFvnOIBq068P/+BLlGzpa8jPU4kfND0+0Ua/BRXUi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1218

Add a cqhci_cit_ns member to struct dwcmshc_pltfm_data so that platforms
can set the CQHCI Send Status Command Idle Timer (CIT). When it is set,
dwcmshc_cqhci_init() passes it to cqhci_set_cmd_idle_time() after
cqhci_init(), and the CQHCI core programs it every time the CQE is
enabled.

Use it to set the CIT to 320 ns on StarFive JHB100 to improve eMMC CQE
performance. Before/after dd results:

before:
dd if=/dev/mmcblk0 of=/dev/null bs=1M count=800
838860800 bytes (839 MB, 800 MiB) copied, 9.38511 s, 89.4 MB/s
dd if=/dev/zero of=/dev/mmcblk0 bs=1M count=800
838860800 bytes (839 MB, 800 MiB) copied, 12.2127 s, 68.7 MB/s

after:
dd if=/dev/mmcblk0 of=/dev/null bs=1M count=800
838860800 bytes (839 MB, 800 MiB) copied, 3.19472 s, 263 MB/s
dd if=/dev/zero of=/dev/mmcblk0 bs=1M count=800
838860800 bytes (839 MB, 800 MiB) copied, 10.7587 s, 78.0 MB/s

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 249055f14162..afd392393ef5 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -283,6 +283,9 @@
 #define PHY_DELAY_CODE_SD		0x55
 #define PHY_DELAY_CODE_SDIO		0x29
 
+/* CIT for the JHB100 SoC */
+#define JHB100_CQHCI_CIT_NS		320
+
 struct rk35xx_priv {
 	struct reset_control *reset;
 	u8 txclk_tapnum;
@@ -322,6 +325,7 @@ struct dwcmshc_priv {
 struct dwcmshc_pltfm_data {
 	const struct sdhci_pltfm_data pdata;
 	const struct cqhci_host_ops *cqhci_host_ops;
+	u32 cqhci_cit_ns; /* CQHCI Send Status Command Idle Timer */
 	int (*init)(struct device *dev, struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
 	void (*deinit)(struct dwcmshc_priv *dwc_priv);
 	void (*postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
@@ -2412,6 +2416,7 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_jhb100_pdata = {
 		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
 		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	},
+	.cqhci_cit_ns = JHB100_CQHCI_CIT_NS,
 	.init = dwcmshc_starfive_jhb100_init,
 	.deinit = dwcmshc_starfive_jhb100_deinit,
 };
@@ -2471,6 +2476,13 @@ static void dwcmshc_cqhci_init(struct sdhci_host *host, struct platform_device *
 		goto int_clock_disable;
 	}
 
+	if (pltfm_data->cqhci_cit_ns) {
+		err = cqhci_set_cmd_idle_time(cq_host, pltfm_data->cqhci_cit_ns);
+		if (err)
+			dev_warn(mmc_dev(host->mmc),
+				 "Unable to set CQHCI command idle time: %d\n", err);
+	}
+
 	dev_dbg(mmc_dev(host->mmc), "CQE init done\n");
 
 	return;
-- 
2.25.1

