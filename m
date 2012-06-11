From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 05/29] regulator: use IS_ERR_OR_NULL() instead of
 open-coding
Date: Mon, 11 Jun 2012 20:15:31 +0800
Message-ID: <20120611121528.GO11439@opensource.wolfsonmicro.com>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
 <1336057558-11031-6-git-send-email-g.liakhovetski@gmx.de>
 <20120503153239.GN3955@opensource.wolfsonmicro.com>
 <20120518085749.GE24355@linux-sh.org>
 <20120518150417.GA4039@opensource.wolfsonmicro.com>
 <Pine.LNX.4.64.1206111332310.29799@axis700.grange>
 <20120611115131.GM11439@opensource.wolfsonmicro.com>
 <Pine.LNX.4.64.1206111402250.29799@axis700.grange>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DITGHUV3p5DjDsXt"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1206111402250.29799@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--DITGHUV3p5DjDsXt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2012 at 02:06:29PM +0200, Guennadi Liakhovetski wrote:
> On Mon, 11 Jun 2012, Mark Brown wrote:

> > The stubs return NULL and we could decide in future to use NULL for
> > something else (though that seems unlikely).

> Ah, sure, forgot about that, sorry. In fact, I was wondering, whether it'=
s=20
> indeed a good idea to return success from functions like=20
> regulator_set_voltage() or regulator_get_voltage() when regulator is even=
=20
> not configured? Isn't it confusing for drivers to get a success from=20

Anything that really cares about set_voltage() should have a hard
dependency on the API, it's mainly done so that cpufreq type drivers
can work easily (since they don't *really* care about the voltages
normally, generally if nothing happens in the regulator they're just
less effective).

> set_voltage(voltage > 0) and then get 0V back from get_voltage()?

There's not a use case I can think of for this, though.

--DITGHUV3p5DjDsXt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP1eFVAAoJEBus8iNuMP3dadcP/Rqzm3WCta9ZJ02GzAAQJnf2
wupVw7sgeDWaNaFbauFY2uZlX3HASBw4ETtdc5HYMUJh5sAXOuF2fFmTVpjYY55B
5+lruvz4WVigJSmPnQMnUD3cocpl1gIbp5XtIsCKqss273xws4rmvQhjdB2WAwjl
A41z7qKWxsbAphejMymfs58X26SsM5u3RCgw4Ph9fmnfYLQh5Hme/7pKUDfvvfdu
XcsOwaPMMCoR5fmi1zf/Lx8urHrjfset5MMtTv6+1jPnRD/Rc8MUBq3pMMeHHpQ7
n0g31KiSfwT6TcLDaJnvaSAif+hGd6AFEDLx4Atmx5EEI8VIdx4jlAhghfQfNuPS
kGChO3r0dSNcLrH9T9JkiK2TivL/i6qu1x2oUAkil/w8PRSH8ywQ51ykQSerZ+UO
wy7ihbJMcvIRHjnCF/Z5/nhXiQQk1t/1/Itk6lXelXz2dUhD4fxVLgEccI1eIhAR
OwxIDbldyThOb3oyNZ3l4GIMlS/Ji3zqEaS7jD6yjMR3wVLsJdII/gW0hgUjidwy
ez41m2CZZ2yLrkW9hF5fjbJYRO42/b7Y9u2gGUDLPgYC1A/ePALbTR2l31HDnqHs
E6DdwdDXakXR7qYMR079WNETOv7J5c3a2Dzicr4asI8J112bvQx8LgLcppvTPCmF
5JT/sRBED1DqHfx7MOHd
=DoHB
-----END PGP SIGNATURE-----

--DITGHUV3p5DjDsXt--
