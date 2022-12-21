Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74073C10F1B
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Dec 2022 11:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiLUL25 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Dec 2022 06:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbiLUL2z (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Dec 2022 06:28:55 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2055.outbound.protection.outlook.com [40.107.15.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7C42315C
        for <linux-mmc@vger.kernel.org>; Wed, 21 Dec 2022 03:28:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8jVsa4ason55HmA6Nj5yGTfyeFgpfgYLK5cafefW80mbfkt1Qgx4Enh2XDgsIQFjQ5G9hkYHO+3y38eOUC71S+9I9JUoB4b+FO1sIQZZwYVelFNtpwoDl5HRXzfUCRfjimrc4fPTD7JcDTl9CVycoQXjm80B7lpjZk4zXBjfQHHB6BwNr0qEDq3OzGLL/ovJQxjEpycCaGYpa6pWzMYU+HzqSq+IR51YnL+ARNUQNEggoYxv1jN7+i3Voo/1C51qpKvH1JWSTOLIC4CgvLu0IFBoscv7Iqer3Sc8m+pCUoj7PdHZ9RWL486f8Q6fxL4xTdfeLVrbxonag3r6O/EWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8uRlppJfmpn0m29G7TvPlOTMdCnlTuaGNK/V/1nB7M=;
 b=an3gOMJgQ5CwftD/mZAHBm7scyPWSPiW5wkFxwheGNBLGs8RF2RqV44fnTVQ/LfWtRN1MBXW1Tf2fsXStyKjXCo0Xmxr1JFn8xQz2Zzrq+hsO9l2sWirf5ZLw2Ae8cTUxe1dKiC7PUekgiaPFLIG3E01rm2pAv9gQYbrI2V3CpSiyWyh+7WWukLWpC85GV95qrWQimGvwFz0uROGveZmRiVCESwU0ih7i/hjty6sgiBEP3zDyq4iwM351oWC+KhiRw50W9GdmH1ip1fO679OoZ0lbpFBWfdi2gOewvlQqFXbPRRS0riqifJhZkrRcnnUDDDJT2hFL2znwbmPAMH5zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8uRlppJfmpn0m29G7TvPlOTMdCnlTuaGNK/V/1nB7M=;
 b=GV2mkIh7CY7FUo7oJl/h17ze31X7FVn+JCmnPg1jSUZhsI3XjeZddqKAjjyMMr+sXUo5MxpFrmcM8xNKqId1KWHs52xMbuqs6W38FBdN7YSaKaNVhV6HqZVfRmejSVVSgmRfGqhCVqc1wWEpj19bvEznAZ14XNHWj59+uVvngy4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 PAXPR04MB8575.eurprd04.prod.outlook.com (2603:10a6:102:216::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 11:28:51 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 11:28:51 +0000
From:   haibo.chen@nxp.com
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        kgroeneveld@lenbrook.com, haibo.chen@nxp.com
Subject: [PATCH v2 1/3] mmc: sdhci-esdhc-imx: simplify the auto tuning logic
Date:   Wed, 21 Dec 2022 19:28:51 +0800
Message-Id: <20221221112853.789675-2-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221221112853.789675-1-haibo.chen@nxp.com>
References: <20221221112853.789675-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0227.apcprd06.prod.outlook.com
 (2603:1096:4:68::35) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|PAXPR04MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ff57bae-7b6f-4745-2c00-08dae3468906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9kREcJidOmtQT5v3dLysmKEnEyOMZNATuryfpmy3H2rVdidxvbXHj3vfuyI4U6tfq1F2iqQiQ5GzlzD/KpBBOHRn2mz3pUyJFzQVk4cGqsH2eD0tLRnaCJCXsus8vO12NGiNWAmc08QizuJHuTwBt2SaSOusB9p+Ee2f8EC+aUGsxjeppXh9zXZv65Z2sIUEv4aTIHB7nbMPj05fyKZQyIyIs0+i3quKlrHxYtS2TsYZhFIxHZtw1cfpfVb6fwR3W5RLZcZxRyCMlfuovc/UB70xEAuZB5Mr2qLZwGZ1kJlhwsPJKdjiT0A4wiLOdTMJEW6Zk2JE5pT9uYT0x6BMqDi7oQjv9n/LqyWA2jhFFYiWMnc4BZOb/VmIOp2N2W74FXQvYdIB/zn4LT4TWSgdVHewtnr16pfNMHFKnFTaTD+W95OJIlhvQx4KPtCmTiz0LNf7U9x45ZuSepg31Dh+xiTHutdXBJvW+e9ag5SYiZv5Nt0+q+yoRtSwZ9XMnj9bTY3ihcIBDBBr2NPzoWLXGwsNTDSe2e58tOzLj47wDq22QHmZf6lbZilfF0cB/kqfU+bwaNXVC1XwKxDFEpo3x6zpsY9x+tAl8GhFcH4+3Ofj72U+zv+NxJta89Ynam77gXVyOXe157JplvBK8EzZXgKQpkscx0hgXCpoFCU3ohJxZXbjao2grYTe+kCVx10qMAFdIc6sdkoBfj1RuBq/oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199015)(6506007)(52116002)(2906002)(6486002)(478600001)(26005)(2616005)(66476007)(36756003)(66556008)(66946007)(4326008)(41300700001)(8676002)(1076003)(316002)(6512007)(9686003)(8936002)(186003)(5660300002)(83380400001)(38350700002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/NGPG/vdjHVIFmSfh2ppIYhEFP7s7KnPDTecOTujjNUrXDikZmwkEJ2YLmhz?=
 =?us-ascii?Q?N1l94afJHoBUmPTMTFswX1a4jgIniD59lWsrP+NnIeTjbSrVeK6uvNJK6Gsa?=
 =?us-ascii?Q?5/XOgGRTfuRiOk8yQwqM1JbgGtzyuMWDSdCx7GlZD0bKt5Ue9PniwjiJjm3k?=
 =?us-ascii?Q?Nk/lwGaDOxc5YIyuvtHKyDxj3QnK01RVcWNJy5u0JKVSK8sLJtYSHgb76kG4?=
 =?us-ascii?Q?whgLYR54bookecNrDVQytVivXORyMi+FvFOE2GrEt4Me1Q9oYXyY8qMbVuXg?=
 =?us-ascii?Q?0KzHKKRieXbKbZQ8PrNMYEQ/1iGoEPITlpGCoVArCsR5X0hJG1j30mQSH1kw?=
 =?us-ascii?Q?gNfJtCl5dUNgzD7MWDRgXXMyeRIjPuTamwRtSSVCI+LxmRNgUjXu47rFdKyg?=
 =?us-ascii?Q?pAkDwKSOmvzWk/RpvpK0dp1wTd0PmLbOMORG+EQBzhicUm7cWuNc3sK9XlCm?=
 =?us-ascii?Q?/ThXNUKga/vwkgGnyWUwn6LD9SqM8uQdxPuwwzsUfM9PGpXCwuHTAVk4tmBi?=
 =?us-ascii?Q?cZ/kWqyYnZMdTPbL3U0ADSnket9Xs9+HOb6nnMVrxvhPn6Msqd1UR6MlxlVE?=
 =?us-ascii?Q?tFBD3IzRQfat4lFeTZQlZO8Fi1shfeMjuHAK9HFfxgUDVaygPVamgqQTErBx?=
 =?us-ascii?Q?2t00rm6X8Y6lr5S9/ir0UiTWX1G742f9Eo7RUbyyVssN7RMiEQ4lxhtP4Atp?=
 =?us-ascii?Q?IWf+jmeQNq3/eErGD+hIWbuDSxEuJ1L1pHloJsK7ARKjWmxogawTSKYKuWj7?=
 =?us-ascii?Q?v5A64vOlcKhrXG7Vp4YIAjQ2XNmrBbx2P63grI/HsD302y1cSPBdjXiKMBe3?=
 =?us-ascii?Q?rO+LdekMpB5htvssMkcN/YHxakEwXqiJUPADEJrZ4n2VBW/zMnGAaWQe3pyM?=
 =?us-ascii?Q?HleeBJ3+5cGbaCeVGp0OAHBDhZ6AFzy+CtsAG0NAOOzKkQ1ceKfaFjTaLaUd?=
 =?us-ascii?Q?VBiIZf1aYuzuUNAEotIyMDx02a4WBoZvZXeDIMyxYb8VtuK1Oq1bnVvoNFAj?=
 =?us-ascii?Q?pDhEQEm985I5YzLfdNSojPcNmD3XsnhE1N1rtxvFPE8I+Cd0saVVKz+jexNi?=
 =?us-ascii?Q?JA9TNiQwKtEJ6MD8iJejotBPRFAMyXCZV2HcuaNst78LNUdGeriF/J8VUCK4?=
 =?us-ascii?Q?63wy7EDpwhZjRP3gt8TlQyP92fNFFDNgSTk7AEf9lR+miJI/Rwpt+592pnJZ?=
 =?us-ascii?Q?kpVf85KQFcBZj0xnal78KjWCCm8grv1zWjMr6sEe60CGmX30zzrY0qoGQl95?=
 =?us-ascii?Q?H9gt483XKxM+cxI7qtswH7pP3mvU8HhICVWdGqua6fsZGmDXEewu4DO5Xq0h?=
 =?us-ascii?Q?QgmzdRB+W2w1CdcXln3DnX4oEalv8UlXETHWc3ojFg5rnlUyh8R5mgxVwXDm?=
 =?us-ascii?Q?aNWRZqyae2ECWQpyxvZIKT4uBJvv+zcu0HfCJq4SylQ6tim6M8pGgkkTrSlW?=
 =?us-ascii?Q?LfdC0tO05aclVkWM8gRJsT5R+kLS6RiyvWflWUTh3XDuWRK0mUWGEvTIRmqH?=
 =?us-ascii?Q?ISfcuXrRSb4HGSxQUmv7FvHLR8TD9P5GAEcccyJnKkWm3Arr3SH4rSUwE03l?=
 =?us-ascii?Q?LnRlfz87ThzDr93agOfqpTMNyD+DtfU+u6ljOjb3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff57bae-7b6f-4745-2c00-08dae3468906
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 11:28:51.5257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xi1CcesZveAmO41W599Ur2gAAFs/uJiYbxIMWSWUKhtKyEqKYp6eX6NOfokIKGOP7Ou1cXNiQ9BGQwc8J9HhGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8575
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Clear auto tuning bit when reset tuning, and enable auto tuning
only after tuning done successfully for both standard tuning and
manual tuning.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 89ef0c80ac37..bf8d6f60a9ee 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -429,9 +429,10 @@ static inline void esdhc_wait_for_card_clock_gate_off(struct sdhci_host *host)
 }
 
 /* Enable the auto tuning circuit to check the CMD line and BUS line */
-static inline void usdhc_auto_tuning_mode_sel(struct sdhci_host *host)
+static inline void usdhc_auto_tuning_mode_sel_and_en(struct sdhci_host *host)
 {
 	u32 buswidth, auto_tune_buswidth;
+	u32 reg;
 
 	buswidth = USDHC_GET_BUSWIDTH(readl(host->ioaddr + SDHCI_HOST_CONTROL));
 
@@ -450,6 +451,10 @@ static inline void usdhc_auto_tuning_mode_sel(struct sdhci_host *host)
 	esdhc_clrset_le(host, ESDHC_VEND_SPEC2_AUTO_TUNE_MODE_MASK,
 			auto_tune_buswidth | ESDHC_VEND_SPEC2_AUTO_TUNE_CMD_EN,
 			ESDHC_VEND_SPEC2);
+
+	reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
+	reg |= ESDHC_MIX_CTRL_AUTO_TUNE_EN;
+	writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
 }
 
 static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
@@ -681,14 +686,11 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 			} else {
 				v &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
 				m &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
-				m &= ~ESDHC_MIX_CTRL_AUTO_TUNE_EN;
 			}
 
 			if (val & SDHCI_CTRL_EXEC_TUNING) {
 				v |= ESDHC_MIX_CTRL_EXE_TUNE;
 				m |= ESDHC_MIX_CTRL_FBCLK_SEL;
-				m |= ESDHC_MIX_CTRL_AUTO_TUNE_EN;
-				usdhc_auto_tuning_mode_sel(host);
 			} else {
 				v &= ~ESDHC_MIX_CTRL_EXE_TUNE;
 			}
@@ -1022,13 +1024,15 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
 
 	/* Reset the tuning circuit */
 	if (esdhc_is_usdhc(imx_data)) {
+		ctrl = readl(host->ioaddr + ESDHC_MIX_CTRL);
+		ctrl &= ~ESDHC_MIX_CTRL_AUTO_TUNE_EN;
 		if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
-			ctrl = readl(host->ioaddr + ESDHC_MIX_CTRL);
 			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
 			ctrl &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
 			writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
 			writel(0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
 		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
+			writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
 			ctrl = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
 			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
 			ctrl &= ~ESDHC_MIX_CTRL_EXE_TUNE;
@@ -1054,6 +1058,7 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
 static int usdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
+	int err;
 
 	/*
 	 * i.MX uSDHC internally already uses a fixed optimized timing for
@@ -1068,7 +1073,12 @@ static int usdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	 * correct delay cell.
 	 */
 	esdhc_reset_tuning(host);
-	return sdhci_execute_tuning(mmc, opcode);
+	err = sdhci_execute_tuning(mmc, opcode);
+	/* If tuning done, enable auto tuning */
+	if (!err && !host->tuning_err)
+		usdhc_auto_tuning_mode_sel_and_en(host);
+
+	return err;
 }
 
 static void esdhc_prepare_tuning(struct sdhci_host *host, u32 val)
@@ -1102,11 +1112,8 @@ static void esdhc_post_tuning(struct sdhci_host *host)
 {
 	u32 reg;
 
-	usdhc_auto_tuning_mode_sel(host);
-
 	reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
 	reg &= ~ESDHC_MIX_CTRL_EXE_TUNE;
-	reg |= ESDHC_MIX_CTRL_AUTO_TUNE_EN;
 	writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
 }
 
-- 
2.34.1

