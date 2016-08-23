From: Haibo Chen <haibo.chen-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH] sdhci: Add quirk and device tree parameter to force SD
 test mode
Date: Tue, 23 Aug 2016 01:34:20 +0000
Message-ID: <AM4PR0401MB2324D95AB7382C828BF8E5CE90EB0@AM4PR0401MB2324.eurprd04.prod.outlook.com>
References: <1471906531-28668-1-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471906531-28668-1-git-send-email-zach.brown-acOepvfBmUk@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>, "adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

> -----Original Message-----
> From: linux-mmc-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-mmc-
> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Zach Brown
> Sent: Tuesday, August 23, 2016 6:56 AM
> To: adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
> Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org; robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org;
> linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: [PATCH] sdhci: Add quirk and device tree parameter to force SD t=
est
> mode
>=20
> From: Jaeden Amero <jaeden.amero-acOepvfBmUk@public.gmane.org>
>=20
> On some devices, CD is broken so that we must force the SDHCI into test m=
ode
> and set CD, so that it always detects an SD card as present.
>=20
> In order to get a device with broken CD working, we had previously always=
 set
> the SDHCI into test mode. Unfortunately, this had the side effect of maki=
ng all
> SD cards used with our Linux kernels undetectable and non-removable.

Why not use the poll mode? You can set the flag MMC_CAP_NEEDS_POLL, then=20
the mmc core will detect the card every second.

>=20
> By making this "SD test mode" setting optional via a quirk, we can avoid =
this
> side effect for devices other than the device with broken CD.
> Additionally, we add a device parameter to sdhci-pltfm to allow all SDHCI
> drivers to enable this quirk.
>=20
> Signed-off-by: Jaeden Amero <jaeden.amero-acOepvfBmUk@public.gmane.org>
> Signed-off-by: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt | 2 ++
>  drivers/mmc/host/sdhci-pltfm.c                | 4 ++++
>  drivers/mmc/host/sdhci.c                      | 9 +++++++++
>  drivers/mmc/host/sdhci.h                      | 4 ++++
>  4 files changed, 19 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt
> b/Documentation/devicetree/bindings/mmc/mmc.txt
> index 22d1e1f..3a9be41 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -52,6 +52,8 @@ Optional properties:
>  - no-sdio: controller is limited to send sdio cmd during initialization
>  - no-sd: controller is limited to send sd cmd during initialization
>  - no-mmc: controller is limited to send mmc cmd during initialization
> +- force-sd-cd-test-mode: card detection is broken on device, force cd
> +test
> +  enable and cd test inserted so host will always detect a card.
>=20
>  *NOTE* on CD and WP polarity. To use common for all SD/MMC host
> controllers line  polarity properties, we have to fix the meaning of the =
"normal"
> and "inverted"
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltf=
m.c
> index 1d17dcf..056d101 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -87,6 +87,10 @@ void sdhci_get_of_property(struct platform_device
> *pdev)
>  	if (of_get_property(np, "broken-cd", NULL))
>  		host->quirks |=3D SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>=20
> +	if (of_get_property(np, "force-sd-cd-test-mode", NULL))
> +		host->quirks2 |=3D
> +			SDHCI_QUIRK2_MUST_FORCE_SD_CD_TEST_MODE;
> +
>  	if (of_get_property(np, "no-1-8-v", NULL))
>  		host->quirks2 |=3D SDHCI_QUIRK2_NO_1_8_V;
>=20
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index
> cd65d47..2f4c6f9 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -117,6 +117,15 @@ static inline bool sdhci_data_line_cmd(struct
> mmc_command *cmd)  static void sdhci_set_card_detection(struct sdhci_host
> *host, bool enable)  {
>  	u32 present;
> +	u8  ctrl;
> +
> +	if (host->quirks2 & SDHCI_QUIRK2_MUST_FORCE_SD_CD_TEST_MODE)
> {
> +		/* Put the card in test mode, with card inserted */
> +		ctrl =3D sdhci_readl(host, SDHCI_HOST_CONTROL);
> +		ctrl |=3D SDHCI_CTRL_CD_TEST_INSERTED |
> +			SDHCI_CTRL_CD_TEST_ENABLE;
> +		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> +	}
>=20
>  	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) ||
>  	    !mmc_card_is_removable(host->mmc))
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h index
> 0411c9f..dd609b2 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -84,6 +84,8 @@
>  #define   SDHCI_CTRL_ADMA32	0x10
>  #define   SDHCI_CTRL_ADMA64	0x18
>  #define   SDHCI_CTRL_8BITBUS	0x20
> +#define  SDHCI_CTRL_CD_TEST_INSERTED	0x40
> +#define  SDHCI_CTRL_CD_TEST_ENABLE	0x80
>=20
>  #define SDHCI_POWER_CONTROL	0x29
>  #define  SDHCI_POWER_ON		0x01
> @@ -422,6 +424,8 @@ struct sdhci_host {
>  #define SDHCI_QUIRK2_ACMD23_BROKEN			(1<<14)
>  /* Broken Clock divider zero in controller */
>  #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
> +/* Controller must support device with broken CD */
> +#define SDHCI_QUIRK2_MUST_FORCE_SD_CD_TEST_MODE		(1<<16)
>=20
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */
> --
> 2.7.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in t=
he
> body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
