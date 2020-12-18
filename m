Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B60CC2BBD5
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Dec 2020 03:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0201123A9B
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Dec 2020 03:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732600AbgLRDzH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Dec 2020 22:55:07 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:52013 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726789AbgLRDzH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Dec 2020 22:55:07 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9A56F5C00D2;
        Thu, 17 Dec 2020 22:54:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 17 Dec 2020 22:54:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=KSRPuSjoX18Mr
        PCxVgf/9kBU5TXFu4khlyApjlCo9JI=; b=YjdWUNlQYS6a9dNPvKJS2BT0ZEzgP
        /GlOZFxrMToXygI+5uIkRWkGK5J62FIKTY464DZ6wFzRsS2KS7LAr32do80FUagq
        G0223L8zQaSnvlivIjn0lSIdu0/MXUYbgD95iYBT2gxxPVRT2OHnQvfjzQO1GvJE
        R64NlMgo1Kfq29xplxho2EXTaZrKfC1ERU4pw4bWM2kJPYdury8tLnAA6bh+ousE
        6BhMEb1Yjmbk0uBoqoAu3xuMZ4q/bDbfEdV6p8Z44qVB9rQri/3/MR8nTiMBCj2Y
        j+Lb3c9C68Mfpf+RFHGfYo67Mvx5LUgKMA+L/MaWkjOmdOHHDKtQu4qmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=KSRPuSjoX18MrPCxVgf/9kBU5TXFu4khlyApjlCo9JI=; b=C9sy6sj4
        xHYbfPv3CW2uqQKgIF9ZN7RFoXNEbYcaHF5lXabUK54xEbZMctHIcQFjfztoO0vP
        Iyp2syFr8gcG/KVitXmD3kQHenU/WtaFUGirqu5iASHtc2gSv6Z5m4rIjVTsZ0tM
        kJGKChfs0JgWHGaxWwbXt7opu4j1BxkPjMZbhM96RutLca0Xbr4WpMfcLt17p4We
        5mYi8rstXFNHZLowNk0cUzFDH5En9eQVdcS0tKbnIMXs2EU3eZjUHIkJea/N/Boq
        64Oco7Z8r3vSikwRZv28YsOuFW5gCjSXMZsbWCC10yvVCeur0FN7CxkjuU+BrjIf
        JYsP/6cix3HjiQ==
X-ME-Sender: <xms:2CfcX0m-enwvmQe_C3HqMW4ToURUb6N9d0U3A52p5hk_W0zpMX2q1w>
    <xme:2CfcXz23ekj1yqoTJLAVyzIMlTVOIdkxRn_m64FvaFMEbYR-JcpUGhZb4wOoIA7Md
    4lfAYyYR9Xw_vJs3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudelhedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecuggftrfgrthhtvghrnhepjefgvdevheetkeevgeegleelgfelte
    etjeffleffvdduudevieffgeetleevhfetnecukfhppeduvddtrddvtddrjeejrddvuddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnug
    hrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:2CfcXyorfeZuVCCT6ErX2YyVp5bnd8M93g7QGtsUCBpGbugXDseu_w>
    <xmx:2CfcXwmJrhPFhMw3YhLb0oGDmAytw2xENi_ycjhwY9Ja2rcR2J4PuA>
    <xmx:2CfcXy0z_o6IKxaB82XSinToBQmUbTTEO1FHcJ6MmhK-8F05nCNPmQ>
    <xmx:2CfcX7mKpDYYwwjSN2O7IFZKuoZxd2IZCJGvPkjnsk0VSabkhzauww>
Received: from localhost.localdomain (unknown [120.20.77.211])
        by mail.messagingengine.com (Postfix) with ESMTPA id ECA781080067;
        Thu, 17 Dec 2020 22:53:55 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, ryan_chen@aspeedtech.com
Subject: [PATCH v6 1/6] mmc: core: Add helper for parsing clock phase properties
Date:   Fri, 18 Dec 2020 14:23:33 +1030
Message-Id: <20201218035338.1130849-2-andrew@aj.id.au>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201218035338.1130849-1-andrew@aj.id.au>
References: <20201218035338.1130849-1-andrew@aj.id.au>
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

