Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4A836C;
	Thu, 26 Dec 2024 00:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735173564; cv=none; b=kYoA62U813qJn/iotfBW+jicfDV4iLPvt1pnRRF/NHqAotgho2PT1NYq7YH6DleoQR/1pmLQ5kT1kcWKsts0b3thg1ylyGroJwFCKyVaXnrdNfKD6tDG1XRCj24B1p9AZa+rw/F2tJvvhJ/Uf0BjU/rCXSCHt6OkbfrHeRJ7ODc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735173564; c=relaxed/simple;
	bh=SHDwITgKEgZd07tYanIYMyk8b7paCKDnYV75NPW17BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfvAXvnl4RIP/UNiB+YdX0DM+RzpJCHrMj3S3J0OxHWqetobAEn2n3xjlbkZ9fnYhqP8k+Miq0ErvcReZfy7+4gDrn0aHmcYsu1fHn0Nd6Q5MUGWQbzh2DUziv8dCvVSn5fNY0Ba/3ggRCjmAVDizY1To7V/IE9uJBMoKZXu3/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=BF8ZUKmc; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="BF8ZUKmc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vvqCUwKVTzYMhdJqzWkqyXvwsvG0AIMbePI763uVLm0=; b=BF8ZUKmcSGmiiBWE8iopcALx4c
	gNQGI3iY+f7IR0v8nHOSAelarKX3GGPAIe5hl0CM+ZU+9JpsoAL/5m1O7g63WNh9Zy3ebRI98vgTa
	+lIQwrWLABC71rGx0oyJIh75TqZU8zPUVtqpNKhhuglyLATI+vauvvBVJV/cysNufCQ56lhNYuP0y
	WYGjqvNfA9JHNXtkUUd9iZXnn7ddNmFhNVnXcR0ONYVDRZNKZBfodMhJ77bfDipRKE43SHXkeSIBO
	bZgt64EtNv36sYxvD/z5Jfz6Lufi1AvbID9ulD+nqTuMl//QUm12f9O1HQY9Vth0vXUOlc+QdW76q
	7Y1b5mAQ==;
Received: from i53875a54.versanet.de ([83.135.90.84] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tQbuL-0004LM-FN; Thu, 26 Dec 2024 01:39:21 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org,
 Kever Yang <kever.yang@rock-chips.com>, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject:
 Re: [PATCH v2 03/17] dt-bindings: mmc: rockchip-dw-mshc: Add rk3562
 compatible string
Date: Thu, 26 Dec 2024 01:39:20 +0100
Message-ID: <13860713.uLZWGnKmhe@phil>
In-Reply-To: <20241224094920.3821861-4-kever.yang@rock-chips.com>
References:
 <20241224094920.3821861-1-kever.yang@rock-chips.com>
 <20241224094920.3821861-4-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 24. Dezember 2024, 10:49:06 CET schrieb Kever Yang:
> Add RK3588 compatible string for SD interface.

	^ this still says rk3588

> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> index 06df1269f247..772f592291bf 100644
> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> @@ -38,6 +38,7 @@ properties:
>                - rockchip,rk3328-dw-mshc
>                - rockchip,rk3368-dw-mshc
>                - rockchip,rk3399-dw-mshc
> +              - rockchip,rk3562-dw-mshc
>                - rockchip,rk3568-dw-mshc
>                - rockchip,rk3588-dw-mshc
>                - rockchip,rv1108-dw-mshc
> 




