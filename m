Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5CE30D41E;
	Thu, 23 Jul 2026 07:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784793114; cv=none; b=o2GH6JDi/88PedEdz9oS9W0jOaZB1mi+GHmlPfQMwRA9MjWlj1c+we9mZs4ZVKoQd6ZG87kDvYB+/MGMp9yvK+CRyCtfXTme9U2g6a+fck+WVNQzfkG+G8p7ckmkxp+g6Q1tMF5CSXg9EVvarO9DHoH3+xmlwqdctTof/oBnSm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784793114; c=relaxed/simple;
	bh=C1YWW5jl0Jn9MlWPbFdbx0lqCUrvMHP+K1JM3EksePI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrGSt0RpWazsKMWlF8gQQdaUV6slmrlx35gisEFACb89oWH8T1zMncP2Gr+MttJp7N/npbXn6BP4TLrsGmEHqjiTYPx2nmwxKnV1WA+VTcZJ8Ehqu48DoSONLMtqu8q+adLAhxD44OiYGqC3n8lWBXerUyArM2tp74roP2w/u8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHeLDDMa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHeLDDMa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171E21F000E9;
	Thu, 23 Jul 2026 07:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784793113;
	bh=xkW0JQd5WXPD8BqL7YHHM/Xor/p5nv4xebXGKmyA6xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EHeLDDMaNDfXJpfm+sBj4bJjMEOMMF2HaUljkVX8x/TT1+7CCfRAaR0IetFtl/gTi
	 EildAM1FAV4JY/huB7M+ZR3SHz+cJy7WsWv1k3j8LEQyxoOmKDdoLgtDp7AtNbmMHy
	 EqPlY6FjAN7+r1z/FoODrp9vrElnVSzhznM+Osso+IldITzqe4EqQEAMOKNiXxHM3n
	 qi3WnJrSbosgXvBJbMJO6KxpfmHm1UI+kgeZRqQX7K6LYVUhYbnf7kXDoS2QcqKly9
	 ERPE8thHHT/rjSSu0NepEqkp8XKFWyTjtIePekuz5OKtGBIqS05XReRv7ggYerMdXA
	 IuAYRe6I4hiiQ==
Date: Thu, 23 Jul 2026 09:51:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: Ulf Hansson <ulfh@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Avri Altman <avri.altman@sandisk.com>, 
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>, Erick Shepherd <erick.shepherd@ni.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: mmc: Document
 no-mmc-poweroff-suspend property
Message-ID: <20260723-venerable-infallible-oriole-434b75@quoll>
References: <20260722211417.3702709-1-kamal.dasu@broadcom.com>
 <20260722211417.3702709-2-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260722211417.3702709-2-kamal.dasu@broadcom.com>

On Wed, Jul 22, 2026 at 05:14:16PM -0400, Kamal Dasu wrote:
> On some platforms, firmware accesses the (e)MMC card directly during
> system resume from Suspend-to-DRAM, before the kernel's own resume
> path has run, in order to load boot code using hard wired logic that
> is not field updatable. This requires the card to remain powered
> and responsive throughout suspend: it cannot be put to sleep, sent a
> power-off notification, or have its supply removed.
> 
> Add a no-mmc-poweroff-suspend flag property so affected boards can
> tell the mmc core to keep the card powered across suspend instead of
> sleeping or powering it off.
> 
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> ---
> Changes in v3:
>   - Renamed from no-mmc-sleep; dropped S_A_TIMEOUT framing per Ulf.
> 
> Changes in v2:
>   - New patch, replacing v1's card-level quirk, per Ulf.
> 
>  .../devicetree/bindings/mmc/mmc-controller-common.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> index 3d7195e9461c..5f7b3f8ef1dd 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> @@ -232,6 +232,16 @@ properties:
>      description:
>        All eMMC HS400 modes are not supported.
>  
> +  no-mmc-poweroff-suspend:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      On this platform, firmware accesses the attached (e)MMC card
> +      directly during system resume, before the kernel's own resume
> +      path runs. The card must therefore stay powered throughout
> +      suspend, and the controller must not send it a sleep or
> +      power-off notification. The kernel re-initializes the card
> +      after resume, since firmware may have already reset it.

Isn't this exactly the same as keep-power-in-suspend?

Best regards,
Krzysztof

