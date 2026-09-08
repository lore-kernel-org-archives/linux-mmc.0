Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF77159221F
	for <linux-mmc@vger.kernel.org>; Tue,  8 Sep 2026 17:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888826; cv=none; b=MnQ82U6cVbrtR3Kh8lHZaT3l2+NgiAzCiY8ZIPZCKDbZ7q+iGYgp+YsFsOp9ulPmBFettL49JbWCS71hCm1XQYWcv+LU/D6NcVFhO6x3tbhMFxufzrVGgEyMYbTA/nsM+KwCQEpiZfZvHJqzjXcbi0CWgAZ+jCg44KbCR/6Evv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888826; c=relaxed/simple;
	bh=gmIGR0/AjmJLqjqIA+b+biNqhfd5J7r7shYDGeksk7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Py4dfJtQ9+xfu17s6TGb/2sJRlaUniI0xvJ9jVoQ5PpuvemQLirTwRfCQVKBivlnl4qxx8LefdTw1Al2c19Awi8y+y06RHlDKGb7Jn5IfYjYIAB0mIj9Z4OSExcoVcaSK0OiWbNDHc3YstzzzA7xb8mr3xfePbQ3YuqWCo+OvRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYUkJxyp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYUkJxyp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530531F00A3F
	for <linux-mmc@vger.kernel.org>; Tue,  8 Sep 2026 17:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788888823;
	bh=gmIGR0/AjmJLqjqIA+b+biNqhfd5J7r7shYDGeksk7M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oYUkJxypWqLI8uJLzQPHxhQ71Ks/IyFSnoobdkhybHg/VFrZcScUaUzcU5iGJu3Yg
	 SVr1zNYq9lzWcvDiEUcX1atpf0jaVT6xPToEVsGnnnsYQD5x0GXAUtiUe+VTGJC6+U
	 lVLE5LREy7a0wkg5nqv6jsrAjqnRn4VO+GvC4P1WC1OuR3Y0iPEm0L25Nk/xBf6b9z
	 uj+EZWNfmBY9zPHxZZzMY+PZaGLcUap6z6HgDOpRkikwj/4SgkOIg8RzL7eKjY5zR2
	 8qBXig3e3zoeZ5+dV8aYrX3pQiy5jGox/+C0yb3jT+lcAU0xZn8D99wJLkp8fHxUtM
	 u1lhsOfW8IKpA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b0231a3e86so4503058e87.0
        for <linux-mmc@vger.kernel.org>; Tue, 08 Sep 2026 10:33:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwetApIbjtThhBopb+PfdkD+Mv8Vj9NxvNNMzcDfpNLiFTDwczKHjt9TnNU/L2JUFyPqdue6Jj79S8=@vger.kernel.org
X-Gm-Message-State: AFuF++nsXuMmgwLT2KbupPbvJh4ms7zFx01ySvqIFddjQV8f3raDkb68
	ENWNRF4a53/vR9ctMwitZM2rlzlgk2PyzbdxqW1jwDBbi1RYEUgyEVmsjK88iR4GO2+ftyCY44g
	m1/IQoGJiGSF/V+tzzxhOqZPdbRhzQZI=
X-Received: by 2002:a05:6512:2241:b0:5b5:fae5:b241 with SMTP id
 2adb3069b0e04-5b616f22e66mr5771186e87.14.1788888821627; Tue, 08 Sep 2026
 10:33:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908152808.3928630-1-arnd@kernel.org> <20260908152808.3928630-6-arnd@kernel.org>
In-Reply-To: <20260908152808.3928630-6-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 8 Sep 2026 19:33:29 +0200
X-Gmail-Original-Message-ID: <CAD++jLka1EcE_pgbQ+k-==7ZBy4t=UzMRoSpftToUvqSWikfOA@mail.gmail.com>
X-Gm-Features: AcwNN1W4V_RHIjZXrzOUvAHXUKzBi-tBnO9Xu5bnMkKM7BxKaEWn60o-CzXXb5s
Message-ID: <CAD++jLka1EcE_pgbQ+k-==7ZBy4t=UzMRoSpftToUvqSWikfOA@mail.gmail.com>
Subject: Re: [PATCH 05/13] ARM: orion/dove/mv78xx0: remove all board files
To: Arnd Bergmann <arnd@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Russell King <linux@armlinux.org.uk>, Drew Fustini <fustini@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, Stefan Agner <stefan@agner.ch>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew@lunn.ch>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Kristoffer Ericson <kristoffer.ericson@gmail.com>, Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
	Shawn Guo <shawnguo@kernel.org>, Karl Mehltretter <kmehltretter@gmail.com>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
	Alexander Clouter <alex@digriz.org.uk>, "Jeremy J. Peper" <jeremy@jeremypeper.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Thomas Weissschuh <thomas.weissschuh@linutronix.de>, 
	linux-ide@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 5:29=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The 'orion' platform is the predecessor to what linux now calls the
> 'mvebu' line of Marvell SoCs, and originally covered orion5x,
> mv78xx0, kirkwood, dove and a few others that do not have any
> upstream support at the moment.
>
> Only a few board files remain here, these are the ones left
> in 2022 board file purge because they had some level of support
> in Debian or OpenWRT, mostly for commercial NAS or router boxes.
> This distro support is now gone, and nobody has converted the
> board files to devicetree, though the orion5x and dove platforms
> also come with devicetree support for some other machines.
>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: Alexander Clouter <alex@digriz.org.uk>
> Cc: Jeremy J. Peper <jeremy@jeremypeper.com>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Niklas Cassel <cassel@kernel.org>
> Cc: Ulf Hansson <ulfh@kernel.org>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: "Krzysztof Wilczy=C5=84ski" <kwilczynski@kernel.org>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@kernel.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Linus Walleij <linusw@kernel.org>
> Cc: Bartosz Golaszewski <brgl@kernel.org>
> Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>
> Cc: linux-ide@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-phy@lists.infradead.org
> Cc: linux-rtc@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-watchdog@vger.kernel.org
> Cc: linux-sound@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
