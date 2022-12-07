Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A360EC352A1
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Dec 2022 11:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiLGLXd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Dec 2022 06:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiLGLXN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Dec 2022 06:23:13 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2048.outbound.protection.outlook.com [40.107.105.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A7CB4AE
        for <linux-mmc@vger.kernel.org>; Wed,  7 Dec 2022 03:23:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFxiqFnQWrakF9GvSgOhqt66FPAyfuoej2MVMG0LL1AwkmhB2+XicYviJomzCumzxpOh3BD22067N4h13AnOqrxABPlsg/zKZXBHNosLaglrY1VBBkLkJlM+un+w0WhIJBDIYG6BRk6qu7ojX68P7sZ3x+Sfkj+ntskAM3WPHnmSOlreWrRkgmqyRc7frGt+l508HOS4WtcEKkfAMZ0M87e0g4K+Ey0jtdyTkFuih2gXnRwtaIff3TAkecnE1hG90NTMAJzHeNpX2xZeAFick3Jj6EY7+StdOPLQroDR9x8Lze8yTsZQIIRSy1Bf+ht0ITrTgcahE2LXNyoYZGsccQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjlJoAUrE7czgMISGVs+HJVknuz8HCp8frfAIdrsT+s=;
 b=eONSemrYZb/Ft8C5MybcaZHCtym2MjEoXVjrLC59GmXxtendxZ3D1yAkpgl70TXkZVvyiCV83s1WZGy+dhxsCJPUHEAzv+YYt2SC0ik64VWRS1n0bVVimtCfHR8segit4jPkcKKz378yrOJOAP29GT9iJN2STE3fZ+loHMhS6IfoNoj4DrdVk7u8Z+Pv+TddU4t+xHiSy78jDpQoDoV8LNkiWvDu6rh3p8IH/KFzx+z26Qth4vptfAOM7TabxN8OX7SqqvPgsUxf7r6sGlN5FeDFZ4+8fuypBjhm8zzK8fI+OCICY0Awkv8MhyqxFbk4nlPnpvg0axzhFaWtZAUNIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjlJoAUrE7czgMISGVs+HJVknuz8HCp8frfAIdrsT+s=;
 b=ZV4Dso1gGhOnTL1F8gqgLLQM9zuKTTfket9WT3Y3z/vUbcSP9yu2yWIhWPb51rSDZIHIgh+zDqraQTUtut4akuGtbqcRv0vtGYTh5RtRCOdU1kpBxfL+s7aRLGUN0HCZovQNZ9CEKYsXe/1RSf6/vtA49MrlG5pszYuTgCYWADY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 PAXPR04MB9519.eurprd04.prod.outlook.com (2603:10a6:102:22e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Wed, 7 Dec
 2022 11:23:07 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%7]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 11:23:07 +0000
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Subject: [PATCH] mmc: sdhci-esdhc-imx: correct the tuning start tap and step setting
Date:   Wed,  7 Dec 2022 19:23:15 +0800
Message-Id: <20221207112315.1812222-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|PAXPR04MB9519:EE_
X-MS-Office365-Filtering-Correlation-Id: a4f0d73f-ea7c-46d0-4649-08dad84569f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SpixsG1SKXnSmrrkutc9Nj/b5ogfiTwIb2Cga1CW1/HoX6EAIDW0dxuRvow5wyNvQj49EhKEClTeFq2fqGoTR18W82flipo6qdn1Ee5vredxaHDsSY7E4adDMT/hNrw/q9APuovfTYNb+HrdywN/NHOdChKDug3xva7nOtZYz1sJlU5LYWcpGeJvQZcw57s3g3nkereAJMEaLFAvKIgnJL58JuYcl6kxgJ1dSoLlZZV/Ov5X9066U1RJT4rDxq4VQ83GAFZZYkw+G8j4ETQn2b66M7HqSOOE6M9+1V6mbOimyFPsd1teD6zRmgT5neJreXfhZn34ZRXtENEvKkWeE+Fb2MYjYOyMIcmkKRo+g3PfXhOPjyUGZw2aMEbq6e1d+CmbN67qhkntLFfiObLU21UIJkAtgt/dBYPK6BNdeaCXPrTeYoN8jrKgFfRmJafQ1PGSJK2hYtKMSDmrL/Mj6gLbO5+kf7YuHyNsGjaqSMZKquPgarsKjTiPQpXIx44uTwFcz9x6tiUJ57x/YDkVY0ws6j5u1MRVLtktOJnBfOLV+kMRKFmbUvz/DFYysh47wmTAFzFVsuePXBJTvGhPwcMLU9DpRb+bPh5kKhtTL6IKwKy6nNcen9ZsT4aoaOKpK6WuUCNDS0Ge+jRd/QEgLPE0QtZah/IbeyOkLkEBTjizLTvL5KfLYCJNtHPL8Z1wEc8JjUYnr2FalSf6jyOk0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199015)(2906002)(83380400001)(186003)(1076003)(2616005)(41300700001)(36756003)(52116002)(86362001)(4326008)(38100700002)(66476007)(8936002)(6512007)(5660300002)(38350700002)(26005)(8676002)(66946007)(9686003)(6506007)(66556008)(478600001)(6666004)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LKtpAcNrq9WJWWTiEusW77kQVD6GhZFcGOzU5UYQIAKIGq0/xtnX5hYHLwC0?=
 =?us-ascii?Q?59N/XowMvGDCLetEO1CAJUmGEl/SQDK/0PswZ3s8AZ3RWspiwaibSCwd0K/B?=
 =?us-ascii?Q?yJxqP+3icqi4DO4bC7dsQu0BSxtWlqalCLRe3rtP3RwtaywR4HLjJlWVIA4g?=
 =?us-ascii?Q?+yQ9g++UN03wwvCP4lQGTFC+ZZ4L9dqlVtVXKTLi1SjHlJz1J6ImOdYlRMEp?=
 =?us-ascii?Q?GpdD/HSW+Bw6NCVfnP10GEUTbTpiKsUlT6fpfL5a9GI6b9DFVU77RUihlPBF?=
 =?us-ascii?Q?7D58CUj5Z+eVpPBQ+vBJVm7HFGCuJ55m3mFXHlyR6rYKCl/HI0bV8wk0Jvvh?=
 =?us-ascii?Q?RSGMkk8u660ss82x+CfuvP4fHYrvJp92wSFlOwjxip6gSeeiHCPTaQQwp/AE?=
 =?us-ascii?Q?N86kV7wg0U6ZdTifcbu4lrXkv4uEO3pl1WuuuzaA+MFGE0HBWT2MSTop62yf?=
 =?us-ascii?Q?jjGJVpuLHgf9d01OPah/RZuX4VPntyUyMTjDo0ogzfpFGs900K2YDlHPVoQz?=
 =?us-ascii?Q?0YwNtW2XEU7y/r840boo33mwq6OH0uf8UaXTGaaY+PcXvwCDSXTk6WR2vHP/?=
 =?us-ascii?Q?cN8Pv3TfjTNZ6O2j3wxACqnF9dBmTnagTFr+f9ixcD8Wj1ftbr0mitPDGlxJ?=
 =?us-ascii?Q?ZZJuWb7oEjGtiiMNZz1THUfmjaK6tqm1IsWByKPxJQz2+jEbewkyPqWV69TC?=
 =?us-ascii?Q?zkK6Ea8g8dJG3NQqUUpmteZjO3folLlvPoNnLD6JVBrDq5pyTX60dLygP9Hv?=
 =?us-ascii?Q?LbGlWct8dTicP2Th3FM6Ljsxhg2fT2BnRi8luWpGbStie6s01n/bW+jUsI+O?=
 =?us-ascii?Q?8qQDqHk5Aj1fRPibA26qafpDXTBEvoeqVO4lYLZDwZ/ly86s22OgEd40vDhm?=
 =?us-ascii?Q?0xWE0wwG4nMaVVZ7Au+68G0RvGXyYBRSRhXh1He2OmETNeXPfK7bLkaTo57w?=
 =?us-ascii?Q?jGjqnaKSHxWAio/QuooLaSHSRflfLRaYCj5yAMFparQhFu/II8lRGkJkVCH+?=
 =?us-ascii?Q?BqQGKGYJlvPMkOlw8PdpoLPt3nkP/zwkAfKzgKTKaSpqvTSgCn32DV7Xtl/v?=
 =?us-ascii?Q?J0kK0Fz7fEZEBgZP3uWXU/5gxMq1yvVrOsWUOri4bv0AnJHFAkdMH+oeTT6U?=
 =?us-ascii?Q?DAHOVwkFwPSbdgM6CoSldIqaOxx/C65HM3TVSKLc6gzk2n2SJoW6gzB8IXFd?=
 =?us-ascii?Q?vLe6AZnFYGbTtPdY3PiV8sQQ3glCfuY45bsS50k8gWROB5bsd/9oQPKIYY3m?=
 =?us-ascii?Q?iSohpo9uwHiBkazn7QBTQw8tPfDk28x9OdvnzgWgFosogABc7cJK87vVlQph?=
 =?us-ascii?Q?M1ZPszGBN0fbXoBxhBBo2GIYKVeyb/Zl0upQ9hRILHWaV341Hkynj+Khaw75?=
 =?us-ascii?Q?7joGrXBaP7knSlNRA8iZVqtvlMrafCg+BtnVN4rg1GNDCeKas6g8FHvKx4td?=
 =?us-ascii?Q?nvwC+9CrP0UNxQ906S241u//WPeNBBEtydjLRu1odpz+ucwaf+a7R5LoSHUD?=
 =?us-ascii?Q?/Bl2BUmzyXhhFBB/BDaXUePs0OsVgaiCkvybhjMD96Zs3WeTtdwyFjdrFaj4?=
 =?us-ascii?Q?nUjxlJMvE0PnO643uWOWMmPbfKMKF/w57yyJArIq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f0d73f-ea7c-46d0-4649-08dad84569f4
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 11:23:07.0805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +L+TQw6f6TeH6O9GUfrK6ueGlM8huZGyAgPr0FVoA6FqwS5M5g7HyXNdZgX0BSzLk9Qr8yMHJaUUDARvrkIp/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9519
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Current code logic may be impacted by the setting of ROM/Bootloader,
so unmask these bits first, then setting these bits accordingly.

