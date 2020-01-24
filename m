Return-Path: <SRS0=bXXM=3N=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425DEC47409
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jan 2020 01:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0A524673
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jan 2020 01:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579828795;
	bh=E0awQwTam+1n25uIcPvb3MI3juss7eRUO4EghGen+rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d/GUADf1+geyVyM7NibKrTb+jfo56R+od8H1dEJbi9AqRL673s/vKN8yCxpnk4OVA
	 CqR0hzJ56MbVK2COp4ZOJFcNdSMBObCdpipLFAExObH36gYb0lotuRT8do/T1NEkRU
	 tT0e0821W/AKnj7161ju1YLdwx7D+yUj4qxxcwEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbgAXBRh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Jan 2020 20:17:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:60716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730540AbgAXBRg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 23 Jan 2020 20:17:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A53022467E;
        Fri, 24 Jan 2020 01:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579828656;
        bh=E0awQwTam+1n25uIcPvb3MI3juss7eRUO4EghGen+rs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=znA0DuXbodEf0gBTFYekrABxloKNS/03GdIQ4uOpYXzqI6P9ow9CRxS8xrYMnPgQM
         u/E2Y9kLVZ9mJPSOEXpHCLD+VToNR0A8rIg+UPo8yH7gZWs9YVgPBMkkhkj4L2vTXL
         i9SOExu7IJp8cWFQU15f/nn2FGdgv0CgEh5tzSvY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 24/33] mmc: core: fix wl1251 sdio quirks
Date:   Thu, 23 Jan 2020 20:16:59 -0500
Message-Id: <20200124011708.18232-24-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124011708.18232-1-sashal@kernel.org>
References: <20200124011708.18232-1-sashal@kernel.org>
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
index 2d2d9ea8be4f3..3dba15bccce25 100644
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

