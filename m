Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9635548552;
	Tue,  8 Sep 2026 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881688; cv=none; b=BiHv4jP8tqQqeWluC3FVIS5wdSnEiDMas2rV9C+QFVXLHHs6ODKAlvNmypDgzf8m1+ggGIDNtFZ20ZJOfi8j9LzFehM4ZtAk+K/emXk1bWxGq5L5ES1FS2TTqBg7KB2RR+su9AZEHdlJ0s45R1dTWEzYaDTVtQ2whqRSlUr0ph0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881688; c=relaxed/simple;
	bh=2xdZ+I35O5wMzCJuFztU21SdXhO0KTe6CqKTPCSHmFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/9AVwprOejM4oE3Ve1X+534Z+PfR9S8Kwjs1ikES1eC86BJnfA5sprLc50XJZt1yMVNjRZB0xQ/Nylj/q2XgU7UCRanA1N0VJlPV0kBMJmXZ6ZGjeLvr2YlQHXjZiIjfp1V2kf6JRpLr5KTMu64wgMY8sHY9L7ej/641J7/dfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBCoJrEg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBCoJrEg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654811F00A3A;
	Tue,  8 Sep 2026 15:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788881679;
	bh=2xdZ+I35O5wMzCJuFztU21SdXhO0KTe6CqKTPCSHmFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OBCoJrEgKyTIogjTC/andPa6J0fJ1vFRHhoBRsIEo6UKgKKpa/UE9KjPF+prT18B6
	 +WU/mwHOifa5Vb3wnHcP1QKhgfPzJTG3QFZn3oU1n8nTn09O4NY9KcMRLwd72CLBOq
	 WcC+5KRMiI+BLF0jeV0TNM6ukmdxL1YkiDt0ykTh4FzcPaBpInMJuRzL56Y7YyPrBk
	 9CjpQGx2c0/yHP+IEP+94P46/Og36DHw9BvOpAcA40cfSStyY3HAwEDtUGKRnsduzU
	 tSv50jVo+Ac7sXDU/zwy9lKX1QZUxOczMJvb42m3GZ1+Ja6tAkwTz9Q3vkVDJsWNyx
	 1PBqPdZbzC2gg==
Date: Tue, 8 Sep 2026 16:34:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Linus Walleij <linusw@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Drew Fustini <fustini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Vladimir Zapolskiy <vz@mleia.com>, Stefan Agner <stefan@agner.ch>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Kristoffer Ericson <kristoffer.ericson@gmail.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-omap@vger.kernel.org, Alexander Clouter <alex@digriz.org.uk>,
	"Jeremy J. Peper" <jeremy@jeremypeper.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	linux-ide@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 05/13] ARM: orion/dove/mv78xx0: remove all board files
Message-ID: <c38b1d3e-fcb7-419d-b62d-200eb552df52@sirena.org.uk>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-6-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Io5kq1JWW/hrTr1x"
Content-Disposition: inline
In-Reply-To: <20260908152808.3928630-6-arnd@kernel.org>
X-Cookie: The world is not octal despite DEC.


--Io5kq1JWW/hrTr1x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2026 at 05:27:55PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The 'orion' platform is the predecessor to what linux now calls the
> 'mvebu' line of Marvell SoCs, and originally covered orion5x,
> mv78xx0, kirkwood, dove and a few others that do not have any
> upstream support at the moment.

Acked-by: Mark Brown <broonie@kernel.org>

--Io5kq1JWW/hrTr1x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqgKwAACgkQJNaLcl1U
h9DsUAgAhTBN3De8z6XWQRAaxTKXnxOI2ZAZ09YuAC1G51g140wYOj1XcTcrgluM
7wjICW1rmG/S2w60M9udCHUfMPlo9rW6GIGO2B1qfb0m4qgWkKLQATvB5YsJ2zfW
L99pWEuasrdzP7KGhnrxKZNOdQCFpTgvdUjqnrbSnWylQvyy6wvJ0mk9b3x8Cg60
MEJcm4MwHcaLV1P15o/WmXRf66ZBs3I0qbjeg/jQFAAqYtR525BYiKvMuPc/ASW/
/wP2S0zxYLYrFdPFpCGcfbozjD/XENGuCLe3va+eSiqYc2zPA7sSRG5+j5CJNRV+
v0dE8G7KZ/6VC0eWNsgkbHlxV41eIg==
=fCpR
-----END PGP SIGNATURE-----

--Io5kq1JWW/hrTr1x--
