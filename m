From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: omap: Use DIV_ROUND_UP instead of open coded
Date: Wed, 14 May 2014 11:33:25 +0200
Message-ID: <CAPDyKFp3tQVtcDbUD1R1GeO1Zr0ScE2yZVZuWVmztq02FfjP+w@mail.gmail.com>
References: <1399079262.9244.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1399079262.9244.1.camel@phoenix>
Sender: linux-omap-owner@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Chris Ball <chris@printf.net>, Joachim Eastwood <manabian@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 3 May 2014 03:07, Axel Lin <axel.lin@ingics.com> wrote:
> Also uses NSEC_PER_SEC and USEC_PER_SEC instead of hard-coded value.
> This makes the intention more clear.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Thanks Axel!

Will include this patch in the next PR to Chris.

Kind regards
Ulf Hansson

> ---
>  drivers/mmc/host/omap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index 5c2e58b..81974ec 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -177,7 +177,7 @@ static void mmc_omap_fclk_offdelay(struct mmc_omap_slot *slot)
>         unsigned long tick_ns;
>
>         if (slot != NULL && slot->host->fclk_enabled && slot->fclk_freq > 0) {
> -               tick_ns = (1000000000 + slot->fclk_freq - 1) / slot->fclk_freq;
> +               tick_ns = DIV_ROUND_UP(NSEC_PER_SEC, slot->fclk_freq);
>                 ndelay(8 * tick_ns);
>         }
>  }
> @@ -435,7 +435,7 @@ static void mmc_omap_send_stop_work(struct work_struct *work)
>         struct mmc_data *data = host->stop_data;
>         unsigned long tick_ns;
>
> -       tick_ns = (1000000000 + slot->fclk_freq - 1)/slot->fclk_freq;
> +       tick_ns = DIV_ROUND_UP(NSEC_PER_SEC, slot->fclk_freq);
>         ndelay(8*tick_ns);
>
>         mmc_omap_start_command(host, data->stop);
> @@ -477,7 +477,7 @@ mmc_omap_send_abort(struct mmc_omap_host *host, int maxloops)
>         u16 stat = 0;
>
>         /* Sending abort takes 80 clocks. Have some extra and round up */
> -       timeout = (120*1000000 + slot->fclk_freq - 1)/slot->fclk_freq;
> +       timeout = DIV_ROUND_UP(120 * USEC_PER_SEC, slot->fclk_freq);
>         restarts = 0;
>         while (restarts < maxloops) {
>                 OMAP_MMC_WRITE(host, STAT, 0xFFFF);
> @@ -677,8 +677,8 @@ mmc_omap_xfer_data(struct mmc_omap_host *host, int write)
>         if (n > host->buffer_bytes_left)
>                 n = host->buffer_bytes_left;
>
> -       nwords = n / 2;
> -       nwords += n & 1; /* handle odd number of bytes to transfer */
> +       /* Round up to handle odd number of bytes to transfer */
> +       nwords = DIV_ROUND_UP(n, 2);
>
>         host->buffer_bytes_left -= n;
>         host->total_bytes_left -= n;
> --
> 1.8.3.2
>
>
>
