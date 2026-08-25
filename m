Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3B33D4132;
	Tue, 25 Aug 2026 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787657749; cv=none; b=iAHuDgUVoKBZDNiu4VH+VpqCIBKc3FeliRmGbMco4ipyLIwCamkX/bY7U/VacMTA1USzkyeydtM3CDvUTqUp5SIdx4Sw5TEJB7KztB600aMbbtemx4d6QwffoTZgftpmV5Zw6LKy5HiGJjns6LFgGiadpz7I/PZnGKPpS8QzP/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787657749; c=relaxed/simple;
	bh=LyY5n4FuaDPJUu/4HPp5k1JnShQprIJdbBw0bb5+61Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yt9w0kIho/OU1+7kSOp2Kg61DXisaHkIIi4AoYSE15zmtl49VVmI0sL7iLwgmgu0ow+mxBMiakfSsrwGJrhVh6BEvttPFq+6xPUo0DbrUvkC7vD+8k/O9NspYEqAjOGd1m58nfBcG00DW3a93n0Y9hbKNDF2yXguNPwM6LBRSKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdMykINM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdMykINM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045AD1F000E9;
	Tue, 25 Aug 2026 11:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787657748;
	bh=PYeVr7Y1uH/33WLA9G3W/PuQTrelaF+8wJBGYrxlTvU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JdMykINMlfn3Ld/UmBqu2WHJIFNCMLnZ3ltjEKjrfdd2WbJAbDLDUMquzQ3lr2nDL
	 xlmfuQElX2/zx+goZK1CVJA04P7mWxQlbmHE6NsV8d3Mz1gGLI6CCugp9SnbP9KYmi
	 JIEhGqr4CwixDnuQbzJqSUyXreZFshPIKaLWbgmrzuxWBKfQWlHSxYcRAzTVDWAMJu
	 gx2pTBz4/vFkJkRIQQ4rAgT6JPDXWpfLM/+dWaOkZAq1tggEECyqzy/c0nt6c+xnEh
	 AH4cEHLsLGu6CaZNizAqlnXDzUlpWx5cpCLuWvALSISl2ad26TIxS47EWfEAqTuZsQ
	 nlqcq+gfP/org==
Message-ID: <519d44cc-2a67-4f15-addc-774ed8dfdb98@kernel.org>
Date: Tue, 25 Aug 2026 13:35:40 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: mmc: cdns,sdhci: Add CQE support
To: rohan1sj@cadence.com, Ulf Hansson <ulfh@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mparab@cadence.com, pawell@cadence.com,
 sjakhade@cadence.com, mpillai@cadence.com, razb@mobileye.com, blarson@amd.com
References: <20260825-cdns_sdhci_cqe-support-v4-0-e9f72e338373@cadence.com>
 <20260825-cdns_sdhci_cqe-support-v4-1-e9f72e338373@cadence.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260825-cdns_sdhci_cqe-support-v4-1-e9f72e338373@cadence.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/08/2026 13:10, Rohan Joshi via B4 Relay wrote:
> From: Rohan Joshi <rohan1sj@cadence.com>
> 
> Add optional named resource "cqhci" to map the CQE
> register space. When present, it is used for CQHCI
> initialization and enable Command Queue Engine for eMMC.
> 
> The "cqhci" space is optional to maintain compatibility
> for platforms that don't have CQE block. When absent, the
> controller can operate without the CQE block as routined.

routined? routed? What did you want to say?

Which platforms do not have CQE? Usually devices NOT having something
should have this resource disallowed/restricted. But your binding says
all devices have cqhci

> 
> Update amd,pensando-elba platform to include this resource
> since Elba does have hardware block required for CQE! The
> original author for Elba, Brad Larson (blarson@amd.com)
> was able to confirm the CQE support.


Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

> 
> Signed-off-by: Rohan Joshi <rohan1sj@cadence.com>
> ---
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml        | 28 +++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index 6c7317d13aa6..10bc9ac2073a 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -22,7 +22,14 @@ properties:
>  
>    reg:
>      minItems: 1
> -    maxItems: 2
> +    maxItems: 3
> +
> +  reg-names:
> +    minItems: 1
> +    items:
> +      - const: hc
> +      - enum: [bctl, cqhci]
> +      - const: cqhci
>  
>    interrupts:
>      maxItems: 1
> @@ -131,13 +138,27 @@ allOf:
>      then:
>        properties:
>          reg:
> +          minItems: 2
>            items:
>              - description: Host controller registers
>              - description: Elba byte-lane enable register for writes
> +            - description: CQE (Command Queuing Engine) registers (optional)

Schema says what is optional, do not repeat it in free form text.

> +        reg-names:
> +          minItems: 2
> +          items:
> +            - const: hc
> +            - const: bctl
> +            - const: cqhci

So are the names required now? If not then how does your driver work?

>      else:
>        properties:
>          reg:
> -          maxItems: 1
> +          items:
> +            - description: Host Controller registers
> +            - description: CQE (Command Queuing Engine) registers (optional)
> +        reg-names:
> +          items:
> +            - const: hc
> +            - const: cqhci

So now all devices have exactly two entries?

>  
>  unevaluatedProperties: false
>  
> @@ -145,7 +166,8 @@ examples:
>    - |
>      emmc: mmc@5a000000 {
>          compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
> -        reg = <0x5a000000 0x400>;
> +        reg = <0x5a000000 0x400>, <0x5a000400 0x060>;
> +        reg-names = "hc", "cqhci";
>          interrupts = <0 78 4>;
>          clocks = <&clk 4>;
>          bus-width = <8>;
> 


Best regards,
Krzysztof
