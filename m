Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F2630BF6B;
	Wed,  6 May 2026 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073892; cv=none; b=R4BaZWJimp9WfhI8Vhdnc83UZ/LBRaJlCo6PUudle2j5kmo39sKrUPxMAT5GWrcYZHF3NDRMUji09+aXhenFTQs7FuoLXUFu+8a6wOe/3VGa06kDNbN+zGNd3RLpjpf21t30nSV5xYLdkzq7U8gHSc5gB+mA3WD7PS4+kSgNVaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073892; c=relaxed/simple;
	bh=KBdPCA7WqEzlXbX6sx7AIpxIm+mcvsDlaeSMWNZqW4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BHL52xz556kTzwU6ozF20gK1GrTHlKWoFfdh1q7vuPC8OtScCHgEp8VqwkPnRBdQI0XS5KJGlbPGRwLsIrkyzs/2vYKIbpeJ/LcZ+ojOBWX05dUq0cxIR5kOCdg8F72xVxbuRNhjr+QE0LZXzAmTrebCKL6K1PYD1Rw0qVMDuL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnhLWjdj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnhLWjdj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89500C2BCB8;
	Wed,  6 May 2026 13:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778073891;
	bh=KBdPCA7WqEzlXbX6sx7AIpxIm+mcvsDlaeSMWNZqW4E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dnhLWjdjcB85BCksEOsYETDm11pnnkv3yP24sIU6FIManXsMJ7dFahkQIHbmrTcY+
	 qIJTQTO6qq3MfuxajunDNQPFobTLiZgOo4IJk5AM248sBhgMfX4XRv4cWy54gowgbB
	 y3jAS/QqvOJKsmh2ajHTcJjNfBUifcIrqzv8X6lbXsTX07j2+CK8YvhakjsmxFozk2
	 Z3I3oksig/VmS2cKqZyK3CKxIwf5XVZL9W8jl3+hhNsx/IB+3Sk825a0mR/REY2JKz
	 5VSp49IldZjboehsv8+q3cVuVo9nkYu4a3msLQXCaILnrv2n3U4yv8Ke/09SvPSkl5
	 ds6NBUt/noKZg==
Message-ID: <0d9b9a53-2743-4202-96dc-0b922c48f375@kernel.org>
Date: Wed, 6 May 2026 15:24:46 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: cdns,sdhci: Add CQE support
To: rohan1sj@cadence.com, Ulf Hansson <ulfh@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mparab@cadence.com, pawell@cadence.com,
 sjakhade@cadence.com, mpillai@cadence.com
References: <20260506-cdns_sdhci_cqe-support-v2-0-754fe4de8b65@cadence.com>
 <20260506-cdns_sdhci_cqe-support-v2-1-754fe4de8b65@cadence.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260506-cdns_sdhci_cqe-support-v2-1-754fe4de8b65@cadence.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/05/2026 11:04, Rohan Joshi via B4 Relay wrote:
> From: Rohan Joshi <rohan1sj@cadence.com>
> 
> Cadence host controller can support CQE. Add optional CQE
> register space and reg-names property to cdns sdhci binding
> 
> Signed-off-by: Rohan Joshi <rohan1sj@cadence.com>
> ---
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml        | 41 +++++++---------------
>  1 file changed, 12 insertions(+), 29 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index 8902e7925eab..79064282fabc 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -26,7 +26,9 @@ properties:
>  
>    reg-names:

There are no reg-names in this file.

>      minItems: 1
> -    maxItems: 2
> +    items:
> +      - const: hc
> +      - const: cqhci
>  
>    interrupts:
>      maxItems: 1
> @@ -138,22 +140,16 @@ allOf:
>            items:
>              - description: Host controller registers
>              - description: Elba byte-lane enable register for writes
> +        reg-names: false

Why?

> +      required:
> +        - resets

Why?

>      else:
>        properties:
>          reg:
> -          oneOf:
> -            - items:
> -                - description: Host controller registers
> -            - items:
> -                - description: Host controller registers
> -                - description: CQE (Command Queue Engine) registers
> -        reg-names:
> -          oneOf:
> -            - items:
> -                - const: sdhci
> -            - items:
> -                - const: sdhci
> -                - const: cqhci
> +          minItems: 1
> +          items:
> +            - description: Host Controller registers
> +            - description: CQE (Command Queuing Engine) registers

Why each device has CQE? If each, then why not Pensando?



>  
>  unevaluatedProperties: false
>  
> @@ -161,7 +157,8 @@ examples:
>    - |
>      emmc: mmc@5a000000 {
>          compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
> -        reg = <0x5a000000 0x400>;
> +        reg = <0x5a000000 0x400>, <0x5a000400 0x060>;
> +        reg-names = "hc", "cqhci";
>          interrupts = <0 78 4>;
>          clocks = <&clk 4>;
>          bus-width = <8>;
> @@ -170,17 +167,3 @@ examples:
>          mmc-hs400-1_8v;
>          cdns,phy-dll-delay-sdclk = <0>;
>      };
> -
> -  - |

What are you doing here?


Best regards,
Krzysztof
