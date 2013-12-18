From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] mmc: core: don't return 1 for max_discard
Date: Wed, 18 Dec 2013 16:00:22 -0700
Message-ID: <52B22906.4010704@wwwdotorg.org>
References: <1387405663-14253-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387405663-14253-1-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dong Aisheng <dongas86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 12/18/2013 03:27 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> In mmc_do_calc_max_discard(), if only a single erase block can be
> discarded within the host controller's timeout, don't allow discard
> operations at all.
> 
> Previously, the code allowed sector-at-a-time discard (rather than
> erase-block-at-a-time), which was chronically slow.
> 
> Without this patch, on the NVIDIA Tegra Cardhu board, the loops result
> in qty == 1, which is immediately returned. This causes discard to
> operate a single sector at a time, which is chronically slow. With this
> patch in place, discard operates a single erase block at a time, which
> is reasonably fast.

Alternatively, is the real fix a revert of e056a1b5b67b "mmc: queue: let
host controllers specify maximum discard timeout", followed by:

> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 050eb262485c..35c5b5d86c99 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1950,7 +1950,6 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
>         cmd.opcode = MMC_ERASE;
>         cmd.arg = arg;
>         cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
> -       cmd.cmd_timeout_ms = mmc_erase_timeout(card, arg, qty);
>         err = mmc_wait_for_cmd(card->host, &cmd, 0);
>         if (err) {
>                 pr_err("mmc_erase: erase error %d, status %#x\n",
> @@ -1962,7 +1961,7 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
>         if (mmc_host_is_spi(card->host))
>                 goto out;
>  
> -       timeout = jiffies + msecs_to_jiffies(MMC_CORE_TIMEOUT_MS);
> +       timeout = jiffies + msecs_to_jiffies(mmc_erase_timeout(card, arg, qty));
>         do {
>                 memset(&cmd, 0, sizeof(struct mmc_command));
>                 cmd.opcode = MMC_SEND_STATUS;

That certainly also seems to solve the problem on my board...
