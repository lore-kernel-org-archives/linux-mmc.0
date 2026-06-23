Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011071.outbound.protection.outlook.com [52.101.65.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDE13C8716;
	Tue, 23 Jun 2026 07:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782200036; cv=fail; b=Ooo8dfCCUbeKw++1j2LYcGH3TM76AknCXe03/PxOleiIqZHJi0+mL5cufcfPxij6HPEffyhRG385HxsaYPPbskwuGM8Ab22htm2bc1/vTsXshNuHxiEKV5oHRVGTNhsowLn3KU9xU+h/crNX4AvZRTk2rhFQJILcZ1HedGXh48Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782200036; c=relaxed/simple;
	bh=jlYV8zVgFRltLbPWJQ93Ywpcrmgd1OTS9J2uonlBOnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QHYY3pr2O0jd0QHnhrp2oAveWgytuQGCLxdDBtYzPGovGiADwWdJ+e/E/6kcpEI8RhpqbFYCFDu1LxRK+1lsLpU8fyk+LGfgS+E1ZWOscQ6nTXUlh/D2aL+xyWtDnR3G/hOBV/QJHG/mNaEOvBtlcktwa8Ft/UCsJkCE6l3gK5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XnLq1gjj; arc=fail smtp.client-ip=52.101.65.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XnLq1gjj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DeYedYQ1yPrPpfOLaGX/GxzHtvoMhiDVxtK7QK1TpDZsdfwDSL2ZUf9FSvoN+KSel7OBRXaeufiUM9SgVCcaytptaZwev5Iv25UJ2Wr4h945Xtozt8xKZlcYJ1QeWJQ1W9/AX9wgxXjxzfjUDa/Adhpgf8fAAg0u8NeGTSY7k1OPRrBjc4uKgWmW5EQklFfn7iBagXLaniw4e3SVtcjZUKhPrE9viKePYsgy8PhPvt+ngEOsV8VN3xryLG7fAxch43FEhjIEBhTKag4FQlavfsP3y1KiDbcLz8zTz6Kjjd3SRuLNncJi0dLM7hm0+VDrmnmbOYfzll8QsvhlAaq9cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJjWidpRQQzbZpxCZVcc6nLzUmCyrCIuvEaL476B8GM=;
 b=aVnsrwG1LBnjRaOYNS8EQ8cciNjzEXnuTLSUN4hmeIaKMNeERLJTT5g5iOqCIllvmGscWEoiV0MQAoQqtHsDbKaqOQ25Jj58IYGrij/lLbXvRY8YHfsfD3Gf04YZP9aq3cFKRdpyb8PvBWXzmh4/f5kdvRx1H/BAijs07Pn2oulSiDknw87QPhf7NjrVrXrbeeg5kgEsfQd8BZYV43mwGoDVTct7uO6GJOkwojBu1XohE7XKaDyRFgTABAYD9nro+p9giCiangD1ud7wmJIx9KHFx69PJmzIntteZW/5rL4FpOtJ3eqrENkb8zysHifjWoMYk0DBs6IoTd9n5+CVng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJjWidpRQQzbZpxCZVcc6nLzUmCyrCIuvEaL476B8GM=;
 b=XnLq1gjjloqj7LHgAMl++R7B47I0XfXi4YEXhstbh3hXHP/FxuQ+KBqihfAKSXiIcKDv1rtG98+J9cq0WWbOayXJcd61HF+mi/fWxNtvVKP+bmFcreuL0uulCnaO0o/NkXkqr2Nl5U09+L49TaSCFzS6TT9yEYXYmRjDTheFLphwE9r1QoBt6gxgtVLCATadL65aFDrsaFeMX8OEGBua6AXUN4mxQqKxv7gVh4m37URjsAtuXmqffWuOJv+O1FfXJLowv+tdsF8WQWgd73CL0Dtk5ybDS05QzSD/4ogimMjbOqfnoM7lGLhA3AG4IOdc4YBQuX0E7JTq0TfClbxe6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by GV1PR04MB10822.eurprd04.prod.outlook.com (2603:10a6:150:205::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 07:33:48 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 07:33:48 +0000
From: ziniu.wang_1@oss.nxp.com
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
Subject: [PATCH 3/4] mmc: sdhci-esdhc-imx: restore pinctrl before restoring ios timing on resume
Date: Tue, 23 Jun 2026 15:35:14 +0800
Message-Id: <20260623073515.2658205-4-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623073515.2658205-1-ziniu.wang_1@oss.nxp.com>
References: <20260623073515.2658205-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0015.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::14) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|GV1PR04MB10822:EE_
X-MS-Office365-Filtering-Correlation-Id: 93b0ecba-128e-4c9e-9992-08ded0f9c3ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|19092799006|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	bjnR+EMgD1pGY8pBwY0LX+TPQ75dizge7FLDHSBTLJwYI72AI7xjDasb6ScoqZ66kiKY5+Ul5F+qtXZQxrAV/J4BSlpmajD0jl5jkC39JW68PaXqKjwYFHjPB9pLe+oe63P71TdCemCB0y2V/USbkfocYsWQNRSXK2iZuj4xZJPgTksBWLLqZRjrRxFM2FoIz3pmAq0OjK1S5zCSTDTXBZkgKavBzMAzm/wZfprk9FjxEKkNvlYAnyU+nrIwjxocP3kQPMpl1S68t6jjpqmaejYryYtj3PXvyh3Z9r5bI5fI56Q1o2AuljvnTcOFHee2WJ94VEFqMAzdKUUqd7+1/QKLy2G0Z7jd+YUKuap+ejWpuUhLTxfvohK7tD4tF6FrpA3X1Nkm1pULY2Zvk5vdR77evvUBzrBG3gtIGx5EBhhGK9WjfvwGYNRH1Hsxhu7FyOE1L3qDlrmlZNrfJay9ub2AQk/aiM9cOuM5adAlxsjubkcRtJFpud1+0TT8ZK7AFABL2cm5ynSG+fOHOcgmyLtUZbM8m+ThGZLNywSZjnB36L/32pmjxtlRImIWUWE/v/LOF7vboGyuy0dHS0HtiuQIVl8eLsNsM/DtNhvcLgFHuUowQX30VlQs9P+AoYGPgjpF+fedHNGPBD/41aufldHH8clDo0phS9+JA9dgHos=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(19092799006)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?glzgyr9k36tKrB0idRQ8NE5ZA9lmcnGKuQldPxwNbwHBGVu9v7SlvYN2g/Za?=
 =?us-ascii?Q?T7auaqt80CWB6TctN9uR9xwhw5t79hIycKmGG47pAlOcGcFvHn5aBdOb43ZR?=
 =?us-ascii?Q?HqytGbzmbgFzmzlPMfQ0ErAFvh5/lhbIahmb83G8po0Xaa867VxO+NWmVcif?=
 =?us-ascii?Q?KdLl6qq2BUgCz8McXHK9Q30ou7dsp+A+6K7FRhfZEKTa4+tghPXO0k/zQQOd?=
 =?us-ascii?Q?GQCmASVbZNCaEtwLeM2eOiKZauUYwBJO5fWd8KABTQEG7mTcHNNlQT/EqF66?=
 =?us-ascii?Q?byUjEWZnc1Ln1C9WtboSIcP92e9hqkQj++0DJutn/0YwQ6GWeME2tH6+irHh?=
 =?us-ascii?Q?IR2O/ZztYjiksGZLJbG7Ga2sklp3RaiSbsFsmYOTTAXm6LLxIYURMwAc3v39?=
 =?us-ascii?Q?BAGdsPDBp3uCnod8rfNnmDBB8q1Z4jIdUlhsiflWog0iwHXAAZt+feSYXZ+e?=
 =?us-ascii?Q?4NbuH9/Js+7j6qF83iCLoUDlsxyiu/4obotMIZD8Hh8r0j6p89sBf4wh1b+k?=
 =?us-ascii?Q?sOqZ7kdk1Zd+xaKJzElY8KC/ORpt5QM0JH4uq1E801JIM08gvLMxfTZzQ73v?=
 =?us-ascii?Q?q8Su+RDCJ8UKBvW+UiqAnUReGtox2exDNpdeBAWfUgsMkwp4bsmBmHjwrhDb?=
 =?us-ascii?Q?gkW5QavHDSP0b5MPM5FmQpunEQ/29+/KtEqhMJRMNHRVykqG4c4A7eYjzyKx?=
 =?us-ascii?Q?OqhXeNUlMvAPfW+LgAkqccSWxH+u5WFlRODW2SUjCufUpikFmoPt2fqLG5tc?=
 =?us-ascii?Q?qtu5nviuHLNf2S+Ln5+eqbzfs1El7kZOKfoHxlENC4YoeUQBgogF/+l7dY7F?=
 =?us-ascii?Q?sQVJV5w17jBfGdnHkfruSAX2R38xxBYY0l1TG+XVPwYgorDugv9fwa9y0OyW?=
 =?us-ascii?Q?4V0G10zz/7p1QEadcJ9A8Hjl6PUO+/daV6RoO2qlmYBSnScmvTwkFv1qYLGd?=
 =?us-ascii?Q?0lW8TzciIZXymJdmlAYQDeByfnlHiTxuJONQoKDMfNfl0VSGgv7Rt1jUkHy8?=
 =?us-ascii?Q?6gVkSrfrxbkpf219qs6nPEQogzA1eTZzfmA416tWFGt1SBaWQVPFlou4OnQf?=
 =?us-ascii?Q?mOdZpYF59rmiTtOxfjbD+9ep4Z6YUDS4JV9b3CrzEhUKSmqLFVQAVrXoHlO+?=
 =?us-ascii?Q?HrzRlNB08dXZ+WoT1Fx6nJSbvfjYJCxKioNdqKrFUVo/jlzrIrra/8vVKAgx?=
 =?us-ascii?Q?RBVUmG+vnKUVHAd8G8Q+g9GOB1RoCX/LhSU8Vws9f7IzqvSF6pNqwceO8gpj?=
 =?us-ascii?Q?/kiP8FlbYqH2mdSWH7lLUR0fC6ElJMf0fUXMVAC4k4PiJ1PiBEJMxM3/LkQv?=
 =?us-ascii?Q?EoK8s8FiUp1J3GACXFzMof/VOLFvtrP5fTIp//f7aqP3D+ZL5ZbK0coRT9IP?=
 =?us-ascii?Q?z+uVvT7PEdtbND23eT4rc6Nc3FcYgCSPRZSB6MjBHZph2P1UPjaQUK6bc6FE?=
 =?us-ascii?Q?4VPzxWs7Y7oKSjH9DyfphB+h9V+t4sJW5vMg4DXh6LAdxWVhTL/PB7ciBhOg?=
 =?us-ascii?Q?G2y/W0M1kJANaJYcfvhRI523ERfLHGesLi+IU3lWb3uv3rCeSJSBNBHYHo3U?=
 =?us-ascii?Q?ZaCqYyvYkHwMYJT55KdgZuLH3RRT6H1NT15Jq6MtNC13xTjV/FHLuTI+qOWN?=
 =?us-ascii?Q?77yrAF0Xu94Ew663/SAcA9KcJjFDru4RlCyBgkMpNTi6PtliAoSFptEiFUOK?=
 =?us-ascii?Q?4k7QJcKRY36Y85j9WJziNM9dMiDACp4uOusaoMrgyGdQkzcrM6Ghm5IUrFcO?=
 =?us-ascii?Q?ohLHqRISbQUTO9Y/17Z3/KUF0nr6w0DVg/loc7LA4QgxWuc0ev27?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b0ecba-128e-4c9e-9992-08ded0f9c3ae
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 07:33:48.2945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ah8aJCcEs4V6vvt+GuT2DV09aB9C/BWRamuDfNiNQygOTsKgo6X3B3jfYZPMustJV3+hELEWD6PIEslcXMHMx328+zGytWWOIvkwIUJvXFQEHePYzAnlHaIeP6NayThE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10822

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

Fix this by restoring the default pinctrl state before
pm_runtime_force_resume(). The timing-specific pin configuration will
be set later by esdhc_change_pinstate() during runtime resume.

Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a944351dbcdf..a3688c94cf58 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -2114,6 +2114,10 @@ static int sdhci_esdhc_resume(struct device *dev)
 	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret)
+		return ret;
+
 	pm_runtime_force_resume(dev);
 
 	ret = mmc_gpio_set_cd_wake(host->mmc, false);
-- 
2.34.1

