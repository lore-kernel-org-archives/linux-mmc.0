Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965934;
	b=dcHhcqTwgrNgEuDmKLt+XT7t3C17RC/AwRGvCD5UaWoeT1ez9hgvzFz6g3yPUXt3NOGf
	 XXomv7FMixLYTD4RBXRLVVwn01hTjn4vdudKwQePfVnW9xZMP/5LQAZPe6Vikwftg6HAH
	 uxsIgb1FgoZLmzBWmug8t9p8Y288btEsIqa1/wUOpa7fPUhGbPjxugEZJ9ucMxaFDl/RO
	 7upEv7oRS6jKUunoP5C+SHmoFzDpBlhGkwayKbvlMuKTiwkgpMoK3wujs2HHOOtfdLGl2
	 U0vICxhdrEm0CVo+nVOmdYCEI5CuoO/CCW/YZpYhVBTifPI7oPGl8IE5kZG4ElKTvbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965934;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=x4R1KJ8aSDphl2LcCS6CvgrEOcfwytQMmMr8A/7wcqQ=;
	b=cmj+KVAXhhf/jxD34tw/aGr/iHEyXDwKocs8UPeE6lmf4fKIkAcOPU+MgxKDmTfvZyVO
	 vMGR8LYz6/kF2wHLp4fqljPMAFPv73m4iGyqN6P1W9KnFiIaQkgJyhLiEByQyx96Q0XVF
	 Mc/UQmwlU6IuRq6/gs6ReRkLoGsree5+NuqBqTe5gL+sciOCc6pi8XX9XnRDs4UzB2NRD
	 BtVdaV2G+u4iGxjfpi+AJRxiwPypdvhdgnta36DmxUPcKHUEXKXeJz+BHOzab4B5FSzIS
	 p8Uw+k/1iRbvWT9AS2C36lkF/X/HeB9T4mrzTbSKo4iBFtWlbIQVVOry8Itnr/VQmcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mdKeqRHF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2912B606A329;
	Fri,  6 Nov 2026 11:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mdKeqRHF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8731F008AB;
	Fri,  6 Nov 2026 11:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793965933;
	bh=x4R1KJ8aSDphl2LcCS6CvgrEOcfwytQMmMr8A/7wcqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mdKeqRHFYOg8ENrNWN71+qqIn1anHGJLPU2Fp+Ej948gLRr96t/1AEydZuO75yBs9
	 DmFWEq0hQAEFbLt3sHBH8kMRb8QsAXN289DmBlwCTscHWZSaLTSZ292UbXLYHlN/Lh
	 9rfv5+bkF/1zG2yRucyhD6IpgW7NSq0wew0T10Rf1ernIbYzXnlSRwQiOs5en7WPkJ
	 uNLv330A/Hlx74I2ILfc+HazPXlGXgEcyDtSFYibGEsqN/0zzdzZmJvNhFKyigs/BP
	 b9/kEbIui1ok/wZflXvNQ9yPclYlaamPxIed+Z77KivCrpx7U9ApbJPlw6axU0tOP6
	 gG35Cwzd1z0Dg==
Date: Fri, 6 Nov 2026 12:52:10 +0100
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
Subject: Re: [PATCH 23/25] usb: dwc2: add support for Metanoia MT2824
Message-ID: <20261106-glistening-flounder-from-mars-3ec4af@quoll>
References: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
 <20261106-mt2824-v1-23-86087eaf5af4@bootlin.com>
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
In-Reply-To: <20261106-mt2824-v1-23-86087eaf5af4@bootlin.com>

On Fri, Nov 06, 2026 at 10:30:20AM +0100, Beno=C3=AEt Monin wrote:
> Add core parameters for the Metanoia MT2824 DWC2 controller: high-speed
> UTMI PHY, no host DMA, and no OTG HNP/SRP support.
>=20
> Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
> Signed-off-by: Beno=C3=AEt Monin <benoit.monin@bootlin.com>
> ---
>  drivers/usb/dwc2/params.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
> index 091bfcfef753..d6a6a581d021 100644
> --- a/drivers/usb/dwc2/params.c
> +++ b/drivers/usb/dwc2/params.c
> @@ -303,6 +303,17 @@ static void dwc2_set_stm32mp15_hsotg_params(struct d=
wc2_hsotg *hsotg)
>  	p->hird_threshold_en =3D false;
>  }
> =20
> +static void dwc2_set_metanoia_mt2824_params(struct dwc2_hsotg *hsotg)
> +{
> +	struct dwc2_core_params *p =3D &hsotg->params;
> +
> +	p->otg_caps.hnp_support =3D false;
> +	p->otg_caps.srp_support =3D false;
> +	p->speed =3D DWC2_SPEED_PARAM_HIGH;
> +	p->host_dma =3D false;
> +	p->phy_type =3D DWC2_PHY_TYPE_PARAM_UTMI;
> +}
> +
>  const struct of_device_id dwc2_of_match_table[] =3D {
>  	{ .compatible =3D "brcm,bcm2835-usb", .data =3D dwc2_set_bcm_params },
>  	{ .compatible =3D "hisilicon,hi6220-usb", .data =3D dwc2_set_his_params=
 },
> @@ -347,6 +358,8 @@ const struct of_device_id dwc2_of_match_table[] =3D {
>  	  .data =3D dwc2_set_stm32mp15_hsotg_params },
>  	{ .compatible =3D "intel,socfpga-agilex-hsotg",
>  	  .data =3D dwc2_set_socfpga_agilex_params },
> +	{ .compatible =3D "metanoia,mt2824-usb",

Please organize the patch documenting the compatible (DT bindings)
before the patch using that compatible.
See also: https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/d=
evicetree/bindings/submitting-patches.rst#L46


Best regards,
Krzysztof

