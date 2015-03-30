From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] mmc: Add support for marking hpi as
 broken through devicetree
Date: Mon, 30 Mar 2015 11:14:19 +0200
Message-ID: <CAPDyKFp8bNYNgNW0u-JCN4ay0UM7JEdkdW48VRsCmu+JWpJgEA@mail.gmail.com>
References: <1427652575-12642-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDF57NG2XIHRB25H4SUAKGQEYZV2NGQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1427652575-12642-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 29 March 2015 at 20:09, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> The eMMC on a tablet I've will stop working / communicating as soon as
> the kernel executes:
>
>                 mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>                                 EXT_CSD_HPI_MGMT, 1,
>                                 card->ext_csd.generic_cmd6_time);
>
> There seems to be no way to reliable identify eMMC-s which have a broken
> hpi implementation, but at least for eMMC's which are soldered onto a board
> we can work around this by specifying that hpi is broken in devicetree.

Seems like a reasonable approach!

>
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/mmc/mmc-card.txt | 31 ++++++++++++++++++++++
>  drivers/mmc/core/mmc.c                             | 10 ++++++-
>  2 files changed, 40 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/mmc-card.txt
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.txt b/Documentation/devicetree/bindings/mmc/mmc-card.txt
> new file mode 100644
> index 0000000..0cc67fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/mmc-card.txt
> @@ -0,0 +1,31 @@
> +mmc-card / eMMC bindings
> +------------------------
> +
> +This documents describes the devicetree bindings for a mmc-host controller
> +child node describing a mmc-card / an eMMC, see "Use of Function subnodes"
> +in mmc.txt
> +
> +Required properties:
> +-compatible : Must be "mmc-card"
> +-reg        : Must be <0>

Instead of using a compatible, why can we just use "reg = <0>"?

> +
> +Optional properties:
> +-broken-hpi : Use this to indicate that the mmc-card has a broken hpi
> +              implementation, and that hpi should not be used
> +
> +Example:
> +
> +&mmc2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&mmc2_pins_a>;
> +       vmmc-supply = <&reg_vcc3v3>;
> +       bus-width = <8>;
> +       non-removable;
> +       status = "okay";
> +
> +       mmmcard: mmccard@0 {
> +               reg = <0>;
> +               compatible = "mmc-card";
> +               broken-hpi;
> +       };
> +};
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 1d41e85..8d18920 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -11,6 +11,7 @@
>   */
>
>  #include <linux/err.h>
> +#include <linux/of.h>
>  #include <linux/slab.h>
>  #include <linux/stat.h>
>  #include <linux/pm_runtime.h>
> @@ -336,6 +337,8 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>  {
>         int err = 0, idx;
>         unsigned int part_size;
> +       struct device_node *np = card->dev.of_node;
> +       bool broken_hpi = false;
>
>         /* Version is coded in the CSD_STRUCTURE byte in the EXT_CSD register */
>         card->ext_csd.raw_ext_csd_structure = ext_csd[EXT_CSD_STRUCTURE];
> @@ -349,6 +352,9 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>                 }
>         }
>
> +       if (np && of_device_is_compatible(np, "mmc-card"))
> +               broken_hpi = of_property_read_bool(np, "broken-hpi");
> +
>         /*
>          * The EXT_CSD format is meant to be forward compatible. As long
>          * as CSD_STRUCTURE does not change, all values for EXT_CSD_REV
> @@ -494,7 +500,7 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>                 }
>
>                 /* check whether the eMMC card supports HPI */
> -               if (ext_csd[EXT_CSD_HPI_FEATURES] & 0x1) {
> +               if (!broken_hpi && (ext_csd[EXT_CSD_HPI_FEATURES] & 0x1)) {
>                         card->ext_csd.hpi = 1;
>                         if (ext_csd[EXT_CSD_HPI_FEATURES] & 0x2)
>                                 card->ext_csd.hpi_cmd = MMC_STOP_TRANSMISSION;
> @@ -1251,6 +1257,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>                 card->ocr = ocr;
>                 card->type = MMC_TYPE_MMC;
>                 card->rca = 1;
> +               /* Also gets done by mmc_add_card, but we need early access */
> +               card->dev.of_node = mmc_of_find_child_device(host, 0);
>                 memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
>         }
>
> --
> 2.3.4
>

Kind regards
Uffe
