Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3F7C43333
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 03:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C72B235FA
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 03:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbhANDP5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 22:15:57 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58705 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727768AbhANDPy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 22:15:54 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 8FF3E5C01E5;
        Wed, 13 Jan 2021 22:14:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 13 Jan 2021 22:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=KSRPuSjoX18Mr
        PCxVgf/9kBU5TXFu4khlyApjlCo9JI=; b=cNZBRnuOBN7WbiuP7Wt5mvNJbZ5nt
        2vXJlNzZ91e2+gLpQtYxXE3ekUauzhgW4ZQEERfhz0Ez21uX2lc2UpTbfQD3j+HY
        jjp4YCBcNQGftApHTwYvmAvVoSks9lTLjcltkF+xl93qky1nJKjnA4luQy8rNaIS
        6lA+1LGtlwo7w3JvytSX296SIw8MxRl5LoImQY/3isIG8fQZgClVh6B8jXZaMsDv
        3lDK28WXOc0JriNba4LgQC6zBPNOrE6/6cwvwtaIqTott43hEbPPO4FO3WlMQiDl
        x5TCEv1BTJkpuErKfwIDjJqPc8XTMbItxGznKdkZZMW+JAJu+Gwdin7gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=KSRPuSjoX18MrPCxVgf/9kBU5TXFu4khlyApjlCo9JI=; b=fwa7iDCg
        /sWoYPo1k4pEg+ZxyU9/WzYT9XwOB2linVob98VQhJ/IwCDjgDWgaMHtc6X0M0Ih
        jVZ21w97Ex4njZhaUbZ1Aj3NLn8P+Ugc2c4hO5r2QZyQdvi5tZiGQEUdqtz9lNyY
        RMG9ohLN8vAd3g8nX9DW69cZbBD5JSljd3YATMrcqKQ6XWawEDI8bX+QjO0GVDWB
        ghE7MyuBx2hj0sW+TvfZ6oFeimfIMXzTaBySC7ZOuoIW6rsze2Ae815lTBhmWjVi
        24J81hhsNzYO7CCiUkevfpc3T8VUSNVRu7ZK847+jyIR/Rn6CbX++dIqQJmy6Ll/
        YiU4LW0prvy6+A==
X-ME-Sender: <xms:KLf_X0qrKcUc4R8hK5VCCdbf2wsQYx5qCGCkgOo6kNniQN7BgmsnGA>
    <xme:KLf_X6qG0L7tAuiV_kowpNHA__Nzx3xzVxHjhk1iUP8tj-ysjLPRfL970zhZN6Wk2
    lK6Z1ZtsTzLpnKWrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtdeggdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucggtffrrghtthgvrhhnpeejgfdvveehteekveeggeellefgleette
    ejffelffdvudduveeiffegteelvefhteenucfkphepuddukedrvddutddrudejfedrgeek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnug
    hrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:KLf_X5Nq3h8tpreqeKEXqLpnius4wcj_lWsewtN1DLhScpUxb_aHIw>
    <xmx:KLf_X77e2mPRqm-G_8YJ3vXQpHQmRs6amMxl_Nur_lYOnsNy6LBa7w>
    <xmx:KLf_Xz5Pu3_L1mB-zuGJX-Cz_YtXoenOwMIjJ2cEQOJGyUd0rpj5pA>
    <xmx:KLf_X2YPccu3L1ZcxpsoCrbKNbEerS7CdGkY9hJ0dYkWrm2YvPZm9g>
Received: from localhost.localdomain (ppp118-210-173-48.adl-adc-lon-bras34.tpg.internode.on.net [118.210.173.48])
        by mail.messagingengine.com (Postfix) with ESMTPA id 63634240057;
        Wed, 13 Jan 2021 22:14:45 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, ryan_chen@aspeedtech.com
