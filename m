From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 10/18] mmc: sdhci-iproc: Add support for emmc2 of the
 BCM2711
Date: Wed, 24 Jul 2019 16:08:38 +0200
Message-ID: <CAPDyKFoJgiSQOYTiNHidr99tDe1QmuASfj0sJ=H7Ot1tb9mcBg@mail.gmail.com>
References: <1563776607-8368-1-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1563776607-8368-1-git-send-email-wahrenst@gmx.net>
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

On Mon, 22 Jul 2019 at 08:24, Stefan Wahren <wahrenst@gmx.net> wrote:
>
> The additional emmc2 interface of the BCM2711 is an improved version
> of the old emmc controller, which is able to provide DDR50 mode on the
> Raspberry Pi 4. Except 32 bit only register access no other quirks are
> known yet.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-iproc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 2feb4ef..2b9cdcd 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -261,8 +261,17 @@ static const struct sdhci_iproc_data bcm2835_data = {
>         .mmc_caps = 0x00000000,
>  };
>
> +static const struct sdhci_pltfm_data sdhci_bcm2711_pltfm_data = {
> +       .ops = &sdhci_iproc_32only_ops,
> +};
> +
> +static const struct sdhci_iproc_data bcm2711_data = {
> +       .pdata = &sdhci_bcm2711_pltfm_data,
> +};
> +
>  static const struct of_device_id sdhci_iproc_of_match[] = {
>         { .compatible = "brcm,bcm2835-sdhci", .data = &bcm2835_data },
> +       { .compatible = "brcm,bcm2711-emmc2", .data = &bcm2711_data },
>         { .compatible = "brcm,sdhci-iproc-cygnus", .data = &iproc_cygnus_data},
>         { .compatible = "brcm,sdhci-iproc", .data = &iproc_data },
>         { }
> --
> 2.7.4
>
