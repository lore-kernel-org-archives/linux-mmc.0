From: Felipe Balbi <balbi@ti.com>
Subject: Re: Regression for non-eMMC cards with commit fa550189?
Date: Tue, 29 May 2012 10:40:48 +0300
Message-ID: <20120529074047.GE16340@arwen.pp.htv.fi>
References: <20120528132147.GC12766@atomide.com>
 <CAPDyKFrcviT3_Fz13LpFJ+1oKxQ5LKswN7EmzVcWTJkiiDWusA@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5xSkJheCpeK0RUEJ"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:34716 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751225Ab2E2HmZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 May 2012 03:42:25 -0400
Received: by lags15 with SMTP id s15so3224089lag.34
        for <linux-mmc@vger.kernel.org>; Tue, 29 May 2012 00:42:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPDyKFrcviT3_Fz13LpFJ+1oKxQ5LKswN7EmzVcWTJkiiDWusA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--5xSkJheCpeK0RUEJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 29, 2012 at 02:52:34PM +0800, Ulf Hansson wrote:
> Hi Tony,
>=20
> This patch changes the sequence of how the host drivers set_ios
> function gets called during probe.
>=20
> Before:
> 1. mmc_power_off
> 2. mmc_power_up
>=20
> Now:
> 1. mmc_power_up
>=20
> My guess is then; the omap driver set_ios function requires that
> mmc_power_off is called before a mmc_power_up.
> Hopefully this requirement can be removed and fixed in the host driver so=
mehow.
>=20
> Please get back to me if you need some more assistance around this matter.
>=20
> Kind regards
> Ulf Hansson
>=20
>=20
> On 28 May 2012 21:21, Tony Lindgren <tony@atomide.com> wrote:
> > Hi Ulf & Chris,
> >
> > Looks like commit fa550189 (mmc: core: Prevent eMMC VCC supply to be
> > cut from late init) causes MMC card to stop working at least with
> > n8x0 using drivers/mmc/host/omap.c. The card(s) on it are not eMMC.
> >
> > Reverting fa550189 makes things work again. Any ideas what could
> > be causing this?
> >
> > No debug output from MMC_DEBUG, looks like commands won't even
> > get started?

Can you enable debugging on menelaus so we see what the driver is doing ?

I believe that to change the VMMC's supply voltage you need to turn off
the regulator, meaning LDO_CTRL7[1:0] =3D 0b00.

That could be one thing. It would be cool what menelaus is writing to
the registers on working and failing case. Also what are the contents of
LDO_CTRL1 and LDO_CTRL7 before any operation. Something like this will
help:

diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
index cb4910a..8cab234 100644
--- a/drivers/mfd/menelaus.c
+++ b/drivers/mfd/menelaus.c
@@ -31,6 +31,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
=20
+#define DEBUG
+
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
@@ -469,6 +471,10 @@ static int menelaus_set_voltage(const struct menelaus_=
vtg *vtg, int mV,
 	if (vtg =3D=3D 0)
 		goto set_voltage;
=20
+	dev_dbg(&c->dev, "VTG_REG %02x MODE_REG %02x\n",
+			menelaus_read_reg(vtg->vtg_reg),
+			menelaus_read_reg(mode_reg));
+
 	ret =3D menelaus_read_reg(vtg->vtg_reg);
 	if (ret < 0)
 		goto out;

--=20
balbi

--5xSkJheCpeK0RUEJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPxH1/AAoJEIaOsuA1yqREGD8P/iuRiLEYkBO0wpZ8V0cZ+5xX
SDdbhzcneYFncJuj334KzLyuBRUaCMMcBycR0w6P/NUtlAwP5BWAI99h0mSH8zBR
jaQcZjC6Mh9e3ICWSMAjASf1L+lu6C+BJj3gSxNH1N/h3eSaShMctAl+NKOG/r6v
7rYgrGseILVs5WAJz65NHXWGHDnQA/N0hjWL0evRdOOu15T3ZAXGKEViND7cpens
c4Sj1+MG/MEsz0DStEeQAh9F8KsTPck5b76N32K7LmnqSATvAuZnRDu0KSn3LLZG
3EAqWsnqrOHatPRuKhPl0gkcvC7m2JMKG2dtav2/9eZ7+tbrtaDJWUPzAiGqPWbs
Ve8/Ceo+sqL3ckhLfKd4c6SM+xQFjLqqpSBOjED/obDYg5owrz+hywiCVPCgUVy8
xr9UMpcGFLmfzlYHqOOjILzcd0c7ElPJJ6mf4fX2bYpKK6UPpdiuj0YnfWCAyIlB
3s0QVKw/sn7YdDnMukm6xYHgYoRADLJRqbIDDWv0Fkx4DTITeG/HLkbtFWQF6z8P
sQhjktfk2Q/zZTE/4CmOpKUPRnN2LmMjfDkAY8jlP+7HTQ4C2EJiqXwNlcI/xg89
Yid9jBy+dDuP/n8/+ZMuQbFsdlxxm7AQ/3nRPHXsdsQFf4zf4MttwxRMMpDMijK1
rL90eJnHuQOxCds0Vzx9
=jepE
-----END PGP SIGNATURE-----

--5xSkJheCpeK0RUEJ--
