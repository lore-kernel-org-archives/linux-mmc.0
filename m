From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ARM: dts: exynos: Fix invalid maximum voltage for buck9
 supplying SD card
Date: Thu, 24 Mar 2016 11:02:40 +0000
Message-ID: <20160324110240.GU2566@sirena.org.uk>
References: <1458807125-13580-1-git-send-email-k.kozlowski@samsung.com>
 <20160324095332.GS2566@sirena.org.uk>
 <CAJKOXPc03ksVFKAHo_Znw41wdzRmzJpFYfAEw2q3EfrQxevghg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+EMqLL+3vmTi4N6E"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJKOXPc03ksVFKAHo_Znw41wdzRmzJpFYfAEw2q3EfrQxevghg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-mmc@vger.kernel.org


--+EMqLL+3vmTi4N6E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 24, 2016 at 07:25:35PM +0900, Krzysztof Kozlowski wrote:

> I'll look at it after weekend. For now I applied my patch to the
> for-next, so the next should be fixed.

Oh, and please send this to Linus - the regulator change is fixing a
problem some other boards noticed.

--+EMqLL+3vmTi4N6E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW88lPAAoJECTWi3JdVIfQo5YH/jqaxGNXXdpAhEUPoQonAuhf
V41C/dB3jaayLAv6l3t+9jsUYjFEPfRXkZyl6UQiuVfvR/HL4RrrTJidCaV5IdRU
x/Qp6iU+PSJVWvnCvjVK/gpuTOoizOpQuqBYzW2cUw/Kn8n6StWsi3dMmqZIfcMj
DUFusbKmLgD927oDTFx2gDv/FMsRnLQRLHQcyJlic5ajSRid5A30mKIEvKaAOvtU
dF5CeD2cxcYm7dxkbqgqq/OWr6/ZCC/HGWiDsi6fFZMGQpm6/up1hxLLkzbEPCak
H6roemh2j26YiEKDK+X+uU7WYlEE7SMQY7Ehi8hnQzpXBu59wi0tVfYMX+k7Oas=
=Bmkr
-----END PGP SIGNATURE-----

--+EMqLL+3vmTi4N6E--