Subject: [PATCH v7 1/6] mmc: core: Add helper for parsing clock phase properties
Date:   Thu, 14 Jan 2021 13:44:28 +1030
Message-Id: <20210114031433.2388532-2-andrew@aj.id.au>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210114031433.2388532-1-andrew@aj.id.au>
References: <20210114031433.2388532-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Drivers for MMC hosts that accept phase corrections can take advantage
of the helper by embedding an instance of struct mmc_clk_phase_map in
their private data and invoking mmc_of_parse_clk_phase() to extract
phase parameters. It is the responsibility of the host driver to
translate and apply the extracted values to hardware as required.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/mmc/core/host.c  | 44 ++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h | 13 ++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 96b2ca1f1b06..74e853bb6948 100644
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
+mmc_of_parse_clk_phase(struct mmc_host *host, struct mmc_clk_phase_map *map)
+{
+	struct device *dev = host->parent;
+
+	mmc_of_parse_timing_phase(dev, "clk-phase-legacy",
+				  &map->phase[MMC_TIMING_LEGACY]);
+	mmc_of_parse_timing_phase(dev, "clk-phase-mmc-hs",
+				  &map->phase[MMC_TIMING_MMC_HS]);
+	mmc_of_parse_timing_phase(dev, "clk-phase-sd-hs",
+				  &map->phase[MMC_TIMING_SD_HS]);
+	mmc_of_parse_timing_phase(dev, "clk-phase-uhs-sdr12",
+				  &map->phase[MMC_TIMING_UHS_SDR12]);
+	mmc_of_parse_timing_phase(dev, "clk-phase-uhs-sdr25",
+				  &map->phase[MMC_TIMING_UHS_SDR25]);
+	mmc_of_parse_timing_phase(dev, "clk-phase-uhs-sdr50",
+				  &map->phase[MMC_TIMING_UHS_SDR50]);
+	mmc_of_parse_timing_phase(dev, "clk-phase-uhs-sdr104",
+				  &map->phase[MMC_TIMING_UHS_SDR104]);
+	mmc_of_parse_timing_phase(dev, "clk-phase-uhs-ddr50",
+				  &map->phase[MMC_TIMING_UHS_DDR50]);
+	mmc_of_parse_timing_phase(dev, "clk-phase-mmc-ddr52",
+				  &map->phase[MMC_TIMING_MMC_DDR52]);
+	mmc_of_parse_timing_phase(dev, "clk-phase-mmc-hs200",
+				  &map->phase[MMC_TIMING_MMC_HS200]);
+	mmc_of_parse_timing_phase(dev, "clk-phase-mmc-hs400",
+				  &map->phase[MMC_TIMING_MMC_HS400]);
+}
+EXPORT_SYMBOL(mmc_of_parse_clk_phase);
+
 /**
  *	mmc_of_parse() - parse host's device-tree node
  *	@host: host whose node should be parsed.
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 01bba36545c5..8cf686d98a68 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -79,6 +79,17 @@ struct mmc_ios {
 	bool enhanced_strobe;			/* hs400es selection */
 };
 
+struct mmc_clk_phase {
+	bool valid;
+	u16 in_deg;
+	u16 out_deg;
+};
+
+#define MMC_NUM_CLK_PHASES (MMC_TIMING_MMC_HS400 + 1)
+struct mmc_clk_phase_map {
+	struct mmc_clk_phase phase[MMC_NUM_CLK_PHASES];
+};
+
 struct mmc_host;
 
 struct mmc_host_ops {
@@ -490,6 +501,8 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *);
 int mmc_add_host(struct mmc_host *);
 void mmc_remove_host(struct mmc_host *);
 void mmc_free_host(struct mmc_host *);
+void mmc_of_parse_clk_phase(struct mmc_host *host,
+			    struct mmc_clk_phase_map *map);
 int mmc_of_parse(struct mmc_host *host);
 int mmc_of_parse_voltage(struct device_node *np, u32 *mask);
 
-- 
2.27.0

