Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC70F7350E;
	Tue, 11 Jun 2024 20:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718137394; cv=none; b=WsMoowsAO/I+REqRoxcN2VSFo9rOt1qvl9KQxIn5L+fxPW+6Rc+A/XQ+MIMBaEiJeB71hksJT2S3JSbxyDqc2+aQKBrPXrVfanrhahz62oxiIkvvk47PUxU2VBEshbK+cO8TaaPOlUmJFVrdMdM2u3z4LFE2C0hhye2BoBYcTww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718137394; c=relaxed/simple;
	bh=56NOMgdsoxv7ugc+ao6X6J5QmSuvu4JChgfjXogleMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fy1J9EBA65DbVrk8il+eIlwN/v32SYVJqWh7dnlDtxbdoBiL+vOVGU5izWpliwLrEmyE0fA2Z1gbqCJt4EoEbVXXuWQRIXvZ/8eP3czz/6LU8uZ+lsFt8hQu5JyWOoagMv+dcWItq9XJM2KH3oehsoE2d7GY9g71FLqUUx9PzU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUVtHTD+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUVtHTD+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E708AC2BD10;
	Tue, 11 Jun 2024 20:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718137393;
	bh=56NOMgdsoxv7ugc+ao6X6J5QmSuvu4JChgfjXogleMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TUVtHTD+w/kTSIrjuW9puv0jtLqV5sx4w5q2Sq5hPhdc/gbV9VUlDReL9JiSnuzXq
	 Vno81Y9nhfHacE7rS+MKwGs+UAVaTcbHX+ZyoFhmPHlhBh2ZL4qEIdrDj4VDPX4/4J
	 KxQNFqcKrS6Ds/JYog6j/FJLtwHh24UhhgBQ9lwxkBqZjMF490WVFxoJ4p0lCZhQt4
	 TIsxSktoFBXqKlhSJFKYr7mwKUXYufcall3mTa/cdnz74amEMeXZd9ReaZZdBtQ/50
	 dQh+bcge7VuRkTxZbPLYyqzYi+9J/AVNR7MeNWeO4MSZuTTX/i//UtDiCPnSofEMz3
	 JuTWOdSrUCVgQ==
Date: Tue, 11 Jun 2024 14:23:11 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 2/8] dt-bindings: mmc: mmc-spi-slot: Change
 voltage-ranges to uint32-matrix
Message-ID: <20240611202311.GB3003237-robh@kernel.org>
References: <20240611-ls_waring_esdhc-v4-0-d0d8a5b3f3cb@nxp.com>
 <20240611-ls_waring_esdhc-v4-2-d0d8a5b3f3cb@nxp.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611-ls_waring_esdhc-v4-2-d0d8a5b3f3cb@nxp.com>

On Tue, Jun 11, 2024 at 12:01:47PM -0400, Frank Li wrote:
> According to common mmc core, voltages-ranges should be matrix.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> ---
> Not sure why it impact other mmc yaml's voltage-ranges.

It's a quirk of the tools. When decoding properties, the tools only know 
all possible types. Types are global, not per binding. Sometimes it can 
be figured out, but cases like this cannot be.

> ---
>  Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
> index 36acc40c7d181..05815b837219d 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
> @@ -27,17 +27,20 @@ properties:
>      maxItems: 1
>  
>    voltage-ranges:
> -    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>      description: |
>        Two cells are required, first cell specifies minimum slot voltage (mV),
>        second cell specifies maximum slot voltage (mV).
>      items:
> -      - description: |
> -          value for minimum slot voltage in mV
> -        default: 3200
> -      - description: |
> -          value for maximum slot voltage in mV
> -        default: 3400
> +      items:
> +        - description: |
> +            value for minimum slot voltage in mV
> +          default: 3200
> +        - description: |
> +            value for maximum slot voltage in mV
> +          default: 3400
> +    minItems: 1
> +    maxItems: 8

From what I remember, SPI mode doesn't support voltage changes. 
Switching to 1.8V came much later in the spec. So it should be 
'maxItems: 1'. Or better yet, make the outer 'items' a list (of 1 
entry).

Rob
