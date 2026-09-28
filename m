Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB9F46D566;
	Mon, 28 Sep 2026 08:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582722; cv=none; b=iZB3jVaeee8eREwt9AZVrdKqJmYDGAFHSzjcKR4CqeShoea+wjG2THUHl7eqboR1G8f4c46BKlzF1ZhVA+74r4YqoA7o5TJ4T7ID0INDYzrxChlVNLpY/GRhlMIl7Ld4Qtty/BpnXk7sSE5MLFHxUxVFYmXCYV52f1gBz1+DaN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582722; c=relaxed/simple;
	bh=CLE1hff59NfDaPqxetHMHCxnVK9pP11wBDO1IHdaMMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKl7d1c4QXY/cFXNn3wDFB7dDGEhPue4eFkJxhcCKTL0TJVOcsofPDkdA/FMu0WJb7JYYjeTHR/i7SJftohTHACvh8hs0/l7BnZDTP2JT6gx0T7rEgClpIkbHd/7F8wZWa/3EwLcS/NCPBygSq484q/zcAT6Oe/A/ugRo3CCepI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuJs//tE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuJs//tE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488351F00898;
	Mon, 28 Sep 2026 08:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790582720;
	bh=kMSliRECiOyVzb7mmb2oyO8TWYL1SDNQtZEnFZXRVXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RuJs//tEi1R/HBgjPWiAUFaTLnXlfDfe2P6LxrN7edYXtiO0bNjvXpxw1VRRpR5aU
	 nsw+I38VALfol5uxnd7Q+UqnzAGnoJMzdqD1noWbcJ9YqeZ3BUvQmo7ozUyQBm+ZzE
	 7mLgR3D7RweZgFeUCsq1XhluBv63VJkDVuFJVOvxixWWi9eR4cF8ndmfFceNDK7mEA
	 vTpBGohEtqHCSI0GQSCRihiiOxzM4tVcPfALAa1HL6Eea/uggDKLKJOpqBQ6smvquA
	 Z+GrqblCbwZzpfW1QAR7R2rubIie8wv60HNxE+zSjA4I1Hzv4lfCOkK075KlKeZsBZ
	 RK3cbAn1TaQOw==
Date: Mon, 28 Sep 2026 10:05:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: tze.yee.ng@altera.com
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>, 
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: mmc: cdns,sdhci: add SD6HC DDR50
 read-path tuning
Message-ID: <20260928-thoughtful-firefly-of-science-7fe3f5@quoll>
References: <cover.1790074790.git.tze.yee.ng@altera.com>
 <25649477d9967bb04b12c6e60b0ee76443f356af.1790074790.git.tze.yee.ng@altera.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <25649477d9967bb04b12c6e60b0ee76443f356af.1790074790.git.tze.yee.ng@altera.com>

On Tue, Sep 22, 2026 at 07:12:37PM +0800, tze.yee.ng@altera.com wrote:
> From: Tze Yee Ng <tze.yee.ng@altera.com>
> 
> DDR50 has no CMD19 tuning, so the SD6HC read path must be centred by
> static, board/SoC-characterised PHY settings. Add three optional SD6HC
> properties:
> 
>   - cdns,ddr50-read-dqs-delay:   DLL_SLAVE[7:0] read-DQS delay that centres
>     the read eye (0-255).
>   - cdns,ddr50-use-lpbk-dqs:     DQS_TIMING[21] read-DQS source
>     (0 = phony, 1 = loopback).
>   - cdns,ddr50-phony-dqs-timing: PHY_CTRL[9:4] phony DQS assertion timing
>     (0-63) that positions the fabricated strobe relative to the returning
>     DDR data; not produced by the Cadence timing calculation.
> 
> All three are disallowed for the SD4HC variant.
> 
> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
> ---
>  .../devicetree/bindings/mmc/cdns,sd6hc.yaml   | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml b/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
> index d5ea2717904b..df86872603d0 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
> @@ -74,6 +74,33 @@ properties:
>      maximum: 1000
>      default: 24
>  
> +  cdns,ddr50-read-dqs-delay:
> +    description: |
> +      SD6HC DDR50 read-DQS delay (DLL_SLAVE[7:0]) used to centre the read
> +      eye. DDR50 has no CMD19 tuning, so this is a board/SoC-characterised
> +      value. If absent, the driver default is used.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 0xff

default: ...

Also, look at the existing bindings. How are the delays represented? ps.
Why is this different?


> +
> +  cdns,ddr50-use-lpbk-dqs:
> +    description: |
> +      SD6HC DDR50 read-DQS source (DQS_TIMING[21]): 0 = phony DQS,
> +      1 = loopback DQS. If absent, the driver default is used.

Then this is just type: boolean

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +
> +  cdns,ddr50-phony-dqs-timing:
> +    description: |
> +      SD6HC DDR50 phony DQS assertion timing (PHY_CTRL[9:4]). Positions the
> +      fabricated read strobe relative to the returning DDR data; the correct
> +      value depends on the board's SD flight time and is not produced by the
> +      Cadence timing calculation. If absent, the driver default
> +      (REBAR_PULSE_CYCLES-1) is used.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 0x3f

Best regards,
Krzysztof

