From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 09/18] dt-bindings: sdhci-iproc: Add brcm,bcm2711-emmc2
Date: Wed, 24 Jul 2019 16:08:34 +0200
Message-ID: <CAPDyKFqrbwJ9G0Za+U2FCBB=GKpMZdXesQAHZ+8v8T0fCusmiQ@mail.gmail.com>
References: <1563774880-8061-1-git-send-email-wahrenst@gmx.net>
 <1563774880-8061-10-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1563774880-8061-10-git-send-email-wahrenst@gmx.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>, Scott Branden <sbranden@broadcom.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, Ray Jui <rjui@broadcom.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Michael Turquette <mturquette@baylibre.com>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, linux-rpi-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Mon, 22 Jul 2019 at 07:56, Stefan Wahren <wahrenst@gmx.net> wrote:
>
> Add a new compatible for the additional emmc2 controller
> on BCM2711 and clearify usage.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Applied for next, thanks!

Kind regards
Uffe


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
>                "brcm,bcm2835-sdhci"
> +              "brcm,bcm2711-emmc2"
>                "brcm,sdhci-iproc-cygnus"
>                "brcm,sdhci-iproc"
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
