Return-Path: <SRS0=tDFP=7W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3062C433DF
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Jun 2020 00:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E40B20774
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Jun 2020 00:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591663596;
	bh=fE+F2MIP8scEjfPsKRccOUjhiCq/HM5JqCR7gNnlWr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GaOPLfk84Wqv37ADfEt18DYlFcp7/3ud5MrDGlHeWhaf4VPG2IDKAW/0uQ8BQ6eLE
	 sgxzSot/7vr/sRWQE77+9L+vUHmmHgf5bN16L/B1dzg7ff3UXLOpzPCVXVuiIqI9s0
	 q1vy2j7HeI/q2mTp3M+4i7CwztMTDS3qVhQxziLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbgFIAqb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:46:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728923AbgFHXLg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 8 Jun 2020 19:11:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19995208C7;
        Mon,  8 Jun 2020 23:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657895;
        bh=fE+F2MIP8scEjfPsKRccOUjhiCq/HM5JqCR7gNnlWr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hBr+QauRZzy/vQk08leVj3G3rLae2SBYhTHgkzsq+HLRtGgtxwjqjX0EAlAru7RnU
         T3Ryhr57MwjUSwZ1BNP2PIa4Un+m8o6MA6ndA/AmIvEZF+2d/cezGkRlbFZgXhR+A6
         neiCObI0mbwOiM9VfUagboK146GW6wF48lJFxVzA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Angelo Dureghello <angelo.dureghello@timesys.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 250/274] mmc: sdhci: add quirks for be to le byte swapping
Date:   Mon,  8 Jun 2020 19:05:43 -0400
Message-Id: <20200608230607.3361041-250-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Angelo Dureghello <angelo.dureghello@timesys.com>

[ Upstream commit e93577ecde8f3cbd12a2eaa0522d5c85e0dbdd53 ]

Some controller as the ColdFire eshdc may require an endianness
byte swap, because DMA read endianness is not configurable.

Facilitate using the bounce buffer for this by adding
->copy_to_bounce_buffer().

Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20200518191742.1251440-2-angelo.dureghello@timesys.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci.c | 10 +++++++---
 drivers/mmc/host/sdhci.h |  3 +++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e368f2dabf20..5dcdda5918cb 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -634,9 +634,13 @@ static int sdhci_pre_dma_transfer(struct sdhci_host *host,
 		}
 		if (mmc_get_dma_dir(data) == DMA_TO_DEVICE) {
 			/* Copy the data to the bounce buffer */
-			sg_copy_to_buffer(data->sg, data->sg_len,
-					  host->bounce_buffer,
-					  length);
+			if (host->ops->copy_to_bounce_buffer) {
+				host->ops->copy_to_bounce_buffer(host,
+								 data, length);
+			} else {
+				sg_copy_to_buffer(data->sg, data->sg_len,
+						  host->bounce_buffer, length);
+			}
 		}
 		/* Switch ownership to the DMA */
 		dma_sync_single_for_device(host->mmc->parent,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 79dffbb731d3..1bf4f1d91951 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -653,6 +653,9 @@ struct sdhci_ops {
 	void	(*voltage_switch)(struct sdhci_host *host);
 	void	(*adma_write_desc)(struct sdhci_host *host, void **desc,
 				   dma_addr_t addr, int len, unsigned int cmd);
+	void	(*copy_to_bounce_buffer)(struct sdhci_host *host,
+					 struct mmc_data *data,
+					 unsigned int length);
 	void	(*request_done)(struct sdhci_host *host,
 				struct mmc_request *mrq);
 };
-- 
2.25.1

