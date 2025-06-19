Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010009.outbound.protection.outlook.com [52.103.43.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BA52417FA;
	Thu, 19 Jun 2025 05:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750311367; cv=fail; b=abIy3urFPEtL+BrfZxwQwp3y2LgV1mBTSGx5OO0jkRHaGnSlh4GBQ7iwg6gi4tWJhMqXoHaef4BFgbRkMhHRZhVg0Q1QkCaStUuSy8cXG+oQF69/Nm34JRELDy9+nYaEtjmG8DVn6wrsTGBjr2uwpyhDB3ISzpGDJt5ucv7aoH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750311367; c=relaxed/simple;
	bh=l9E28H91SuiRZMiYj2wavzdI2QvFKzUsV5UOywqrTQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aCLO8ENTEaujygLRsiprlWMGrSVgrYPmrwujytdk/iB7/OLqkAlmFB17EM6q/FSyw7rJNwdKp9/ARfsiR9riwvFG89uAiB06B969iRlenYZMIIEfwXH33s9qYiUBFbbqg7YPxJ9e3fvj163thfpHTgPkfjjBWs4fIqM7WTd9cGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Qw0Wxa4X; arc=fail smtp.client-ip=52.103.43.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Qw0Wxa4X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igZR7jAJM9DORW36wUArvk/m531YVS9lx9aMvAZd7V3pB3ZtpAlC4BurqAA8AmViuDqc0nqQU2ELEB2CUjHA5q/kDe37kEz9MDk4nLfbYtV6imMxUEL3TsiL/SCUE5eZe+KQXPcdw+H81iG1uKdKT9faq3NflZ8YhQ4Nfe+RIfjwMYX1d8CH3HAK/irIs/OL8a4n2zkblIfQJEqDATDgJ1AIVdWT+5Qj1F6qRIye2WWItf4sDdtWcXDpzP/y1npYD8mvPQfQrpaFprHq97DvpuidcBFUSc/WgXEU/AVMiYGulXywvaMmask2K59Bk1Zbc7JBvuoVUR4n+mJRgg/Tog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4XNvnBmWktxueVjyOdJhHfHZggemsSL1h/OFPR7oMU=;
 b=hzyjXYgApZxIVyqfUHiKtCyaTpuuNQUmXYp2WEpsfrA7grffLzoSalB51V7vgwZWPNgcfkTSJY0cu0HKTNlaxM6xW8708fooNUe642MKSWZUGsFlwACGfgdf5MNX4AzsiZvcFYNOSnyE8oGAH+4zG50YNCsyemnBaXJKIe/imZ7CtIO8MeR7RsuBao8rQiw7gVk5oDrxopMfVUoAjBtDRH1af7D4Ct5TJNw9n0gm0rq/g/Wgy12xaQzEawUd4jqPgcHp7ltcI3UOjrFMXbsm0z1tAZ2fel9PJS6zmnUaaxreLdmamIHr5xbtlNS8l2zSToL6R8pUIMs6s0wO0k30WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4XNvnBmWktxueVjyOdJhHfHZggemsSL1h/OFPR7oMU=;
 b=Qw0Wxa4XnBsecqtkSqYTIgF+vEwbwiM3QAgJcrZXrwyxXGFTY5rrSEpaxEWiuoWfEx337Ce3PnGClCwYd0f2+b5fB1euRqX8fIZfIg/BgeGyIJi1++Y2cnZq6y36RIqdVKJvooTyP/Ai0R6SuwwmmtIDFPZGIQsePL3JJ1G2WdRb71k34bC6Sd6Z+SICg/uvY/PEYrRfkq3vqW471OFrULSBPpvXGTd+x1zG2TQhUR6BkXynahhyrtx35p55pcqmvmNK/QzycEpe+QM2s9wJQ/rUWoivUQ0V9leHAJSbqdtR80IWVOh2/4K+DAruqq0Gh6rRBij0gaWq61rSqWy+xA==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by OS9PR01MB16295.jpnprd01.prod.outlook.com (2603:1096:604:3f3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Thu, 19 Jun
 2025 05:36:02 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8857.016; Thu, 19 Jun 2025
 05:36:02 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: linux-mmc@vger.kernel.org
Cc: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 1/4] mmc: mtk-sd: disable auto CMD23 support for mt7620
Date: Thu, 19 Jun 2025 13:35:09 +0800
Message-ID:
 <OSBPR01MB16701142441CAA0F2D12A843BC7DA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <OSBPR01MB16708176FE57F691359D0943BC7DA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
References: <OSBPR01MB16708176FE57F691359D0943BC7DA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::18) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID:
 <20250619053512.14507-2-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|OS9PR01MB16295:EE_
