Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06417C433FE
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Dec 2020 14:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C697120784
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Dec 2020 14:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgLGO06 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Dec 2020 09:26:58 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:59333 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725803AbgLGO06 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Dec 2020 09:26:58 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2C5115C00F9;
        Mon,  7 Dec 2020 09:26:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 07 Dec 2020 09:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=SBALsPNYnP1HF
        pXf5N2yZ6Vi3FshNtci6dnwoaQoJw8=; b=GKnED2dDKK4vPgHovpWSCRWDNRj1a
        D0GLqDZlfRA4nLfZYgDJ3eYrDVGLO9+n/SQp9mMZQ4XmM0kTj4XvX/WBoqxmk5r6
        DdgAvLNmQSpjaJrtNy1zQZ8wAXSO42uxPAIwr2ezPRVk8Yy9jEmNS2VB5pDzoZEG
        fewPeFRqzjQANUkxO2u1LBpn2Gnc5/ndFv12RPn5UWvN6rFVs59XKLFyWGe7zBlc
        MMql0nUOMzU+rltiF/ztd3vzzA88/OBYzwNdBMQK2ZMabPtdjS7+bj4D6UJJISpv
        mn20I9t4fuEK5LUOV9omppOyAWXPCBHoqf51mixkFPiPPbUoeNRzyK3Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=SBALsPNYnP1HFpXf5N2yZ6Vi3FshNtci6dnwoaQoJw8=; b=ibGRSqgy
        KhOHX5qRkRueYHjQVdkJzVNBa8THZr31TM1O4lgwCOGkR6N0Vh+Z5Yas696uZaze
        0ASV+8INlRAu3VgDsiQssWsweNzvxecBOoNBr1G4uZcmhZnxEnj09MJxuviU/f98
        LW3MUkIGGQYN5rCt0l5XVl2CUT27JNPgc1lYmRQfQXQFDbz1xWTOXjawS8w3vm/u
        SsS85XAIP07bfdsAkZl5Pt06YQ2MrTTpuE9pcSmWFjk1Tbr4GRe5D2pT7chxcbmQ
        essZmSCdoh17qL27ppmklrV9UBiGH47Tum+allqypcFF9D4JYvag1iH15EzlRN3M
        Qq6pQDrS9LqV9Q==
X-ME-Sender: <xms:hDvOX9ly4K8wxtiooLplny6wgp0RLUwMqtOgDqFI6KYVm6Mfo-TpNA>
    <xme:hDvOXyePYHO1yAYMoAbG2-4A2WQUE4UOkcl6UrDjUGXp1HlFmIBXVDhxUHdlOZbHb
    TQe_MbQlr998ntkzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejgedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecuggftrfgrthhtvghrnhepjefgvdevheetkeevgeegleelgfelte
    etjeffleffvdduudevieffgeetleevhfetnecukfhppedvtdefrdehjedrvddtkedrudeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnh
    gurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:hDvOXzr1f1yJ8rxcS9b-iqAUXJsZYbt_WdI7I4Y9cUeVYdO3ARUing>
    <xmx:hDvOXw6Ow-rYP481Ui_OHxvrSZSLTvbibBQckfGR4Z9d3uBlMxJRnQ>
    <xmx:hDvOX5qTlqgOt6wFeZMZciO-PGlN4JhO0bSaafJf2D1JonEZFKzofg>
    <xmx:hDvOX1JVszPJfSqCOqM8r5Bhrj3RSqjAQFfR4gre7ffON0CN9rKTtw>
Received: from localhost.localdomain (203-57-208-146.dyn.iinet.net.au [203.57.208.146])
        by mail.messagingengine.com (Postfix) with ESMTPA id BD0931080059;
        Mon,  7 Dec 2020 09:26:08 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, ryan_chen@aspeedtech.com
Subject: [PATCH v4 1/6] mmc: core: Add helper for parsing clock phase properties
Date:   Tue,  8 Dec 2020 00:55:51 +1030
Message-Id: <20201207142556.2045481-2-andrew@aj.id.au>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201207142556.2045481-1-andrew@aj.id.au>
References: <20201207142556.2045481-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Drivers for MMC hosts that accept phase corrections can take advantage
of the helper by embedding a mmc_clk_phase_map_t object in their
private data and invoking mmc_of_parse_clk_phase() to extract phase
parameters. It is the responsibility of the host driver to translate and
apply the extracted values to hardware as required.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/mmc/core/host.c  | 43 ++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h | 17 ++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 96b2ca1f1b06..d03518f2e654 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -163,6 +163,49 @@ static void mmc_retune_timer(struct timer_list *t)
 	mmc_retune_needed(host);
 }
 