Fixes: 2b16cf326b70 ("mmc: sdhci-esdhc-imx: move tuning static configuration into hwinit function")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 89ef0c80ac37..9e73c34b6401 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -107,6 +107,7 @@
 #define ESDHC_TUNING_START_TAP_DEFAULT	0x1
 #define ESDHC_TUNING_START_TAP_MASK	0x7f
 #define ESDHC_TUNING_CMD_CRC_CHECK_DISABLE	(1 << 7)
+#define ESDHC_TUNING_STEP_DEFAULT	0x1
 #define ESDHC_TUNING_STEP_MASK		0x00070000
 #define ESDHC_TUNING_STEP_SHIFT		16
 
@@ -1368,7 +1369,7 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	struct cqhci_host *cq_host = host->mmc->cqe_private;
-	int tmp;
+	u32 tmp;
 
 	if (esdhc_is_usdhc(imx_data)) {
 		/*
@@ -1423,17 +1424,24 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
 
 		if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
 			tmp = readl(host->ioaddr + ESDHC_TUNING_CTRL);
-			tmp |= ESDHC_STD_TUNING_EN |
-				ESDHC_TUNING_START_TAP_DEFAULT;
-			if (imx_data->boarddata.tuning_start_tap) {
-				tmp &= ~ESDHC_TUNING_START_TAP_MASK;
+			tmp |= ESDHC_STD_TUNING_EN;
+
+			/*
+			 * ROM code or bootloader may config the start tap
+			 * and step, unmask them first.
+			 */
+			tmp &= ~(ESDHC_TUNING_START_TAP_MASK | ESDHC_TUNING_STEP_MASK);
+			if (imx_data->boarddata.tuning_start_tap)
 				tmp |= imx_data->boarddata.tuning_start_tap;
-			}
+			else
+				tmp |= ESDHC_TUNING_START_TAP_DEFAULT;
 
 			if (imx_data->boarddata.tuning_step) {
-				tmp &= ~ESDHC_TUNING_STEP_MASK;
 				tmp |= imx_data->boarddata.tuning_step
 					<< ESDHC_TUNING_STEP_SHIFT;
+			} else {
+				tmp |= ESDHC_TUNING_STEP_DEFAULT
+					<< ESDHC_TUNING_STEP_SHIFT;
 			}
 
 			/* Disable the CMD CRC check for tuning, if not, need to
-- 
2.34.1

