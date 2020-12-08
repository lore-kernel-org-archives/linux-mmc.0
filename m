Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0128C2BB40
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Dec 2020 01:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAB3523A40
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Dec 2020 01:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgLHB1i (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Dec 2020 20:27:38 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:50337 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725995AbgLHB1i (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Dec 2020 20:27:38 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BB61A5C01BE;
        Mon,  7 Dec 2020 20:26:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 07 Dec 2020 20:26:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=1vZcpqBH92H2y
        09BRQ/QI3SD2MWN5UMVaCtiQACTia4=; b=fACt2ITYar97AnyHsd195C0ys5KWP
        jYI7Y3GqbXzknnttg79l8ngxeig7jw+85hBlFQETTLYPeFQcASDijXDUWpsxmGMA
        vmYlO3l4rkbBhVUovhzOqQNgQ1zpc4ndF/Cwgj6reIxNiQiynqB2WEIYE534r4+T
        CbP3hUI2tznlqfTezyqEDQ+ELR5Eo8mZEjTrA0N6UENmPmYrCImNsR/eZXet2+4c
        5l6Havi1dMFa3HGth9cetkoF0G75rYkW+xgPQsIjNb7SdutQPBHqxaBmCqja467Y
        Xym/7h7o81cFmIGBfOH0hFmLT9EM9iCBYlscf960C2vfcJpF8TFa4RYhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=1vZcpqBH92H2y09BRQ/QI3SD2MWN5UMVaCtiQACTia4=; b=J6sUETo3
        e4foxueYWwr1F6cooohXM9xRrodV+sn1Vs6m4tsOMe+vZUVa9Ly9CW1MwOEac/kY
        wNli0vD0AsYVnys9rf9BU9ziFkYyKqN3ws+IvAswL3OMx4f7hA/B58BS9vzTAC2q
        ipW4tb68H9KT62yKzwGdKaceH1FCKmuC859s2i5CPfVLkczPp/+uak/9lxGbxblL
        KRBEHHwpT1hJmWSqwxAKzUWM3QmY1otaGdx9NyiQxo7/tDjPRyVmGsowtWvn7B8O
        IZsz9i3kMndiL2RbF1siznf/gL8SSciCgllnM50QETdO3eomlZLzVS2S8IY7WyNh
        T7rdhvaWtm9YmA==
X-ME-Sender: <xms:R9bOX29HQDTEjTczme_vxnyId4XX1I6GygGnvJjdZkPlcpfC4x2Yxw>
    <xme:R9bOX2tA1mP87mC4WSFbIxHCW59WA2c5HtM5tXxwGYeopwEeYIqwXyZNPasbdrUPL
    FrFUHz5iL-FIx6DmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejhedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecuggftrfgrthhtvghrnhepjefgvdevheetkeevgeegleelgfelte
    etjeffleffvdduudevieffgeetleevhfetnecukfhppedvtdefrdehjedrvddtkedrudeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnh
    gurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:R9bOX8DnHSSh_Bxje6FxSdWcIi_mZW6u0tX6oPELH-o83TPGozpFiA>
    <xmx:R9bOX-eY1agyYjFsPpHVvL22CjIaInP8qsmK_wzC0mjq0qriFRI6Tg>
    <xmx:R9bOX7NoiU3n2o-qPgvTBgAqkaqhj6Gh5d_BRxkGkL9K2DqhhDo1hw>
    <xmx:R9bOX2e7zEi4XwRXLT9WEDe7UN7Hw-atLML6_C4LnJxFZFrC-NK8bw>
Received: from localhost.localdomain (203-57-208-146.dyn.iinet.net.au [203.57.208.146])
        by mail.messagingengine.com (Postfix) with ESMTPA id 039161080066;
        Mon,  7 Dec 2020 20:26:27 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, ryan_chen@aspeedtech.com
Subject: [PATCH v5 1/6] mmc: core: Add helper for parsing clock phase properties
Date:   Tue,  8 Dec 2020 11:56:10 +1030
Message-Id: <20201208012615.2717412-2-andrew@aj.id.au>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201208012615.2717412-1-andrew@aj.id.au>
References: <20201208012615.2717412-1-andrew@aj.id.au>
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
 drivers/mmc/core/host.c  | 44 ++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h | 17 ++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 96b2ca1f1b06..b1697f00c4b5 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -163,6 +163,50 @@ static void mmc_retune_timer(struct timer_list *t)
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
+EXPORT_SYMBOL(mmc_of_parse_clk_phase);
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

