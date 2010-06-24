From: Rabin VINCENT <rabin.vincent@stericsson.com>
Subject: Re: [PATCH 07/12] mmci: pass power_mode to the translate_vdd
 callback
Date: Thu, 24 Jun 2010 13:57:47 +0530
Message-ID: <20100624082746.GA12453@bnru01.bnr.st.com>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
 <1277198267-10860-7-git-send-email-rabin.vincent@stericsson.com>
 <AANLkTil2Cb4alVFkfEjXApMgIdkmNvEEarWkT9AhXIdU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:41321 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751102Ab0FXI2C (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Jun 2010 04:28:02 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTil2Cb4alVFkfEjXApMgIdkmNvEEarWkT9AhXIdU@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>

On Wed, Jun 23, 2010 at 00:03:47 +0200, Linus Walleij wrote:
> 2010/6/22 Rabin Vincent <rabin.vincent@stericsson.com>:
> > @@ -17,7 +17,8 @@
> > =A0* mmc/host.h
> > =A0* @translate_vdd: a callback function to translate a MMC_VDD_*
> > =A0* mask into a value to be binary or:ed and written into the
> > - * MMCIPWR register of the block
> > + * MMCIPWR register of the block. =A0May also control external pow=
er
> > + * based on the power_mode.
>=20
> Actually this callback is named like that for a reason: it is to be u=
sed
> to translate the MMC_VDD_* into a u8:4 bitmask for the MMCIPWR
> register, 4 bits possibly routed out of the PL180 block on some
> designs (never seen in practice, but could be used in theory).
>=20
> So it translates a voltage into a 4-bit bitmask, hence the name.
>=20
> Now the semantics are altered to have other side-effects in
> the platform, so the function should be renamed, something like
> platform_vdd_handler() would be more appropriate.
>=20

This is already inside platform data, so how about just ->vdd_handler()=
?
Or ->set_power(), like some other drivers?

Note that we'd also like to use this to do the board-specific settings
for the *DIREN and FBCLK bits, which replace the Voltage bits on some S=
T
variants, like so:

+static u32 mop500_sdi0_translate_vdd(struct device *dev, unsigned int =
vdd,
+				     unsigned char power_mode)
+{
+	if (power_mode =3D=3D MMC_POWER_UP)
+		gpio_set_value(gpio_sdmmc_en, 1);
+	else if (power_mode =3D=3D MMC_POWER_OFF)
+		gpio_set_value(gpio_sdmmc_en, 0);
+
+	return MCI_FBCLKEN | MCI_CMDDIREN | MCI_DATA0DIREN |
+	       MCI_DATA2DIREN | MCI_DATA31DIREN;
+}

Rabin
