From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 3/4] MMC/core: Make sure the power is up, when detect
 the card
Date: Fri, 9 Dec 2011 03:16:06 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F1163647E@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1323077026-12071-1-git-send-email-r66093@freescale.com>
	<1323077026-12071-2-git-send-email-r66093@freescale.com>
	<1323077026-12071-3-git-send-email-r66093@freescale.com>
 <CACRpkdZ6FjrjtarzyLe_bmrZ6m6N=j07zaTxCFMuF6AsraKa4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:47535
	"EHLO VA3EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750861Ab1LIDQM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 8 Dec 2011 22:16:12 -0500
In-Reply-To: <CACRpkdZ6FjrjtarzyLe_bmrZ6m6N=j07zaTxCFMuF6AsraKa4Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>



> -----Original Message-----
> From: Linus Walleij [mailto:linus.walleij@linaro.org]
> Sent: Wednesday, December 07, 2011 5:05 PM
> To: Huang Changming-R66093
> Cc: linux-mmc@vger.kernel.org; Huang Changming-R66093
> Subject: Re: [PATCH 3/4] MMC/core: Make sure the power is up, when de=
tect
> the card
>=20
> On Mon, Dec 5, 2011 at 10:23 AM,  <r66093@freescale.com> wrote:
> > From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> >
> > Before running get_cd() recall function to detect whether the card =
is
> > present, must make sure the power is up.
> (...)
> > + =A0 =A0 =A0 mmc_power_up(host);
> > =A0 =A0 =A0 =A0if (host->ops->get_cd && host->ops->get_cd(host) =3D=
=3D 0)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> > + =A0 =A0 =A0 mmc_power_off(host);
>=20
> NAK, I don't get it.
>=20
> mmc_power_up() mmc_power_off() is about powering up/down the *card*.
>=20
> If you need to read a register in your MMC host or so, control power =
and
> clocking of your silicon in the driver itself. You can use runtime PM=
 or
> whatever including explicit clk_enable()/clk_disable() etc.
>=20
> I have a strong feeling that the bug you're trying to fix is in the h=
ost
> controller you're using, not in the MMC core.
>=20

Yes, you are right, the power_up will enable the controller clock, then=
 controller can update state register.
Now I add this code to special platform codes and can detect the card c=
orrectly.

