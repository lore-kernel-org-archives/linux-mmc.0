Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF5583CAE;
	Mon,  3 Jun 2024 12:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717418423; cv=none; b=QeJCa4o/0G6qJ9YuO66y7xCyG8CZQKLBM3W3Klm7wSEod9l6BWtwgY+uErKLDnESyZhvOfXyVFanELHrux9dIWEGsEw1kdiaVoMsUK0GpnDZ5a71ibNHQK0bYgrQA/aZWEiof2tCh+CK1u80d2lZMlx6U7SvZO3frhCVXssli4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717418423; c=relaxed/simple;
	bh=Z1LbbjT1HTuXOORfAk5bbAHP08+Y9Osfj2fJ39uD5Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ru5ZxGa/xR3naHkzrmwTzWvKYX8rFujVQPBkjHPGo608QSIvJxEzi1aVO2ALCWzArx2I7nTDFLkEoq7wXzqOVRelg3Uqs2t07MTZiekRlvPHGwh2op1MIwxkcrMl0uPMXyJZDPoXyJNh61P2VoIQj3nnlUb9vaFN35oo9XQWeRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [213.70.33.226] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sE6z0-0007IM-MA; Mon, 03 Jun 2024 14:40:14 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: ulf.hansson@linaro.org, Adrian Hunter <adrian.hunter@intel.com>
Cc: serghox@gmail.com, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, quentin.schulz@cherry.de,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Subject:
 Re: [PATCH] mmc: sdhci-of-dwcmshc: don't enable CQE without a suitable irq
 handler
Date: Mon, 03 Jun 2024 14:40:13 +0200
Message-ID: <6504160.iIbC2pHGDl@phil>
In-Reply-To: <24c34023-e6c1-471a-ad0e-ee229cba8b3c@intel.com>
References:
 <20240530215532.2192423-1-heiko@sntech.de> <4015176.ZaRXLXkqSa@diego>
 <24c34023-e6c1-471a-ad0e-ee229cba8b3c@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Montag, 3. Juni 2024, 13:49:34 CEST schrieb Adrian Hunter:
> On 3/06/24 14:26, Heiko St=FCbner wrote:
> > Am Montag, 3. Juni 2024, 10:01:23 CEST schrieb Adrian Hunter:
> >> On 31/05/24 00:55, Heiko Stuebner wrote:
> >>> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> >>>
> >>> supports-cqe is an established dt property so can appear in devicetre=
es
> >>> at any time. CQE support in the sdhci-of-dwcmshc driver does require a
> >>> special irq handler in the platform-specific ops, to handle the CQE
> >>> interrupt.
> >>>
> >>> Without this special handler we end up with a spew of unhandled inter=
rupt
> >>> messages on devices with supports-cqe property but without irq handle=
r:
> >>>
> >>> [   11.624143] mmc0: Unexpected interrupt 0x00004000.
> >>> [   11.629504] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHC=
I REGISTER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> [   11.636711] mmc0: sdhci: Sys addr:  0x00000008 | Version:  0x00000=
005
> >>> [   11.643919] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000=
000
> >>> [   11.651128] mmc0: sdhci: Argument:  0x00018000 | Trn mode: 0x00000=
033
> >>> [   11.658336] mmc0: sdhci: Present:   0x13f700f0 | Host ctl: 0x00000=
034
> >>> [   11.665545] mmc0: sdhci: Power:     0x00000001 | Blk gap:  0x00000=
000
> >>> [   11.672753] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000=
407
> >>> [   11.679961] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00004=
000
> >>> [   11.687169] mmc0: sdhci: Int enab:  0x02ff4000 | Sig enab: 0x02ff4=
000
> >>> [   11.694378] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000=
000
> >>> [   11.701586] mmc0: sdhci: Caps:      0x226dc881 | Caps_1:   0x08000=
007
> >>> [   11.708794] mmc0: sdhci: Cmd:       0x00000d1e | Max curr: 0x00000=
000
> >>> [   11.716003] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000=
000
> >>> [   11.723211] mmc0: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x00000=
7cd
> >>> [   11.730419] mmc0: sdhci: Host ctl2: 0x0000000f
> >>> [   11.735392] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xee28f=
008
> >>> [   11.742600] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >>>
> >>> So don't enable CQE if a usable interrupt handler is not defined and =
warn
> >>> instead about this fact.
> >>>
> >>> Fixes: 53ab7f7fe412 ("mmc: sdhci-of-dwcmshc: Implement SDHCI CQE supp=
ort")
> >>> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> >>> ---
> >>> My rk3588-tiger and rk3588-jaguar devicetrees had an accidential
> >>> supports-cqe in their devicetree, which made me run into this problem
> >>> with 6.10-rc1 .
> >>>
> >>>  drivers/mmc/host/sdhci-of-dwcmshc.c | 10 +++++++---
> >>>  1 file changed, 7 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/s=
dhci-of-dwcmshc.c
> >>> index 39edf04fedcf7..4410d4523728d 100644
> >>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> >>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> >>> @@ -1254,10 +1254,14 @@ static int dwcmshc_probe(struct platform_devi=
ce *pdev)
> >>> =20
> >>>  	/* Setup Command Queue Engine if enabled */
> >>>  	if (device_property_read_bool(&pdev->dev, "supports-cqe")) {
> >>> -		priv->vendor_specific_area2 =3D
> >>> -			sdhci_readw(host, DWCMSHC_P_VENDOR_AREA2);
> >>> +		if (pltfm_data && pltfm_data->ops && pltfm_data->ops->irq) {
> >>
> >> ->irq() could be used for other things, so checking it for CQE
> >> support is not appropriate.
> >=20
> > though here we are in the very limited scope of only the dwcmshc sdhci
> > controller.
>=20
> I am afraid that does not justify it.  It can still create
> problems in the future if that very limited scope changes
> i.e. someone wants to use the ->irq() callback in
> sdhci-of-dwcmshc.c for something else.
>=20
> >=20
> > And at this point, any controller using the generic sdhci_dwcmshc_ops
> > will always get the CQE irq handler, while _all other_ controllers
> > will need to define one to handle the CQE irqs.
> >=20
> > So any variant trying to enable CQE needs to define an irq handler, hen=
ce
> > the check simply was meant to not allow CQE enablement without any irq
> > handler, because that will always cause those unhandled irq issues.
> >=20
> >> If necessary, it would be better to flag which variants support
> >> CQE in their platform data.
> >=20
> > I guess we can assume that all of the dwcmshc IP variants support
> > CQE, it's just that the implementation is slightly strange in that
> > a DT can enable CQE support and this will cause the driver to enable the
> > CQE interrupt, even if nothing is there to handle it.
>=20
> Isn't the problem that the IP may support CQE but the driver does
> not for the given variant, but switches it on anyway.

exactly ... that is the problem I have with that accidential "supports-cqe"
in that devicetree.


The sdhci-of-dwmshc has already some
	if (pltfm_data =3D=3D &sdhci_dwcmshc_rk35xx_pdata)
conditionals in its probe function for variant-specific init, so I guess
we could also just move the CQE init into those?

bool supports_cqe =3D false;

if (pltfm_data =3D=3D &sdhci_dwcmshc_pdata)
	supports_cqe =3D true;

if (pltfm_data =3D=3D &sdhci_dwcmshc_rk35xx_pdata)
{
=2E...
	supports_cqe =3D true;
}

Because in the end I would guess once every variant has check it's CQE
support, we'll have all of them supporting it anyway, so that can
handling could than get removed again.


