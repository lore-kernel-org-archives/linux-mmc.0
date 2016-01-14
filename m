From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: tmio_mmc_dma: don't print invalid DMA cookie
Date: Thu, 14 Jan 2016 11:02:33 +0100
Message-ID: <CAPDyKFr-Y+pnhkTLYO2k-XHieA1rOEX9Ov129fFtZac8MksooQ@mail.gmail.com>
References: <5032992.kTQ6Oyibpy@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <5032992.kTQ6Oyibpy@wuerfel>
Sender: linux-sh-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ian Molton <ian@mnementh.co.uk>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-sh list <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-mmc@vger.kernel.org

On 13 January 2016 at 22:25, Arnd Bergmann <arnd@arndb.de> wrote:
> The tmio_mmc_start_dma_{rx,tx} function functions contain debug
> code that prints the dma cookie among other things. However,
> in case we fall back to PIO mode for some reason, the cookie
> variable is never initialized, and gcc warns about this:
>
> In file included from ../include/linux/printk.h:277:0,
>                  from ../include/linux/kernel.h:13,
>                  from ../include/linux/list.h:8,
>                  from ../include/linux/kobject.h:20,
>                  from ../include/linux/device.h:17,
>                  from ../drivers/mmc/host/tmio_mmc_dma.c:13:
> ../drivers/mmc/host/tmio_mmc_dma.c: In function 'tmio_mmc_start_dma':
> ../include/linux/dynamic_debug.h:86:3: warning: 'cookie' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    __dynamic_dev_dbg(&descriptor, dev, fmt, \
>    ^
> ../drivers/mmc/host/tmio_mmc_dma.c:128:15: note: 'cookie' was declared here
>   dma_cookie_t cookie;
>
> This modifies the dev_dbg() statements so we only print the cookie
> when we are already in the DMA path.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
> This warning has existed for a long time, and it's only in debug code,
> so probably nobody cared.
>
> diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
> index e4b05dbb9ca8..4a0d6b80eaa3 100644
> --- a/drivers/mmc/host/tmio_mmc_dma.c
> +++ b/drivers/mmc/host/tmio_mmc_dma.c
> @@ -94,9 +94,9 @@ static void tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
>                         desc = NULL;
>                         ret = cookie;
>                 }
> +               dev_dbg(&host->pdev->dev, "%s(): mapped %d -> %d, cookie %d, rq %p\n",
> +                       __func__, host->sg_len, ret, cookie, host->mrq);
>         }
> -       dev_dbg(&host->pdev->dev, "%s(): mapped %d -> %d, cookie %d, rq %p\n",
> -               __func__, host->sg_len, ret, cookie, host->mrq);
>
>  pio:
>         if (!desc) {
> @@ -116,8 +116,8 @@ pio:
>                          "DMA failed: %d, falling back to PIO\n", ret);
>         }
>
> -       dev_dbg(&host->pdev->dev, "%s(): desc %p, cookie %d, sg[%d]\n", __func__,
> -               desc, cookie, host->sg_len);
> +       dev_dbg(&host->pdev->dev, "%s(): desc %p, sg[%d]\n", __func__,
> +               desc, host->sg_len);
>  }
>
>  static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
> @@ -174,9 +174,9 @@ static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
>                         desc = NULL;
>                         ret = cookie;
>                 }
> +               dev_dbg(&host->pdev->dev, "%s(): mapped %d -> %d, cookie %d, rq %p\n",
> +                       __func__, host->sg_len, ret, cookie, host->mrq);
>         }
> -       dev_dbg(&host->pdev->dev, "%s(): mapped %d -> %d, cookie %d, rq %p\n",
> -               __func__, host->sg_len, ret, cookie, host->mrq);
>
>  pio:
>         if (!desc) {
> @@ -196,8 +196,7 @@ pio:
>                          "DMA failed: %d, falling back to PIO\n", ret);
>         }
>
> -       dev_dbg(&host->pdev->dev, "%s(): desc %p, cookie %d\n", __func__,
> -               desc, cookie);
> +       dev_dbg(&host->pdev->dev, "%s(): desc %p\n", __func__, desc);
>  }
>
>  void tmio_mmc_start_dma(struct tmio_mmc_host *host,
>
