Return-Path: <SRS0=tDFP=7W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE690C433E0
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Jun 2020 01:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82F6920737
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Jun 2020 01:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591664594;
	bh=OaiQKm1bB3NmMoGKTxrJngEVvq3569afw1osq8OEFZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k2P8YCUAi/1qexL5ntND79eEniya2mxk7EEvJVASSg7rE1GhOwusjwpQv0yVDWg9v
	 0dH+nqH33DL2UNwn5Sj71NynDR1zwcFfdI969L1E0zSLPylYpjMtNHcunlb0SUiUUf
	 X21A0KorKk0dUhsVqoWZV9pnOfvSn+mK8Exyqyak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgFHXHr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:07:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbgFHXHq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 8 Jun 2020 19:07:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A72D20888;
        Mon,  8 Jun 2020 23:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657666;
        bh=OaiQKm1bB3NmMoGKTxrJngEVvq3569afw1osq8OEFZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ruNEgV7kIJbhNz4ws/2nOm4I69roVOGO5ElZRJjJy1YAse6dtOl2ddZMuO47JEVtA
         NxWBmcqdxafQeZOslHRM6LoSZr1GonP0MlqE/zGp+7TkZx0uXqG916fNIsPLe/DelL
         GbOWSVnif37OrPMwI1Zi3Vr9Hva4tBGJgBBLuWQM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ludovic Barre <ludovic.barre@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.7 076/274] mmc: mmci_sdmmc: fix power on issue due to pwr_reg initialization
Date:   Mon,  8 Jun 2020 19:02:49 -0400
Message-Id: <20200608230607.3361041-76-sashal@kernel.org>
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

From: Ludovic Barre <ludovic.barre@st.com>

[ Upstream commit 33ba6fec0012e47f4e72bfab922b99327373f210 ]

This patch fix a power-on issue, and avoid to retry the power sequence.

In power off sequence: sdmmc must set pwr_reg in "power-cycle" state
(value 0x2), to prevent the card from being supplied through the signal
lines (all the lines are driven low).

In power on sequence: when the power is stable, sdmmc must set pwr_reg
in "power-off" state (value 0x0) to drive all signal to high before to
set "power-on".

To avoid writing the same value to the power register several times, this
register is cached by the pwr_reg variable. At probe pwr_reg is initialized
to 0 by kzalloc of mmc_alloc_host.

Like pwr_reg value is 0 at probing, the power on sequence fail because
the "power-off" state is not writes (value 0x0) and the lines
remain drive to low.

This patch initializes "pwr_reg" variable with power register value.
This it done in sdmmc variant init to not disturb default mmci behavior.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Link: https://lore.kernel.org/r/20200420161831.5043-1-ludovic.barre@st.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/mmci_stm32_sdmmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index d33e62bd6153..14f99d8aa3f0 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -519,6 +519,7 @@ void sdmmc_variant_init(struct mmci_host *host)
 	struct sdmmc_dlyb *dlyb;
 
 	host->ops = &sdmmc_variant_ops;
+	host->pwr_reg = readl_relaxed(host->base + MMCIPOWER);
 
 	base_dlyb = devm_of_iomap(mmc_dev(host->mmc), np, 1, NULL);
 	if (IS_ERR(base_dlyb))
-- 
2.25.1

