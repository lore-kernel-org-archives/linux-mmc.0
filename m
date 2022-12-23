Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AADEC4332F
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Dec 2022 02:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbiLWCuN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Dec 2022 21:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiLWCuL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Dec 2022 21:50:11 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC3F21813
        for <linux-mmc@vger.kernel.org>; Thu, 22 Dec 2022 18:50:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYuIOSz6bsJc8vtfU1tfo687zv5C+K92gsR1gS8aDaijycy8xDBT511fGZAk1F77c4YTILfOaoMhnfC8WkQs4kQ2M3Mf9+eoGTksqAUjnIRXTR2avQ8kJjKBJIoUOubCae4/on67ugNcInvoTiHozlXEzs+Knrut+TekNTDHAEbNIhydHhAJRTKZuk7QTuMU+g4xn99FhJBTpICTSNhlZRRxz41Is4o1OGTqnDFlpJYRo/jmnXG948ZAIOCoLqevOjS4tYJV86OJkADYh5esoAEqgyr2V2dvtPoJEjtPDH/9GCwOjIqMhgZX7q07qZVZQO3BlzpzEj1hPrP6eQSIlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXJ44308MSRMXTQecsCzb4lg2b+aWpTM25csrYlHGPw=;
 b=dgumAvXA05d2IE87H+Fv9HvmeUCZPOX0xHKeVExegyl5xDpGN0gbF+dau41OX6w6xpmpcPYwGgAAJ0zF7h8DSsTge421k4yt7PbMYdoCgzGak9YtG+D8i1RjrpZoOXj+Q0Dh8HxYxWfNaprB470+YkJkwqdJEJQiSFXsaYfk7161hTftsLRuW9v+0AaDv8HO74ZW5k2U9HF8jjB/xfIjF4768IZ1Try5rVsMXPj5C08x+MrVQQgCL4W+eFyouuU5oZRHzfI15wINsApO0SPr9+hAsITQJiB5cX0STCBlhluxzZQi3CJ688faXcs/Kr2pYBIcszw/hy8miPwKJNnnng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXJ44308MSRMXTQecsCzb4lg2b+aWpTM25csrYlHGPw=;
 b=SE2+/eXURqeWQOiDT918rs5VDPGJW2a9DSetfB/ej0jm9nXRHV3wPRcZJxlpPhnbSYJNRJoDLmtbJO1vpuq3jT1sfLrss8Qfn/3zkpiUBcZ4iItHru8SEGTgmbtqLN2pKbPe3Yy1ttSfrgoFLHNlQjIvtwE8g/Aeof2xkB8GpbI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 PA4PR04MB7709.eurprd04.prod.outlook.com (2603:10a6:102:e3::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.13; Fri, 23 Dec 2022 02:50:06 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.5924.016; Fri, 23 Dec 2022
 02:50:06 +0000
From:   haibo.chen@nxp.com
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        kgroeneveld@lenbrook.com, haibo.chen@nxp.com
Subject: [PATCH v3 2/2] mmc: sdhci-esdhc-imx: only enable DAT[0] and CMD line auto tuning for SDIO device
Date:   Fri, 23 Dec 2022 10:50:22 +0800
Message-Id: <20221223025022.1893102-3-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221223025022.1893102-1-haibo.chen@nxp.com>
References: <20221223025022.1893102-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|PA4PR04MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e811dd-925b-43a5-76cb-08dae49065ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H1efqLNBt72WbITRGccRJ/ZxWepk6JBU/wqozciEqoP2xwSjRzfqNU3E9V1a58BE39LZWH1tGMwzCxm3WsXV33w0CjKVRONvysZmBKa4zlV2dlxn2yMNt0oJVdqPpOfVIAZIfsCjL8rg4WuCDAHgs4fN72Lz41+rLm/D6KxFuIT1IYoXe5aLeCRmTgX2OIGLZeNK05y+qsbGrQuAZk2ze1nR67nz7wwVnnsbK1S5kDBFDhXrlv7E1ggZ2PSIpl8pNt/Fpv88wdjc0yFK+5g0zs7JLH24vXmTc2kF/eR4vNJlwaglGMZwTUJZdjiiuoh4/ozTiQuimCNGa1KB+oPKMY4R3d6yQJVOXhpgGA5Yw6VjYpw+UEgDRAxwCMbQ01k4/p6tILKbdys12Ya3iDff+Yt99j7gmTezAGsxXEi2Zx0jPYSeqEGNf7SfNT+ByzbH0IID7A9suZubb0XPEqOS9WBWERn0tZJJPS6yv1r2oYS7aBA/oxLuaIq32xKARt6xdBYpuiNo+tavgJng1OYb8uehBoip1fCFsSlyEnj1uIwlbUjtdqdIWMsc38IKQZ53aRDRAVc+OqfSKvAvmm4mS5eiwbU5BaHH5rDhQG18AZFcugG/w9uMmiznZ5sWMWvshx4S3QSAReaeoQSCGpb1rq9fFRF3huNZO4/91wOOrUwQMQHoSwxJweAzm909cA3wTZYM/6f0jxkbqgF3bsCNLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199015)(2906002)(38100700002)(38350700002)(36756003)(86362001)(52116002)(1076003)(6506007)(6666004)(26005)(9686003)(6512007)(186003)(6486002)(2616005)(478600001)(83380400001)(5660300002)(41300700001)(8936002)(4326008)(66946007)(66556008)(66476007)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2IrnAL5Y2ncAnbbBwjizS2Gsb4VOH/E8E+HWKjipPUySw0mbRn9MUowLeoTI?=
 =?us-ascii?Q?jFtNX1317QBU2ezhAoQu48fvwq7FksUOE7su05ZPl3VZnMGfQrfeuJKJzwUL?=
 =?us-ascii?Q?j4+SCbqwPP2uCDOvJAraMP+c5OI9923aaIzOFQ2uStVpMe8XqeuQUCy8EjeX?=
 =?us-ascii?Q?ZP5s8PqHZYG8rZPvjNPFwtSJuvAQKZm2WAjRvdr824BWyUEmewNXnDwN0tQw?=
 =?us-ascii?Q?FYmjJ65Sj5ycVBBeoQcDPi2JN74qYJgcgjy9ZAQ0QdrZQ4NfZNHebZB+I/ue?=
 =?us-ascii?Q?jsP90ZFbzZ05ldQs3cNSsz13y8zneBp+FhuaK2xi/iuearQkQn+VDj9Q3J0r?=
 =?us-ascii?Q?7IYRD+OOKfW8XkL9NIdwKjMdGJEwq0Djldr3EjE10TTx9EU2+fTbRpsVKvjI?=
 =?us-ascii?Q?8C5ZRegnYMWKJTE8hHFr1zI/ZwrFJ0cqAI1nDkvYqoy2v/6egZDqzcHBVd8P?=
 =?us-ascii?Q?tGRc3lJeE1VaHWhAbxCnh9wXB7Kfyj7EGHMamDjGycCQSilINNJUJa79c9SI?=
 =?us-ascii?Q?2jfW/TyZ3HGQUbqoerX9YiIByaUXTQG0t5HqemY3puFgnxcma56a3PDCKOw2?=
 =?us-ascii?Q?gQOGySbE2IMommaO9rgaQfe30EloIqlLcYRshZAPWotUTte/sdiZ1nzIaJTS?=
 =?us-ascii?Q?z08Exf/fhbPh92U+YGAY8j75XBM2faJPraNPZPEY1JIgS5HmzVgvjc5I6SG2?=
 =?us-ascii?Q?gR3wht5cPxODReKgky3I1UaP2ZpOcDb0z2jyzbadsjbPqFMWwN/ZH6V8Romj?=
 =?us-ascii?Q?wjNXyN7atOVlmdIGhJpt9PHuBglV/vR0p61sUhFbfUWFsPRMgn5lvEe9pVDG?=
 =?us-ascii?Q?oF/uonLd0iuwOLEZ8mUx5QPrDiZxAp502RrTUtYCvGfGyCaj5cF3EPG+B+3u?=
 =?us-ascii?Q?ICxwE/PxUXXWwlKktbIRsaI/uF+0WP8niWOsj7pu1bx44D/p84mGFkiH4uMV?=
 =?us-ascii?Q?Z2D2lAqDvG7X7EmAwl16/+KB+wlaChZqDOA6FjOJjuGzSWV7/6wzKwAEX+K2?=
 =?us-ascii?Q?JuHdd17vrD1flJbPf4p/k9+EDwIGr2MdO10jxYiSi7ZJrFRb0d5qpmLei7ln?=
 =?us-ascii?Q?BIgPpbAVnt9fnU4J1oISSj19TCPPk8skFM+kfwm4Fr3JaiiM+KpdFWHj/ogI?=
 =?us-ascii?Q?z0KejM0CHrawoJ4OU0t3BrMbuum8g7Pnc6pHQkSa6O5ukjdXn0W6KXMv8uXq?=
 =?us-ascii?Q?ravsBa68pA0sgcpNCHHjZwWJIwZAs5Wv1hTFmq7352hYi8MUUbL5c6SQLYG+?=
 =?us-ascii?Q?S0nGDZ49pb1lsZoyburLwSJiyqK7XjjBcwG2jJaYfzBUEDiNBTLwqNoZVcrm?=
 =?us-ascii?Q?NAbsHqy/lw1k80bh7f5J4Jtwok6nOCdvLMvePtJdKAoZfmwRCJGUkcvo7YB/?=
 =?us-ascii?Q?Sze17sRfVkF3lI031YUwr5MdgyZwCeGFIfc7v5csDAmuJYjhnmGOJmo7BRO1?=
 =?us-ascii?Q?24R9flZcoTKrWGDV5VpAEuGBNFbV1xPi6SdSOx1nBCRH+yaU/VYAt9m0gSfD?=
 =?us-ascii?Q?L5VB9vr+cR3AADQmu2LazYwwDZD1I7l/R+xm1disq+7FXY9H5+3R0EPEixHS?=
 =?us-ascii?Q?Viel0a9HRujyYH5sLaN0n2aNSg/kyFoixXcfvv09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e811dd-925b-43a5-76cb-08dae49065ed
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 02:50:06.5643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ex0BT6+WpCGPH2FgjpuIRg9u2Ko99405S1qd2M0oeT5VCUXTd+DGL7Xb7pbZT5JfDGXdrdGoVMMhBOyNDExsaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7709
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

