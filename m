Return-Path: <SRS0=VpFb=4X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40510C3F2D6
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 12:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232992166E
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 12:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgCFMlT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Mar 2020 07:41:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:49620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbgCFMlT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 6 Mar 2020 07:41:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CB939AF4E;
        Fri,  6 Mar 2020 12:41:16 +0000 (UTC)
Message-ID: <444a97c46126bb86ca37da9bf26a840c38176bbe.camel@suse.de>
Subject: Re: [PATCH 01/10] mmc: sdhci: Add quirk SDHCI_QUIRK2_SET_BUS_VOLTAGE
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, f.fainelli@gmail.com, phil@raspberrypi.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 06 Mar 2020 13:40:54 +0100
In-Reply-To: <55ef25ae-5c73-7778-dfda-976809cf9fe6@intel.com>
References: <20200306103857.23962-1-nsaenzjulienne@suse.de>
         <20200306103857.23962-2-nsaenzjulienne@suse.de>
         <55ef25ae-5c73-7778-dfda-976809cf9fe6@intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-1lAvgayd9GrTsqnjjrF7"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--=-1lAvgayd9GrTsqnjjrF7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-03-06 at 14:34 +0200, Adrian Hunter wrote:
> On 6/03/20 12:38 pm, Nicolas Saenz Julienne wrote:
> > Adds quirk for controllers whose bus power select register has to be se=
t
> > even when powering SD cards from a regulator.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >  drivers/mmc/host/sdhci.c | 5 +++++
> >  drivers/mmc/host/sdhci.h | 2 ++
> >  2 files changed, 7 insertions(+)
> >=20
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index c59566363a42..c7fd87447457 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -1920,6 +1920,11 @@ static void sdhci_set_power_reg(struct sdhci_hos=
t
> > *host, unsigned char mode,
> > =20
> >  	mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> > =20
> > +	if (host->quirks2 & SDHCI_QUIRK2_SET_BUS_VOLTAGE) {
>=20
> We don't really want to replace callbacks by quirks.
>=20
> Replace sdhci_milbeaut_set_power() etc by a common fn in sdhci.c if you w=
ant.

Ok, fair enough.

Regards,
Nicolas

>=20
> > +		sdhci_set_power_noreg(host, mode, vdd);
> > +		return;
> > +	}
> > +
> >  	if (mode !=3D MMC_POWER_OFF)
> >  		sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL);
> >  	else
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index cac2d97782e6..9531a4e5b148 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -484,6 +484,8 @@ struct sdhci_host {
> >   * block count.
> >   */
> >  #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
> > +/* Set bus voltage even when powering from an external regulator */
> > +#define SDHCI_QUIRK2_SET_BUS_VOLTAGE			(1<<19)
> > =20
> >  	int irq;		/* Device IRQ */
> >  	void __iomem *ioaddr;	/* Mapped address */
> >=20


--=-1lAvgayd9GrTsqnjjrF7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5iRNYACgkQlfZmHno8
x/5h5Af8C26SwoE7s5IkeLA0S3BV9MJtqzvOsBo2x+myRwpvvktRc+f2sVpkjQT/
lIpr4k4mxiaDiTaxmtYRIgXCtz4Hq9T6kfJXwVcnQeAVu3z9BAYqUVqsWG2uGQra
j/mdMmNvuvJQsMds327CuCGyg/FTp0rFueCELZrMzTTO60chert7/bE85LZbeErF
+xmR9+1JvMBTGx818rp3/SA95S9VlPf9z3dRqpKIvmSkSMom23GoGYa1/NFVzyi3
q36vAQ7D074JsmbG0D3L7W8B1Bo6yvKihw0tnVzsy1MS5w1sIF6YZac3tpnxuFgt
lSgKWktx6E+gN1k/1uujvRqyJ3MsOw==
=jDxC
-----END PGP SIGNATURE-----

--=-1lAvgayd9GrTsqnjjrF7--

