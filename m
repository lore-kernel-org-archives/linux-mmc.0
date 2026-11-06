Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793966055;
	b=Rhy5WPr7U/T+1Syj0ACZNisxq6nYYEILtFyu9IKXaX4uqOy8l1w0b/kZ9SQrC8OjbDsM
	 wCYMK+qCShCLZhSp5GS4T0QNe4xQAlsxpvu7ty141bS5HPPcuV/da4rQuClfxC2sX8nPO
	 UtYX9s91FqSeTZ0A4VX8mHFPEf5duTdx5EAI8BHLK2V4biQjbE+4yluHwmyxvYTlgpmPg
	 soiS6blvIf9CfQX7QDDlC7I85hUgrr9XRz6gNDZn1L+afzpjpf8lQmqwAicoHYOW0HMGq
	 b1JJYkkWN3QcTVtVJERKSF+CIgWbQRpvGB6pLAuwaOeuBd56x0t+aoR5IWz7bzNmG5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793966055;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=zeUGkAr+dd5pvA9ddLYxv09ZmZOzgKimQinHuYdcXGY=;
	b=nD944bRzJtD01Czk8LogNd0ovrkOzknjFr/iqGF72spuChB8nmnNHScqjt/VPcNrmKtT
	 rocvj/HvKXDUdKydAVHqQASrZCftPk0B8ziPi7gfYqCpDjL0g/13TGDd/t/xEsdF9SqTU
	 33yxlA/bxmaoUZtom1a7kpv5cbJUzVU6WMrhmmkl2pPvJXM5S3rsGE6KFE54ti1ElDZ7a
	 9OQpnBKxhRIiB0nVa+hdWUHzDEJrMErbphH5HMGugFJAx8kgoNzlPZTnVWxpcwEswjTg8
	 zRzhm9T4Zy07Zr0PiRqL/irM8MdysJOJv/BQ0WjtwKTmXaxvvZSMVJrMs4wD61Mqgzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DRtzz8Ow;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF392606A32D;
	Fri,  6 Nov 2026 11:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DRtzz8Ow
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A36C1F008A1;
	Fri,  6 Nov 2026 11:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793966054;
	bh=zeUGkAr+dd5pvA9ddLYxv09ZmZOzgKimQinHuYdcXGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DRtzz8OwVZ8h54GrjlHTDasRVBAtPcFhfr0YDhT28zp43jVnv922ia2GefpiSxLaP
	 yJXFCDtltMQPVRqKI9XDeUNQsQFV2xMb9f3OCVoNPlwI38PEUXRH+kADoZWdAgOsK5
	 Bn+IngDuAfKSFPhD+fzi3S3NK4SMCmXifiAivN6Cm7tvLub7p769OUi04UjLkAj4Jc
	 vTSVJ0E76oZyp9PUYzhzqHCSQHGHz9R0kOSBm/lYfSzttPRp3SiPh+J1Q0SyMHCR4j
	 5ysZKp2SKvW9jfZOfQ8/bOogtll/OOaT4woBxUVwTacfXodHtYRkjWtlBIRJDHa9iN
	 zdKoYNy5p7M5w==
Date: Fri, 6 Nov 2026 12:54:10 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?Q?Beno=C3=AEt?= Monin <benoit.monin@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jun Chang <jun.chang@metanoia-comm.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Sebastian Reichel <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Conor Dooley <conor@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Samuel Holland <samuel.holland@sifive.com>, Ben Zong-You Xie <ben717@andestech.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, CL Wang <cl634@andestech.com>, Mark Brown <broonie@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Adrian Hunter <adrian.hunter@intel.com>, 
	Minas Harutyunyan <hminas@synopsys.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Randolph Sheng-Kai =?utf-8?B?TGluKOael+iBluWHsSk=?= <randolph@andestech.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, linux-phy@lists.infradead.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 13/25] dt-bindings: usb: dwc2: add Metanoia MT2824
Message-ID: <20261106-dexterous-predictable-pelican-ae2094@quoll>
References: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
 <20261106-mt2824-v1-13-86087eaf5af4@bootlin.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261106-mt2824-v1-13-86087eaf5af4@bootlin.com>

On Fri, Nov 06, 2026 at 10:30:10AM +0100, Beno=C3=AEt Monin wrote:
> Document the metanoia,mt2824-usb compatible, which falls back to the
> generic snps,dwc2 binding, so that the DWC2 USB controller on the Metanoia
> MT2824 SoC can be described in device trees.

This is completely redundant commit msg. You repeat subject and diff, so
obvious things, while completely skipping non-obvious part - why do you
thing they are compatible.

>=20
> Originally-by: Jun Chang <jun.chang@metanoia-comm.com>

Please drop (or read submitting patches if you need other tags)

> Signed-off-by: Beno=C3=AEt Monin <benoit.monin@bootlin.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc2.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentat=
ion/devicetree/bindings/usb/dwc2.yaml
> index 6c3a10991b8b..898c83e57843 100644
> --- a/Documentation/devicetree/bindings/usb/dwc2.yaml
> +++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
> @@ -55,6 +55,7 @@ properties:
>                - amlogic,meson-g12a-usb
>                - amlogic,meson-a1-usb
>                - intel,socfpga-agilex-hsotg
> +              - metanoia,mt2824-usb
>            - const: snps,dwc2

Is it then compatible with DWC2? Your driver code suggests not.

>        - const: amcc,dwc-otg
>        - const: apm,apm82181-dwc-otg
>=20
> --=20
> 2.56.0
>=20
