From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/3] Signal voltage switch procedure for UHS mode
Date: Mon, 10 Dec 2012 13:45:36 +0100
Message-ID: <CAPDyKFoE+sy2rwa5=2oZtb41kwtEKfyqqzdsMqocVS_v+Oi42Q@mail.gmail.com>
References: <1354897176-15307-1-git-send-email-johan.rudholm@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:58818 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367Ab2LJMph (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Dec 2012 07:45:37 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so7693756ieb.19
        for <linux-mmc@vger.kernel.org>; Mon, 10 Dec 2012 04:45:37 -0800 (PST)
In-Reply-To: <1354897176-15307-1-git-send-email-johan.rudholm@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <johan.rudholm@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>, Kevin Liu <keyuan.liu@gmail.com>, Philip Rakity <prakity@marvell.com>, Daniel Drake <dsd@laptop.org>, Aaron <leafy.myeh@allwinnertech.com>, Subhash Jadavani <subhashj@codeaurora.org>

On 7 December 2012 17:19, Johan Rudholm <johan.rudholm@stericsson.com> wrote:
> This patch series attempts to make the 1.8V signal voltage switch
> required for UHS mode work according to the SD specification.
>
> These patches have been tested with a couple of UHS SD cards, one of
> which sometimes requires up to five power cycles before it accepts the
> signal voltage switch. The patches have also been tested with various
> other SD cards, as well as one SDIO WLAN chip (cw1200) to check
> for regressions. The patches have also been tested with
> CONFIG_MMC_CLKGATE.
>
> As usual, I'd be very grateful if someone could help me test this patch
> with an UHS SDIO card and perhaps also a combo card (which does seem to
> be rare these days?)?
>
> This patch series is based on previous RFC/patch:
>
> [RFC/PATCH v2] mmc: core: Fixup signal voltage switch
>
> Changelog:
>         v2 -> This patch series
>         - Removed the extra argument to the card_busy host_ops function
>         - Added mmc_power_cycle
>         - Some clarifying comments
>         v1 -> v2
>         - Removed reset of signal voltage in mmc_sd_get_cid, since
>           "mmc: core: reset signal voltage on power up"
>         previous two patches -> v1:
>         - Keep calls to mmc_host_clk_hold / mmc_host_clk_release
>         - Add retry-loop / power cycle in sdio.c
>         - Fall back to 3.3 V if the switch repeatedly fails
>         - Add an extra argument to the card_busy host_ops function,
>           which can be used to signal polling use of the function
>
> Johan Rudholm (3):
>   mmc: core: Add mmc_power_cycle
>   mmc: core: Add card_busy to host_ops
>   mmc: core: Fixup signal voltage switch
>
>  drivers/mmc/core/core.c  |   43 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/core/core.h  |    1 +
>  drivers/mmc/core/sd.c    |   26 +++++++++++++++++++++-----
>  drivers/mmc/core/sdio.c  |   25 +++++++++++++++++++++++--
>  include/linux/mmc/host.h |    3 +++
>  5 files changed, 91 insertions(+), 7 deletions(-)
>
> --
> 1.7.10
>

Great Johan! Thanks for fixing this up.

Now, I can go ahead with upstreaming the patches for mmci host driver
for this feature.
If some of the sdhci guys needs some assistance for fixing this more
properly for sdhci as well, I can also happily help out.

So for the hole series:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Ulf Hansson
