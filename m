From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc-utils: add the revision for eMMC5.0
Date: Wed, 04 Dec 2013 09:29:15 +0900
Message-ID: <529E775B.5000308@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:37071 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206Ab3LDA3P (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Dec 2013 19:29:15 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MX900BW3AOP5360@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 04 Dec 2013 09:29:13 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: 'Chris Ball' <cjb@laptop.org>

To know whether eMMC card is version5.0 or not, add the check point.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 mmc_cmds.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index b8afa74..5edf42b 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -722,6 +722,9 @@ int do_read_extcsd(int nargs, char **argv)
 	ext_csd_rev = ext_csd[192];
 
 	switch (ext_csd_rev) {
+	case 7:
+		str = "5.0";
+		break;
 	case 6:
 		str = "4.5";
 		break;
-- 
1.7.9.5
