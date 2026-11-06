Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793963508;
	b=U/T9jycgywyZ0g06MS+N8dBmvdUo4mDdVFRFEsrdSxvHPASYKacuBHGjYMuMvIcH6PjF
	 44Z/YhFLE6MMMhlAmMMR6kSCJjMci0Y61t6fdgRieVPR2b6MI0GZNwH8Og4q7CyWGuzII
	 4bmd8uNXErjhcdW3ousMcZs6IoTbfJBthCirlhxbk8WJw7ZQ/yYSRaKIBHclLwcE+UbuB
	 dv+U1SCbNzQfA0x/72HjQMt2CGOWJ9zcWf2PLF4SVnRaIP670nQU6cA1s3qtB/H9c3Wrs
	 vurWSngXaQJOZ43XLLV+lBGJhAmSpUO5WdrFv95zDboALllE/v9iss4S3g8FXs+ZXnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793963508;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=ymv0niTVnWnKS+pFTfZaMzhEe6bmcXaXyLur7KiR9IE=;
	b=ICF3RCY6kzMYVgyaDiDeyVgwQS16YVDU/7ajyc/+R0icvRzQXS8mCCppTt11x8jcS2as
	 mS/NfauKpueYZtwMYmUrJLVHNoi0DHMB4PmHBiU2kyOxn9YFcdFImGvlQL2yE9qIlHw58
	 K6G1swYNelXFLhajtIecIToj7wz/6ZqCIcDS4iq49w6KdXSej04FFsjzmw+xGoG6hWwRo
	 H2ZW1YjivqhJJDkuLizKUQHhZ6ArKdjH1iD6QpY9wm167GB8RPmGQH2oLqXayDWOSJR0r
	 uMh39O2yEmjaMKQCMRuVr1Dv+sRGz6TeZEZTi9ut10ApZ6c49ZmGnf7RPFMm0exwJFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FIXfAf5Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6444606A33E;
	Fri,  6 Nov 2026 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FIXfAf5Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63A01F008BF;
	Fri,  6 Nov 2026 11:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793963507;
	bh=ymv0niTVnWnKS+pFTfZaMzhEe6bmcXaXyLur7KiR9IE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FIXfAf5Zx37NfO5GLrcenTXjpTMp1DBfUo4/QUReR8rF6AxsQTqUTrgRF+0j5apXe
	 ZB0NsHvsFvk6EgsiTAMagSpL6uWWpVkZUO8r/FNZUMbhYtYG0rYa3GIKwaKCAp0us4
	 m2XYoIP+BmjiDtH1xsZMGNKvkY2v/tVzeIN38VtoPTkjn6lQDWYpeUDZFqAW6ehXrX
	 HhmpmyJ6/r3j3guRCsDqPXblfup0LMrZj9h4WhEYnNGLQLKxw7j5zgX+we3FnKEQaP
	 LG3OckjSOE1p+dVd5p/tLlaFcGxSYVQbSNoO3UAmI3q0tAj/tgY6QsE4dkqT1/b3An
	 NzwCDdtReyohQ==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 91F4627E8491; Fri, 06 Nov 2026 11:11:07 +0000 (GMT)
Date: Fri, 6 Nov 2026 11:11:07 +0000
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jun Chang <jun.chang@metanoia-comm.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sebastian Reichel <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Samuel Holland <samuel.holland@sifive.com>,
	Ben Zong-You Xie <ben717@andestech.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
	CL Wang <cl634@andestech.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Minas Harutyunyan <hminas@synopsys.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Randolph Sheng-Kai =?utf-8?B?TGluKOael+iBluWHsSk=?= <randolph@andestech.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>, linux-mmc@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 11/25] dt-bindings: spi: andestech,ae350-spi: make DMA
 and interrupts optional
Message-ID: <07329076-00d4-49c6-a320-165910a364b9@sirena.org.uk>
References: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
 <20261106-mt2824-v1-11-86087eaf5af4@bootlin.com>
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
	protocol="application/pgp-signature"; boundary="0rA9jbrCb+ammo71"
Content-Disposition: inline
In-Reply-To: <20261106-mt2824-v1-11-86087eaf5af4@bootlin.com>
X-Cookie: Whoever dies with the most toys wins.


--0rA9jbrCb+ammo71
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2026 at 10:30:08AM +0100, Beno=EEt Monin wrote:
> The ATCSPI200 controller can be used in PIO mode, without DMA, and PIO
> transfers can optionally use the controller's interrupt. Make dmas,
> dma-names and interrupts optional, and require dma-names if dmas is
> specified.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--0rA9jbrCb+ammo71
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCau21ywAKCRAv73Ows9A4
iUbmAP9uPXjuvImN4DYj7yBA9yMQ34eBI4TfDanUysfyegnzFwEA41yLk793Adlv
ceQ4scKXQENx1b01FUJT30h4t/rYaA8=
=PoeG
-----END PGP SIGNATURE-----

--0rA9jbrCb+ammo71--
