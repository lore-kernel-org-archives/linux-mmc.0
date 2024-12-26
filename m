Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8700B2F36;
	Thu, 26 Dec 2024 00:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735173346; cv=none; b=PHGDzDLzNU+u3+2b6fz2OVeHsZBsrku0gfZTeYSf4Idq7TOQ9OptXSUtwO9HKbclQeJze7Z+WgmtFdjEVJl0g6f9nhRqe04b70r+brWt2w1/hIGmgs+ULs8Am66y3fVvO0Fb0aOOvJBTIsQT8MI8KO9f6THPg/U9ZIwtH5dVczM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735173346; c=relaxed/simple;
	bh=dS/ZYu3PbfSbHlXUchVIhSAI21XQIwvZ0P+gfKlo6OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qlNIRUufaWHjTZpB/qi85/OPE9q9N/mndmUjTiv7yVeGDEq6Am6isNc7aDOMNYTQ09/szJ2QtjqqSPX30UiUy4LL0U3uyEWK7jyLGfornh2wE+17xiVq64v1AzfiQ31Aw2WCFhJWIbO6LC0gcns1dJd42i0+wQyRpTJLfH5Ul6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=zcexjbNi; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="zcexjbNi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XnjTBP16KGtGJBYXoy8uXq0dzk6OV5wbB39xpaT3xNQ=; b=zcexjbNiaR48aL+tug/mQWM3SR
	eFibOXzfr4kBn1a+X8IHhAmJVWhBnlODLtV7LgWJ7ZZTcTIilPhtHhPdeTY8ISH/e59qtjAh5bRVt
	+YwOD4nGqn82HHzxEXZXkItK58gMUN9nhNxoQgxhOoI6riePWpn6qjaRao8elbfiC0Wikl35SDRfy
	CqG5GSLGNBZ4jOrJHcwlYcUtNUe/4fZd5bDxSz5Awo0HtS8KDMWho0tnVWQ+PpLn2mDJe7wbHMnmT
	3do3z1uaZPg0RyTTVFGeNAfwVOz+87p5X7N2jZp38AEQtZVBvecLxGz+hVEYpEHgVr+RcJRYjrCDM
	ikfipWMw==;
Received: from i53875a54.versanet.de ([83.135.90.84] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tQbqc-0004Gf-SL; Thu, 26 Dec 2024 01:35:30 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org,
 Kever Yang <kever.yang@rock-chips.com>, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Jisheng Zhang <jszhang@kernel.org>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 02/17] dt-bindings: mmc: Add support for rk3562 eMMC
Date: Thu, 26 Dec 2024 01:35:29 +0100
Message-ID: <5169773.31r3eYUQgx@phil>
In-Reply-To: <20241224094920.3821861-3-kever.yang@rock-chips.com>
References:
 <20241224094920.3821861-1-kever.yang@rock-chips.com>
 <20241224094920.3821861-3-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Kever,

Am Dienstag, 24. Dezember 2024, 10:49:05 CET schrieb Kever Yang:
> rk3562 is using the same controller as rk3588.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v2: None
> 
>  .../devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml      | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index c3d5e0230af1..33f4288ff879 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -14,16 +14,19 @@ properties:
>    compatible:
>      oneOf:

oneOf means what the naming suggests, the compatible needs to
either follow the "items", the old one means:
	"rockchip,rk3576-dwcmshc", "rockchip,rk3588-dwcmshc"
or the enum below, which means "one" element from the enum
list.

>        - items:
> -          - const: rockchip,rk3576-dwcmshc
> +          - const: rockchip,rk3568-dwcmshc
>            - const: rockchip,rk3588-dwcmshc

That means, both the rk3568 and rk3588 entries in the enum below need
to stay, as they represent the single-value compatibles and the items
above should definitly not mention the rk3568, but instead be modified
to just include the rk3562. So just modify the items above to include it:

     - items:
         - enum:
             - rockchip,rk3562-dwcmshc
             - rockchip,rk3576-dwcmshc
         - const: rockchip,rk3588-dwcmshc

>        - enum:
> -          - rockchip,rk3568-dwcmshc
> -          - rockchip,rk3588-dwcmshc
>            - snps,dwcmshc-sdhci
>            - sophgo,cv1800b-dwcmshc
>            - sophgo,sg2002-dwcmshc
>            - sophgo,sg2042-dwcmshc
>            - thead,th1520-dwcmshc


Heiko


