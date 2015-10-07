From: Olliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] mmc: Add support for marking hpi as
 broken through devicetree
Date: Wed, 07 Oct 2015 10:43:58 +0200
Message-ID: <5614DB4E.8040807@schinagl.nl>
References: <1427901984-26469-1-git-send-email-hdegoede@redhat.com>
Reply-To: oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Return-path: <linux-sunxi+bncBDDZ7YMYRMGBBUNW2OYAKGQEMFO5VFY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1427901984-26469-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hey Hans,

On 01-04-15 17:26, Hans de Goede wrote:
> The eMMC on a tablet I've will stop working / communicating as soon as
> the kernel executes:
>
> 		mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>   				EXT_CSD_HPI_MGMT, 1,
>   				card->ext_csd.generic_cmd6_time);
>
> There seems to be no way to reliable identify eMMC-s which have a broken
> hpi implementation, but at least for eMMC's which are soldered onto a board
> we can work around this by specifying that hpi is broken in devicetree.
We've been talking about this a little off-list, and I was just 
triggered again by this so I'm following up on it again.

The same issue bit me in the ass on a Micron 'industrial' grade eMMC 
(MTFC4GACAANA) and luckily you found this back then to help me.

As we discussed, this may very well be a limitation of the mmc 
controller, rather then the MMC chip. While we only have a sample size 
of 2 on 2 different socs (with likely the same mmc IP) (A13/A20) I found 
in the JEDEC spec in the appendix on changes from 4.4 to 4.41:
Introduce of High Priority Interrupt mechanism, HPI background and one 
of possible solutions.

Which leaves me to believe, that HPI was added to eMMC in version 4.41 
and was not available before. Both the A13 and A20 user manuals state 
that the MMC controller in these socs is only version 4.3.

Obviously I know far to little as to what does and what does not work 
with an MMC-host, since it's just a simple data-bus, but I would not be 
surprised if these things are somewhere somewhat related, so hopefully 
someone on this list can give their opinion on this.

I already checked the core/mmc.c where the version is read from the mmc 
controller to see if we can trigger on this based on version, however it 
seems only the major version number is stored here [0]?

So in my opinion, it is quite likely that this setting be moved up to 
the mmc-core level, for the SoC, rather then the card itself?

[0] http://lxr.free-electrons.com/source/drivers/mmc/core/mmc.c#L148
>
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
> Changes in v2:
> -Fix of_node leakage
> ---
>   Documentation/devicetree/bindings/mmc/mmc-card.txt | 31 ++++++++++++++++++++++
>   drivers/mmc/core/mmc.c                             | 10 ++++++-
>   2 files changed, 40 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/devicetree/bindings/mmc/mmc-card.txt
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.txt b/Documentation/devicetree/bindings/mmc/mmc-card.txt
> new file mode 100644
> index 0000000..a70fcd6
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
> +
> +Optional properties:
> +-broken-hpi : Use this to indicate that the mmc-card has a broken hpi
> +              implementation, and that hpi should not be used
> +
> +Example:
> +
> +&mmc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc2_pins_a>;
> +	vmmc-supply = <&reg_vcc3v3>;
> +	bus-width = <8>;
> +	non-removable;
> +	status = "okay";
> +
> +	mmccard: mmccard@0 {
> +		reg = <0>;
> +		compatible = "mmc-card";
> +		broken-hpi;
> +	};
> +};
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 1d41e85..c84131e 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -11,6 +11,7 @@
>    */
>   
>   #include <linux/err.h>
> +#include <linux/of.h>
>   #include <linux/slab.h>
>   #include <linux/stat.h>
>   #include <linux/pm_runtime.h>
> @@ -336,6 +337,8 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>   {
>   	int err = 0, idx;
>   	unsigned int part_size;
> +	struct device_node *np;
> +	bool broken_hpi = false;
>   
>   	/* Version is coded in the CSD_STRUCTURE byte in the EXT_CSD register */
>   	card->ext_csd.raw_ext_csd_structure = ext_csd[EXT_CSD_STRUCTURE];
> @@ -349,6 +352,11 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>   		}
>   	}
>   
> +	np = mmc_of_find_child_device(card->host, 0);
> +	if (np && of_device_is_compatible(np, "mmc-card"))
> +		broken_hpi = of_property_read_bool(np, "broken-hpi");
> +	of_node_put(np);
> +
>   	/*
>   	 * The EXT_CSD format is meant to be forward compatible. As long
>   	 * as CSD_STRUCTURE does not change, all values for EXT_CSD_REV
> @@ -494,7 +502,7 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>   		}
>   
>   		/* check whether the eMMC card supports HPI */
> -		if (ext_csd[EXT_CSD_HPI_FEATURES] & 0x1) {
> +		if (!broken_hpi && (ext_csd[EXT_CSD_HPI_FEATURES] & 0x1)) {
>   			card->ext_csd.hpi = 1;
>   			if (ext_csd[EXT_CSD_HPI_FEATURES] & 0x2)
>   				card->ext_csd.hpi_cmd =	MMC_STOP_TRANSMISSION;
