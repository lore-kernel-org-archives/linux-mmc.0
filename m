From: Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH 09/18] dt-bindings: sdhci-iproc: Add brcm,bcm2711-emmc2
Date: Mon, 22 Jul 2019 10:31:55 +0000
Message-ID: <4749e256-69a2-bf42-e1ec-4dbbdee6c967@suse.com>
References: <1563774880-8061-1-git-send-email-wahrenst@gmx.net>
 <1563774880-8061-10-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1563774880-8061-10-git-send-email-wahrenst@gmx.net>
Content-Language: en-US
Content-ID: <D8D2F9593A16FE408812D088287C3219@namprd18.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <wahrenst@gmx.net>, Eric Anholt <eric@anholt.net>, Mark
 Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Florian
 Fainelli <f.fainelli@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>, "linux-rpi-kernel@lists.infradead.org" <linux-rpi-kernel@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org



On 22/07/2019 07:54, Stefan Wahren wrote:
> Add a new compatible for the additional emmc2 controller
> on BCM2711 and clearify usage.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>  Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt b/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
> index fa90d25..09d87cc 100644
> --- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
> +++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
> @@ -6,10 +6,12 @@ by mmc.txt and the properties that represent the IPROC SDHCI controller.
>  Required properties:
>  - compatible : Should be one of the following
>  	       "brcm,bcm2835-sdhci"
> +	       "brcm,bcm2711-emmc2"
>  	       "brcm,sdhci-iproc-cygnus"
>  	       "brcm,sdhci-iproc"
> 
> -Use brcm2835-sdhci for Rasperry PI.
> +Use brcm2835-sdhci for the eMMC controller on the BCM2835 (Raspberry Pi) and
> +bcm2711-emmc2 for the additional eMMC2 controller on BCM2711.
> 
>  Use sdhci-iproc-cygnus for Broadcom SDHCI Controllers
>  restricted to 32bit host accesses to SDHCI registers.
> --
> 2.7.4
> 
> 
