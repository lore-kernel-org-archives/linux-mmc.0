From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 1/3i v6] MMC/SD: Add callback function to detect card
Date: Fri, 22 Mar 2013 07:03:36 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C33B361@039-SN1MPN1-003.039d.mgd.msft.net>
References: <25B60CDC2F704E4E9D88FFD52780CB4C0BDEC869A3@SC-VEXCH1.marvell.com>
	<CADz5_gJe8xJH6FD7xwxssmWSZ2w4tvKAnYAexzTtVSyW0ovweQ@mail.gmail.com>
	<110EED8CC96DFC488B7E717A2027A27C33B2BF@039-SN1MPN1-003.039d.mgd.msft.net>
 <CADz5_gLJvVmJa_5zAZAD-7cfbneySgH8GmwfDfj+-eT3Y80QQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe001.messaging.microsoft.com ([207.46.163.24]:27240
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751899Ab3CVHEd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Mar 2013 03:04:33 -0400
In-Reply-To: <CADz5_gLJvVmJa_5zAZAD-7cfbneySgH8GmwfDfj+-eT3Y80QQA@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>


> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Kevin Liu
> Sent: Friday, March 22, 2013 2:55 PM
> To: Huang Changming-R66093
> Cc: linux-mmc@vger.kernel.org; Chris Ball; Ulf Hansson
> Subject: Re: [PATCH 1/3i v6] MMC/SD: Add callback function to detect card
> 
> 2013/3/22 Huang Changming-R66093 <r66093@freescale.com>:
> >> Jerry,
> >>
> >> Function _mmc_detect_card_removed should only be called when card
> >> insert/removal or i/o error occur unless POLLING is used(called once
> >> per second). So it should _not_ impact performance much.
> > [jerry]
> > No, your understanding is wrong.
> > Function "_mmc_detect_card_removed " is called to check if our card has
> been removed when driver run the function "mmc_rescan" every time.
> >
> 
> But when will mmc_rescan be called?
> Besides boot up, only when card status change it will be called.
> So usually it should _not_ be called frequently.
[jerry]
For poll mode, how to know card status changed?
The answer is "mmc_rescan".
maybe you could read the last two lines of this function ago.

> >> POLLING is poor for performance, why not change to slot-gpio if host
> >> is broken for card detect.
> > [jerry]
> > Some our boards can't support interrupt mode to detect card
> insert/removable, so we unify the poll mode.
> >
> 
> Not support gpio interrupt?
> I think you only don't support sdh host interrupt.

