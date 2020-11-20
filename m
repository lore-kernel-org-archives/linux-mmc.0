Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445AEC64E7B
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 18:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E62FF2416E
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 18:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6aV58LK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbgKTShL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:37:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:55138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731148AbgKTShI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 20 Nov 2020 13:37:08 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9DEB24124;
        Fri, 20 Nov 2020 18:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897427;
        bh=s2Ty/JLf5jolMy7JPfcU8PXsMKPLhxDS8ktLvPUxD90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f6aV58LKYF9rRJJqHIgNAFFLVKfNSOcsLwZng/7YOvXebN8H+AiL3ru8BAP//ZIkX
         WkJdnUSUSE+M6wco+b0+Hjvu0GHtTv8I2jpKc2+YFLz7LLXTNZRlmLUJD+BR4CfxPr
         SXmmSstvnAkhuDLPJycrDoohYCoerVsZ4Uzjgh5c=
Date:   Fri, 20 Nov 2020 12:37:13 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 098/141] mmc: sdhci-of-arasan: Fix fall-through warnings for
 Clang
Message-ID: <387cab3a466038aa5d1fc34b8b6a7c4f693826ea.1605896060.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
warnings by explicitly adding multiple break statements instead of
letting the code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/mmc/host/sdhci-of-arasan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 829ccef87426..1f7e42b6ced5 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -627,6 +627,7 @@ static int sdhci_zynqmp_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
 	case MMC_TIMING_MMC_HS200:
 		/* For 200MHz clock, 8 Taps are available */
 		tap_max = 8;
+		break;
 	default:
 		break;
 	}
@@ -695,6 +696,7 @@ static int sdhci_zynqmp_sampleclk_set_phase(struct clk_hw *hw, int degrees)
 	case MMC_TIMING_MMC_HS200:
 		/* For 200MHz clock, 30 Taps are available */
 		tap_max = 30;
+		break;
 	default:
 		break;
 	}
@@ -760,6 +762,7 @@ static int sdhci_versal_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
 	case MMC_TIMING_MMC_HS200:
 		/* For 200MHz clock, 8 Taps are available */
 		tap_max = 8;
+		break;
 	default:
 		break;
 	}
@@ -831,6 +834,7 @@ static int sdhci_versal_sampleclk_set_phase(struct clk_hw *hw, int degrees)
 	case MMC_TIMING_MMC_HS200:
 		/* For 200MHz clock, 30 Taps are available */
 		tap_max = 30;
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

