From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH 3/3] sdhci: arasan: Add support to read Tap Delay
 values from DT
Date: Tue, 10 Jul 2018 10:31:39 +0200
Message-ID: <CAPDyKFoGJOE-h4rLqzMO=wzNjkfcuU_oQ3NLK5=OQfSMj3dDHg@mail.gmail.com>
References: <1528373500-24663-1-git-send-email-manish.narani@xilinx.com> <1528373500-24663-3-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528373500-24663-3-git-send-email-manish.narani@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Manish Narani <manish.narani@xilinx.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Moritz Fischer <mdf@kernel.org>, stefan.krsmanovic@aggios.com, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, devicetree@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@xilinx.com>
List-Id: linux-mmc@vger.kernel.org

On 7 June 2018 at 14:11, Manish Narani <manish.narani@xilinx.com> wrote:
> This patch adds support for reading Tap Delay values from Device Tree
> and write them via eemi calls. The macros containing these tap delay
> values are removed from the driver.
>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 131 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 131 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index e3332a5..fc0fd01 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -36,6 +36,8 @@
>
>  #define PHY_CLK_TOO_SLOW_HZ            400000
>
> +#define MMC_BANK2              0x2
> +
>  /*
>   * On some SoCs the syscon area has a feature where the upper 16-bits of
>   * each 32-bit register act as a write mask for the lower 16-bits.  This allows
> @@ -90,6 +92,10 @@ struct sdhci_arasan_data {
>         struct sdhci_host *host;
>         struct clk      *clk_ahb;
>         struct phy      *phy;
> +       u32 mio_bank;
> +       u32 device_id;
> +       u32 itapdly[MMC_TIMING_MMC_HS400 + 1];
> +       u32 otapdly[MMC_TIMING_MMC_HS400 + 1];
>         bool            is_phy_on;
>
>         bool            has_cqe;
> @@ -160,11 +166,36 @@ static int sdhci_arasan_syscon_write(struct sdhci_host *host,
>         return ret;
>  }
>
> +/**
> + * arasan_zynqmp_set_tap_delay - Program the tap delays.
> + * @deviceid:          Unique Id of device
> + * @itap_delay:                Input Tap Delay
> + * @oitap_delay:       Output Tap Delay
> + */
> +static void arasan_zynqmp_set_tap_delay(u8 deviceid, u8 itap_delay, u8 otap_delay)
> +{
> +       const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();

No thanks!

Isn't there a more generic framework we can use to change the tap
values, rather than calling SoC specific functions from the driver?

BTW, what is a tap value, more exactly?

What does changing a tap value mean and where does the property belong, really?

Of course this doesn't even compile, as you have a dependency to
another series. Next time, please clarify that in a cover-letter
(maybe you did, but I can't find it).

> +       u32 node_id = (deviceid == 0) ? NODE_SD_0 : NODE_SD_1;
> +
> +       if (!eemi_ops || !eemi_ops->ioctl)
> +               return;
> +
> +       if (itap_delay)
> +               eemi_ops->ioctl(node_id, IOCTL_SET_SD_TAPDELAY,
> +                               PM_TAPDELAY_INPUT, itap_delay, NULL);
> +
> +       if (otap_delay)
> +               eemi_ops->ioctl(node_id, IOCTL_SET_SD_TAPDELAY,
> +                               PM_TAPDELAY_OUTPUT, otap_delay, NULL);
> +}

Another overall comment for the series.

I would recommend to change the order of the patches in the series.
Let the DT doc change come first, next the driver change and finally
the change to the DTS file(s). This makes it easier to follow and
review.

[...]

Kind regards
Uffe
