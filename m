Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793803126;
	b=qBP4dQOVdLhR85WT5ZwfOHSF6LsE6eGxlhqtfsjD3YZDQcGZS4ILAMiYgfqcmz3Hqh9r
	 72HfOjQabeZROTr5IhRzIJ1enQqNKnwn74oW9X3RZOspVLe+A8BVkVR78dQk8MnJC6leM
	 jM5SIlhATQQOGY0gfzLx4/iR4jpNnLPok3GSIVy5uVdeN06ybKFEWRPnTe77y8h8NrhDH
	 ZEad+DLnX9nSUgwIZeBKfH5hhlNhTuQOz/ii+l16QzW1IRYtgSMFL8JGe6a60Yvl2d/w2
	 AWJZKMg0d3xK+GyzR09ObDGs5AN6oXb4nLIATO5HJKznVcKz1iIEfP553hb5WvTXuKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793803126;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:
	 X-Last-TLS-Session-Version;
	bh=I8vXLFqojS5ybFij5vE8EJiBrKQ2IKCppMIQdCmOTuo=;
	b=zaoWpGMB8UrFH2VeXwbhRbJ5zSPn+NdZ8ar7lGG7sNljbTMEPXvPGb+Rkixn6Fru93WM
	 TTzZYl22T0BPichABSBRJDm4cwIdVoWN5W7hudonvfwYU07qSotfJSII1N7TpclQWODKN
	 Rvm3b25Py8mE4+gRRKfxo1nf/5ZUkRfLiey/5s+myhvbtidnvBYHpfw3tcqsCJ6Yy1KiU
	 3vpIlKAaIH3sbr4P7PRjwznM9NHdpQooSPVIai5h8zrPhFySyScerK/XL9w/NxEhX8WCR
	 UBE0MSOfsQG8RfvRyYJOR2q09pTPE8y1b9LghbPHJ2yMFyQTl5CumCbb3/hkOZSfdeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=aN894YlH;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77659606A32F;
	Wed,  4 Nov 2026 14:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77659606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=aN894YlH
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B7F834E413FF;
	Wed,  4 Nov 2026 14:38:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6E53360770;
	Wed,  4 Nov 2026 14:38:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E180E10329205;
	Wed,  4 Nov 2026 15:38:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793803117; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=I8vXLFqojS5ybFij5vE8EJiBrKQ2IKCppMIQdCmOTuo=;
	b=aN894YlHG3JxjIrKKcuPk3PjJeHrZek/Fq4ux0Ig2b7emKCjNU5a/dEIjWFaVykpooM1ei
	vtHXk1IVL21kgafdAOxAkQPGu5QONbag5l5hlxKmjgrQg5RWlur5jTb51C6H+7oU85bGTk
	mqqtDtd6y9kICEda23/yJHhPBtYaj8oMSahW9lEuf4rdIvsjFwkhBNl+1V+dPxkRWEdrGR
	roM44jXVxNYR4zuBgkPZzjek7yw5cfYj/nDYkbZId+qc2G3kY4vRE1vrHZ1Au42X5dBvQV
	6XkEkJtBkXar7tl9GTPLyXm4UddNl6wfx56+tcbuUM1K6gbShP+GGJpD9Ca4JA==
Message-ID: <21015d0ab9c99bbe8b187792836ecd267e02d4dd.camel@bootlin.com>
Subject: Re: [PATCH] mmc: sdhci-cadence: enable probing from ACPI
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Tanmay Kathpalia
	 <tanmay.kathpalia@altera.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas
 Petazzoni	 <thomas.petazzoni@bootlin.com>
Date: Wed, 04 Nov 2026 15:38:32 +0100
In-Reply-To: <c8dc0612-7ba2-45f0-9aa9-5e312fc8aab4@intel.com>
References: <20261103093501.218232-1-paul.cercueil@bootlin.com>
	 <c8dc0612-7ba2-45f0-9aa9-5e312fc8aab4@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

Hi Adrian,

Le mercredi 04 novembre 2026 =C3=A0 16:30 +0200, Adrian Hunter a =C3=A9crit=
=C2=A0:
> On 03/11/2026 11:35, Paul Cercueil wrote:
> > Use the device property API instead of the OF-specific property API.
> > This way, the driver will also probe from ACPI.
> >=20
> > Note the change in the core's probe function for SD6HC. We can't have
> > named clocks in ACPI.
>=20
> Do you mean in the future?=C2=A0 ACPI does not provide clocks at all
> at the moment does it?=C2=A0 Otherwise, clocks registered directly by
> clk_register_clkdev() can have names.=C2=A0 Maybe I misunderstand,
> but perhaps clarify the commit message.

I sent another patch in parallel of this one, that adds basic support for c=
lock
resources introduced in ACPI 6.5:

