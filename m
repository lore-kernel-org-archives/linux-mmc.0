Return-Path: <SRS0=GOb8=3F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1ABCC33CAF
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 17:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F771246A1
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 17:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579195956;
	bh=v5xJJ6yvSrlDbz7tmGMXlrb2kVf29Aj02dDkzuGsCA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AZSz3C8YlqDJqu1E4hXGNLXNcwULZI9wtvmmG5gW2wI0x+X+ZilFPfak/4J3nDkwh
	 xhxNeS/ZTO/lTRr5xIKIPEsNacODj4YKIQmkKcVqJmRygwDu8/qFA9VZHmuJuiSkxs
	 li/N/Ol4kX/q6+Gjd1QTDOcx0ylpMtvRLsa78EHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404631AbgAPRa5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:30:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:43776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404590AbgAPRay (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 16 Jan 2020 12:30:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3397E2469B;
        Thu, 16 Jan 2020 17:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195853;
        bh=v5xJJ6yvSrlDbz7tmGMXlrb2kVf29Aj02dDkzuGsCA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XZugOtdGxjijF4/Sto9XlDQNe9y7jq4ICvP3AbZZPFs/sEoyf0b35sKK5xt6/7A60
         0ZyZhtSwFJ2IkGySw47fCuRtPwjlPjJ++o9PUE+mgiHlO5VmwXtT7/4t47sX0HbRIq
         5JWhJ44bJFgOMPMefKUUdyOz62lI186ku1UhyVQU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 353/371] mmc: sdio: fix wl1251 vendor id
Date:   Thu, 16 Jan 2020 12:23:45 -0500
Message-Id: <20200116172403.18149-296-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: "H. Nikolaus Schaller" <hns@goldelico.com>

[ Upstream commit e5db673e7fe2f971ec82039a28dc0811c2100e87 ]

v4.11-rc1 did introduce a patch series that rearranged the
sdio quirks into a header file. Unfortunately this did forget
to handle SDIO_VENDOR_ID_TI differently between wl1251 and
wl1271 with the result that although the wl1251 was found on
the sdio bus, the firmware did not load any more and there was
no interface registration.

This patch defines separate constants to be used by sdio quirks
and drivers.

Fixes: 884f38607897 ("mmc: core: move some sdio IDs out of quirks file")
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Cc: <stable@vger.kernel.org> # v4.11+
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mmc/sdio_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 0a7abe8a407f..68bbbd9edc08 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -67,6 +67,8 @@
 
 #define SDIO_VENDOR_ID_TI			0x0097
 #define SDIO_DEVICE_ID_TI_WL1271		0x4076
+#define SDIO_VENDOR_ID_TI_WL1251		0x104c
+#define SDIO_DEVICE_ID_TI_WL1251		0x9066
 
 #define SDIO_VENDOR_ID_STE			0x0020
 #define SDIO_DEVICE_ID_STE_CW1200		0x2280
-- 
2.20.1

