From: <wei_wang@realsil.com.cn>
Subject: [PATCH 2/7] MFD:rtsx: Remove redundant code
Date: Mon, 24 Dec 2012 14:03:24 +0800
Message-ID: <19e2c741f89b80b9d1640ff00902b1cc3f76a171.1356319097.git.wei_wang@realsil.com.cn>
References: <cover.1356319097.git.wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rtits2.realtek.com ([60.250.210.242]:50322 "EHLO
	rtits2.realtek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793Ab2LXGEC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Dec 2012 01:04:02 -0500
In-Reply-To: <cover.1356319097.git.wei_wang@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, sameo@linux.intel.com
Cc: devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, oakad@yahoo.com, bp@alien8.de, Wei WANG <wei_wang@realsil.com.cn>

From: Wei WANG <wei_wang@realsil.com.cn>

Signed-off-by: Wei WANG <wei_wang@realsil.com.cn>
---
 drivers/mfd/rtsx_pcr.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/rtsx_pcr.c b/drivers/mfd/rtsx_pcr.c
index 3a44efa..fa2c2bc 100644
--- a/drivers/mfd/rtsx_pcr.c
+++ b/drivers/mfd/rtsx_pcr.c
@@ -325,7 +325,6 @@ static void rtsx_pci_add_sg_tbl(struct rtsx_pcr *pcr,
 	val = ((u64)addr << 32) | ((u64)len << 12) | option;
 
 	put_unaligned_le64(val, ptr);
-	ptr++;
 	pcr->sgi++;
 }
 
-- 
1.7.9.5

