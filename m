From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] omap-hsmmc: Implementation of i761 errata
Date: Mon, 20 Aug 2012 11:58:43 +0300
Message-ID: <20120820085842.GK17455@arwen.pp.htv.fi>
References: <1345219546-6646-1-git-send-email-semen.protsenko@ti.com>
 <CANfBPZ9NqZGN1LPNu+5DVWdkut2AL3O_8TWtWhBTufpdRZYZ_Q@mail.gmail.com>
 <CANwLT1SADwqn2Hgj2etiYyRu=TboT8DOfBsqjg02rrk6CYcFTw@mail.gmail.com>
 <CANfBPZ9iAuMmwGC_QuhM9k4MyAt4mgAYVSG3K3uMq=mOH_dewg@mail.gmail.com>
 <CAMQu2gzc4o_fYGk8Jgtd5tf89xh1N2e4DhN8MKE_Zm=eg_e1=Q@mail.gmail.com>
 <CAM=Q2cs+oX6pYe=ME9At49QXfzJjsMjy0g0YidFD5F7JNBVYzQ@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KaGhPsiNaI6/sRd6"
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAM=Q2cs+oX6pYe=ME9At49QXfzJjsMjy0g0YidFD5F7JNBVYzQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Puttagunta, Viswanath" <vishp@ti.com>, Semen Protsenko <semen.protsenko@ti.com>, linux-omap@vger.kernel.org, Volodymyr Ryazantsev <x0153367@ti.com>, Balaji T Krishnamoorthy <balajitk@ti.com>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, "S, Venkatraman" <svenkatr@ti.com>
List-Id: linux-mmc@vger.kernel.org


--KaGhPsiNaI6/sRd6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 20, 2012 at 02:30:01PM +0530, Shubhrajyoti Datta wrote:
> On Mon, Aug 20, 2012 at 12:25 PM, Shilimkar, Santosh
> <santosh.shilimkar@ti.com> wrote:
> > On Mon, Aug 20, 2012 at 12:08 PM, S, Venkatraman <svenkatr@ti.com> wrot=
e:
> >>
> >> On Fri, Aug 17, 2012 at 11:43 PM, Puttagunta, Viswanath <vishp@ti.com>
> >> wrote:
> [...]
> >> >>> Signed-off-by: Semen Protsenko <semen.protsenko@ti.com>
> >> >>
> >> >> The implementation looks fine, but can we simply not set the errata
> >> >> flag and make this as default
> >> >> behaviour ? I suppose the documented behaviour with CSRE and RSP10 =
is
> >> >> independent of the
> >> >> errata..
> >> >>
> >> >> Also, please send it to the linux-mmc list as well.
> >> >
> >> > Vish>> We don't know if this errata effects OMAP5 as well. So, I thi=
nk
> >> > we should only do this if we are OMAP4.
> >> >
> >> That's precisely why the code shouldn't check for cpu_() flags. There =
are
> >> other
> >> OMAP variants as well and we can't check all of them
> >> What I mean is to make the check for RSP10 and CSRE all the time as pa=
rt
> >> of the IRQ check.
> >>   Then it equally applies to silcon with or without errata.
> >
> > Apart from above comment, please don't add the cpu_is_xxx() check inside
> > device driver. You can pass that information from platform code
> > while registering the MMC controllers using a flag and then just
> > use that flag to enable/disable errata in the driver.
>=20
> The other option is to check something like MMCHS_HL_REV to get the ip re=
vision
> and decide.

If the revision register is broken, please don't pass a flag. Use
different compatible attributes and/or platform_device_id structures to
make sure you can differentiate the versions on the driver itself
without any needs to use cpu_is_* or pass flags.

--=20
balbi

--KaGhPsiNaI6/sRd6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQMfxCAAoJEIaOsuA1yqREq5kP+QE+6UYoZxcrIEnJoI1g/XQG
8Co+qZCPqKlpKYxa/v6y+L+JKWl1EqBNH5TTzGIYaqrx96sfGkq3gs9uXaJgV7bZ
QdRknsNy9ZOK605xFJ3iyfKr2F8fzgqW+KVvOdV0s1j3Ggeyle48m9T2Edjr2t1s
LL0aTmeU07C/KVrWZgyu4VoHjBGdzoQaR9IdJEDAlxBsEVhX7NaAIy0zNpnJ5hhF
qnboDViEShl3K/iRppwKspXiLst4B+I0qTLFT2eNDQ1N3ODD4uySqdikmTeedHJ+
Ow2HYqlIZm1fXczYqKnsQMASKwTc6qkMAMT97QdO1lY4YTp6O9V6kWsZ/cEXCMNN
YqerV1fXJq5w5mJmpKKPfxwPZCcpSZzuVKCPwpLzJwswp+jgTBePuYmL7VnMING2
thV4t2++BPE/jrRnJYum2Dtkxdzf7EEzPVkx3pg2FLAG/52XzFl21qGGdMM1rOdw
h5i8yY2/UKwovxhzAdkQw6o60I07V9YHooSmF9xQgNZSZdJCEoZTXqMbsSgJAefL
F4UCwMygBMoPN/1Z+fo7yH4pex5XqrxXmi5Y0nUL6fxvtwtyHpDNG7FWtDn11hm4
K7SFC6kZbO69dOVdX4CNuZOCxHpMj7qM2cB7sX2bBRBWVSkYEbcKUEK6LnNTUbgQ
IxhT7wcpXi6vtRJaPUix
=w2xo
-----END PGP SIGNATURE-----

--KaGhPsiNaI6/sRd6--
