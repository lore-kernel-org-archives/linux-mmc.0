Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F95A14AD0A;
	Thu, 15 Aug 2024 13:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729761; cv=none; b=jvUv1qAWU5nFMCJywKND/ENXzdGvS2k4QLJl1kh5AMyWoKqwqPe+Roma3HGoj9NU+2jH47XPPG/Cmt1vWCcAfhp8+0wIAex78YlrBTx6w7nS+q1bAdfZuqxBIJSdbja14ySszyqQ1awiwG7UJwbCDv7CDO3yKQpuoGHEPRhzqko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729761; c=relaxed/simple;
	bh=l29BpF0pE5dummAf4WWU6M7uDFZRtdSPnLLm2sEUcWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkiLwTYe2gu+6ykav3kprwlq9N0qtaTvRcTFHRyk3/aOeM5xJgqveM/iiMwk6Xe+G+uXUNU+UKnbZFGBCHU1LZPReIeMvz+QZC4sINQPEBQrARPTk39hhfqX73emVU0mLyjlijPS/cqEJOwAjp1TW6bb0IMb5Tkx7tYNJneTVhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=F4jASlBM; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="F4jASlBM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+qjUZXXQPxMbzidk2Un7iyE+5qXqgDIpBfTv+OoiY/8=; b=F4jASlBMHLJFuTxmhQmLd6CS/j
	3NjADgAqcSl22SIIgqYqRERAsTyT5hfI646h0/71qZTNnWT3HHQYCe619+p8wQ/qvvvt+Txd2U1nd
	5B35td3fAFveSUz3jGvEzysWWh9ge4i69J92C7NLB+/W0U5qlIF0Q0V/TcgjwaaLmUR+ButCPZ1Ag
	Sq1Wg94yjFUZfJ6OjgQrSOo6iUdymNPO6HXlSZ26JSFPNhF+pw+dRpb9v6NWK10abrSpvcwaLp6TZ
	7VWmshsSob2mvkEt2fG/cGq6H/Hc1glLWZ9CH2ZasXzmOm5lYwGMUYdvjXFKH+FPvNQRGekqRux4j
	A/Un8Fbg==;
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1seaqn-0003Br-7q; Thu, 15 Aug 2024 15:49:13 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
 Detlev Casanova <detlev.casanova@collabora.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com,
 Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: mmc: Add support for rk3576 dw-mshc
Date: Thu, 15 Aug 2024 15:49:12 +0200
Message-ID: <5057223.82XvGhxQ46@diego>
In-Reply-To: <20240814223555.3695-2-detlev.casanova@collabora.com>
References:
 <20240814223555.3695-1-detlev.casanova@collabora.com>
 <20240814223555.3695-2-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 15. August 2024, 00:34:00 CEST schrieb Detlev Casanova:
> Add the compatible string for rockchip,rk3576-dw-mshc and add support
> for the rockchip,v2-tuning flag, a new feature of this core.
> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> index 211cd0b0bc5f3..0543cdb51c657 100644
> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> @@ -39,6 +39,7 @@ properties:
>                - rockchip,rk3368-dw-mshc
>                - rockchip,rk3399-dw-mshc
>                - rockchip,rk3568-dw-mshc
> +              - rockchip,rk3576-dw-mshc
>                - rockchip,rk3588-dw-mshc
>                - rockchip,rv1108-dw-mshc
>                - rockchip,rv1126-dw-mshc

this would mark the rk3576-dw-mshc as being the "same" as the
core rk3288 variant. rk3288 was the first controller introducing the
clock tuning for higher speeds. with the clocks being part of the CRU.

As we can see in later patches, this rk3576 though changes that
setup with moving the tunable clock configurations into the controller
itself.

So please don't claim to be compatible to the 3288, but instead start
a new block for this new set of controllers:


  compatible:
    oneOf:
      # for Rockchip RK2928 and before RK3288
      - const: rockchip,rk2928-dw-mshc
      # for Rockchip RK3288
      - const: rockchip,rk3288-dw-mshc
      - items:
          - enum:
              - rockchip,px30-dw-mshc
              - rockchip,rk1808-dw-mshc
              - rockchip,rk3036-dw-mshc
              - rockchip,rk3128-dw-mshc
              - rockchip,rk3228-dw-mshc
              - rockchip,rk3308-dw-mshc
              - rockchip,rk3328-dw-mshc
              - rockchip,rk3368-dw-mshc
              - rockchip,rk3399-dw-mshc
              - rockchip,rk3568-dw-mshc
              - rockchip,rk3588-dw-mshc
              - rockchip,rv1108-dw-mshc
              - rockchip,rv1126-dw-mshc
          - const: rockchip,rk3288-dw-mshc
+      # for Rockchip RK3576 with phase tuning inside the controller
+      - const: rockchip,rk3576-dw-mshc

That way you can simplify the dt-parsing code too.


Heiko


