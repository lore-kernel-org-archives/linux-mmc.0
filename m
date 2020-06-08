Return-Path: <SRS0=tDFP=7W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A1DC433E2
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Jun 2020 00:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FFD72074B
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Jun 2020 00:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591660935;
	bh=ZcVpFMnNya8jE2nq81tFcyYpizXtVtOzYmsv2lw/vwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DgzgdjcORrrZRtgLKNiqysQLDI0g9RRKB5vjKdrWviGDbQwchzKrOZEZE9CH/3BBc
	 Na/gSBthGFfIwIX7RgrKmRNWnWFVDOWxrg3aLeifxFFP8hCngD9cYD9XqlIW7TBoAm
	 gq9OtAQ+QwvT8yExO2UQjIOaiLbIw6gq5MkBX/ns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgFIACN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:02:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728842AbgFHXWJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 8 Jun 2020 19:22:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD89E2086A;
        Mon,  8 Jun 2020 23:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658529;
        bh=ZcVpFMnNya8jE2nq81tFcyYpizXtVtOzYmsv2lw/vwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zHyzShWy8sWM2C9ytOISmDCo+4nY4L5Nj6+I1jwaZGOizoHG2VgqG2JGpb6jVC6Jk
         kB3zSFYnP5DheMnzc07d6WP82WRRk6DFpfWowHT4g/GrYDImtgvhUoNNdTTCO+cFoN
         jqUvJt2gBi5qc6ZKOG/scwGJELIv/OSceA/W66ZA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 154/175] mmc: sdhci-msm: Set SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 quirk
Date:   Mon,  8 Jun 2020 19:18:27 -0400
Message-Id: <20200608231848.3366970-154-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231848.3366970-1-sashal@kernel.org>
References: <20200608231848.3366970-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>

[ Upstream commit d863cb03fb2aac07f017b2a1d923cdbc35021280 ]

sdhci-msm can support auto cmd12.
So enable SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 quirk.

Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/1587363626-20413-3-git-send-email-vbadigan@codeaurora.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-msm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 0148f8e6bb37..fe7e9028f767 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1736,7 +1736,9 @@ static const struct sdhci_ops sdhci_msm_ops = {
 static const struct sdhci_pltfm_data sdhci_msm_pdata = {
 	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
 		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
-		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
+		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
+
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	.ops = &sdhci_msm_ops,
 };
-- 
2.25.1

