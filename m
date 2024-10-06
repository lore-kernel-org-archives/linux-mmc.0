Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FEA54F95;
	Sun,  6 Oct 2024 12:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728218269; cv=none; b=LZ9O7uFO/o1wRBwV6aRLbRpCdnuS32JSCYHzlzZeAQfZSEgDt2luCgMzNWFGKUwEvn2wjS7yeysDPNko/cRPCKPdOoUYqwnLPT2M0YtTdgaHHyY8X40Q4iEz+xpkKMmP00JNqTH6ZN41gOn47ZO0S+I6wTczUrAdR7//sArsjYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728218269; c=relaxed/simple;
	bh=Fd+4pPjg8zZxyNMkxDrxwDPUzAaVg1js2zv7hz1NOZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiUymw02EEqMDtKk48J6EBDbBmksxegRcF6WyA+lHuPtsoQPB6x+8oaI1yPukVteq7jgCchEv9qg/ExTW4hAfMhyMcC8Jbr3IilWNyi2e6xBbi/fO6VzSi7+vPAhvL+kYftRE5dm2JwLEj//UdYWX3Z2C8JGcnNfrlEiTEuIAcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKx73EZg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKx73EZg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD2FC4CEC5;
	Sun,  6 Oct 2024 12:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728218268;
	bh=Fd+4pPjg8zZxyNMkxDrxwDPUzAaVg1js2zv7hz1NOZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fKx73EZgQIgXeNWoPgGTF5DsxrGqTVsCgnLO6OLa77UQaWfb6+nbL2YZH2S3D8Zp9
	 XIU2cbub5F9eXwyr/vu935kEnwyLSEq3lYA66vaCGATBJLfr9r1JiI6+fV8XERI4Zl
	 yK2PhoB0qcUM4P08RiEjCWElzfeKR4JkM/va9OaHusfrKpRDF/Agfu/1APFeXR7nRb
	 MNSGiMasW/bg0BVK2owtmxqTicxBNZ5vN5a/ro/he+ELlc8RdVDTtdb3O0MkHR23OH
	 Vac2PdLPOjVVVTWMVFbVpJRi0ZRqrZsjhSLwA+0k8pHojq+jAMJtkqwycf0yvcEFW0
	 2UXK3RkiekJWw==
Date: Sun, 6 Oct 2024 14:37:43 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, p.zabel@pengutronix.de, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, m.felsch@pengutronix.de, 
	bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH 1/2] dt-bindings: mmc: mmc-pwrseq-simple: add support for
 reset control
Message-ID: <kpg2cwn7eq7wclpmcudwmygqzzn7s5fb4i7c2dbjlks5bttghs@aekop3ugv26s>
References: <20241004120740.2887776-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241004120740.2887776-1-catalin.popescu@leica-geosystems.com>

On Fri, Oct 04, 2024 at 02:07:39PM +0200, Catalin Popescu wrote:
> Add compatible value "mmc-pwrseq-simple-reset" to support reset control
> instead of gpios. Reset controls being refcounted, they allow to use
> shared resets or gpios across drivers. Support of reset control is
> limited to one single reset control.

Driver support is not that relevant to the bindings.

> 
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
> ---
>  .../bindings/mmc/mmc-pwrseq-simple.yaml       | 21 +++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml
> index 00feaafc1063..da218260af01 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml
> @@ -16,12 +16,13 @@ description:
>  
>  properties:
>    compatible:
> -    const: mmc-pwrseq-simple
> +    enum:
> +      - mmc-pwrseq-simple
> +      - mmc-pwrseq-simple-reset

Nope, that's the same device.

>  
>    reset-gpios:
>      minItems: 1
>      # Put some limit to avoid false warnings
> -    maxItems: 32
>      description:
>        contains a list of GPIO specifiers. The reset GPIOs are asserted
>        at initialization and prior we start the power up procedure of the card.
> @@ -50,6 +51,22 @@ properties:
>  required:
>    - compatible
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mmc-pwrseq-simple-reset
> +    then:
> +      properties:
> +        reset-gpios:
> +          maxItems: 1
> +    else:
> +      properties:
> +        reset-gpios:
> +          maxItems: 32

So basically they are the same... Sorry, this all patch makes little
sense to me. You are not doing here much. It's exactly the same device
which you now describe in two ways (first no-go) but the two ways are
actually the same (second no-go).

Best regards,
Krzysztof

