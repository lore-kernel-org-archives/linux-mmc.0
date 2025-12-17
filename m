Received: from mail-m3273.qiye.163.com (mail-m3273.qiye.163.com [220.197.32.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B08337B96
	for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 08:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765960787; cv=none; b=oQzIIKCKT6a37LiOO8/88CNfluKt0OEbFZ57BU1LR+FQfSBjpCCEIUMz2ddtfYGFbl1ZAMwC95hhL9e8P8MflB1YF3QpWE2tFx3wLhLToyV9IUD4O7RiRNGjObr+cUfjgJLIWFRNpLe+H3Ua8OEJYX3N2cTFopHI9UKQbRX+QDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765960787; c=relaxed/simple;
	bh=uScr/YgLJQyhL9D3Ts584WOXz74iuZusipcGJxiV+mo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=QnkKKtxJwGx0CQasndNk0+d9/RNGiVw64ZObBH8oSSg19tUdNvwDKMzBUwaHYerDY7zBDerWinOz6CNrGQITAUV+lPhqA3T/kgCJ/t9K506VPjF+0dAwk5Zrpx0HoR9Kzpfr3+BnpRBIzsSWA2dveLCGyCVa0q5XzHrrCaGR7cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=CpJbCAjD; arc=none smtp.client-ip=220.197.32.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="CpJbCAjD"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2d8ee3865;
	Wed, 17 Dec 2025 16:04:13 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: dw_mmc: Fix descriptor increasing case in 64-bit case
Date: Wed, 17 Dec 2025 16:04:08 +0800
Message-Id: <1765958648-218422-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9b2b56960c09cckunm70940c3348f0cb
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh8eGlYZTUsaHRhMHR4eTB5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=CpJbCAjD9E8CetS6Svb20GUM3xSFf5ct6ifZ+Icx4S8+mqBFJ652R+SPz8jjHoGaSpFCKCTFv6Ulal3UmH74Qvhc5l0VmY9rwKoOrZZDGzJIrfvjBlMgUs42RxOakOfHfCqYRkXcROAtzLR2pjnji/GaVC288yeeYZ0iyYHPJFA=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=ngsh6LtQGD8jYhOEFC4przrS3BYQvjLnUlYnUA17UDU=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The original 'for ( ; length ; desc++)' loop unconditionally increments
the 'desc' pointer. However, in 64-bit mode (when 'is_64bit' is true),
the 'desc' pointer is not initialized or used; only the 'desc64' pointer
is valid. This leads to incorrect memory access and potential undefined
behavior.

This commit replaces the flawed 'for' loop with a 'while' loop and ensures
that the correct pointer ('desc' or 'desc64') is incremented based on the
'is_64bit' flag within each iteration.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 2d81d021..5d84d44 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -594,7 +594,7 @@ static inline int dw_mci_prepare_desc(struct dw_mci *host, struct mmc_data *data
 
 		u64 mem_addr = sg_dma_address(&data->sg[i]);
 
-		for ( ; length ; desc++) {
+		while (length > 0) {
 			desc_len = (length <= DW_MCI_DESC_DATA_LENGTH) ?
 				   length : DW_MCI_DESC_DATA_LENGTH;
 
@@ -640,10 +640,13 @@ static inline int dw_mci_prepare_desc(struct dw_mci *host, struct mmc_data *data
 			mem_addr += desc_len;
 
 			/* Save pointer to the last descriptor */
-			if (is_64bit)
+			if (is_64bit) {
 				desc64_last = desc64;
-			else
+				desc64++;
+			} else {
 				desc_last = desc;
+				desc++;
+			}
 		}
 	}
 
-- 
2.7.4

