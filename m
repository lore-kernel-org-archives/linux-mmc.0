Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A46C36BCC3;
	Wed, 18 Mar 2026 07:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820499; cv=none; b=s9TS3sa4H6joRI2H2AC7ZWjo9TTZ8w8eg21cWRsPShUxZPxH6Afiex/7YvfLlnLh7spVIwD5YVcwkvqT/hWuREtdHfHznz1aeWyRpWeZIhIkttiREU+kfpjGZeegy9Fo0TWyY9GIA1CR0CcME5NnJCc/FS0KSdoOxIZUB1PTSI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820499; c=relaxed/simple;
	bh=N6cd1DK0Kllt8jT0L6RRnZfk0S+Wf0Q5OKZrj6RgUR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+E3WLA/MAdGZW1T6ld822ZNo9OFp85lYC9LcRRzmHdc3Swrf8DBvgAy6nbJREOUvdZR9+VWY6XihYxrIpazR+tMTt7LaRZdtp9DzJRxiY+BA0j/54JNxo23a0PDR9LbFyWUQ6PJfe9wwiJfCLQraGdULdnHbdmxPgDgCwySfwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrmaJoSL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrmaJoSL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73269C19421;
	Wed, 18 Mar 2026 07:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773820499;
	bh=N6cd1DK0Kllt8jT0L6RRnZfk0S+Wf0Q5OKZrj6RgUR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DrmaJoSLYjPRCs7DRpxicubv3U5QaPhq+488+AQX8dcYmEavnuAOs2G76mN5fFOIq
	 6bpAl2gVrXOgbV4z0l9rTcTULZKFmGYPPMmJ4JFwvFZ2iIa0UAOB+qXWu+MzVap2dc
	 x5UwJCt97AiEpGSl7jyRpvVUUI/aho9cN6IG71u5w8Frm3CNbSGOvh14b3ZR5tPBtm
	 xVVODjI+b67MdwHxPFaDGAttosT4cTffNeiXeudYIWxeY0JPWa2UxgGkXloXxCS4xv
	 BTk4MBcsyYnj63QpdwFnQjKcwdk8w5dwiO4fqFOC13f0fncEZR5NaXP2dC0nfoztVX
	 kzfkTOHd2/V0w==
Date: Wed, 18 Mar 2026 08:54:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Ryan Chen <ryanchen.aspeed@gmail.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Andrew Jeffery <andrew@aj.id.au>, linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mmc: dt-bindings: sdhci-of-aspeed: Add AST2700
 fallback compatibles
Message-ID: <20260318-abiding-sloppy-poodle-efd3e5@quoll>
References: <20260317-sdhci-v2-0-39b1f063061b@aspeedtech.com>
 <20260317-sdhci-v2-1-39b1f063061b@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260317-sdhci-v2-1-39b1f063061b@aspeedtech.com>

On Tue, Mar 17, 2026 at 01:56:42PM +0800, Ryan Chen wrote:
> Describe AST2700 as compatible with the existing AST2600 SD controller
> and SDHCI bindings by requiring fallback compatibles in the device tree.
> 
> Also require `resets` on the AST2700 SD controller node.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
> Changes in v2:
> - add missing blank line
> - modify ast2700 compatible items const

Why?

> ---
>  .../devicetree/bindings/mmc/aspeed,sdhci.yaml      | 39 +++++++++++++++++-----
>  1 file changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> index d24950ccea95..9c8e068964a1 100644
> --- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> @@ -22,10 +22,14 @@ description: |+
>  
>  properties:
>    compatible:
> -    enum:
> -      - aspeed,ast2400-sd-controller
> -      - aspeed,ast2500-sd-controller
> -      - aspeed,ast2600-sd-controller
> +    oneOf:
> +      - const: aspeed,ast2400-sd-controller
> +      - const: aspeed,ast2500-sd-controller
> +      - const: aspeed,ast2600-sd-controller

No, previous code was correct.

Is this some microslop LLM product? I questioned style last time and now
we got random changes without explanation.

Please confirm - did you use any LLM microslop tools to create this
patch? Please also confirm - who internally reviewed this patch before
posting?

Best regards,
Krzysztof