X-MS-Office365-Filtering-Correlation-Id: be60d073-8594-4d74-60ae-08ddaef32d03
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|12121999007|19110799006|7092599006|15080799009|8060799009|5072599009|40105399003|51005399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rUNwlLDvLN5hWeYJVTncjGv1AUenfXNk7CZCqLO//fR5wfxtjDvG5goria5Q?=
 =?us-ascii?Q?+yGN7b6r34uE+awIbkHG/QdSkYmEy0GEGithZsgMJAkyxVQ5MWuIKCVDCXrz?=
 =?us-ascii?Q?g9lSPJCNydNrVkMgsKds/g2Cgf3onmBf49ImBmoc4eNiOGQaZ92xIcjb4yrg?=
 =?us-ascii?Q?5Bcwpe3rEQoUG2JsgQck3zcJ96w5rIrCJfhu+ND3jtguCPAurHlVNyFSLL24?=
 =?us-ascii?Q?FFC91kyebPU4ZvHV7bzY0++THo3bKhVrMI/OKAMJ+/W6IICWDLn6QE/zCfbL?=
 =?us-ascii?Q?RnVhig8WwuvythJUeLSfRmpYSCxzI86jzrd8PkZj7onXBPzZt9prVQzGvW40?=
 =?us-ascii?Q?BKYNt2KOgZ5LG25r92sDkPEkx+4uH7ZNDK5Emzs1CaxKjho1eL9q9zoDvVcA?=
 =?us-ascii?Q?k0Tew804RuVS0A8rPK54JjIm4abG2o1Kyny4Ea3iTjGWROCCZ7OHk/qw1PN2?=
 =?us-ascii?Q?kFM8oCWwKRU5xkZJCGzPDBDPuwhaY+UimAJBXPdaiINv7RUtFAIjVqlwoVVa?=
 =?us-ascii?Q?+XzYNp7/hcMG9i3dVXzamJQ2QU6/iG0s6JyO2T0pxaPJW8ThY8GdiwnY6hbz?=
 =?us-ascii?Q?oh8GYDW+njKKYtGW7ZDA6C14AzYAMABPRrCbqJxIajM9+q12i/WdkAjUDJra?=
 =?us-ascii?Q?wz56b7R+mhwQuF+Gxh54M5jzAfrRhF2GM90DoksbkOgOoolxrYCi6GW5YKKU?=
 =?us-ascii?Q?AnvO49pHk15s0nZZKNbRmzcN1qnNllNmIFnWGKdXqKi3kRORXFxpXSmS9B9x?=
 =?us-ascii?Q?/GDWQFllHy9u2pGYmaFPsp8WeZCsujjCPA91mwjDWdFjRAB5tmwCMpQOA9eM?=
 =?us-ascii?Q?2sPSMwvTTrzawF7OWWnc4ufmjWN8ZeTV44kZtCrRVZVHdBta7CBGanAbbzji?=
 =?us-ascii?Q?AlwiwnJS2ljQM761OiNLtnz6CVRPBk40I+AYin/7aInRayMnFuBXvwHqjtgo?=
 =?us-ascii?Q?6ExPfA3W+sVa0ZJC5Q0l/MURx4r5F3m/bHs4JVjER55/FVCocWCnT6lr+lWs?=
 =?us-ascii?Q?0wRWdqXQyZGyX+ejjWoMzRa+jwUh5idO+Hw/vKwsyYZ5X3QMPxJGr3rbnSna?=
 =?us-ascii?Q?Z+KLwciTghXGnqZigNaP+Iei0D7CUjnv+UEeM7oNpVTZiWEtDN+V4qVDRVvo?=
 =?us-ascii?Q?KcsMZHSYNYE80rjobRVDamA5DJIPAFKJp1EOOmxrbXmlU+fk+EW7gT5o+A+L?=
 =?us-ascii?Q?ejuuLF1KSRqMxipmeChPB/kTPbuaGi3FnbsRZ7hv7mnzwdb3HYFX3UFJn5g?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8K5C5y3zQKThqVbsqnftNguzhEjo/AJC3gtkuLz+r52+nCtuzYSHHoKSwt+M?=
 =?us-ascii?Q?L7WrAaBihdPf1FJRjo/aThP2B6HeHBBU6dUdSenpM38Ti70TLNWPhUWaltrp?=
 =?us-ascii?Q?cGsV5WKr+vlxWQK0pa91tKbff8Z5IL0eG0HeNFEGEQ1J3iJo37ZngiNYZlAb?=
 =?us-ascii?Q?HqlFs8tAPg5+x6JkV/8IOrVhgRAkCrxXYzqDJcqb+a56NxwE/GPkfIzppUf9?=
 =?us-ascii?Q?w7BxF5r3WeqYedqvnWQIWkeSNMLASZfd5MiLKbLkY3fzHe/s7xlbljthveU/?=
 =?us-ascii?Q?ypUwjVKQ717pDpf9Nm7fbGYlbwYP69tsxa1o2yffKULmV5gp2m5ougkF57uI?=
 =?us-ascii?Q?qZgOwEFoTr1uPefutIWHVi28jkdJQ0DTI8/MBN9tFRLoaRPUlV3yHezC5iLO?=
 =?us-ascii?Q?XNhtAp7hZ5nOtHJ4S9gFvBW6Qs08+fzGmRoiBwCdMNbrsWL0q3LIBxIFxqeR?=
 =?us-ascii?Q?6ku4Jk2lpKVLOhKU+BsMjM851g7jKkHWlvF5fWWeMHbn+SV3sHKsXmaB63wm?=
 =?us-ascii?Q?ti/ZOM0ys67s1m2G5LszDsXnjLdlg9ZTRt1Eda+j3EmTwbv+swi0mJJpkx0M?=
 =?us-ascii?Q?8NNk+nKkve7H2aoYCpEJEreEtzi3tiEeHq27XSG4gwKoKZxYU9BWemiCTkPD?=
 =?us-ascii?Q?P403eEdEr7CbOezWtq9T/0ZACEkZVNipJ+qpmTypO+dWD5JlpdUTQ8LmJ4IH?=
 =?us-ascii?Q?NnAAY0ujNmnlDD04Iz7yozonmeg+HtLmEdqpgppwZYBc4fEBWAt6rDYMGZof?=
 =?us-ascii?Q?GrP/W05xdIAKF5Wl//Lrljbwozhmo9JcZ4r7O/ZA4YfYWcbn219FKjlsCPlL?=
 =?us-ascii?Q?v077cmF6x2Y+B4Xu8jfKO9cXiVcX024VZMatW91wz5aONu8HBGdbhwwtjAPN?=
 =?us-ascii?Q?EFV4J01i3L1oEdCaj2h0gqapzOqZ0VDDkffgwklzPmWn9wr26VHyyU1bB1yf?=
 =?us-ascii?Q?mXVl+3/qRofuRNu72ls2vb9mI6Qxk06dQOaEc2pIX3GHsEmFwn4TdDGhAEWs?=
 =?us-ascii?Q?VDy3p3ceLMjs6jl4L3EYrdUb4Ucym9aLlwOZJnfDHvTetPBma+wkfhkc9o3W?=
 =?us-ascii?Q?duLoORHkV0OxnME6KJGdof+cykYcuiMQ1gS/jGtfVk8m9b9L6WAvYFkTQuio?=
 =?us-ascii?Q?kZVBWz4oFQbHfEqVhgdmbXN3UYdzw0w03SdDDkgCuPSeNwM+LxNduh5QGaGH?=
 =?us-ascii?Q?VVLIc7KUVYS2EnnYH6Gtpm5fKPjpjSbKRF5QtxRBQb9hfoHeEeCyLDNfbMsa?=
 =?us-ascii?Q?/ar2V5pfCC73Pntaoiem?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be60d073-8594-4d74-60ae-08ddaef32d03
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 05:36:02.2843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16295

