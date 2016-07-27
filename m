From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: BayTrail-T SDIO PM issue
Date: Wed, 27 Jul 2016 22:20:16 +0200
Message-ID: <CAPDyKFrUUc=02tTzsC6CKGjbezMmmbm_TznOjS11mZoaJ5VdFg@mail.gmail.com>
References: <CA+7w51jySmwSnMaVr_7vVsAzD0d11QY7+GaVWjd88adoe4DO6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36154 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754303AbcG0UUS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jul 2016 16:20:18 -0400
Received: by mail-wm0-f49.google.com with SMTP id q128so226360166wma.1
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jul 2016 13:20:18 -0700 (PDT)
In-Reply-To: <CA+7w51jySmwSnMaVr_7vVsAzD0d11QY7+GaVWjd88adoe4DO6Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Laszlo Fiat <laszlo.fiat@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 27 July 2016 at 19:57, Laszlo Fiat <laszlo.fiat@gmail.com> wrote:
> Hello,
>
> Historically we had to add some out-of-tree mmc patches [1] for
> BayTrail-T to run stable.
> This was reduced to only 1 patch [2] by linux v4.6.4 thanks to the
> work of Adrian and Ulf.
> Without patch [2] we get: irq 187: nobody cared [3] and instability.
>
> However patch [2] cannot be applied to v4.7 any more, as patch [4]
> removed the base of it.
> I can partly revert patch [4] and reapply patch [2] on linux v4.7 to
> achieve stability, but it would be nice to have a proper solution for
> this, and get rid of out-of-tree patches once and for all.

Agree, as I think it's probably not only Baytrail that suffer from
this. Although it seems like some Baytrail developer need to take a
lead on this.

Regarding patch[2], in general it seems like the correct approach
(although perhaps not applied to generic sdhci code, but in sdhci
variants).
In some case the SoC/mmc-controller can support a different wakeup
setting that doesn't require the clock to be ungated to wakeup on SDIO
irq...

>
> I can help with testing.

That's great, thanks for volunteering!

Anybody with a Baytrail or someone whit similar issue for SDIO irq and
sdhci that can help?

>
> Thank you.
>
> Bye,
>
> Laszlo Fiat
>
>
> [1]: https://github.com/hadess/rtl8723bs/tree/master/patches
> [2]: https://github.com/hadess/rtl8723bs/blob/master/patches/0001-mmc-sdhci-get-runtime-pm-when-sdio-irq-is-enabled.patch
> [3]: https://github.com/hadess/rtl8723bs/issues/76#issuecomment-226897659
> [4]: https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=15e82076a0edbebedbe12652b4ad8f1d93bcb7fe

Kind regards
Uffe
