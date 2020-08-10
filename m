Return-Path: <SRS0=LKB8=BU=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBB1C433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Aug 2020 19:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FD592080C
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Aug 2020 19:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597087414;
	bh=K1hirN2sBpFZcADEX5DOg98QwrA5CvrnN4JSkIwDI64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U6ca/cwMKCtTUqIHd6T9xbj0rPOoiLzg3i7A0OmvraYT5zuy5jAsY/ESS/JLP5Tx9
	 pNzgiL5eqJvQ0ZNWq8RnmY/AA+oKjXIHbvHbIKEO1qq3EChhxZWqg874d0PFME8CfU
	 NMCr5WuGft/i4dEzBHyJf9QlCJLo1voBfI+Sq7oU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgHJTXb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:23:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729619AbgHJTMr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 10 Aug 2020 15:12:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15F1622B49;
        Mon, 10 Aug 2020 19:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597086766;
        bh=K1hirN2sBpFZcADEX5DOg98QwrA5CvrnN4JSkIwDI64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k+COgtKJPZI4PMqcbgbCxripOKmXZgSVA/8yXv+V7BfKqxqjYsOadz4WGirNcdYAO
         b7rpqO1SCFof43A+g1LxSPOyPYrgU3SxVQCbwzC86pTvB57P0oDzyzghYxOj+S/gaI
         6uX3nZbzsqATGI9Aym1KvoLR1IsA+H+NmFVqk43M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     shirley her <shirley.her@bayhubtech.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 37/45] mmc: sdhci-pci-o2micro: Bug fix for O2 host controller Seabird1
Date:   Mon, 10 Aug 2020 15:11:45 -0400
Message-Id: <20200810191153.3794446-37-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810191153.3794446-1-sashal@kernel.org>
References: <20200810191153.3794446-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: shirley her <shirley.her@bayhubtech.com>

[ Upstream commit cdd2b769789ae1a030e1a26f6c37c5833cabcb34 ]

To fix support for the O2 host controller Seabird1, set the quirk
SDHCI_QUIRK2_PRESET_VALUE_BROKEN and the capability bit MMC_CAP2_NO_SDIO.
Moreover, assign the ->get_cd() callback.

Signed-off-by: Shirley Her <shirley.her@bayhubtech.com>
Link: https://lore.kernel.org/r/20200721011733.8416-1-shirley.her@bayhubtech.com
[Ulf: Updated the commit message]
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index fa8105087d684..41a2394313dd0 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -561,6 +561,12 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 			slot->host->mmc_host_ops.get_cd = sdhci_o2_get_cd;
 		}
 
+		if (chip->pdev->device == PCI_DEVICE_ID_O2_SEABIRD1) {
+			slot->host->mmc_host_ops.get_cd = sdhci_o2_get_cd;
+			host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
+			host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
+		}
+
 		host->mmc_host_ops.execute_tuning = sdhci_o2_execute_tuning;
 
 		if (chip->pdev->device != PCI_DEVICE_ID_O2_FUJIN2)
-- 
2.25.1

