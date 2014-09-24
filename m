From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: core: Add new power_mode MMC_POWER_UNDEFINED
Date: Wed, 24 Sep 2014 11:23:54 +0200
Message-ID: <CAPDyKFqO-FCD1CMy4KitjWUtNg=__Vvmv4JmC6S0182iB-ONsQ@mail.gmail.com>
References: <1411549634-28683-1-git-send-email-rogerable@realtek.com>
 <1411549634-28683-2-git-send-email-rogerable@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1411549634-28683-2-git-send-email-rogerable@realtek.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Roger Tseng <rogerable@realtek.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "driverdev-devel@linuxdriverproject.org" <driverdev-devel@linuxdriverproject.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wei WANG <wei_wang@realsil.com.cn>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

On 24 September 2014 11:07, Roger Tseng <rogerable@realtek.com> wrote:
> Define new macro MMC_POWER_UNDEFINED for power_mode in struct mmc_ios.
> It will also be set as the initial value of host->ios.power_mode in
> mmc_start_host().
>
> For hosts with MMC_CAP2_NO_PRESCAN_POWERUP, this makes the later
> mmc_power_off() do real power-off things instead of NOP, and further
> prevents state messed up in cards that was already initialized(eg. by
> BIOS of UEFI driver).
>
> Signed-off-by: Roger Tseng <rogerable@realtek.com>

Thanks! Applied for next!

I changes some minor parts of the commit message and set the author of
the patch to "Roger Tseng <rogerable@realtek.com>" instead of
"<rogerable@realtek.com>". Please fix that in for future patches.

Kind regards
Uffe

> ---
>  drivers/mmc/core/core.c  |    1 +
>  include/linux/mmc/host.h |    1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index d03a080fb9cd..7dad1a1adf18 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2489,6 +2489,7 @@ void mmc_start_host(struct mmc_host *host)
>  {
>         host->f_init = max(freqs[0], host->f_min);
>         host->rescan_disable = 0;
> +       host->ios.power_mode = MMC_POWER_UNDEFINED;
>         if (host->caps2 & MMC_CAP2_NO_PRESCAN_POWERUP)
>                 mmc_power_off(host);
>         else
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 7960424d0bc0..b3bfa609816a 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -42,6 +42,7 @@ struct mmc_ios {
>  #define MMC_POWER_OFF          0
>  #define MMC_POWER_UP           1
>  #define MMC_POWER_ON           2
> +#define MMC_POWER_UNDEFINED    3
>
>         unsigned char   bus_width;              /* data bus width */
>
> --
> 1.7.10.4
>
