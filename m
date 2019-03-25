From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] net: liquidio: fix NULL pointer dereferences
Date: Mon, 25 Mar 2019 13:41:29 +0100
Message-ID: <CAPDyKFr6QhDz2f12MuugQ5wnBBnn+y=5QsEQFy5Ve3h2XB6FVw@mail.gmail.com>
References: <20190311.121710.968693621648443243.davem@davemloft.net> <20190323032420.21162-1-kjlu@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190323032420.21162-1-kjlu@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Kangjie Lu <kjlu@umn.edu>
Cc: pakki001@umn.edu, Derek Chickles <dchickles@marvell.com>, Satanand Burla <sburla@marvell.com>, Felix Manlunas <fmanlunas@marvell.com>, "David S. Miller" <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Sat, 23 Mar 2019 at 04:24, Kangjie Lu <kjlu@umn.edu> wrote:
>
> In case octeon_alloc_soft_command fails, the fix reports the
> error and goes to cleanup to avoid NULL pointer dereferences.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
> V2: goto setup_nic_dev_free for cleanup
> ---
>  drivers/mmc/host/mmc_spi.c                         |  2 +-
>  drivers/net/ethernet/cavium/liquidio/lio_vf_main.c | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 32fea585262b..a3533935e282 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -820,7 +820,7 @@ mmc_spi_readblock(struct mmc_spi_host *host, struct spi_transfer *t,
>
>         status = spi_sync_locked(spi, &host->m);
>         if (status < 0) {
> -               dev_dbg(&spi->dev, "read error %02x (%d)\n", status, status);
> +               dev_dbg(&spi->dev, "read error %d\n", status);

Looks like a leftover from debugging?

[...]

Kind regards
Uffe
