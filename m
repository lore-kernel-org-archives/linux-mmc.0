From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [RFC PATCH] mmc: sdhci-of-arasan: Add the support for sdhci-5.1
Date: Tue, 11 Aug 2015 07:06:35 +0200
Message-ID: <55C982DB.30208@xilinx.com>
References: <1439256888-6658-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439256888-6658-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 08/11/2015 03:34 AM, Shawn Lin wrote:
> This patch adds the quirks and compatible string in sdhci-of-arasan.c
> to support sdhci-arasan5.1 version of controller. No documented controller
> IP version is found in the TRM, so we use ths version of command queueing
> engine integrated into this controller by arasan to specify our controller.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 2 +-
>  drivers/mmc/host/sdhci-of-arasan.c                     | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 7e94903..da541c3 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -9,7 +9,7 @@ Device Tree Bindings for the Arasan SDHCI Controller
>  
>  Required Properties:
>    - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' or
> -                'arasan,sdhci-4.9a'
> +                'arasan,sdhci-4.9a' or 'arasan,sdhci-5.1'
>    - reg: From mmc bindings: Register location and length.
>    - clocks: From clock bindings: Handles to clock inputs.
>    - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index ef5a7d2..c9012f5 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -175,6 +175,9 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  	if (of_device_is_compatible(pdev->dev.of_node, "arasan,sdhci-4.9a")) {
>  		host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
>  		host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
> +	} else if (of_device_is_compatible(pdev->dev.of_node,
> +					   "arasan,sdhci-5.1")) {
> +		host->quirks |= SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;

Is this broken Arasan version or just broken capability on your SoC?

Thanks,
Michal
