From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [patch 077/232] sdio: fix read buffer overflow
Date: Thu, 01 Oct 2009 12:16:49 +0100
Message-ID: <4AC48FA1.409@csr.com>
References: <200909222345.n8MNj9kq013725@imap1.linux-foundation.org> <4AC47F84.20806@cam.ac.uk> <4AC48E8E.6030808@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020203050003080601040102"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-d.mailcontrol.com ([85.115.60.190]:40185 "EHLO
	cluster-d.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756318AbZJALSD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Oct 2009 07:18:03 -0400
Received: from rly15d.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly15d.srv.mailcontrol.com (MailControl) with ESMTP id n91BHsDt024710
	for <linux-mmc@vger.kernel.org>; Thu, 1 Oct 2009 12:18:06 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly15d.srv.mailcontrol.com (MailControl) id n91BGt7A018667
	for <linux-mmc@vger.kernel.org>; Thu, 1 Oct 2009 12:16:55 +0100
In-Reply-To: <4AC48E8E.6030808@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: akpm@linux-foundation.org, roel.kluin@gmail.com, linux-mmc@vger.kernel.org, "libertas-dev@lists.infradead.org" <libertas-dev@lists.infradead.org>

This is a multi-part message in MIME format.
--------------020203050003080601040102
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

David Vrabel wrote:
> 
> It's harmless if the tuple contains fewer so I think we should just try
> and parse as many strings as possible.  Does this patch fix your regression?

I spelt the field name wrong in the comment.  Use this patch instead,
please.

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom

--------------020203050003080601040102
Content-Type: text/x-diff;
 name="0001-mmc-sdio-don-t-require-CISTPL_VERS_1-to-contain-4-st.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="0001-mmc-sdio-don-t-require-CISTPL_VERS_1-to-contain-4-st.patch"

>From 41dc65a6198d2852a586ec0032fd5e03038fa32f Mon Sep 17 00:00:00 2001
From: David Vrabel <david.vrabel@csr.com>
Date: Thu, 1 Oct 2009 11:56:25 +0100
Subject: [PATCH] mmc: sdio: don't require CISTPL_VERS_1 to contain 4 strings

The PC Card 8.0 specification (vol. 4, section 3.2.10) says the
TPLLV1_INFO field of the CISTPL_VERS_1 tuple must contain 4 strings.
Some cards don't have all 4 so just parse as many as we can.

Signed-off-by: David Vrabel <david.vrabel@csr.com>
---
 drivers/mmc/core/sdio_cis.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
index 6636354..e5ab44d 100644
--- a/drivers/mmc/core/sdio_cis.c
+++ b/drivers/mmc/core/sdio_cis.c
@@ -29,6 +29,8 @@ static int cistpl_vers_1(struct mmc_card *card, struct sdio_func *func,
 	unsigned i, nr_strings;
 	char **buffer, *string;
 
+	/* Find all null-terminated (including zero length) strings in
+	   the TPLLV1_INFO field. Trailing garbage is ignored. */
 	buf += 2;
 	size -= 2;
 
@@ -39,9 +41,7 @@ static int cistpl_vers_1(struct mmc_card *card, struct sdio_func *func,
 		if (buf[i] == 0)
 			nr_strings++;
 	}
-
-	if (nr_strings < 4) {
-		printk(KERN_WARNING "SDIO: ignoring broken CISTPL_VERS_1\n");
+	if (nr_strings == 0) {
 		return 0;
 	}
 
-- 
1.6.3.3


--------------020203050003080601040102--
