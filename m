From: <wei_wang@realsil.com.cn>
Subject: [PATCH v4 2/8] MFD:rtsx: Remove redundant code
Date: Tue, 8 Jan 2013 17:57:23 +0800
Message-ID: <08bda2184701413431444c0e58219ace09c5d97b.1357638064.git.wei_wang@realsil.com.cn>
References: <cover.1357638064.git.wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1357638064.git.wei_wang@realsil.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: cjb@laptop.org, sameo@linux.intel.com
Cc: devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, oakad@yahoo.com, bp@alien8.de, Wei WANG <wei_wang@realsil.com.cn>
List-Id: linux-mmc@vger.kernel.org

From: Wei WANG <wei_wang@realsil.com.cn>

In function rtsx_pci_add_sg_tbl, the statement "ptr++" is useless.

Signed-off-by: Wei WANG <wei_wang@realsil.com.cn>
Acked-by: Borislav Petkov <bp@alien8.de>
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
