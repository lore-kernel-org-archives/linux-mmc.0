From: Zhu Richard-R65037 <R65037@freescale.com>
Subject: RE: [PATCH V7 4/4] mmc: sdhci-esdhc: enable esdhc on imx53
Date: Tue, 22 Mar 2011 09:49:12 +0000
Message-ID: <010C9052C42A00499CE76D637FA5EE900D365D@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1300684936-8218-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1300684936-8218-5-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20110321130844.GG9686@pengutronix.de>
 <010C9052C42A00499CE76D637FA5EE900D32B1@039-SN1MPN1-001.039d.mgd.msft.net>
 <20110322085429.GA2134@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-tx2.bigfish.com ([65.55.88.10]:8872 "EHLO
	TX2EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752270Ab1CVJtS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 22 Mar 2011 05:49:18 -0400
In-Reply-To: <20110322085429.GA2134@pengutronix.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi wolfram:
No, I don't prefer to skip this patch, and want to carry this patch,
 since these patch are used for imx53, and imx53 only support the SDHC V2.

What I just want to say is that the common sd/mmc subsystem would
keep coherent with spec about the multi-block IO mode after the ACMD23 is implemented
 in the previous email.

Best Regards
Richard Zhu


> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang@pengutronix.de]
> Sent: Tuesday, March 22, 2011 4:54 PM
> To: Zhu Richard-R65037
> Cc: linux-mmc@vger.kernel.org
> Subject: Re: [PATCH V7 4/4] mmc: sdhci-esdhc: enable esdhc on imx53
>
> Hi Richard,
>
> (please don't drop the list)
>
> > I saw that some ones are discussing the implementation of the ACMD23 in
> the community.
> > The new command introduced by SDHC spec3.0.
> > This feature can solve the concern that mentioned by this patch.
> > http://www.spinics.net/lists/linux-mmc/msg06428.html
> > If the ACMD23 is implemented, the predefined-block number multi-block
> IO can be achieved without any confusion.
> > It seems that the ACMD12 would be used in the another multi-block IO
> mode in those serial patches.
>
> So do you want to carry this patch until SDHC V3 is mainline and then
> change or do you prefer to skip this patch altogether?
>
> Regards,
>
>    Wolfram
>
> --
> Pengutronix e.K.                           | Wolfram Sang
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |

