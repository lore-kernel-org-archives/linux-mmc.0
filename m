Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06538227E95;
	Sun, 11 Jan 2026 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768124576; cv=none; b=eEbPyPw/8fSRn6Wz1+GdsOslh7Pxh3edx8pS89IJ4NZENBFui80H05tDVeN4eYx8uJgf1vxHJmIZr5wEaHjRbWoGisptf0Bg3wsJv/lnuUVSLaSoudbDgs7EEPCEcMeYTOkTqpsv32rTjPSA2T47GB/C7uqM/HErkzqUHsF0wzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768124576; c=relaxed/simple;
	bh=+KYg75XD2jPTkQn0jSbd/Ju0N5oE/9yFt24CvhVjjF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtrdgQu8nnDRlh4pqQh17n+ufSATshCWHtlzXJ6xUDvk5pUt/+usVUJDT1F8Oll047ZOtg2s3mEGVQDUiIwpNDycpBDj1JMvivt5XWuW+3atqVaGLKaFUIPEBF/jg8yBVsaAKQO9kWElcHgb29sbcs6hcmkQEbjPmv09X3D3VTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkxpWjr5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkxpWjr5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254A5C4CEF7;
	Sun, 11 Jan 2026 09:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768124575;
	bh=+KYg75XD2jPTkQn0jSbd/Ju0N5oE/9yFt24CvhVjjF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nkxpWjr5krlraBYJpOyEoLkD/j9RtNsltvlMk4e6kPxnIjwDwHP+O6qSAm+HDo3Op
	 5fD//dGEsW+NVcpmzQuUs4D6+hbOqBIurRVMfpt495YKt92XA/414ATIPoREdDzv+7
	 y/jkmTrQ94XUmiLhP38yZ3qtZd4bdnj9JgnDFf+RDZTzgzXmoxXj8KsaGs4KlmcwcU
	 MrvZXOyKWeyGE+XPEDo3q6+aQqgA4ONeL5FPprvGH60zZ1x+JKNj7nNCr16oINtihy
	 5CBEshZKw3yG1xHMA8eft1M/n8wPCc6YxOwgVDEWyhHXQmIUsA3ivHIDi8WYah5K+I
	 Sx5HpR7ZLqtnA==
Date: Sun, 11 Jan 2026 10:42:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marco Schirrmeister <mschirrmeister@gmail.com>
Cc: heiko@sntech.de, ulf.hansson@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-rockchip@lists.infradead.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 3/3] arm64: dts: rockchip: add stability quirk to
 NanoPi R76S
Message-ID: <20260111-utopian-vehement-lori-50cbca@quoll>
References: <20260110010715.1610159-1-mschirrmeister@gmail.com>
 <20260110010715.1610159-4-mschirrmeister@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260110010715.1610159-4-mschirrmeister@gmail.com>

On Sat, Jan 10, 2026 at 02:07:15AM +0100, Marco Schirrmeister wrote:
> Enable the 'rockchip,disable-runtime-pm' quirk for the SDMMC node on the 
> NanoPi R76S to prevent bus instability and retraining loops during 
> idle periods.

You miss some other properties or fixing driver and solution is not
adding such properties in DTS. Nothing like that belongs to DTS.

> 
> Signed-off-by: Marco Schirrmeister <mschirrmeister@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts b/arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts
> index 31fbefaeceab..90a798ee9e68 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts
> @@ -754,6 +754,7 @@ &sdmmc {
>  	disable-wp;
>  	no-mmc;
>  	no-sdio;
> +	rockchip,disable-runtime-pm;

Best regards,
Krzysztof