+static void mmc_of_parse_timing_phase(struct device *dev, const char *prop,
+				      struct mmc_clk_phase *phase)
+{
+	int degrees[2] = {0};
+	int rc;
+
+	rc = device_property_read_u32_array(dev, prop, degrees, 2);
+	phase->valid = !rc;
+	if (phase->valid) {
+		phase->in_deg = degrees[0];
+		phase->out_deg = degrees[1];
+	}
+}
+
+void
+mmc_of_parse_clk_phase(struct mmc_host *host, mmc_clk_phase_map_t map)
+{
+	struct device *dev = host->parent;
+
+	mmc_of_parse_timing_phase(dev, "clk-phase-legacy",
+				  &map[MMC_TIMING_LEGACY]);
+	mmc_of_parse_timing_phase(dev, "clk-phase-mmc-hs",
+				  &map[MMC_TIMING_MMC_HS]);
+	mmc_of_parse_timing_phase(dev, "clk-phase-sd-hs",
+				  &map[MMC_TIMING_SD_HS]);
+	mmc_of_parse_timing_phase(dev, "clk-phase-uhs-sdr12",
+				  &map[MMC_TIMING_UHS_SDR12]);
+	mmc_of_parse_timing_phase(dev, "clk-phase-uhs-sdr25",
+				  &map[MMC_TIMING_UHS_SDR25]);
+	mmc_of_parse_timing_phase(dev, "clk-phase-uhs-sdr50",
+				  &map[MMC_TIMING_UHS_SDR50]);
+	mmc_of_parse_timing_phase(dev, "clk-phase-uhs-sdr104",
+				  &map[MMC_TIMING_UHS_SDR104]);
+	mmc_of_parse_timing_phase(dev, "clk-phase-uhs-ddr50",
+				  &map[MMC_TIMING_UHS_DDR50]);
+	mmc_of_parse_timing_phase(dev, "clk-phase-mmc-ddr52",
+				  &map[MMC_TIMING_MMC_DDR52]);
+	mmc_of_parse_timing_phase(dev, "clk-phase-mmc-hs200",
+				  &map[MMC_TIMING_MMC_HS200]);
+	mmc_of_parse_timing_phase(dev, "clk-phase-mmc-hs400",
+				  &map[MMC_TIMING_MMC_HS400]);
+}
+
 /**
  *	mmc_of_parse() - parse host's device-tree node
  *	@host: host whose node should be parsed.
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 01bba36545c5..bc4731c9738f 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -79,6 +79,22 @@ struct mmc_ios {
 	bool enhanced_strobe;			/* hs400es selection */
 };
 
+struct mmc_clk_phase {
+	bool valid;
+	u16 in_deg;
+	u16 out_deg;
+};
+
+/*
+ * Define a type to map between bus timings and phase correction values. To
+ * avoid bloat in struct mmc_host we leave it to the host driver to define the
+ * phase map object in its private data if it supports phase correction.
+ * However, mmc_of_parse_clk_phase() is provided by the mmc core and needs the
+ * provided array to be correctly sized, so typedef an appropriately sized
+ * array to minimise the chance that the wrong size object is passed.
+ */
+typedef struct mmc_clk_phase mmc_clk_phase_map_t[MMC_TIMING_MMC_HS400 + 1];
+
 struct mmc_host;
 
 struct mmc_host_ops {
@@ -490,6 +506,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *);
 int mmc_add_host(struct mmc_host *);
 void mmc_remove_host(struct mmc_host *);
 void mmc_free_host(struct mmc_host *);
+void mmc_of_parse_clk_phase(struct mmc_host *host, mmc_clk_phase_map_t map);
 int mmc_of_parse(struct mmc_host *host);
 int mmc_of_parse_voltage(struct device_node *np, u32 *mask);
 
-- 
2.27.0

