From: Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH 10/18] mmc: sdhci-iproc: Add support for emmc2 of the
 BCM2711
Date: Mon, 22 Jul 2019 10:15:31 +0000
Message-ID: <55b337d1-8e6c-2b80-9859-c35a82ea5df3@suse.com>
References: <1563776607-8368-1-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1563776607-8368-1-git-send-email-wahrenst@gmx.net>
Content-Language: en-US
Content-ID: <09C4B038350A3B47A7C493B68609A1CF@namprd18.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <wahrenst@gmx.net>, Eric Anholt <eric@anholt.net>, Florian
 Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Matthias Brugger <mbrugger@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-rpi-kernel@lists.infradead.org" <linux-rpi-kernel@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>
List-Id: linux-mmc@vger.kernel.org



On 22/07/2019 08:23, Stefan Wahren wrote:
> The additional emmc2 interface of the BCM2711 is an improved version
> of the old emmc controller, which is able to provide DDR50 mode on the
> Raspberry Pi 4. Except 32 bit only register access no other quirks are
> known yet.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>  drivers/mmc/host/sdhci-iproc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 2feb4ef..2b9cdcd 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -261,8 +261,17 @@ static const struct sdhci_iproc_data bcm2835_data = {
>  	.mmc_caps = 0x00000000,
>  };
> 
> +static const struct sdhci_pltfm_data sdhci_bcm2711_pltfm_data = {
> +	.ops = &sdhci_iproc_32only_ops,
> +};
> +
> +static const struct sdhci_iproc_data bcm2711_data = {
> +	.pdata = &sdhci_bcm2711_pltfm_data,
> +};
> +
>  static const struct of_device_id sdhci_iproc_of_match[] = {
>  	{ .compatible = "brcm,bcm2835-sdhci", .data = &bcm2835_data },
> +	{ .compatible = "brcm,bcm2711-emmc2", .data = &bcm2711_data },
>  	{ .compatible = "brcm,sdhci-iproc-cygnus", .data = &iproc_cygnus_data},
>  	{ .compatible = "brcm,sdhci-iproc", .data = &iproc_data },
>  	{ }
> --
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