USDHC IP has one limitation: the tuning circuit can't handle the async
sdio device interrupt correctly. When sdio device use 4 data lines,
async sdio interrupt will use the shared DAT[1], if enable auto tuning
circuit to check these 4 data lines, include the DAT[1], this circuit
will detect this interrupt, take this as data on DAT[1], and adjust the
delay cell wrongly, finally will cause the DATA/CMD CRC error.
So for SDIO device, only enable DAT[0] and CMD line for auto tuning.
To distinguish the card type during card init, involve init_card().

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 41 ++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index bf8d6f60a9ee..8f5ee5964396 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -337,6 +337,16 @@ struct pltfm_imx_data {
 	struct clk *clk_ahb;
 	struct clk *clk_per;
 	unsigned int actual_clock;
+
+	/*
+	 * USDHC has one limition, require the SDIO device a different
+	 * register setting. Driver has to recognize card type during
+	 * the card init, but at this stage, mmc_host->card is not
+	 * available. So involve this field to save the card type
+	 * during card init through usdhc_init_card().
+	 */
+	unsigned int init_card_type;
+
 	enum {
 		NO_CMD_PENDING,      /* no multiblock command pending */
 		MULTIBLK_IN_PROCESS, /* exact multiblock cmd in process */
@@ -431,6 +441,8 @@ static inline void esdhc_wait_for_card_clock_gate_off(struct sdhci_host *host)
 /* Enable the auto tuning circuit to check the CMD line and BUS line */
 static inline void usdhc_auto_tuning_mode_sel_and_en(struct sdhci_host *host)
 {
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	u32 buswidth, auto_tune_buswidth;
 	u32 reg;
 
@@ -448,6 +460,20 @@ static inline void usdhc_auto_tuning_mode_sel_and_en(struct sdhci_host *host)
 		break;
 	}
 
+	/*
+	 * For USDHC, auto tuning circuit can not handle the async sdio
+	 * device interrupt correctly. When sdio device use 4 data lines,
+	 * async sdio interrupt will use the shared DAT[1], if enable auto
+	 * tuning circuit check these 4 data lines, include the DAT[1],
+	 * this circuit will detect this interrupt, take this as a data on
+	 * DAT[1], and adjust the delay cell wrongly.
+	 * This is the hardware design limitation, to avoid this, for sdio
+	 * device, config the auto tuning circuit only check DAT[0] and CMD
+	 * line.
+	 */
+	if (imx_data->init_card_type == MMC_TYPE_SDIO)
+		auto_tune_buswidth = ESDHC_VEND_SPEC2_AUTO_TUNE_1BIT_EN;
+
 	esdhc_clrset_le(host, ESDHC_VEND_SPEC2_AUTO_TUNE_MODE_MASK,
 			auto_tune_buswidth | ESDHC_VEND_SPEC2_AUTO_TUNE_CMD_EN,
 			ESDHC_VEND_SPEC2);
@@ -1055,6 +1081,15 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
 	}
 }
 
+static void usdhc_init_card(struct mmc_host *mmc, struct mmc_card *card)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+
+	imx_data->init_card_type = card->type;
+}
+
 static int usdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
@@ -1673,6 +1708,12 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		 * to replace the standard one in sdhci_ops.
 		 */
 		host->mmc_host_ops.execute_tuning = usdhc_execute_tuning;
+
+		/*
+		 * Link usdhc specific mmc_host_ops init card function,
+		 * to distinguish the card type.
+		 */
+		host->mmc_host_ops.init_card = usdhc_init_card;
 	}
 
 	err = sdhci_esdhc_imx_probe_dt(pdev, host, imx_data);
-- 
2.34.1

