From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: mmc: sdhci-s3c: fix missing clock for gpio card-detect
Date: Fri, 8 Nov 2013 13:04:27 +0300
Message-ID: <20131108100427.GT27977@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:16947 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830Ab3KHKEn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Nov 2013 05:04:43 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: heiko@sntech.de
Cc: linux-mmc@vger.kernel.org

Hello Heiko St=FCbner,

This is a semi-automatic email about new static checker warnings.

The patch fe007c02f965: "mmc: sdhci-s3c: fix missing clock for gpio=20
card-detect" from Nov 18, 2012, leads to the following Smatch=20
complaint:

drivers/mmc/host/sdhci-s3c.c:381 sdhci_s3c_notify_change()
	 warn: variable dereferenced before check 'host' (see line 377)

drivers/mmc/host/sdhci-s3c.c
   376	#ifdef CONFIG_PM_RUNTIME
   377		struct sdhci_s3c *sc =3D sdhci_priv(host);
                                       ^^^^^^^^^^^^^^^^
Dereference.

   378	#endif
   379		unsigned long flags;
   380=09
   381		if (host) {
                   ^^^^^
Check.

   382			spin_lock_irqsave(&host->lock, flags);
   383			if (state) {

regards,
dan carpenter
