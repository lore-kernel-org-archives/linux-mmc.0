From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH] sdio: add MMC_CAP_VDD_165_195 host capability
Date: Mon, 28 Sep 2009 19:09:52 +0100
Message-ID: <4AC0FBF0.6090007@csr.com>
References: <1254160269.10634.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-d.mailcontrol.com ([85.115.60.190]:54124 "EHLO
	cluster-d.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbZI1SKw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Sep 2009 14:10:52 -0400
Received: from rly23d.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly23d.srv.mailcontrol.com (MailControl) with ESMTP id n8SIAVqK022396
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2009 19:10:47 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly23d.srv.mailcontrol.com (MailControl) id n8SI9uZY018577
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2009 19:09:56 +0100
In-Reply-To: <1254160269.10634.15.camel@localhost>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@bencohen.org>
Cc: akpm@linux-foundation.org, "p hilipl"@overt.org, ian@mnementh.co.uk, matt@console-pimps.org, pierre@ossman.eu, roberto.foglietta@gmail.com, linux-mmc@vger.kernel.org

Ohad Ben-Cohen wrote:
> From: Ohad Ben-Cohen <ohad@wizery.com>
> 
> To allow the usage of MMC_VDD_165_195, host capability
> MMC_CAP_VDD_165_195 is introduced. This is necessary
> because MMC_VDD_165_195 is currently reserved/undefined.

The host already reports what voltages it supports (in
mmc_host::ocr_avail) so a seperate MMC_CAP_* isn't needed.

This interpretation of the reserved bits in the OCR should only done for
certain cards where the bits actually do mean 1.8 V operation (with v2.0
signalling) is possible.

That's a fair amount of work so perhaps in the interim something like this:

--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -494,6 +494,9 @@ int mmc_attach_sdio(struct mmc_host *host, u32 ocr)
 		ocr &= ~0x7F;
 	}

+	if (ocr & MMC_VDD_165_195)
+		printk(KERN_WARNING "%s: warning: card claims non-standard 1.65-1.95
V support"
+
 	host->ocr = mmc_select_voltage(host, ocr);

 	/*

And revisit this if these bits either: a) gain a (different) standard
meaning; or b) some other card uses these bits in a different
non-standard way.  Neither seems likely.

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
