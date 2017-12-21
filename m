From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: tmio: use io* accessors consistently
Date: Thu, 21 Dec 2017 15:22:12 +0100
Message-ID: <CAPDyKFrXZVXjroVr-1DO9y_37n09c3n0PBUQok+bwy_hxv95oA@mail.gmail.com>
References: <20171219133403.788-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171219133403.788-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

On 19 December 2017 at 14:34, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Because we started using io*_rep accessors previously because they are
> more widely defined across architectures, let's be consistent and use
> this family for all accessor wrappers.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
> And here is the follow-up patch. Tested on a R-Car M3-W; still could checksum a
> huge file from SD without performance regressions.
>
>  drivers/mmc/host/tmio_mmc.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index 03519c4ca0aa1a..e7d651352dc90f 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -227,7 +227,7 @@ int tmio_mmc_host_runtime_resume(struct device *dev);
>
>  static inline u16 sd_ctrl_read16(struct tmio_mmc_host *host, int addr)
>  {
> -       return readw(host->ctl + (addr << host->bus_shift));
> +       return ioread16(host->ctl + (addr << host->bus_shift));
>  }
>
>  static inline void sd_ctrl_read16_rep(struct tmio_mmc_host *host, int addr,
> @@ -239,8 +239,8 @@ static inline void sd_ctrl_read16_rep(struct tmio_mmc_host *host, int addr,
>  static inline u32 sd_ctrl_read16_and_16_as_32(struct tmio_mmc_host *host,
>                                               int addr)
>  {
> -       return readw(host->ctl + (addr << host->bus_shift)) |
> -              readw(host->ctl + ((addr + 2) << host->bus_shift)) << 16;
> +       return ioread16(host->ctl + (addr << host->bus_shift)) |
> +              ioread16(host->ctl + ((addr + 2) << host->bus_shift)) << 16;
>  }
>
>  static inline void sd_ctrl_read32_rep(struct tmio_mmc_host *host, int addr,
> @@ -257,7 +257,7 @@ static inline void sd_ctrl_write16(struct tmio_mmc_host *host, int addr,
>          */
>         if (host->write16_hook && host->write16_hook(host, addr))
>                 return;
> -       writew(val, host->ctl + (addr << host->bus_shift));
> +       iowrite16(val, host->ctl + (addr << host->bus_shift));
>  }
>
>  static inline void sd_ctrl_write16_rep(struct tmio_mmc_host *host, int addr,
> @@ -269,8 +269,8 @@ static inline void sd_ctrl_write16_rep(struct tmio_mmc_host *host, int addr,
>  static inline void sd_ctrl_write32_as_16_and_16(struct tmio_mmc_host *host,
>                                                 int addr, u32 val)
>  {
> -       writew(val & 0xffff, host->ctl + (addr << host->bus_shift));
> -       writew(val >> 16, host->ctl + ((addr + 2) << host->bus_shift));
> +       iowrite16(val & 0xffff, host->ctl + (addr << host->bus_shift));
> +       iowrite16(val >> 16, host->ctl + ((addr + 2) << host->bus_shift));
>  }
>
>  static inline void sd_ctrl_write32_rep(struct tmio_mmc_host *host, int addr,
> --
> 2.11.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
