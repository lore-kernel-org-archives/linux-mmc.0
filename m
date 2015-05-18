From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] RFC: mmc: core: Increase delay for voltage to stabilize
 from 3.3V to 1.8V
Date: Mon, 18 May 2015 11:23:42 +0200
Message-ID: <CAPDyKFozLU25pS62WTkFR5HcaARfObDi6WcM18UDGmC6-AuguA@mail.gmail.com>
References: <1431467171-12937-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33237 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569AbbERJXn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 May 2015 05:23:43 -0400
Received: by qkgv12 with SMTP id v12so30728008qkg.0
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2015 02:23:42 -0700 (PDT)
In-Reply-To: <1431467171-12937-1-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Johan Rudholm <johan.rudholm@axis.com>, Adrian Hunter <adrian.hunter@intel.com>, Tim Kryger <tim.kryger@gmail.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Andrew Gabbasov <andrew_gabbasov@mentor.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 12 May 2015 at 23:46, Doug Anderson <dianders@chromium.org> wrote:
> Since the regulator used for the SDMMC IO voltage is not expected to
> draw a lot of current, most systems will probably use an inexpensive
> LDO for it.  LDO regulators apparently have the feature that they
> don't actively drive the voltage down--they wait for other components
> in the system to drag the voltage down.  Thus they will transition
> faster under heavy loads and slower under light loads.
>
> During an SDMMC voltage change from 3.3V to 1.8V, we are almost
> certainly under a light load.  To be specific:
> * The regulator is hooked through pulls to CMD0-3 and DAT.  Probably
>   the CMD pulls are something like 47K and the DAT is something like
>   10K.
> * The card is supposed to be driving DAT0-3 low during voltage change
>   which will draw _some_ current, but not a lot.
> * The regulator is also provided to the SDMMC host controller, but the
>   SDMMC host controller is in open drain mode during the voltage
>   change and so shouldn't be drawing much current.
>
> In order to keep the SDMMC host working properly (or for noise
> reasons), there might also be a capacitor attached to the SDMMC IO
> regulator.  This also will have the effect of slowing down transitions
> of the regulator, especially under light loads.
>
> From experimental evidence, we've seen the voltage change fail if the
> card doesn't detect that the voltage fell to less than about 2.3V when
> we turn on the clock.  On one device (that admittedly had a 47K CMD
> pullup instead of a 10K CMD pullup) we saw that the voltage was just
> about 2.3V after 5ms and thus the voltage change would sometimes fail.
> Doubling the delay gave margin and made the voltage change work 100%
> of the time, despite the slightly weaker CMD pull.
>
> At the moment submitting this as an RFC patch since my problem _could_
> be fixed by increasing the pull strength (or using a smaller
> capacitor).  However being a little bit more lenient to strange
> hardware could also be a good thing.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Thanks, applied.

Kind regards
Uffe

> ---
>  drivers/mmc/core/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 92e7671..a7e6110 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1551,8 +1551,8 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, u32 ocr)
>                 goto power_cycle;
>         }
>
> -       /* Keep clock gated for at least 5 ms */
> -       mmc_delay(5);
> +       /* Keep clock gated for at least 10 ms, though spec only says 5 ms */
> +       mmc_delay(10);
>         host->ios.clock = clock;
>         mmc_set_ios(host);
>
> --
> 2.2.0.rc0.207.ga3a616c
>
