From: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>
Subject: Re: [PATCH] mmc: sdhci: extend wait for busy signalling
Date: Tue, 10 Sep 2013 14:25:12 +0000 (UTC)
Message-ID: <loom.20130910T162234-197@post.gmane.org>
References: <loom.20130905T112200-603@post.gmane.org> <CAPDyKFppfnZ18Vev8mzaqQSDTEcDXM0eOcCM1FYKM5xSXORQQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:32949 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752274Ab3IJOZf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 Sep 2013 10:25:35 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1VJOsn-0003rC-9w
	for linux-mmc@vger.kernel.org; Tue, 10 Sep 2013 16:25:33 +0200
Received: from 202.122.18.226 ([202.122.18.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Tue, 10 Sep 2013 16:25:33 +0200
Received: from prasanna.navaratna by 202.122.18.226 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Tue, 10 Sep 2013 16:25:33 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

> 
> I don't think this kind of protocol related code shall remain in the
> host driver. Better keep this in the protocol layer.
> 
> Moreover, most commands can be followed with status command (CMD13) to
> check for busy assertion. I believe this could be a better option to
> use from a generic point of view, since not all mmc controllers
> support hw-check for busy signalling.
> 
> In the cases were CMD13 is not allowed, there are two options to
> improve the situation.
> 1. Extend the usage of host->ops->card_busy in the protocol layer,
> thus provide the option for a host driver to implement a software busy
> check (could be by re-routing pins to GPIO for example)
> 2. MMC_CAP_WAIT_WHILE_BUSY is set by host, thus the hw support busy check.

I had implemented this patch for older version of kernel (3.4.5) and then
ported to latest kernel.
Need to check on card_busy and utilize it. I will re-work on this patch and
will update a newer version in protocol layer.

Thanks,
Prasanna NAVARATNA

