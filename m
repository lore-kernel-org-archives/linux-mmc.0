From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 2/8] mmc: bcm2835: Add new driver for the sdhost
 controller.
Date: Tue, 07 Feb 2017 09:02:55 +0100
Message-ID: <1486454575.24589.29.camel@redhat.com>
References: <1486123913-31705-1-git-send-email-kraxel@redhat.com>
         <1486123913-31705-3-git-send-email-kraxel@redhat.com>
         <1708749883.208474.1486413240581@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752065AbdBGIDA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 7 Feb 2017 03:03:00 -0500
In-Reply-To: <1708749883.208474.1486413240581@email.1und1.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: will.deacon@arm.com, linux@armlinux.org.uk, lee@kernel.org, rjui@broadcom.com, eric@anholt.net, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, ulf.hansson@linaro.org, sbranden@broadcom.com, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org, swarren@wwwdotorg.org, mark.rutland@arm.com, f.fainelli@gmail.com, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Mo, 2017-02-06 at 21:34 +0100, Stefan Wahren wrote:
> Hi Gerd,
> 
> first of all here my wishlist for the next round of this driver:
> * compile test the series with ARM and ARM64

It is tested on both arm and arm64 (rpi2 + rpi3).

> * add me in CC for all patches of the series

Oops.  /me should be more careful when reading names.  I thought I had
you on Cc:  Double-checked.  Turned out that was Stephen Warren ...

> * run checkpatch.pl before submission

Hmm?  Are there any issues?  /me has a pre-commit hook running
checkpatch to avoid anything slipping though.

> * apply the patch series to your cgit repo

Branch pushed now: bcm2837-sdhost-squashed-v2

> > The sdhci controller supports both sdcard and sdio.  The sdhost
> > controller supports the sdcard only, but has better performance.  Also
> 
> Sorry, for the confusion. I was wrong. According to the registers the SDHOST should also support SDIO. It's a feature we could implement later.

Ok.

> > note that the rpi3 has sdio wifi, so driving the sdcard with the sdhost
> > controller allows to use the sdhci controller for wifi support.
> > 
> > The configuration is done by devicetree via pin muxing.  Both SD
> > controller are available on the same pins (2 pin groups = pin 22 to 27 +
> > pin 48 to 53).  So it's possible to use both SD controllers at the same
> > time with different pin groups.
> > 
> > The code was originally written by Phil Elwell in the downstream
> > Rasbperry Pi tree, and I did a major cleanup on it (+319, -707 lines
> > out of the original 2055) for inclusion.
> 
> I think it would be helpful to known the downstream commit, because this commit [1]
> doesn't seem to be included.
> 
> [1] - https://github.com/raspberrypi/linux/commit/ea4b1c5c2ddbb6caba43ab9b0103542a4ca7e1f0
> 
> I've found and fixed a lot of issues in this version and i think it would be better if i send you the patches for squashing them all together. Here is the preview for my patch series:
> 
> Stefan Wahren (15):
>   mmc: bcm2835: Add missing include for threaded irq
>   mmc: bcm2835: Remove CMD_DALLY_US
>   mmc: bcm2835: Fix pio_timeout handling
>   mmc: bcm2835: Remove unnecessary return in bcm2835_data_irq
>   mmc: bcm2835: Handle error cases during probe
>   mmc: bcm2835: Print clk_max as decimal
>   mmc: bcm2835: Downrate message in case of PIO fallback
>   mmc: bcm2835: Don't unveil the data pointer
>   mmc: bcm2835: remove unused host members
>   mmc: bcm2835: Avoid unnecessary linebreaks
>   mmc: bcm2835: Add leading zero to register dumps
>   mmc: bcm2835: Align struct members with tabs
>   mmc: bcm2835: Rearrange bcm2835_finish_request()
>   mmc: bcm2835: Rearrange bcm2835_dma_complete_work()
>   mmc: bcm2835: Rename Kconfig switch
> 
> I'll send it after my tests. In the following review i will mention only the issues which aren't fixed in my patch series.

I'll pick up the patches and look at the remaining issues, new version
later this week (i hope).

thanks,
  Gerd

