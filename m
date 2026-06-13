Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0465713AF2;
	Sat, 13 Jun 2026 19:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781377434; cv=none; b=DYC975puuqh2+oJRtCVO6phscVmHNr56n9au4wS5SgtvTfkChw7/mIuI1FjgohArg1m3/DL0IOqFAZSfwPhdOPGqI4QFX3Lh5rLHXnNzJJCt2h/mR/45vSmo6reVASkUIk71iP3P0BlBxE+Lz1dgsjAZIDEjyrYjzCKH4tjozfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781377434; c=relaxed/simple;
	bh=4+KDWfUUNzEeT3YxUZvuJFDwUHb/vCxBUo61VrHGPaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2kgzDW4U+1VMMFtFlNbY3FzxiyGsB57mUGACWcG3Te9MpqPJAv48TPYkM9/6c/twIhPSsfid+dCoJ18yjkyuB8N9cDgzvqCi5msPcTi8HHhm55IoJhSQxBKSrgxnX/7fpif7KPDS/icQbgbOfkJifBJsd7OFKojQBu5Jhr0h5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZyPaiTw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZyPaiTw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072D01F000E9;
	Sat, 13 Jun 2026 19:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781377433;
	bh=kNQdqW86qxYa8djwovcvqEdfyYcjTVULQCM3tAzMfOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JZyPaiTwQEHgFYv9+ptz7FrUfwLZJQCtnmPXoENoJz+BEEG9IgpmWZJlC19D3pv0v
	 KCXEkY3O6ggSYdMmHOmig9FVqFwIM5Nwc4L3mqTlWcfufd8Mj8vBU+KsyA1JCeTV2B
	 DHPD4UiExZzcLOuNo3pzTs39AW+cWaNBb6jYn1DzO0JyEUhmVlILqmgxqkixmxLTrc
	 Gro2XMc3RSJxo0+thwl0IKGjulPPnzCPrwtvnPTpT/wsRfsJBM395uGp5pQQj4SqiH
	 Q7DVQtExb1DKJEc6l6ya3P4+guOrNgxuK1gBOV0/qItpovtwX9WQojPuPFSg2U2nfT
	 huGdtoUHGyEWA==
Date: Sat, 13 Jun 2026 21:03:50 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Enzo Adriano <enzo.adriano.code@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
	Ulf Hansson <ulfh@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: mmc: add Allwinner A733 compatible
Message-ID: <20260613-dexterous-admirable-ostrich-8cc679@quoll>
References: <20260613-a733-dts-v1-public-ready-v1-0-7787c94681db@gmail.com>
 <20260613-a733-dts-v1-public-ready-v1-2-7787c94681db@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260613-a733-dts-v1-public-ready-v1-2-7787c94681db@gmail.com>

On Sat, Jun 13, 2026 at 05:42:14AM -0400, Enzo Adriano wrote:
> Document the A733 MMC controller compatible with the existing D1-style
> fallback.
> 
> Signed-off-by: Enzo Adriano <enzo.adriano.code@gmail.com>
> ---
>  Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> index 9f3b1edacaa0..9e9590521210 100644
> --- a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> @@ -58,6 +58,9 @@ properties:
>        - items:
>            - const: allwinner,sun55i-a523-mmc
>            - const: allwinner,sun20i-d1-mmc
> +      - items:
> +          - const: allwinner,sun60i-a733-mmc

So that's enum with previous entry... What's with Allwinner patches
recently that they do not use that syntax?

items:
 - enum:
   - ...
 - const:

 Best regards,
 Krzysztof

