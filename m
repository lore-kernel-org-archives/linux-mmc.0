Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0FE39281B;
	Wed, 24 Jun 2026 07:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782287502; cv=none; b=QmeSN6bdUPlY06MDTyuysb2+QTDNf0CD4RvxbrdX9PGvSvUiavhOPT3PgOBQnMo5NqNHY+LZyGGq6EUGGSWZHfTveQvVMigwi99UQz8Ih6CkzXVIePra7RfKWqnewgwxhADPe3G7qP6o9Tvl6cYzG1noCEUtZSmYts/EISwaukE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782287502; c=relaxed/simple;
	bh=DYe7VwFNV9j8vSBxh0sxvNFJ5tm4QCGE7sLXePjo40w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXFeqqspyt3HVWC5YJOm7QHMpXGMnH/9YqeY7NAacYKuSx+v47UKExanShaaEWPPfyw8XfSz9wnDFP6QN4yR1qAzX1cj35Gxg45sjGKRVSD/UKZb6BhRSXh4o2swfFr01cKRmKI6zyXKmTTXWy0D8rG86eXmMWg54FcQbyRhIko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jluGIgQo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jluGIgQo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F291F000E9;
	Wed, 24 Jun 2026 07:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782287501;
	bh=NSEEVjv1/4kjXV4htQAieMuaFZE2MmtV1l1wYqenhLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jluGIgQojegfwtFhgq8ElqtfozWVNevAYkAS+7eRG+5ceLHulNoFDgbgOEEPKDyhJ
	 rbm/gwN+vQMLxFYA1EKDHmd394oQelcS9Jaq97jgrREgjDnNN7a9pMacaUm4x2+pmW
	 64eNX4jO8ucN6Gv3yu7V/rY/iDYJp0UexXaPfmRRPSAmlb35XxBrRona04RJngU6MQ
	 qZ0zueAe2rc5pEB/JgIcQ8wcNJaPcir9l9ZiQKeZZjB6MK2L29on4OIUo/Gr3XdPAs
	 xlCj+e6aRRXmKQvlXyY4jOWTWCCG+tB0Mh8wuQRjtiMuOvC4p/p7PfIdPVDWrqY+C1
	 DPhx5f6suev1Q==
Date: Wed, 24 Jun 2026 09:51:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Eduard Bostina <egbostina@gmail.com>
Cc: daniel.baluta@nxp.com, simona.toaca@nxp.com, goledhruva@gmail.com, 
	m-chawdhry@ti.com, Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: Convert TI OMAP2420 MMC to DT schema
Message-ID: <20260624-frisky-wakeful-wombat-d1be2d@quoll>
References: <20260623094336.4172741-1-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260623094336.4172741-1-egbostina@gmail.com>

On Tue, Jun 23, 2026 at 09:43:35AM +0000, Eduard Bostina wrote:
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ti,hwmods:
> +    description: |
> +      Name of the hwmod associated to the MMC controller. Must be
> +      "msdi<n>" where n is the controller instance starting from 1.
> +    $ref: /schemas/types.yaml#/definitions/string-array

You should not use different type than already used and currently this
is a string (so also no items below).

> +    items:
> +      - pattern: "^msdi[0-9]+$"

"^msdi([1-9]|[1-9][0-9]+)$"

> +
> +  dmas:
> +    maxItems: 2
> +
> +  dma-names:
> +    items:
> +      - const: tx
> +      - const: rx

Best regards,
Krzysztof

