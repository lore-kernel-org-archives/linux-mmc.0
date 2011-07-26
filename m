From: Kyungmin Park <kmpark@infradead.org>
Subject: [RFC] mmc: new discard support at mmc v4.5
Date: Tue, 26 Jul 2011 17:46:03 +0900
Message-ID: <20110726084603.GA15154@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:11668 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337Ab1GZIqN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jul 2011 04:46:13 -0400
Received: from epcpsbgm2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LOX00BWPN0NMKQ0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 26 Jul 2011 17:46:11 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LOX00B93N0Z95@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 26 Jul 2011 17:46:11 +0900 (KST)
Content-disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: jh80.chung@samsung.com

At mmc v4.5, it supports the DISCARD feature.
It's different from trim and there's no check bit. 
currently it's only supported at v4.5.

In trim mode, the controller can perform the actual erase at a convenient time.
however, In discard, The controller can perform partial or full the actual erase at a convenient time.

So in mmc v4.5, it's better to use the discard instead of trim.

Please give opinions or comments.

Thank you,
Kyungmin Park
---
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index b8b1b7a..84f35a6 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -146,6 +146,7 @@ extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int);
 #define MMC_ERASE_ARG		0x00000000
 #define MMC_SECURE_ERASE_ARG	0x80000000
 #define MMC_TRIM_ARG		0x00000001
+#define MMC_DISCARD_ARG		0x00000003
 #define MMC_SECURE_TRIM1_ARG	0x80000001
 #define MMC_SECURE_TRIM2_ARG	0x80008000
 
