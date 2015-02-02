From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH V4 1/4] mmc: core: Initial support for MMC power sequences
Date: Mon, 2 Feb 2015 15:05:37 +0000
Message-ID: <20150202150537.GE8656@n2100.arm.linux.org.uk>
References: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
 <1421658784-11980-2-git-send-email-ulf.hansson@linaro.org>
 <CABxcv==xBNsh+NrVb8PcBVtxQOKDL79YMkwK=wOL0gJZriEUjw@mail.gmail.com>
 <CAPDyKFoze-26fPm+C=D_o3tMSXWeTV4=2ZfOKaC3uLtxCrtjvg@mail.gmail.com>
 <20150131092715.566fa33c@notabene.brown>
 <CAPDyKFo6G+PpV7QpxBEOS_xUxXTQ14v=qVLGpBjT_z6T0vP85A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:42934 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbbBBPFt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Feb 2015 10:05:49 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFo6G+PpV7QpxBEOS_xUxXTQ14v=qVLGpBjT_z6T0vP85A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: NeilBrown <neilb@suse.de>, Javier Martinez Canillas <javier@dowhile0.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-arm-kernel@lists.infradead.org
	<linux-arm-kernel@lists.infradead.org>," <mark.rutland@arm.com>

On Mon, Feb 02, 2015 at 03:57:37PM +0100, Ulf Hansson wrote:
> On 30 January 2015 at 23:27, NeilBrown <neilb@suse.de> wrote:
> > Shortly before this call is
> >
> >         host->ios.power_mode = MMC_POWER_ON;
> >         mmc_set_ios(host);
> >
> > and omap_hsmmc_set_ios() contains:
> >
> >                 switch (ios->power_mode) {
> >                 ....
> >                 case MMC_POWER_ON:
> >                         do_send_init_stream = 1;
> >                         break;
> >
> >
> >         if (do_send_init_stream)
> >                 send_init_stream(host);
> >
> > Which sends the "init stream" to the card.
> > If the card is still being reset at this time, the stream may not
> > be effective.
> >
> > I find that about 10%-20% of the time when I release the reset line
> > *after* the sequence is sent, my card fails to initialised.  When I
> > release *before* the sequence is sent, it never fails.
> 
> Okay, thanks for providing these details.

The right thing to do then is to pulse the reset line at the pre-power-up
stage.

> > I note that other drivers handle the init stream differently.
> > atmel-mci just sets a flag in set_ios, and the actually sends the stream in
> > atmci_start_request()
> >
> > dw_mmc, jz4740_mmc, mxcmmc, pxamci do much the same

Yes.  PXAMCI is one of those dumb "inteligent" controllers that takes
some of the protocol handing away from the host software implementation.
The result of that is things happen at different times.

For PXAMCI, it's not possible to send the initialisation clocks on their
own; you have to queue up a command first.

> Well, the problem is that there are host drivers that don't consider
> MMC_POWER_UP and delays initialization/power_up to MMC_POWER_ON. So we
> might fix the issue for some, but breaks it for another.
> 
> I had a discussion around inconsistent host driver behaviours from
> ->set_ios() callbacks with Russell, for the first version of this
> patchset.

Yes, as I've said a few times now, I regard my original design of this
stuff (which was to separate MMC_POWER_UP and MMC_POWER_ON) to be a big
design mistake, and we should really kill MMC_POWER_UP ASAP, combining
both into a /single/ call into the host driver.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
