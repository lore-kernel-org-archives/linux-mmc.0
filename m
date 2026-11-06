Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793958980;
	b=d7yMKsF3oDsHcYmMZ1370i//XI6hwtFnzcU5vGHu2dE6nwtEHjxQH4Q6ge7z9gnt5mMk
	 /iUZAIavWAi7tQEKHbuN7AF4vgo9sgOUIQG19eUqzl6QdZQaS4Q/uQ1tdxZZUDqbJxgAW
	 wbq4gd2rVzjMKh0emYryqZQ+MGVq1MHqEQfa9KkvpnkUuLs5vqenpedVPipCIEwLWidBJ
	 fJfTiEN+EnhdTgQjWC2aYRjX4+mRjigvETLOjmYihlv2dNgNMTolKqMVaf3OHjuQce1tI
	 vXtx26HmiznocWnPoOynj7cI13iw4ns8O3OsTz8+V99/eYsaqdzs02dxkrNzCcgfN1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958980;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=O6bNKP/PWu+XhHEmy9+0v2gCYo8Y74jTDprqO0ZB8Cs=;
	b=T8pcGIRmQfha30K5QmfSoNwbbqyRcpStYHpgt63VYcpTWIb00+/OPETafsx3jSLBfSIk
	 1DJ/OlFoNGjQmA5Z6WqIHOyvwg20qif5ezPo6Ak1DP4HRLVoXDM8vkUKD+9zgDpxGmDMH
	 reDCtNNKulf1Q5e87PsiZ64K4EwxynxtnQxdTbkUGyAl7JOs5yD49Ia45IP2zMngAMWBe
	 ANrsEOUGfutxo0iBu5k7SnsYA6FyXmVy5OzOBgCTpk5/v0Fu3zsJ95/Sl0Uv8WEnv0rJK
	 xl280xjD4QS93s63ARwOcQ4HgfNT2iDSul4Oo/IaszJUi2vUYtACC/uBMUSw2nui/ug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=G2jvcPnt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C35606A32F;
	Fri,  6 Nov 2026 09:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6C35606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=G2jvcPnt
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 74765200B4C;
	Fri, 06 Nov 2026 10:56:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793958975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6bNKP/PWu+XhHEmy9+0v2gCYo8Y74jTDprqO0ZB8Cs=;
	b=G2jvcPntNwss+Z/2TmYHjQFOX70vsp8lMtTLKgrIIE2PS4bz+GMg4XOxPwkMiX0tTu2QmB
	4Hljng7r9uQKZqYd8Fz+4teUmFhPCMIUSxFOzrZqJkqWi6/mX64HYurOjhI3IwlzNW8ivY
	JMJstQbpm8DgKnmpTmeoQLgPdTzRCsstgB4P1wszniBLoPb1ZLOcxOtphn/L99NkUWT5cf
	JiV5RO1/TKWO4HD9YQoI/nmoCs6xTKreCxBVVcnRIOGuUj5/Vt/QBe7PuYsnZejWPBX1ld
	uYUnD3JLA/tgVoSJc3zuBhgcIimbE293URqqG/4hDi9R5SUsddzWgtbKSA9Log==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793958975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6bNKP/PWu+XhHEmy9+0v2gCYo8Y74jTDprqO0ZB8Cs=;
	b=a4Ju+cfO+qKHeqZZYBM0ICfE0szqnKTzYxbj5BaTDGhCqpENFATxO9jautw6TPedCiCAty
	urdF0rANCIzYqDKn0h5nsx0nNOapYXF5qFZ1gw9c2FzC+X+eCrqgmsa6pZZ4X+pj5sCTCa
	SdA9xhi1ziOFz8uLSVrcLZ2Qt9C7WWkcBof0n4r2rN6dHar89Fe3IPbvC13TQRxWxpCeAN
	CtfXOm0B0foVCsRL6pdxY/cHbkwSk3jx6W28QqBmywQVrmQMCOVmxLhqvtl912fWbV2lYU
	ewB9t7zc5IrdgDG7hLhELuzURxpA6wjHIS8DAH/LQjDKBQ7fiZ2TYxkgU65ykg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pza@pengutronix.de smtp.mailfrom=p.zabel@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793958975; a=rsa-sha256;
	cv=none;
	b=hIH/6oo6yZquWNoVc16a0oxuSsS+WSHDOlmQihFSed6sWHGES4oUYNF0K34N0SXBrqlf9m
	iHe9q4oJk6j3gnWMPvV3DqFiJpZniSf1+xNqZ7wKvDlClOQhH0Fp/HMNtaLBJ50/K7ej5/
	3TDVuLDgKuLFX12a2GOdAFq0RE70GbRXykX5uQkZkdGsgbUL+a9ldki61DFDTgVq7eU/f/
	lBLwlE4Ij4+vxC+7EniQglt00xDl1zn3s9iatii+9dE8IXwNtbRDyG2GEPajlO9lUYMZrt
	WcOMwSMGwPVves1L4q8rDNTnS5QI32gKTokqcw0HESWONpt+ZnOG6UCwTM24yg==