https://lore.kernel.org/linux-acpi/20261103084718.8222-1-paul.cercueil@boot=
lin.com/T/#u

> >=20
> > Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>
>=20
> Nevertheless:
>=20
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thank you!

Cheers,
-Paul

> > ---
> > =C2=A0drivers/mmc/host/sdhci-cadence-core.c=C2=A0=C2=A0 | 22 ++++++++++=
++----------
> > =C2=A0drivers/mmc/host/sdhci-cadence-phy-v6.c | 10 +++++-----
> > =C2=A02 files changed, 17 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/drivers/mmc/host/sdhci-cadence-core.c b/drivers/mmc/host/s=
dhci-
> > cadence-core.c
> > index 745455743b01..c5a4fa8e2fc6 100644
> > --- a/drivers/mmc/host/sdhci-cadence-core.c
> > +++ b/drivers/mmc/host/sdhci-cadence-core.c
> > @@ -5,6 +5,7 @@
> > =C2=A0 * Copyright (C) 2026 Altera Corporation
> > =C2=A0 */
> > =C2=A0
> > +#include <linux/acpi.h>
> > =C2=A0#include <linux/bitfield.h>
> > =C2=A0#include <linux/bits.h>
> > =C2=A0#include <linux/dma-mapping.h>
> > @@ -145,26 +146,26 @@ static int sdhci_cdns4_write_phy_reg(struct
> > sdhci_cdns_priv *priv, u8 addr, u8 d
> > =C2=A0	return ret;
> > =C2=A0}
> > =C2=A0
> > -static unsigned int sdhci_cdns4_phy_param_count(struct device_node *np=
)
> > +static unsigned int sdhci_cdns4_phy_param_count(struct device *dev)
> > =C2=A0{
> > =C2=A0	unsigned int count =3D 0;
> > =C2=A0	int i;
> > =C2=A0
> > =C2=A0	for (i =3D 0; i < ARRAY_SIZE(sdhci_cdns4_phy_cfgs); i++)
> > -		if (of_property_present(np,
> > sdhci_cdns4_phy_cfgs[i].property))
> > +		if (device_property_present(dev,
> > sdhci_cdns4_phy_cfgs[i].property))
> > =C2=A0			count++;
> > =C2=A0
> > =C2=A0	return count;
> > =C2=A0}
> > =C2=A0
> > -static void sdhci_cdns4_phy_param_parse(struct device_node *np, struct
> > sdhci_cdns4_phy *phy)
> > +static void sdhci_cdns4_phy_param_parse(struct device *dev, struct
> > sdhci_cdns4_phy *phy)
> > =C2=A0{
> > =C2=A0	struct sdhci_cdns4_phy_param *p =3D phy->phy_params;
> > =C2=A0	u32 val;
> > =C2=A0	int ret, i;
> > =C2=A0
> > =C2=A0	for (i =3D 0; i < ARRAY_SIZE(sdhci_cdns4_phy_cfgs); i++) {
> > -		ret =3D of_property_read_u32(np,
> > sdhci_cdns4_phy_cfgs[i].property, &val);
> > +		ret =3D device_property_read_u32(dev,
> > sdhci_cdns4_phy_cfgs[i].property, &val);
> > =C2=A0		if (ret)
> > =C2=A0			continue;
> > =C2=A0
> > @@ -204,7 +205,7 @@ static int sdhci_cdns_set_dma_mask(struct sdhci_hos=
t
> > *host)
> > =C2=A0	struct device *dev =3D mmc_dev(host->mmc);
> > =C2=A0	int ret;
> > =C2=A0
> > -	data =3D of_device_get_match_data(dev);
> > +	data =3D device_get_match_data(dev);
> > =C2=A0	if (!data || !data->dma_mask)
> > =C2=A0		return 0;
> > =C2=A0
> > @@ -649,13 +650,13 @@ static int sdhci_cdns4_phy_probe(struct
> > platform_device *pdev, struct sdhci_cdns
> > =C2=A0	struct sdhci_cdns4_phy *phy;
> > =C2=A0	unsigned int nr_phy_params;
> > =C2=A0
> > -	nr_phy_params =3D sdhci_cdns4_phy_param_count(dev->of_node);
> > +	nr_phy_params =3D sdhci_cdns4_phy_param_count(dev);
> > =C2=A0	phy =3D devm_kzalloc(dev, struct_size(phy, phy_params,
> > nr_phy_params), GFP_KERNEL);
> > =C2=A0	if (!phy)
> > =C2=A0		return -ENOMEM;
> > =C2=A0
> > =C2=A0	phy->nr_phy_params =3D nr_phy_params;
> > -	sdhci_cdns4_phy_param_parse(dev->of_node, phy);
> > +	sdhci_cdns4_phy_param_parse(dev, phy);
> > =C2=A0	priv->phy =3D phy;
> > =C2=A0
> > =C2=A0	return sdhci_cdns4_phy_init(priv);
> > @@ -673,7 +674,8 @@ static int sdhci_cdns_probe(struct platform_device
> > *pdev)
> > =C2=A0	struct device *dev =3D &pdev->dev;
> > =C2=A0	static const u16 version =3D SDHCI_SPEC_400 << SDHCI_SPEC_VER_SH=
IFT;
> > =C2=A0
> > -	if (of_device_is_compatible(dev->of_node, "cdns,sd6hc")) {
> > +	/* Note: ACPI only provides one unnamed clock */
> > +	if (!has_acpi_companion(dev) && device_is_compatible(dev,
> > "cdns,sd6hc")) {
> > =C2=A0		clk =3D devm_clk_get_enabled(dev, "ciu");
> > =C2=A0		if (IS_ERR(clk))
> > =C2=A0			return dev_err_probe(dev, PTR_ERR(clk), "failed to
> > enable ciu clock\n");
> > @@ -687,7 +689,7 @@ static int sdhci_cdns_probe(struct platform_device
> > *pdev)
> > =C2=A0			return PTR_ERR(clk);
> > =C2=A0	}
> > =C2=A0
> > -	data =3D of_device_get_match_data(dev);
> > +	data =3D device_get_match_data(dev);
> > =C2=A0	if (!data)
> > =C2=A0		return dev_err_probe(dev, -EINVAL, "missing platform driver
> > data\n");
> > =C2=A0
> > @@ -723,7 +725,7 @@ static int sdhci_cdns_probe(struct platform_device
> > *pdev)
> > =C2=A0	 * For SD6HC, sdhci_add_host() will automatically read capabilit=
ies
> > =C2=A0	 * and version from the host controller registers.
> > =C2=A0	 */
> > -	if (of_device_is_compatible(dev->of_node, "cdns,sd4hc")) {
> > +	if (device_is_compatible(dev, "cdns,sd4hc")) {
> > =C2=A0		__sdhci_read_caps(host, &version, NULL, NULL);
> > =C2=A0		ret =3D sdhci_cdns4_phy_probe(pdev, priv);
> > =C2=A0		if (ret)
> > diff --git a/drivers/mmc/host/sdhci-cadence-phy-v6.c
> > b/drivers/mmc/host/sdhci-cadence-phy-v6.c
> > index 22d56bb46d75..551a0e3b58ad 100644
> > --- a/drivers/mmc/host/sdhci-cadence-phy-v6.c
> > +++ b/drivers/mmc/host/sdhci-cadence-phy-v6.c
> > @@ -880,17 +880,17 @@ int sdhci_cdns6_phy_probe(struct platform_device
> > *pdev, struct sdhci_cdns_priv *
> > =C2=A0	 * Cadence-recommended defaults (2500 ps IO-cell delays, 24 ps D=
LL
> > =C2=A0	 * delay element) that are valid for typical SoC packaging.
> > =C2=A0	 */
> > -	ret =3D of_property_read_u32(dev->of_node, "cdns,iocell-input-delay-
> > ps",
> > -				=C2=A0=C2=A0 &phy->iocell_input_delay);
> > +	ret =3D device_property_read_u32(dev, "cdns,iocell-input-delay-ps",
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &phy->iocell_input_delay);
> > =C2=A0	if (ret)
> > =C2=A0		phy->iocell_input_delay =3D
> > SDHCI_CDNS6_PHY_DEFAULT_IOCELL_DELAY;
> > =C2=A0
> > -	ret =3D of_property_read_u32(dev->of_node, "cdns,iocell-output-delay-
> > ps",
> > -				=C2=A0=C2=A0 &phy->iocell_output_delay);
> > +	ret =3D device_property_read_u32(dev, "cdns,iocell-output-delay-ps",
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &phy->iocell_output_delay);
> > =C2=A0	if (ret)
> > =C2=A0		phy->iocell_output_delay =3D
> > SDHCI_CDNS6_PHY_DEFAULT_IOCELL_DELAY;
> > =C2=A0
> > -	ret =3D of_property_read_u32(dev->of_node, "cdns,delay-element-ps",
> > &phy->delay_element);
> > +	ret =3D device_property_read_u32(dev, "cdns,delay-element-ps", &phy-
> > >delay_element);
> > =C2=A0	if (ret) {
> > =C2=A0		phy->delay_element =3D SDHCI_CDNS6_PHY_DEFAULT_DELAY_ELEMENT;
> > =C2=A0	} else if (!phy->delay_element) {
