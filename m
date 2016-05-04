From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/6] mmc: core: add mmc-hs400-enhanced-strobe support
Date: Wed, 4 May 2016 10:12:01 +0200
Message-ID: <CAPDyKFrPhBKA3g+_NMBGfw4kqonpgQzbdTSo-A5sRwqio268xw@mail.gmail.com>
References: <1461897751-28810-1-git-send-email-shawn.lin@rock-chips.com>
	<1461897995-28903-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461897995-28903-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Rob Herring <robh+dt@kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 29 April 2016 at 04:46, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> This patch introduce mmc-hs400-enhanced-strobe for platforms
> which want to enable enhanced strobe function from DT if the
> mmc host controller claims to support enhanced strobe.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>
> ---
>
> Changes in v2:
> - switch to HS400ES from Highspeed mode directly
>
>  drivers/mmc/core/host.c  | 2 ++
>  include/linux/mmc/host.h | 6 ++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index e0a3ee1..eb1530a 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -289,6 +289,8 @@ int mmc_of_parse(struct mmc_host *host)
>                 host->caps2 |= MMC_CAP2_HS400_1_8V | MMC_CAP2_HS200_1_8V_SDR;
>         if (of_property_read_bool(np, "mmc-hs400-1_2v"))
>                 host->caps2 |= MMC_CAP2_HS400_1_2V | MMC_CAP2_HS200_1_2V_SDR;
> +       if (of_property_read_bool(np, "mmc-hs400-enhanced-strobe"))
> +               host->caps2 |= MMC_CAP2_HS400_ENHANCED_STROBE;

How about MMC_CAP2_HS400_ES instead?

>
>         host->dsr_req = !of_property_read_u32(np, "dsr", &host->dsr);
>         if (host->dsr_req && (host->dsr & ~0xffff)) {
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 85800b4..11e89d3 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -302,6 +302,7 @@ struct mmc_host {
>  #define MMC_CAP2_SDIO_IRQ_NOTHREAD (1 << 17)
>  #define MMC_CAP2_NO_WRITE_PROTECT (1 << 18)    /* No physical write protect pin, assume that card is always read-write */
>  #define MMC_CAP2_NO_SDIO       (1 << 19)       /* Do not send SDIO commands during initialization */
> +#define MMC_CAP2_HS400_ENHANCED_STROBE (1 << 20) /* Host supports enhanced strobe */
>
>         mmc_pm_flag_t           pm_caps;        /* supported pm features */
>
> @@ -480,6 +481,11 @@ static inline int mmc_host_uhs(struct mmc_host *host)
>                  MMC_CAP_UHS_DDR50);
>  }
>
> +static inline int mmc_host_hs400_enhanced_strobe(struct mmc_host *host)
> +{
> +       return host->caps2 & MMC_CAP2_HS400_ENHANCED_STROBE;
> +}
> +

This helper function is to me a bit unnecessary, can you please just
check the MMC_CAP2_* when needed instead!?

>  static inline int mmc_host_packed_wr(struct mmc_host *host)
>  {
>         return host->caps2 & MMC_CAP2_PACKED_WR;

Kind regards
Uffe
