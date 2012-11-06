From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 2/4 v4] MMC/SD: Add callback function to detect card
Date: Tue, 6 Nov 2012 01:55:21 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C215336@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1351584769-16662-1-git-send-email-r66093@freescale.com>
	<1351584769-16662-2-git-send-email-r66093@freescale.com>
	<CA+20K0AfmJSrPO9-_-yNk4HhEVYPj8cMaa+jCZAZhp23Vb817g@mail.gmail.com>
	<110EED8CC96DFC488B7E717A2027A27C210A6D@039-SN1MPN1-004.039d.mgd.msft.net>
	<CA+20K0A3myrosOGK2dcstX06QOS1SRHaaz-zYqoFSA7ZYcEJvQ@mail.gmail.com>
	<110EED8CC96DFC488B7E717A2027A27C213E8A@039-SN1MPN1-004.039d.mgd.msft.net>
 <CA+20K0DmMPDv0SJgd6-zoHN+eZr1fROT7=HY-mEWgAO9-gmSPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [216.32.181.182] ([216.32.181.182]:45912 "EHLO
	ch1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S933487Ab2KFB4g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 5 Nov 2012 20:56:36 -0500
In-Reply-To: <CA+20K0DmMPDv0SJgd6-zoHN+eZr1fROT7=HY-mEWgAO9-gmSPg@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <jrudholm@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Anton Vorontsov <cbouatmailru@gmail.com>, Chris Ball <cjb@laptop.org>

Thanks a lot, Johan.

Best Regards
Jerry Huang


> -----Original Message-----
> From: Johan Rudholm [mailto:jrudholm@gmail.com]
> Sent: Monday, November 05, 2012 10:08 PM
> To: Huang Changming-R66093
> Cc: linux-mmc@vger.kernel.org; Anton Vorontsov; Chris Ball
> Subject: Re: [PATCH 2/4 v4] MMC/SD: Add callback function to detect card
> 
> Hi,
> 
> 2012/11/5 Huang Changming-R66093 <r66093@freescale.com>:
> >>
> >> 2012/11/2 Huang Changming-R66093 <r66093@freescale.com>:
> >> > Hi, Johan,
> >> > When quicks SDHCI_QUIRK_BROKEN_CARD_DETECTION is set, the driver
> will
> >> poll the card status with the command CMD13 periodically, then many
> >> interrupts will be generated, which affect the performance.
> >>
> >> Ok, just to see if I understand the scenario correctly:
> >> SDHCI_QUIRK_BROKEN_CARD_DETECTION causes the MMC_CAP_NEEDS_POLL cap to
> be
> >> set, which will cause mmc_rescan to be run at a one second interval.
> >> mmc_rescan calls bus_ops->detect (mmc_sd_detect) and this in turn
> calls
> >> _mmc_detect_card_removed, which will do the bus_ops->alive and send
> CMD13.
> >> So in this case, one CMD13 is sent per second, right?
> >> Is this the cause of the performance issue?
> >
> > Yes, You are right.
> 
> Ok, it's a bit hard to understand how this can lead to a noticeable
> performance impact, but OK. :)
> 
> >> A thought: if the host hardware does have a GPIO card detect pin
> hooked
> >> up, would it not be possible to make this pin generate an IRQ whenever
> a
> >> card is inserted or removed? This is what we do in the MMCI driver,
> for
> >> instance (mmci_cd_irq).
> >
> > Our silicones has this pin to do card detect, but some boards don't
> generate the interrupt when card is inserted or removed. So I have to use
> the poll mode.
> >
> >> > Yes, some cases to detect GPIO can't be trusted, so I only just
> >> implement this callback in eSDHC-of driver. that is to say, just when
> the
> >> platform support it, this callback can be implement, if not, continue
> to
> >> send the command CMD13.
> >>
> >> I'm just wondering how this will affect our system, where we use the
> cd
> >> GPIO to generate detect jobs on card insert/remove, but where the cd
> pin
> >> is not 100% synchronized with the electrical connection of the power
> and
> >> cmd line of the SD-card. So if I remember correctly, the cd pin may
> >> report that the card has been removed, but there is still an electric
> >> connection and the card is alive...
> >>
> > I don't see this on our board, when card is inserted or removed, the
> register field can reflect this state correctly.
> 
> We see a difference on our boards with this patch, but no functional
> change (actually a removed card is detected earlier now), so from my
> perspective:
> 
> Reviewed-By: Johan Rudholm <johan.rudholm@stericsson.com>
> 
> //Johan


