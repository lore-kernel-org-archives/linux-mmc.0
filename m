From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RESEND PATCH v2 0/6] Update Kona drivers to use clocks
Date: Thu, 17 Oct 2013 14:47:01 +0100
Message-ID: <20131017134701.GC24056@e106331-lin.cambridge.arm.com>
References: <1381960030-1640-1-git-send-email-tim.kryger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1381960030-1640-1-git-send-email-tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Oct 16, 2013 at 10:47:04PM +0100, Tim Kryger wrote:
> This series declares the clocks present on bcm11351 (aka bcm281xx) SoCs
> to be fixed at the rates configured by development bootloaders and then
> updates the Kona drivers to make use of clock calls where appropriate.
> 
> This patch series depends on the following three commits being present:
> 
> https://lkml.org/lkml/2013/9/18/409
> https://lkml.org/lkml/2013/9/20/305
> http://www.spinics.net/lists/arm-kernel/msg274973.html
> 
> Changes in v2:
>   - Renamed bsc4_clk to pmu_bsc_clk
> 
> Tim Kryger (6):
>   ARM: dts: Declare clocks as fixed on bcm11351
>   ARM: dts: Specify clocks for UARTs on bcm11351
>   ARM: dts: Specify clocks for SDHCIs on bcm11351
>   clocksource: kona: Add basic use of external clock
>   ARM: dts: Specify clocks for timer on bcm11351
>   mmc: sdhci-bcm-kona: Add basic use of clocks
> 
>  arch/arm/boot/dts/bcm11351.dtsi      | 111 +++++++++++++++++++++++++++++++++--
>  drivers/clocksource/bcm_kona_timer.c |  14 ++++-
>  drivers/mmc/host/sdhci-bcm-kona.c    |  30 +++++++++-

This requires a description in the binding documents, so we can figure
out which clocks we need to describe, and how to describe them.

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
