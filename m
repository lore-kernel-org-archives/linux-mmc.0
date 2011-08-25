From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH 2/2] mmc: Use mmc_delay() instead of mdelay() for time delay
Date: Thu, 25 Aug 2011 19:23:35 +0900
Message-ID: <CAH9JG2VUA_5c=3LPEvoVmTrYN9WibY87AgEkNgV3uFpAS0euQA@mail.gmail.com>
References: <1314262479-32520-1-git-send-email-Chunhe.Lan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:39989 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167Ab1HYKXg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Aug 2011 06:23:36 -0400
Received: by qwk3 with SMTP id 3so1186162qwk.19
        for <linux-mmc@vger.kernel.org>; Thu, 25 Aug 2011 03:23:35 -0700 (PDT)
In-Reply-To: <1314262479-32520-1-git-send-email-Chunhe.Lan@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chunhe Lan <Chunhe.Lan@freescale.com>
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kumar.gala@freescale.com, Shengzhou Liu <b36685@freescale.com>, Chris Ball <cjb@laptop.org>

On Thu, Aug 25, 2011 at 5:54 PM, Chunhe Lan <Chunhe.Lan@freescale.com> =
wrote:
> The mmc_delay() is a wrapper function for mdelay() and msleep().
>
> =A0 =A0o mdelay() -- block the system when busy-waiting.
> =A0 =A0o msleep() -- suspend the currently running task to enable CPU
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0to process other tasks, so it is n=
on-blocking
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regarding the whole system.
>
> When the desired delay time is more than a period of timer interrupt,
> just use msleep(). Change mdelay() to mmc_delay() to avoid chewing
> CPU when busy wait.
>
> Signed-off-by: Shengzhou Liu <b36685@freescale.com>
> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> Cc: Chris Ball <cjb@laptop.org>
> ---
> =A0drivers/mmc/host/sdhci.c | =A0 11 ++++++-----
> =A01 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 0e02cc1..0cb5dc1 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -27,6 +27,7 @@
> =A0#include <linux/mmc/host.h>
>
> =A0#include "sdhci.h"
> +#include "../core/core.h"

Doesn't better to move the mmc_delay() to "include/linux/mmc/core.h"?
and include it.
I think It's not proper include syntax using relative path.

Thank you,
Kyungmin Park
>
> =A0#define DRIVER_NAME "sdhci"
>
> @@ -186,7 +187,7 @@ static void sdhci_reset(struct sdhci_host *host, =
u8 mask)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timeout--;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_delay(1);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (host->ops->platform_reset_exit)
> @@ -957,7 +958,7 @@ static void sdhci_send_command(struct sdhci_host =
*host, struct mmc_command *cmd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timeout--;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_delay(1);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0mod_timer(&host->timer, jiffies + 10 * HZ);
> @@ -1127,7 +1128,7 @@ static void sdhci_set_clock(struct sdhci_host *=
host, unsigned int clock)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timeout--;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_delay(1);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0clk |=3D SDHCI_CLOCK_CARD_EN;
> @@ -1192,7 +1193,7 @@ static void sdhci_set_power(struct sdhci_host *=
host, unsigned short power)
> =A0 =A0 =A0 =A0 * can apply clock after applying power
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(10);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_delay(10);
> =A0}
>
> =A0/*****************************************************************=
************\
> @@ -1712,7 +1713,7 @@ static int sdhci_execute_tuning(struct mmc_host=
 *mmc)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl =3D sdhci_readw(host, SDHCI_HOST_=
CONTROL2);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tuning_loop_counter--;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timeout--;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_delay(1);
> =A0 =A0 =A0 =A0} while (ctrl & SDHCI_CTRL_EXEC_TUNING);
>
> =A0 =A0 =A0 =A0/*
> --
> 1.7.5.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
