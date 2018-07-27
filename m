From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH 3/3] mmc: tegra: prevent ACMD23 on Tegra 3
Date: Fri, 27 Jul 2018 22:52:11 +0300
Message-ID: <4098188.Bd2NGYzoJE@dimapc>
References: <20180712073904.4705-1-stefan@agner.ch> <24fffc2c52b58301c37d95fe5d1ad355@agner.ch> <3a970d5d-4f18-0167-ab22-2032e8bf743d@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3a970d5d-4f18-0167-ab22-2032e8bf743d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Geis <pgwipeout@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>, adrian.hunter@intel.com, ulf.hansson@linaro.org, thierry.reding@gmail.com, jonathanh@nvidia.com, marcel.ziswiler@toradex.com, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thursday, 26 July 2018 20:48:55 MSK Peter Geis wrote:
> On 07/26/2018 01:36 PM, Stefan Agner wrote:
> > On 26.07.2018 18:39, Peter Geis wrote:
> >>>>>> I finally got around to testing this on the Ouya (Tegra 3).
> >>>>> 
> >>>>> Thanks for testing!
> >>>>> 
> >>>>>> I found that the "Got command interrupt 0x00010000 even though no
> >>>>>> command operation was in progress." error occurred when the interface
> >>>>>> is unstable.
> >>>>>> I've had a lot of problems with sdmmc4 stability on the Ouya above 34
> >>>>>> Mhz, probably due to the fact that they are using the internal cmd
> >>>>>> and
> >>>>>> clock pull-up resistors, against the TRM's instruction.
> >>>>>> At 39Mhz, I saw the error this patch corrects.
> >>>>>> With the patch, the error went away, but the interface is still
> >>>>>> unstable under load.
> >>>>> 
> >>>>> How does this instability manifest exactly?
> >>>> 
> >>>> At the very edge of stability, you see write errors under heavy load.
> >>>> As clock rate increases, the write errors occur more frequently.
> >>>> At a certain point, you start getting read errors.
> >>>> Following that you get constant io errors during card probing.
> >>>> Eventually the emmc will fail to initialize, with errors 87 or 110.
> >>> 
> >>> What mode are you running at actually? E.g. what is the ios file saying?
> >>> cat /sys/kernel/debug/mmcX/ios
> >> 
> >> This is the best functionality I've been able to get prior to the
> >> patches:
> >> root@ouya:~# cat /sys/kernel/debug/mmc0/ios
> >> clock:          30000000 Hz
> >> actual clock:   29142858 Hz
> >> vdd:            21 (3.3 ~ 3.4 V)
> >> bus mode:       2 (push-pull)
> >> chip select:    0 (don't care)
> >> power mode:     2 (on)
> >> bus width:      3 (8 bits)
> >> timing spec:    9 (mmc HS200)
> >> signal voltage: 1 (1.80 V)
> >> driver type:    0 (driver type B)
> > 
> > Yeah HS200 is definilty not supported by the controller and really
> > should not be used.
> > 
> >> Now I am trying DDR, but even with the patches I'm not able to remain
> >> stable above 17Mhz (34Mhz clock).
> >> 
> >> I've also tried just straight mmc-hs mode, but even that makes no
> >> difference.> 
> > So you tried timing spec 1 (mmc HS)?
> > 
> > How did you exactly enable mmc-hs mode?
> 
> cap-mmc-highspeed;
> 
> > I suggest to *not set* vqmmc and apply patch 1. It will report that
> > signaling voltage is 3.3V, but that did not really matter in our case.
> > This was our baseline and always worked stable on mainline. I also would
> > use that mode when tweaking pinmux etc...
> 
> Will do, thanks.
> 
> >>>> I've been tweaking the pull up/down values to try and improve the
> >>>> stability, but without access to anything but the TRM it's a lot of
> >>>> trial and error.
> >>> 
> >>> Hm, maybe Marcel's recent fixes in our device tree are helpful?
> >>> https://lkml.org/lkml/2018/7/22/165
> >>> 
> >>> Also make sure to have a complete pinmux such that alternative pins for
> >>> sdmmc4 are *not* muxed as sdmmc4.
> >> 
> >> That was my first issue, which was preventing sdmmc4 from working at all.
> >> Just double checked all of the spare function pins, they are all
> >> assigned elsewhere.
> > 
> > Ok.
> > 
> >>>>>> Lowering down to 32Mhz, without the patch there are no errors.
> >>>>> 
> >>>>> So the patch does not make it less stable right?
> >>>> 
> >>>> No, it did not affect stability.
> >>>> Although I'd conduct some performance testing to check for degradation.
> >>>> Of course I'm nowhere near the limits of the controller, so it is
> >>>> doubtful I'd see a hit.
> >>> 
> >>> Ok, and this is with the complete patchset applied correct?
> >>> 
> >>> Btw, what device tree are you using? Ouya is not upstream as far as I
> >>> can tell?
> >> 
> >> Indeed, I have the full patchset.
> >> 
> >> Ouya is an old android game console that I've been working on getting
> >> mainline working on.
> > 
> > I know, I have one sitting here too. I only tried to tinker a bit at the
> > very beginning...
> 
> It runs Xubuntu very well now with mainline.
> I've got most everything roughly supported with the exception of audio.
> 
> >> I've written most of the device tree, with contributions from Matt
> >> Merhar.
> >> It's almost bit for bit a cardhu dev board, but with everything not
> >> necessary to function removed.
> >> They cut a lot of corners with the board design.
> >> Last stable kernel was 3.2, but it ran fine at 52mhz, mind you it
> >> reported it was running mode 5.
> > 
> > That is what we saw too. With Apalis/Colibri T30 L4T downstream kernel
> > (which is 3.1 with quite some patches) 52MHz DDR worked fine,
> > surprisingly even with ACMD23. However, speed is slightly slower than
> > mainline 52MHz without ACMD23...
> 
> I noticed the same thing, speed with the original kernel on the MMC was
> worse at 52Mhz than it was at 34Mhz in HS-200 mode on mainline.
> I'd be happy with it where it is, but the fact that it worked at 52Mhz
> before makes me believe something isn't quite there yet.
> I selected HS-200 mode just to force 1.8v mode.

What's the card model your Ouya's eMMC has?
