Return-Path: <SRS0=Ofta=42=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4167C10F27
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Mar 2020 10:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E2920828
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Mar 2020 10:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgCIKyD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 Mar 2020 06:54:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:35236 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgCIKyC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 9 Mar 2020 06:54:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ACDF5AB98;
        Mon,  9 Mar 2020 10:54:00 +0000 (UTC)
Message-ID: <06fc4d492f66bfbe7260937efa849f77c7c12b0d.camel@suse.de>
Subject: Re: [PATCH v2 06/11] mmc: sdhci: xenon: Use
 sdhci_set_power_and_voltage()
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, Hu Ziji <huziji@marvell.com>
Cc:     phil@raspberrypi.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, f.fainelli@gmail.com,
        stefan.wahren@i2se.com, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 09 Mar 2020 11:53:41 +0100
In-Reply-To: <4e74203a-5444-2b7a-3555-9615cc45aaae@intel.com>
References: <20200306174413.20634-1-nsaenzjulienne@suse.de>
         <20200306174413.20634-7-nsaenzjulienne@suse.de>
         <4e74203a-5444-2b7a-3555-9615cc45aaae@intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-mdVi4mtxniNUptONkINn"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--=-mdVi4mtxniNUptONkINn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-03-09 at 09:20 +0200, Adrian Hunter wrote:
> > -static void xenon_set_power(struct sdhci_host *host, unsigned char mod=
e,
> > -		unsigned short vdd)
> > -{
> > -	struct mmc_host *mmc =3D host->mmc;
> > -	u8 pwr =3D host->pwr;
> > -
> > -	sdhci_set_power_noreg(host, mode, vdd);
> > -
> > -	if (host->pwr =3D=3D pwr)
> > -		return;
> > -
> > -	if (host->pwr =3D=3D 0)
> > -		vdd =3D 0;
> > -
> > -	if (!IS_ERR(mmc->supply.vmmc))
> > -		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> > -}
>=20
> This code is different.  The commit message should explain why it is
> equivalent.  Has it been tested?

Yes, I should've pointed it out. The rationale behind including sdhci-xenon=
 and
sdhci-pxav3 is based on xenon's original commit message (99c14fc360dbb):

	mmc: sdhci-xenon: add set_power callback

	Xenon sdh controller requests proper SD bus voltage select
	bits programmed even with vmmc power supply. Any reserved
	value(100b-000b) programmed in this field will lead to controller
	ignore SD bus power bit and keep its value at zero.
	Add set_power callback to handle this.

I can't test it, but it felt to me as the implementation differences are on=
ly
there as different people wrote the code. Ultimately, I'll be happy to drop
them from the series if you feel it's too much of an assumption, I can see =
how
the controllers could react badly to the ordering change. If not I can send=
 a
v3 with fixed commit messages.

Regards,
Nicolas


--=-mdVi4mtxniNUptONkINn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5mIDUACgkQlfZmHno8
x/6ODgf+Pponrv6iI47IZ59PPxtKoH5eODnYoNBo1XTafZnldylaThHuhHpQoegD
bN7jdMI4sRgisibZglsVds4Qq7aQU3H6kNaKp3ynBQLkuJ0T8DDKEueq3MGMZb53
OJvTL+TE6+0jBBMF1H5XUAE5ThyfwkWauF7//uar/8O2EGg1e/ZiTUaZxqN/sK2d
kUBqSlPE8MxlGMP6d0ZuJ9zy3S/RJ5rZ6/Wc4YL+pI47HiRFACmPmxBqWJLpmEaB
mMmc6W84DEg2WB0uDzBQQsDQ8FgHwQBTGIFVmEA5GeSSUbCR0Vv69yyVUb4hGQAx
r9eTbtY5CY3pdMCPz3oYD88aGd5PhQ==
=BUHF
-----END PGP SIGNATURE-----

--=-mdVi4mtxniNUptONkINn--

