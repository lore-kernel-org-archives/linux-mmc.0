From: Martin Fuzzey <mfuzzey@parkeon.com>
Subject: Re: arm: imx35: mmc0: "Timeout waiting for hardware interrupt" with various sdio wlan cards
Date: Mon, 15 Apr 2013 15:58:41 +0000 (UTC)
Message-ID: <loom.20130415T175510-905@post.gmane.org>
References: <CADwvPCurSFGpqjURs=ryv=wRD0WsvNyzJZ7JyVs0LaWo-idJ7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:42942 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754902Ab3DOQFF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 15 Apr 2013 12:05:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1URltu-00035H-Ai
	for linux-mmc@vger.kernel.org; Mon, 15 Apr 2013 18:05:02 +0200
Received: from ip65.parkeon.com ([213.152.31.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 15 Apr 2013 18:05:02 +0200
Received: from mfuzzey by ip65.parkeon.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 15 Apr 2013 18:05:02 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi Johannes,
Johannes Braun <jjo.braun <at> gmail.com> writes:

> 
> Hello,
> 
> our company built an embedded board which is based on the ARM
> Freescale imx35 chip. Now I am trying to run a silex sdio wlan module
> with this board. The Silex module is based on an atheros ar6003 chip.
> The driver in /drivers/mmc/host/sdhci-esdhc-imx.c (config
> MMC_SDHCI_ESDHC_IMX) is used for the imx35 processor. When I load the
> module ath6kl_sdio.ko, I get the following error:
> "mmc0: Timeout waiting for hardware interrupt".
> 

This sounds like the same issue I have run into on i.MX53.

Can you try the patch I just posted: 
[http://article.gmane.org/gmane.linux.kernel.mmc/20121]

Regards,

Martin