MT7628 ProgrammingGuide indicates that the host controller version
3.0 and later support auto CMD23 function. However, it doesn't
define the SD command register BIT[29](Auto CMD23 enable bit). I
guess the legacy MIPS MT762x series SoCs don't support this feature
at all. The experiment on JDCloud RE-SP-01B(MT7621 + 128 GiB EMMC)
shows that disabling auto CMD23 can fix the following IO errors:

[  143.344604] mtk-msdc 1e130000.mmc: msdc_track_cmd_data: cmd=6 arg=03B30101; host->error=0x00000002
[  143.353661] mtk-msdc 1e130000.mmc: msdc_track_cmd_data: cmd=6 arg=03B30101; host->error=0x00000002
[  143.362662] mtk-msdc 1e130000.mmc: msdc_track_cmd_data: cmd=6 arg=03B30101; host->error=0x00000002
[  143.371684] mtk-msdc 1e130000.mmc: msdc_track_cmd_data: cmd=6 arg=03B30101; host->error=0x00000002
[  143.380684] I/O error, dev mmcblk0boot0, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 4 prio class 0
[  143.390414] mtk-msdc 1e130000.mmc: msdc_track_cmd_data: cmd=6 arg=03B30101; host->error=0x00000002
[  143.399468] mtk-msdc 1e130000.mmc: msdc_track_cmd_data: cmd=6 arg=03B30101; host->error=0x00000002
[  143.408516] mtk-msdc 1e130000.mmc: msdc_track_cmd_data: cmd=6 arg=03B30101; host->error=0x00000002
[  143.417556] mtk-msdc 1e130000.mmc: msdc_track_cmd_data: cmd=6 arg=03B30101; host->error=0x00000002
[  143.426590] I/O error, dev mmcblk0boot0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  143.435585] Buffer I/O error on dev mmcblk0boot0, logical block 0, async page read

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 drivers/mmc/host/mtk-sd.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 31eb90536..53d63bb4e 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -445,6 +445,7 @@ struct mtk_mmc_compatible {
 	u8 pop_en_cnt;
 	bool enhance_rx;
 	bool support_64g;
+	bool support_cmd23;
 	bool use_internal_cd;
 	bool support_new_tx;
 	bool support_new_rx;
@@ -535,6 +536,7 @@ static const struct mtk_mmc_compatible mt2701_compat = {
 	.stop_clk_fix = false,
 	.enhance_rx = false,
 	.support_64g = false,
+	.support_cmd23 = true,
 };
 
 static const struct mtk_mmc_compatible mt2712_compat = {
@@ -549,6 +551,7 @@ static const struct mtk_mmc_compatible mt2712_compat = {
 	.stop_dly_sel = 3,
 	.enhance_rx = true,
 	.support_64g = true,
+	.support_cmd23 = true,
 };
 
 static const struct mtk_mmc_compatible mt6779_compat = {
@@ -563,6 +566,7 @@ static const struct mtk_mmc_compatible mt6779_compat = {
 	.stop_dly_sel = 3,
 	.enhance_rx = true,
 	.support_64g = true,
+	.support_cmd23 = true,
 };
 
 static const struct mtk_mmc_compatible mt6795_compat = {
@@ -576,6 +580,7 @@ static const struct mtk_mmc_compatible mt6795_compat = {
 	.stop_clk_fix = false,
 	.enhance_rx = false,
 	.support_64g = false,
+	.support_cmd23 = true,
 };
 
 static const struct mtk_mmc_compatible mt7620_compat = {
@@ -588,6 +593,7 @@ static const struct mtk_mmc_compatible mt7620_compat = {
 	.busy_check = false,
 	.stop_clk_fix = false,
 	.enhance_rx = false,
+	.support_cmd23 = false,
 	.use_internal_cd = true,
 };
 
@@ -603,6 +609,7 @@ static const struct mtk_mmc_compatible mt7622_compat = {
 	.stop_dly_sel = 3,
 	.enhance_rx = true,
 	.support_64g = false,
+	.support_cmd23 = true,
 };
 
 static const struct mtk_mmc_compatible mt7986_compat = {
@@ -618,6 +625,7 @@ static const struct mtk_mmc_compatible mt7986_compat = {
 	.stop_dly_sel = 3,
 	.enhance_rx = true,
 	.support_64g = true,
+	.support_cmd23 = true,
 };
 
 static const struct mtk_mmc_compatible mt8135_compat = {
@@ -631,6 +639,7 @@ static const struct mtk_mmc_compatible mt8135_compat = {
 	.stop_clk_fix = false,
 	.enhance_rx = false,
 	.support_64g = false,
+	.support_cmd23 = true,
 };
 
 static const struct mtk_mmc_compatible mt8173_compat = {
@@ -644,6 +653,7 @@ static const struct mtk_mmc_compatible mt8173_compat = {
 	.stop_clk_fix = false,
 	.enhance_rx = false,
 	.support_64g = false,
+	.support_cmd23 = true,
 };
 
 static const struct mtk_mmc_compatible mt8183_compat = {
@@ -659,6 +669,7 @@ static const struct mtk_mmc_compatible mt8183_compat = {
 	.stop_dly_sel = 3,
 	.enhance_rx = true,
 	.support_64g = true,
+	.support_cmd23 = true,
 };
 
 static const struct mtk_mmc_compatible mt8516_compat = {
@@ -671,6 +682,7 @@ static const struct mtk_mmc_compatible mt8516_compat = {
 	.busy_check = true,
 	.stop_clk_fix = true,
 	.stop_dly_sel = 3,
+	.support_cmd23 = true,
 };
 
 static const struct mtk_mmc_compatible mt8196_compat = {
@@ -687,6 +699,7 @@ static const struct mtk_mmc_compatible mt8196_compat = {
 	.pop_en_cnt = 2,
 	.enhance_rx = true,
 	.support_64g = true,
+	.support_cmd23 = true,
 	.support_new_tx = true,
 	.support_new_rx = true,
 };
@@ -3054,7 +3067,9 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	if (mmc->caps & MMC_CAP_SDIO_IRQ)
 		mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
 
-	mmc->caps |= MMC_CAP_CMD23;
+	if (host->dev_comp->support_cmd23)
+		mmc->caps |= MMC_CAP_CMD23;
+
 	if (host->cqhci)
 		mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
 	/* MMC core transfer sizes tunable parameters */
-- 
2.50.0

