From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: make irq flags 'unsigned long'
Date: Thu, 2 Nov 2017 15:15:01 +0100
Message-ID: <CAPDyKFq-QyZ2bAdo_-y_Y9b7iNdQ0M2mGsdNO4dCtPMoZUcyXg@mail.gmail.com>
References: <20171102111655.3834051-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171102111655.3834051-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Addy Ke <addy.ke@rock-chips.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 2 November 2017 at 12:16, Arnd Bergmann <arnd@arndb.de> wrote:
> The newly added spin_lock_irqsave() passes an argument of the
> wrong type, leading to a warning about non-portable code:
>
> drivers/mmc/host/dw_mmc.c: In function 'dw_mci_set_drto':
> include/linux/typecheck.h:11:18: error: comparison of distinct pointer types lacks a cast [-Werror]
>   (void)(&__dummy == &__dummy2); \
> drivers/mmc/host/dw_mmc.c:1953:2: note: in expansion of macro 'spin_lock_irqsave'
>   spin_lock_irqsave(&host->irq_lock, irqflags);
>
> This changes the type to 'unsigned long' as it should be.
>
> Fixes: 80a2a5a7745b ("mmc: dw_mmc: Cleanup the DTO timer like the CTO one")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, however this has already been taken care of. It was a silly
mistake made by me when I amended an original commit.

Kind regards
Uffe

> ---
>  drivers/mmc/host/dw_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 31f5744a50e0..37b55b095daf 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1938,7 +1938,7 @@ static void dw_mci_set_drto(struct dw_mci *host)
>         unsigned int drto_clks;
>         unsigned int drto_div;
>         unsigned int drto_ms;
> -       unsigned int irqflags;
> +       unsigned long irqflags;
>
>         drto_clks = mci_readl(host, TMOUT) >> 8;
>         drto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
> --
> 2.9.0
>
