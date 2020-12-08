Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BD2C4361B
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Dec 2020 01:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28FF02343F
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Dec 2020 01:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgLHB1q (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Dec 2020 20:27:46 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36899 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725995AbgLHB1q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Dec 2020 20:27:46 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B5DCB5C01C6;
        Mon,  7 Dec 2020 20:26:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 07 Dec 2020 20:26:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=06SREafhLlHLU
        F3HGq2w3cJFjjzGGkvm2N01mQelkbA=; b=OAFm3oRhzDDWDKvbhxE9mMUm3Z25I
        roxuoKiyjB9600dFucN8EcjhhvqVdBvqnR2B2dbdW/o7OYHfj08i5nbvqY9VOfde
        lGhsW4g2F2dXyUTQI6jXlNAZLusV1NZqYP5+wn6ipJXIGCB0enPCSK9VRiGxxtnw
        K2gkCZpthQncfasyWx49/PnMJaVC+A99ZRymCLvSGl0+C11ZQG5CEeIH3xPpHnoJ
        rXDXuhCU49IB0GiAXEICy1355o61ahidHDh/QG1GFTWEXw+0xxsp6AgmXFf/pLAB
        uQchcFMPjZ6PRSjYgSFj7144LXb5qY8POb7uUPi5XrmFvL7ugnm5VbvIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=06SREafhLlHLUF3HGq2w3cJFjjzGGkvm2N01mQelkbA=; b=OPYds6hm
        RHJCd5tiVBLepMkN7CpN060nngtFJi2E2hahrdQfYyQELx4GAY6WtLGWSpaLPgu6
        UXqcaP9jvQPn72zUd2ZBCEiXxoe74B0WS1zBTfqZHAog9BG552YD1N9JcXFmM5ku
        ql2dDyHCPh7+zFdX641GLC592YuxuMLmT2KQVBchkJ4RijosXJg5Xv1yoKafsBZy
        f/acrzHHvYWd2t0EPFuHraMQxF/2BAt1mQEj8gszrkF/z+g5nc9UrQ8XfIp9c/kJ
        hkrzWsNUP2QgbVh+zQxaz/u6rzHteNJoVvzMbmVGQniEK1HSRr588VCU6buWntFz
        TKjOqSFsR4f2lw==
X-ME-Sender: <xms:T9bOX7HGPsx2FdZ_ovMRXGMnsZdTYDbVw_8X1ApNA6c8x-87qqygTg>
    <xme:T9bOX4W7X06MqffrBJ14TPCKqBr64VoYDDoKlh9jJJ-bDrS5_T7FgKUz7dzTbqdHR
    Pm18ZdhZ8c1EdI_0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejhedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecuggftrfgrthhtvghrnhepjefgvdevheetkeevgeegleelgfelte
    etjeffleffvdduudevieffgeetleevhfetnecukfhppedvtdefrdehjedrvddtkedrudeg
    ieenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnh
    gurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:T9bOX9KtOI0SdU3qyTI5uOPtzlYgxhMf_bHmFKXYEyIw7Wb0NjSDCw>
    <xmx:T9bOX5EayKvm7LEOhGauhVotFHFfP_xiHjMsSKWh0R-t2YQfDWJEWg>
    <xmx:T9bOXxVaAWSp6zjnUGwGgN4-A1Ydj6jNEzam2jmMcsSF2mzPyWk3uw>
    <xmx:T9bOXwExc3BaVB208QyDqhJynLv3AAISuoMQATX9uRSjyhAm4CYXuw>
Received: from localhost.localdomain (203-57-208-146.dyn.iinet.net.au [203.57.208.146])
        by mail.messagingengine.com (Postfix) with ESMTPA id 11A451080057;
        Mon,  7 Dec 2020 20:26:35 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, ryan_chen@aspeedtech.com
Subject: [PATCH v5 3/6] mmc: sdhci-of-aspeed: Add AST2600 bus clock support
Date:   Tue,  8 Dec 2020 11:56:12 +1030
Message-Id: <20201208012615.2717412-4-andrew@aj.id.au>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201208012615.2717412-1-andrew@aj.id.au>
References: <20201208012615.2717412-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The AST2600 can achieve HS200 speeds with a change to the bus clock
divisor behaviour. The divisor can also be more accurate with respect
to the requested clock rate, but keep the one-hot behaviour for
backwards compatibility with the AST2400 and AST2500.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 37 ++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 788ec7728227..0a181b104752 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -59,6 +59,7 @@ struct aspeed_sdhci_phase_desc {
 };
 
 struct aspeed_sdhci_pdata {
+	unsigned int clk_div_start;
 	const struct aspeed_sdhci_phase_desc *phase_desc;
 	size_t nr_phase_descs;
 };
@@ -200,10 +201,13 @@ static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host;
 	unsigned long parent, bus;
+	struct aspeed_sdhci *sdhci;
 	int div;
 	u16 clk;
 
 	pltfm_host = sdhci_priv(host);
+	sdhci = sdhci_pltfm_priv(pltfm_host);
+
 	parent = clk_get_rate(pltfm_host->clk);
 
 	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
@@ -214,7 +218,23 @@ static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	if (WARN_ON(clock > host->max_clk))
 		clock = host->max_clk;
 
-	for (div = 2; div < 256; div *= 2) {
+	/*
+	 * Regarding the AST2600:
+	 *
+	 * If (EMMC12C[7:6], EMMC12C[15:8] == 0) then
+	 *   period of SDCLK = period of SDMCLK.
+	 *
+	 * If (EMMC12C[7:6], EMMC12C[15:8] != 0) then
+	 *   period of SDCLK = period of SDMCLK * 2 * (EMMC12C[7:6], EMMC[15:8])
+	 *
+	 * If you keep EMMC12C[7:6] = 0 and EMMC12C[15:8] as one-hot,
+	 * 0x1/0x2/0x4/etc, you will find it is compatible to AST2400 or AST2500
+	 *
+	 * Keep the one-hot behaviour for backwards compatibility except for
+	 * supporting the value 0 in (EMMC12C[7:6], EMMC12C[15:8]), and capture
+	 * the 0-value capability in clk_div_start.
+	 */
+	for (div = sdhci->pdata->clk_div_start; div < 256; div *= 2) {
 		bus = parent / div;
 		if (bus <= clock)
 			break;
@@ -316,6 +336,10 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 	int ret;
 
 	aspeed_pdata = of_device_get_match_data(&pdev->dev);
+	if (!aspeed_pdata) {
+		dev_err(&pdev->dev, "Missing platform configuration data\n");
+		return -EINVAL;
+	}
 
 	host = sdhci_pltfm_init(pdev, &aspeed_sdhci_pdata, sizeof(*dev));
 	if (IS_ERR(host))
@@ -334,7 +358,7 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 	else if (slot >= 2)
 		return -EINVAL;
 
-	if (dev->pdata && slot < dev->pdata->nr_phase_descs) {
+	if (slot < dev->pdata->nr_phase_descs) {
 		dev->phase_desc = &dev->pdata->phase_desc[slot];
 	} else {
 		dev_info(&pdev->dev,
@@ -396,6 +420,10 @@ static int aspeed_sdhci_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct aspeed_sdhci_pdata ast2400_sdhci_pdata = {
+	.clk_div_start = 2,
+};
+
 static const struct aspeed_sdhci_phase_desc ast2600_sdhci_phase[] = {
 	/* SDHCI/Slot 0 */
 	[0] = {
@@ -426,13 +454,14 @@ static const struct aspeed_sdhci_phase_desc ast2600_sdhci_phase[] = {
 };
 
 static const struct aspeed_sdhci_pdata ast2600_sdhci_pdata = {
+	.clk_div_start = 1,
 	.phase_desc = ast2600_sdhci_phase,
 	.nr_phase_descs = ARRAY_SIZE(ast2600_sdhci_phase),
 };
 
 static const struct of_device_id aspeed_sdhci_of_match[] = {
-	{ .compatible = "aspeed,ast2400-sdhci", },
-	{ .compatible = "aspeed,ast2500-sdhci", },
+	{ .compatible = "aspeed,ast2400-sdhci", .data = &ast2400_sdhci_pdata, },
+	{ .compatible = "aspeed,ast2500-sdhci", .data = &ast2400_sdhci_pdata, },
 	{ .compatible = "aspeed,ast2600-sdhci", .data = &ast2600_sdhci_pdata, },
 	{ }
 };
-- 
2.27.0

