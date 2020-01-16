Return-Path: <SRS0=GOb8=3F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8829CC33CB6
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 17:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5424A20730
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 17:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194987;
	bh=zPm3rMc6kTYxFq53Hy+TK42EjY/2/sZs7TOmw6+t2Ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wRecerbewUMcUybAKI9CK9hB/UCKPqPlD7TnOXmJXxejpJd1P0kUssAGFj+aoYw6X
	 ENVOyJcoij3iuwy+d1Sdrm8PDYG/ezXc+3wE0DhSibEy45iFhuyG7Txu/H6ENcKRHj
	 P+eInKi8jOaWCUIjFxwq4R4i+193vRCmDkWvAIUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgAPRQX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:16:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:32772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390887AbgAPROM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 16 Jan 2020 12:14:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76F5B246BB;
        Thu, 16 Jan 2020 17:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194852;
        bh=zPm3rMc6kTYxFq53Hy+TK42EjY/2/sZs7TOmw6+t2Ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zSffbajkJOx4IyEDxt3rZbmWPsKLZ+uKdvslTNWHqDIpPaGW+z5ApSCIqcq1NKG26
         //ZWCtc+5yAifCfgvDv2CZ0EANqpyCeoBZP1TfsMZXgM/CeIk4vTYQKwCa+MlV7rsr
         XQQIbekFLJq5KDKHztBBj3ywDsEGE7/uD/yYw4IA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 648/671] mmc: core: fix wl1251 sdio quirks
Date:   Thu, 16 Jan 2020 12:04:46 -0500
Message-Id: <20200116170509.12787-385-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: "H. Nikolaus Schaller" <hns@goldelico.com>

[ Upstream commit 16568b4a4f0c34bd35cfadac63303c7af7812764 ]

wl1251 and wl1271 have different vendor id and device id.
So we need to handle both with sdio quirks.

Fixes: 884f38607897 ("mmc: core: move some sdio IDs out of quirks file")
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Cc: <stable@vger.kernel.org> # v4.11+
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/quirks.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index dd2f73af8f2c..d5bbe8e544de 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -119,7 +119,14 @@ static const struct mmc_fixup mmc_ext_csd_fixups[] = {
 	END_FIXUP
 };
 
+
 static const struct mmc_fixup sdio_fixup_methods[] = {
+	SDIO_FIXUP(SDIO_VENDOR_ID_TI_WL1251, SDIO_DEVICE_ID_TI_WL1251,
+		   add_quirk, MMC_QUIRK_NONSTD_FUNC_IF),
+
+	SDIO_FIXUP(SDIO_VENDOR_ID_TI_WL1251, SDIO_DEVICE_ID_TI_WL1251,
+		   add_quirk, MMC_QUIRK_DISABLE_CD),
+
 	SDIO_FIXUP(SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271,
 		   add_quirk, MMC_QUIRK_NONSTD_FUNC_IF),
 
-- 
2.20.1

