From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V6 08/15] mmc: mmc: Hold re-tuning if the card is put to sleep
Date: Tue, 21 Apr 2015 11:42:34 +0200
Message-ID: <CAPDyKFq3nncR09=TJ0o3vGEdwEw5bYPCxu38OFPZyaiKTUcAzw@mail.gmail.com>
References: <1429531796-21987-1-git-send-email-adrian.hunter@intel.com>
	<1429531796-21987-9-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33253 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbbDUJmf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Apr 2015 05:42:35 -0400
Received: by qkx62 with SMTP id 62so203644425qkx.0
        for <linux-mmc@vger.kernel.org>; Tue, 21 Apr 2015 02:42:34 -0700 (PDT)
In-Reply-To: <1429531796-21987-9-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 20 April 2015 at 14:09, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Currently "mmc sleep" is used before power off and
> is not paired with waking up. Nevertheless hold
> re-tuning.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/mmc.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index f36c76f..daf9954 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -21,6 +21,7 @@
>  #include <linux/mmc/mmc.h>
>
>  #include "core.h"
> +#include "host.h"
>  #include "bus.h"
>  #include "mmc_ops.h"
>  #include "sd_ops.h"
> @@ -1504,6 +1505,7 @@ static int mmc_can_sleep(struct mmc_card *card)
>         return (card && card->ext_csd.rev >= 3);
>  }
>
> +/* If necessary, callers must hold re-tuning */
>  static int mmc_sleep(struct mmc_host *host)
>  {
>         struct mmc_command cmd = {0};
> @@ -1631,6 +1633,7 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
>         int err = 0;
>         unsigned int notify_type = is_suspend ? EXT_CSD_POWER_OFF_SHORT :
>                                         EXT_CSD_POWER_OFF_LONG;
> +       bool retune_release = false;
>
>         BUG_ON(!host);
>         BUG_ON(!host->card);
> @@ -1651,17 +1654,22 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
>                 goto out;
>
>         if (mmc_can_poweroff_notify(host->card) &&
> -               ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend))
> +               ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend)) {
>                 err = mmc_poweroff_notify(host->card, notify_type);
> -       else if (mmc_can_sleep(host->card))
> +       } else if (mmc_can_sleep(host->card)) {
> +               mmc_retune_hold(host);
>                 err = mmc_sleep(host);
> -       else if (!mmc_host_is_spi(host))
> +       } else if (!mmc_host_is_spi(host)) {
>                 err = mmc_deselect_cards(host);
> +       }
>
>         if (!err) {
>                 mmc_power_off(host);
>                 mmc_card_set_suspended(host->card);
>         }
> +
> +       if (retune_release)
> +               mmc_retune_release(host);
>  out:
>         mmc_release_host(host);
>         return err;
> --
> 1.9.1
>

According to our previous discussions I have given this some more thinking.

I don't think we can allow to hold/disable re-tune in this path at
all. That's because we are claiming the host here and the sleep
command might then be the first command we invoke during the system PM
sequence.

That means sdhci might have flagged need_retune, since it's been
runtime PM suspended. And for those scenarios I guess we really need
to do a re-tune prior sending the sleep command, right?

Earlier I only had the re-tune timer in mind, which is why I was less
restrictive and suggesting you to add hold/disable. Sorry about that.

Now, with the above in mind I believe you have similar issues with
patch5 (mmc: core: Hold re-tuning during switch commands) and patch6
(mmc: core: Hold re-tuning during erase commands). And that's because
there are cases when the switch/erase commands are the first commands
sent, after the sdhci host has been runtime PM suspended. I guess we
need a way to make sure we don't hold re-tune for these cases.

An option to deal with that is to use a separate flag set by host
drivers, though the mmc_needs_retune() API and let that one override
another.

Forgive me for pushing you back and forth for how to do this, but it
seems like we still have some outstanding issues to resolve.

Kind regards
Uffe