Message-ID: <f93de3b97219942fae8e3272f7c65c0d5f9fc9b8.camel@pengutronix.de>
Subject: Re: [PATCH 22/25] phy: metanoia: add USB2 PHY driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: =?ISO-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Jun Chang <jun.chang@metanoia-comm.com>, Paul
 Walmsley	 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou	
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Sebastian Reichel
	 <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong	
 <neil.armstrong@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, Conor
 Dooley <conor@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Lad
 Prabhakar	 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Thomas Gleixner
 <tglx@kernel.org>,  Radu Rendec <radu@rendec.net>, Samuel Holland
 <samuel.holland@sifive.com>, Ben Zong-You Xie	 <ben717@andestech.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Ulf Hansson	 <ulfh@kernel.org>,
 Jisheng Zhang <jszhang@kernel.org>, CL Wang	 <cl634@andestech.com>, Mark
 Brown <broonie@kernel.org>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Adrian Hunter
 <adrian.hunter@intel.com>, Minas Harutyunyan	 <hminas@synopsys.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Randolph Sheng-Kai
 =?UTF-8?Q?Lin=28=E6=9E=97=E8=81=96=E5=87=B1=29?=
	 <randolph@andestech.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-phy@lists.infradead.org, Paul Walmsley
	 <paul.walmsley@sifive.com>, linux-mmc@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-watchdog@vger.kernel.org
Date: Fri, 06 Nov 2026 10:56:15 +0100
In-Reply-To: <20261106-mt2824-v1-22-86087eaf5af4@bootlin.com>
References: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
	 <20261106-mt2824-v1-22-86087eaf5af4@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fr, 2026-11-06 at 10:30 +0100, Beno=C3=AEt Monin wrote:
> Add a minimal reset-only PHY provider for the Metanoia MT2824 USB2 PHY.
> It deasserts the PHY reset required by the DWC2 USB controller on init
> and asserts it again on exit.
>=20
> Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
> Signed-off-by: Beno=C3=AEt Monin <benoit.monin@bootlin.com>
> ---
>  drivers/phy/Kconfig             |  1 +
>  drivers/phy/Makefile            |  1 +
>  drivers/phy/metanoia/Kconfig    | 16 ++++++++
>  drivers/phy/metanoia/Makefile   |  3 ++
>  drivers/phy/metanoia/phy-usb2.c | 88 +++++++++++++++++++++++++++++++++++=
++++++
>  5 files changed, 109 insertions(+)
>=20
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 105fbe408aa2..73ef61f1f53d 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -184,6 +184,7 @@ source "drivers/phy/intel/Kconfig"
>  source "drivers/phy/lantiq/Kconfig"
>  source "drivers/phy/marvell/Kconfig"
>  source "drivers/phy/mediatek/Kconfig"
> +source "drivers/phy/metanoia/Kconfig"
>  source "drivers/phy/microchip/Kconfig"
>  source "drivers/phy/motorola/Kconfig"
>  source "drivers/phy/mscc/Kconfig"
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index c6dd02003bbe..57991b50978c 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_GENERIC_PHY)		+=3D allwinner/	\
>  					   lantiq/	\
>  					   marvell/	\
>  					   mediatek/	\
> +					   metanoia/	\
>  					   microchip/	\
>  					   motorola/	\
>  					   mscc/	\
> diff --git a/drivers/phy/metanoia/Kconfig b/drivers/phy/metanoia/Kconfig
> new file mode 100644
> index 000000000000..b8a49085bb95
> --- /dev/null
> +++ b/drivers/phy/metanoia/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Phy drivers for Metanoia platforms
> +#
> +
> +config PHY_METANOIA_USB2
> +	tristate "Metanoia USB2 PHY reset support"
> +	depends on OF && (ARCH_METANOIA || COMPILE_TEST)
> +	depends on RESET_CONTROLLER

No, it doesn't. This is only required for reset controller drivers.
The reset control API is stubbed out when RESET_CONTROLLER is not set.


regards
Philipp
