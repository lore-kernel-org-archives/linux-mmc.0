From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH V3 0/5] sdhci-esdhc-imx: use gpio for write protection
 and card detection
Date: Thu, 24 Feb 2011 16:18:05 +0800
Message-ID: <20110224081803.GA29530@S2100-06.ap.freescale.net>
References: <1298469118-25282-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe003.messaging.microsoft.com ([213.199.154.141]:16378
	"EHLO DB3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755422Ab1BXISh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Feb 2011 03:18:37 -0500
Received: from mail56-db3 (localhost.localdomain [127.0.0.1])	by
 mail56-db3-R.bigfish.com (Postfix) with ESMTP id 1E414169020D	for
 <linux-mmc@vger.kernel.org>; Thu, 24 Feb 2011 08:18:36 +0000 (UTC)
Received: from DB3EHSMHS001.bigfish.com (unknown [10.3.81.245])	by
 mail56-db3.bigfish.com (Postfix) with ESMTP id 7564CB1804D	for
 <linux-mmc@vger.kernel.org>; Thu, 24 Feb 2011 08:18:35 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
 [10.64.34.199])	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
 p1O8ISNN002357	for <linux-mmc@vger.kernel.org>; Thu, 24 Feb 2011 01:18:28
 -0700 (MST)
Received: from S2100-06.ap.freescale.net (S2100-06.ap.freescale.net
 [10.192.242.50])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
 p1O8IQeX009395	for <linux-mmc@vger.kernel.org>; Thu, 24 Feb 2011 02:18:27
 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <1298469118-25282-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

Hi Wolfram,

On Wed, Feb 23, 2011 at 02:51:53PM +0100, Wolfram Sang wrote:
> Take #3, changes:
> 
> * also intercept calls to SDHCI_SIGNAL_ENABLE (needed on mx25)
> * remove unconditional BROKEN_CARD_DETECTION (leftover)
> * improved kernel-doc about unused GPIO
> * added tags from Eric
> 
> Tested now by me and Marc on mx35, Eric on mx25/35/51. Arnaud, did you have a
> chance to retest on mx51? What about the FSL guys? :)
> 
I'm testing it on mx25 3ds and mx51 babbage. Both card-detect and
write-protect are working on mx25 3ds, but write-protect has some
problem on babbage, and I need some time to figure it out.

Also it's not testable on mx35 3ds board, as these two "gpio" pins
are routed to a MCU which needs the I2C access.  Do we have this
support on mainline?

-- 
Regards,
Shawn

