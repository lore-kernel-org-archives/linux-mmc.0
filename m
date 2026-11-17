Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936241;
	b=Ekm8piA58GkRkBv/gFdAav1SjC9HOqKwDw/lh2SHACY1noT4LnKozC+7QMyKSLwNh3cD
	 fw+g/fOmhXatAt7osGmHcYZoFN4WvseQVV0i45BVcjvMAElATpnL4i1sELCwZPiulrM+d
	 p4Hzjl1qF8Yk4EXZef+hT+kJIVO2iosPTHc8uJQiFN2rsC1VMJkDPbMfLiUmsOCftWWt0
	 ITo9H/rnrDodUGdgi7yrR5QdywZm6jtSBTx8QmtPz9iJs6VpfWsL9yOgKnqttKu/hXu9W
	 +SbZc5VCwAdJSexA7ga1ad5XDMMM6x5dP2JK2kA/PLOQkW66EcYqVrtkixemuNKlYJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936241;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gpbTjTJOw7ujZ3rRhUXfRGBVxlexIhsMVokvC2lfJKg=;
	b=yBvPp+kr4d0kB0tsHGVntgATWVAyzzgZm3H9phqcoo/GVpEmMlNAiwKgiISF3IhSpQbC
	 w/eN1DpaHT4euQXFLxLlEvdA0QCF2E8/1P4nDAJHL8rgIs7aahtX9l8G/u5w2R+5UmSEK
	 0hFR+cmnM1PVUfGHhO52yht9P0WZPcXczf+KtKDoKtN5iLIuJvk+1UxvNsgmIQWCntM+F
	 UH82sI6l0mTlBGYf2FeT3hvlEK4HBoIZEvqALizGlTYRdJ0c/DyQOjfAuxEKC4tqB8g/O
	 gHc+HdPx0Zm2bAcjm7QsFuW/Q0lJfdSY3xfj9wMmqQGO1Lk0jA4okpHySg6R841XH1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KWYKJv3M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92661606A31C;
	Tue, 17 Nov 2026 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KWYKJv3M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF851F000C5;
	Tue, 17 Nov 2026 17:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794936241;
	bh=gpbTjTJOw7ujZ3rRhUXfRGBVxlexIhsMVokvC2lfJKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KWYKJv3MANrtT/7P6e2gCVNbNEBoBXQUtlZh8Mf56ybtul7cxMz8VaDdEbm9pi5Nc
	 BfHrYzv2HEsWoBITaTkD1dwNc0IZP5t+AHr9r5/pBJgvAMxy/5TEQFqF6ZHsPHxNVG
	 op9u27T4ICZalOyLu9Upd4tTFtitwI9B5xybTTBPKgeb74//jEypg5eyVy2IUWUzxl
	 s229NTvD3oSDsgBOL25txWM/8lNYPn1n+FsYdI1WRVctaUXJvaHOOoTs1qIZvUTpJO
	 PpN5jioXs+0HCutxntAveukt2INCYHu0rhNmEEJXl9l4H7rBz8E1vGRdNfnwx2Jetg
	 t/uiur4VkyuEQ==
Date: Tue, 17 Nov 2026 17:23:54 +0000
From: Conor Dooley <conor@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: yogo.0917.sabu@gmail.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Ulf Hansson <ulfh@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Linus Walleij <linusw@kernel.org>,
	Drew Fustini <fustini@kernel.org>, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
	linux-doc@vger.kernel.org, soc@lists.linux.dev
Subject: Re: [PATCH RFC 6/6] ARM: add the SiRF AT550 platform and YPL514si
 board
Message-ID: <20261117-umpire-agency-f82c1415c09c@spud>
References: <20261117-at550-rfc-v1-v1-0-5879573cb825@gmail.com>
 <20261117-at550-rfc-v1-v1-6-5879573cb825@gmail.com>
 <c3832ce3-4605-4810-9348-c6fee394fe04@app.fastmail.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V8Ki5c7P5QvUwrPE"
Content-Disposition: inline
In-Reply-To: <c3832ce3-4605-4810-9348-c6fee394fe04@app.fastmail.com>

--V8Ki5c7P5QvUwrPE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 02:17:58PM +0100, Arnd Bergmann wrote:
> On Tue, Nov 17, 2026, at 14:06, yy-Local-LLM via B4 Relay wrote:
> > From: yy-Local-LLM <yogo.0917.sabu@gmail.com>
> >
> > Add a minimal DT machine using standard IRQ, timer and simplefb paths.
> > Describe the SoC and the firmware-configured YPL514si display. Leave
> > usable memory and the divided counter rate for the bootloader to
> > populate. Keep optional peripheral nodes disabled until firmware hands
> > them over. Disable unvalidated board suspend; limit this board to SD PIO
> > at 25 MHz. Document the RAM-boot contract and the missing
> > cold-boot/clock-tree support.
> >
> > Signed-off-by: yy-Local-LLM <yogo.0917.sabu@gmail.com>
>=20
> Please use a real name for signoff and make sure you understand
> the legal meaning of this.

Given the wording in the cover letter, I have my suspicions the person
behind this has had no interaction with the code at all.

>=20
> > +config ARCH_AT550
> > +	bool "SiRF AT550 platforms"
> > +	depends on ARCH_MULTI_V6
> > +	select ARM_ERRATA_411920
> > +	select AT550_IRQ
> > +	select CLKSRC_AT550
> > +	select CPU_V6
>=20
> Which CPU is this specifically? You need to select CPU_ARM1136R0,
> CPU_ARM1136R1 or CPU_ARM1176 instead CPU_V6 since b5fdfa208175
> ("ARM: deprecate support for ARM1136r0").
>=20
>      Arnd

--V8Ki5c7P5QvUwrPE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavyNpwAKCRB4tDGHoIJi
0tg7AQDFyQE1l10KohugmjgKBSh/b/m8rMXAhDjSMG83Tw2ulgEAjZiuwL+/+iBt
58axZW3SM/hB34QmaPbBaBb9n1xGzQE=
=msXp
-----END PGP SIGNATURE-----

--V8Ki5c7P5QvUwrPE--
