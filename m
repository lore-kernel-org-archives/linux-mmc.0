From: Zhu Richard-R65037 <r65037@freescale.com>
Subject: RE: [PATCH 8/9] esdhc-4 esdhc: fsl esdhc driver based on platform sdhci api
Date: Fri, 10 Sep 2010 16:45:28 +0800
Message-ID: <A88EF4D64D8447468743DC1503C0B6CA078AA4@zch01exm22.fsl.freescale.net>
References: <1283334533-12793-1-git-send-email-r65037@freescale.com> <20100906104729.GB2617@pengutronix.de> <A88EF4D64D8447468743DC1503C0B6CA0787D4@zch01exm22.fsl.freescale.net> <20100907102817.GA7534@pengutronix.de> <A88EF4D64D8447468743DC1503C0B6CA0789F0@zch01exm22.fsl.freescale.net> <20100909163952.GI3773@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:43594 "EHLO
	TX2EHSOBE010.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754007Ab0IJIpm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Sep 2010 04:45:42 -0400
Received: from mail137-tx2 (localhost.localdomain [127.0.0.1])	by
 mail137-tx2-R.bigfish.com (Postfix) with ESMTP id CDA10AE8607	for
 <linux-mmc@vger.kernel.org>; Fri, 10 Sep 2010 08:45:38 +0000 (UTC)
Received: from TX2EHSMHS043.bigfish.com (unknown [10.9.14.236])	by
 mail137-tx2.bigfish.com (Postfix) with ESMTP id 314A41A70058	for
 <linux-mmc@vger.kernel.org>; Fri, 10 Sep 2010 08:45:38 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id o8A8jVqd003090	for
 <linux-mmc@vger.kernel.org>; Fri, 10 Sep 2010 01:45:32 -0700 (MST)
Received: from zch01exm22.fsl.freescale.net (zch01exm22.ap.freescale.net
 [10.192.129.206])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
 o8A8xX12018065	for <linux-mmc@vger.kernel.org>; Fri, 10 Sep 2010 03:59:33
 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <20100909163952.GI3773@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org

Hi Wolfram:


Best Regards,
Richard Zhu
Freescale Semiconductor
Tel: +86-021-28937189
Email:Hong-Xing.Zhu@freescale.com 


-----Original Message-----
From: Wolfram Sang [mailto:w.sang@pengutronix.de] 
Sent: Friday, 10 September, 2010 0:40
To: Zhu Richard-R65037
Cc: linux-mmc@vger.kernel.org; kernel@pengutronix.de;
linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 8/9] esdhc-4 esdhc: fsl esdhc driver based on
platform sdhci api

Hi Richard,

> BTW, Do you know that how to define and pass the kinds of 
> platform_data-struct special to the board to the sdhci_pltfm.c layer 
> platform-data struct?

I think we should extend the pdata->init call to also have the
platform_data as an argument. Then, the platform-specific init routine
should have all it needs. Will update that tomorrow.
[<Zhu Richard-r65037>] Thanks. :)

> [<Zhu Richard-r65037>] The one used in sdhci-of-esdhc.c is better than

> the one listed abov; it's more logical and clear. :)

Good, it seems to be complete, too :)

> > I find that the sdhci.c had been support the 8bits bus_width.
> 
> Yes, it was added recently, but it might have issues. See here:
> 
> http://thread.gmane.org/gmane.linux.kernel.mmc/3370
> [<Zhu Richard-r65037>] Different IC design may have the different 
> definitions of the bus width configuration in the HOST_CONTROL
register.
> This is not a big issue; we can handle these differences in the SW.

Yes, my point is that we don't handle this at the generic sdhci-core,
but at the parts which deal with the platform-specific faul^H^H^H^H...
differences ;)

> About the 8bits supports, I had been verified this feature on i.MX 
> platforms for a while.
> The MMC cards 8bits mode can work well on some i.MX eSDHC platforms.

Why only some? Are the others not working or not tested?
[<Zhu Richard-r65037>] They are not tested in Linux BSP, because some
boards don't have the 8bit caps in the HW design.
 They should be ok in 8bits mode, since the 8bits modes are all verified
in the IC validation.

> One more suggestion, the caps should be handled carefully, because not

> only the caps of the IC design, but also the caps of the board HW 
> design should be taken care,

Could you give an example when it is board-dependent?
[<Zhu Richard-r65037>] In some cases, the SD slots maybe only have
populated 4bits data pins out in HW design, although the caps of IC can
support up to 8bits bus width.

> [<Zhu Richard-r65037>] I'm checking it, and still trying finding a way

> to pass the board related info (such as the WP pins, and bus width to 
> sdhci-platfm.c layer)

See above. And here is my current WIP. I factored out the common stuff
from of and pltfm. Furthermore, I addressed Uwe's comments about adding
MX35-devices. Expect a few updates (platform-data) tomorrow.

http://git.pengutronix.de/?p=wsa/linux-2.6.git;a=shortlog;h=refs/heads/p
cm043-wip

(The old branch is still there, just in case you are working with it)

> The host->ops->get_ro should be added into the sdhci.c file although 
> following the method provided in the RFC patches. How do you think 
> about that?

I agree, that one seems needed. Shall I integrate this into my series or
do you want to place this patch ontop of my series?
[<Zhu Richard-r65037>] You can merge these codes into your patches.

Kind regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang
|
Industrial Linux Solutions                 | http://www.pengutronix.de/
|

