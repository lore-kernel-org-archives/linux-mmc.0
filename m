From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-of-arasan: Add quirk for unstable clocks
Date: Mon, 18 Jun 2018 10:59:31 +0200
Message-ID: <CAPDyKFonk-ftUMQ04r7SSu8Rs67TAV-qTWY+Nme1esOGQZdOoA@mail.gmail.com>
References: <da0ebcb3-b19a-86a6-8462-87a1c0e81fff@intel.com>
 <20180615081830.zrgx6arwn6ga27gu@laureti-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180615081830.zrgx6arwn6ga27gu@laureti-dev>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Helmut Grohne <h.grohne@intenta.de>
Cc: Atul Garg <agarg@arasan.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 15 June 2018 at 10:18, Helmut Grohne <h.grohne@intenta.de> wrote:
> Some controllers immediately report SDHCI_CLOCK_INT_STABLE after
> enabling the clock even when the clock is not stable. When used in
> conjunction with older/slower cards, this can result in:
>
>     mmc0: error -84 whilst initialising SD card
>
> When the stable reporting is broken, we simply wait for the maximum
> stabilization period.
>
> Signed-off-by: Helmut Grohne <h.grohne@intenta.de>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt |  2 ++

Please split this. DT doc should be a separate patch.

Otherwise this looks good to me.

Kind regards
Uffe

>  drivers/mmc/host/sdhci-of-arasan.c                     | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+)
>
> Changes since v1 (RFC):
>  * Use an arasan-specific quirk in the ->set_clock() callback as requested by
>    Adrian Hunter.
>
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 60481bfc3d31..c0e0f04a8504 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -39,6 +39,8 @@ Optional Properties:
>    - xlnx,fails-without-test-cd: when present, the controller doesn't work when
>      the CD line is not connected properly, and the line is not connected
>      properly. Test mode can be used to force the controller to function.
> +  - xlnx,int-clock-stable-broken: when present, the controller always reports
> +    that the internal clock is stable even when it is not.
>
>  Example:
>         sdhci@e0100000 {
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index c33a5f7393bd..f7fe26c75150 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -102,6 +102,9 @@ struct sdhci_arasan_data {
>
>  /* Controller does not have CD wired and will not function normally without */
>  #define SDHCI_ARASAN_QUIRK_FORCE_CDTEST        BIT(0)
> +/* Controller immediately reports SDHCI_CLOCK_INT_STABLE after enabling the
> + * internal clock even when the clock isn't stable */
> +#define SDHCI_ARASAN_QUIRK_CLOCK_UNSTABLE BIT(1)
>  };
>
>  static const struct sdhci_arasan_soc_ctl_map rk3399_soc_ctl_map = {
> @@ -207,6 +210,16 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
>
>         sdhci_set_clock(host, clock);
>
> +       if (sdhci_arasan->quirks & SDHCI_ARASAN_QUIRK_CLOCK_UNSTABLE)
> +               /*
> +                * Some controllers immediately report SDHCI_CLOCK_INT_STABLE
> +                * after enabling the clock even though the clock is not
> +                * stable. Trying to use a clock without waiting here results
> +                * in EILSEQ while detecting some older/slower cards. The
> +                * chosen delay is the maximum delay from sdhci_set_clock.
> +                */
> +               msleep(20);
> +
>         if (ctrl_phy) {
>                 phy_power_on(sdhci_arasan->phy);
>                 sdhci_arasan->is_phy_on = true;
> @@ -759,6 +772,9 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>         if (of_property_read_bool(np, "xlnx,fails-without-test-cd"))
>                 sdhci_arasan->quirks |= SDHCI_ARASAN_QUIRK_FORCE_CDTEST;
>
> +       if (of_property_read_bool(np, "xlnx,int-clock-stable-broken"))
> +               sdhci_arasan->quirks |= SDHCI_ARASAN_QUIRK_CLOCK_UNSTABLE;
> +
>         pltfm_host->clk = clk_xin;
>
>         if (of_device_is_compatible(pdev->dev.of_node,
> --
> 2.11.0
>
