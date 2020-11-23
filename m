Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C56C63697
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 06:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DC7C20756
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 06:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="WiEfkpCx";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VV0gYKFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgKWGas (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Nov 2020 01:30:48 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:58337 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725287AbgKWGar (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Nov 2020 01:30:47 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7CA655C00E7;
        Mon, 23 Nov 2020 01:30:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 23 Nov 2020 01:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=Xa9bEP7zJnv4w
        dCZumpeVFD6wii3/Qs6EfoNMwYhVLs=; b=WiEfkpCxzgnrFSkrIatYH+sUhFu5/
        ddnXjYh2+6cvhwQXmvLaMOxvXJKX4DeGh83co1vEodbps1XeKhBOUFOa8qgO50+J
        dgefiG1ax+IpDLEfNeAwkMjpaTpnJ2F4m4IlPQsuwWOVNaoJx31xoQx39MANxR4t
        4/0At37+MaI1A9Jr3K4AVJlVplGgixosK8TzHq6vFNGQFJfbcFtjcwfKe6MbqEQH
        YCslzDSbd+NAwAQvm98CI0gE6SgswTvmq+1WZRjPVwZDlEoNQuHCEOg7Ohpegiqy
        DCa+o8TJWyhxke/ciiI80uglbp7woont8ji/SjpMvVFHnQvIJgrFigvWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Xa9bEP7zJnv4wdCZumpeVFD6wii3/Qs6EfoNMwYhVLs=; b=VV0gYKFx
        +YZInp1fPX788BYkEHZJ1NXvjkI5rEJvZMv88u/nA8ElNImMmHkJSnM9telo7NPn
        jmYKYYPP9As/+g4VmFSverSjLpxvn+q3EzM6TlOU/guMWQZ97EzGn8ynj0e/vgR5
        p/JjTSwT0ie2DnV7nNBvofDlUVS7OkcN/XIeWKsaMpxaU8GvYuU+PRZPW/HFO5iW
        mZZFdWigTpX/poewR0922og7u0ftxY2hNa+TUYFhCPVOCkCPkB3B9sIN1OFSxmqQ
        ZbFLU8NXNUS2IPdidHtj3dibQH9Xih73faTM+XNl0Wu86E03yGyznHig6NnBebxQ
        Kdr4+YJMfYBH8g==
X-ME-Sender: <xms:FVe7X6wt9N4WPzmDafGYZx_6X9bDVt-O0jCZ0VbBCxZbvARgF10w5w>
    <xme:FVe7X2QWhtk7uNxwJWRnAscxVs1blhws2PBowrIlBI7ltPQO9Kniou_rfPvbFOR86
    ZB0EZncB7nl40ogmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeghedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecuggftrfgrthhtvghrnhepjefgvdevheetkeevgeegleelgfelte
    etjeffleffvdduudevieffgeetleevhfetnecukfhppedvtdefrdehjedrvddtkedrudeg
    ieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnh
    gurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:FVe7X8W4xWmyoo6SYy5kJGiIhPZ9zFXOUskP3RwpsGZlq4_Jv8gfTQ>
    <xmx:FVe7XwgWsB3VzOcCHAjeSwVCdiravRs76o2gznJ6fvGlAZJDWflA3g>
    <xmx:FVe7X8BVaFMg47n17Iqwpc4ngOmgmWUtRzN8wud0pdJCZ9rlT3xisw>
    <xmx:FVe7X6AB8t7aS4n2himpkbpTkijOeUhyh0v9mIVMOnDMj66WMx-D9Q>
Received: from localhost.localdomain (203-57-208-146.dyn.iinet.net.au [203.57.208.146])
        by mail.messagingengine.com (Postfix) with ESMTPA id B58393064AA6;
        Mon, 23 Nov 2020 01:30:41 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     robh+dt@kernel.org, joel@jms.id.au, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ryan_chen@aspeedtech.com
Subject: [PATCH v3 2/3] mmc: sdhci-of-aspeed: Add AST2600 bus clock support
Date:   Mon, 23 Nov 2020 17:00:03 +1030
Message-Id: <20201123063004.337345-3-andrew@aj.id.au>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201123063004.337345-1-andrew@aj.id.au>
References: <20201123063004.337345-1-andrew@aj.id.au>
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
index 9fda2e7c1d78..52179b800e6c 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -65,6 +65,7 @@ struct aspeed_sdhci_phase_param {
 };
 
 struct aspeed_sdhci_pdata {
+	unsigned int clk_div_start;
 	const struct aspeed_sdhci_phase_desc *phase_desc;
 	size_t nr_phase_descs;
 };
@@ -207,10 +208,13 @@ static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
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
@@ -221,7 +225,23 @@ static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
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
@@ -374,6 +394,10 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 	int ret;
 
 	aspeed_pdata = of_device_get_match_data(&pdev->dev);
+	if (!aspeed_pdata) {
+		dev_err(&pdev->dev, "Missing platform configuration data\n");
+		return -EINVAL;
+	}
 
 	host = sdhci_pltfm_init(pdev, &aspeed_sdhci_pdata, sizeof(*dev));
 	if (IS_ERR(host))
@@ -392,7 +416,7 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 	else if (slot >= 2)
 		return -EINVAL;
 
-	if (dev->pdata && slot < dev->pdata->nr_phase_descs) {
+	if (slot < dev->pdata->nr_phase_descs) {
 		dev->phase_desc = &dev->pdata->phase_desc[slot];
 	} else {
 		dev_info(&pdev->dev,
@@ -455,6 +479,10 @@ static int aspeed_sdhci_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct aspeed_sdhci_pdata ast2400_sdhci_pdata = {
+	.clk_div_start = 2,
+};
+
 static const struct aspeed_sdhci_phase_desc ast2600_sdhci_phase[] = {
 	/* SDHCI/Slot 0 */
 	[0] = {
@@ -485,13 +513,14 @@ static const struct aspeed_sdhci_phase_desc ast2600_sdhci_phase[] = {
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

