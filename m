From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: tmio: make a cast explicit
Date: Fri, 3 Jun 2016 10:34:07 +0200
Message-ID: <CAPDyKFreujWc2YNO-xr+pZr2beKJegCsK_eSOQXTwHXRwEzAKw@mail.gmail.com>
References: <1464351029-6863-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1464351029-6863-1-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

On 27 May 2016 at 14:10, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Sparse complains about the implicit cast. Making it explicit is indeed
> better coding style.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/tmio_mmc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index 7d1174c789219a..5f2919ceced12d 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -265,7 +265,7 @@ static inline void sd_ctrl_write16_rep(struct tmio_mmc_host *host, int addr,
>
>  static inline void sd_ctrl_write32_as_16_and_16(struct tmio_mmc_host *host, int addr, u32 val)
>  {
> -       writew(val, host->ctl + (addr << host->bus_shift));
> +       writew(val & 0xffff, host->ctl + (addr << host->bus_shift));
>         writew(val >> 16, host->ctl + ((addr + 2) << host->bus_shift));
>  }
>
> --
> 2.8.1
>
