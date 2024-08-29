Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFB21BC4E;
	Thu, 29 Aug 2024 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931448; cv=none; b=Orc56pXlGzJZsjpVfJ4SYfzlysoIY/yT9TfRDYnv4MurcBYK9QMM37frE8xQ1couNMm1cZs708LiRVIixXSUBstAo0EeFJaTgx1jeOMeMzAgSaBDFX1bIXYc9pe/6E+B/zgZZ8YIDN6dCFuS3tzbwisaK42B+6KvLhfpx6U6J5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931448; c=relaxed/simple;
	bh=Uu3fQm/qBdQjXVQQ7AviV7IdvREiQTmnXpozlL20Iy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lVjGaU1jpRjolEMoggQrXMkzZsUjQOzDGsw88hRNV3Lx200V9Kf/8kdqE0L3oR48Y0qkm+ZizePrOhl8chMXKK1Vu8qWSVyZy10CiRTLBOmpJB7Mwbwi+SdAOGyDxAnz8HXnkbNMQd6bgVm+Yy/8RjeXeLZ6Y6VvUIdtP0vzGGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=2fp85cci; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="2fp85cci"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BA+KEd83KEBsKWki7uMOjFGHXh+6uKMNY5jabo1SQdU=; b=2fp85cciJaJSiIsORnXaNPCdHT
	REhNujUTvFhDOEQIg7kZsUqbccRMTA4WLTj9v2XBHvpeHyA6Qg0WEh7PFJ3NjfBSQ9IBowSBfT9nJ
	Znv4jsuOOUr80d6yze+2wUL2ghisKq4/eTnFYLXnpl6FjwQtehgINTNmlNY61zTEv6Jd6o12GuvRV
	APV9EirnUY/gPANRCwcKQYV1X46VkHbOj4HMtMsLDxje9cua5JhL+/p7aImLGiLQp5BdGCYy3HUYA
	Yom7bk+gR3ecQkc1kL22gE5fMA7OgXTnDHj+UDgFy1bG2M4iznhWVnhZdKqokfQ4MsRaLrADni81L
	w2IhBVtw==;
Received: from i5e861916.versanet.de ([94.134.25.22] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sjdSq-0003Vg-D2; Thu, 29 Aug 2024 13:37:20 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
 Detlev Casanova <detlev.casanova@collabora.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 1/3] dt-bindings: mmc: Add support for rk3576 dw-mshc
Date: Thu, 29 Aug 2024 13:38:33 +0200
Message-ID: <10520454.qUNvkh4Gvn@diego>
In-Reply-To:
 <010201919996f687-08c1988a-f588-46fa-ad82-023068c316ba-000000@eu-west-1.amazonses.com>
References:
 <20240828152446.42896-1-detlev.casanova@collabora.com>
 <010201919996f687-08c1988a-f588-46fa-ad82-023068c316ba-000000@eu-west-1.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 28. August 2024, 17:24:53 CEST schrieb Detlev Casanova:
> Add the compatible string for rockchip,rk3576-dw-mshc in its own new
> block, for devices that have internal phase settings instead of external
> clocks.
> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


