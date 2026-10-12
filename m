Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0855283FE5;
	Mon, 12 Oct 2026 08:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794908; cv=none; b=i+ELZlUvTwOGp14wpHjKeGqqlKjMaBecvaEtxrq1GUiDFHOYPvP7fJbfKnKcF0bD85anteAypW5mzPYe8zJi/mzdq/IGhaCiVSDlvaNIKQJO6RTgLcS2RVjCsIkFeFZSzfzt8fElzNRf9R4dNwPMVM8el/8Sucv45Hz82uphRtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794908; c=relaxed/simple;
	bh=TYFiB0tNnd/72B3ne3cOgEkkNoHhoEfvK6O7CnYI99c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIJPNjSMyZlW34MgupfcP+rkNtIvkCJi//r5GpNkI2dr/WGK6nrEextvPkJI/L7RwGemf9noJlxWZiMK2cTefVKI8d7DBhuJysqsh7r1gGQNEutoXVfAz32mBAEcdQusTVLg3WNJ76PuywSP3jRuMcfHvZphKuyUr5gaYhEgPG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYEqFSLz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYEqFSLz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C6C1F0089B;
	Mon, 12 Oct 2026 08:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791794906;
	bh=iQ8Aespnn0g3VnguJP6XSqwJAP+gOegBjYI/7U1C5BQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NYEqFSLzIXtJ426tZLZHou1wUySfopity/7cEarAufcL+tOCHtsDiUvHwCTGsBJP0
	 Mr1T9BDwDGUbEwxNOaSRWp6p7uF0hCnFaAXm8SSKkjVX9uKWpq1uu9IT0bwjV86OK0
	 7THla2Zz+WQif8deOkP5NfdJMNHiBIK5lblJZ7veSy8l7Ffx4GbFN7iZ09yElWNcQa
	 KoPPbtg/u4EeGr64NkyT9FoKZcpPQ6EknXoeu73jHJkbGlafEKQ4Mok7N0X3xk/ygJ
	 T1su92E3ds2+aeId4zSG6ja8RwGBZ7Z3LaRRiThhwJl6Q/O1LVusaEPXWsAbMECrw8
	 VrAU6fqDU1K/Q==
Date: Mon, 12 Oct 2026 10:48:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: tze.yee.ng@altera.com
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: mmc: cdns,sd6hc: add SD6HC DDR50
 read-path tuning
Message-ID: <20261012-futuristic-worm-of-camouflage-cc2e3e@quoll>
References: <cover.1791459448.git.tze.yee.ng@altera.com>
 <5ea5d406b527cb9b7015693191c9bdeb9202a1bc.1791459448.git.tze.yee.ng@altera.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ea5d406b527cb9b7015693191c9bdeb9202a1bc.1791459448.git.tze.yee.ng@altera.com>

On Fri, Oct 09, 2026 at 10:14:50AM +0800, tze.yee.ng@altera.com wrote:
> From: Tze Yee Ng <tze.yee.ng@altera.com>
> 
> DDR50 has no CMD19 tuning, so the SD6HC read path must be centred by
> static, board/SoC-characterised PHY settings. Add three optional SD6HC
> properties for the extended-read DDR modes (SD DDR50 and eMMC DDR52):
> 
>   - cdns,ddr-read-dqs-delay-ps: read-DQS delay in picoseconds that centres
>     the read eye (default 0).
>   - cdns,ddr-no-lpbk-dqs:       disable the loopback DQS read strobe and
>     use the fabricated phony DQS instead. Loopback DQS is the recommended
>     default; set this only on boards that need the phony DQS read path.
>   - cdns,ddr-phony-dqs-timing:  PHY_CTRL[9:4] phony DQS assertion timing.
>     The driver derives this from the RE# pulse width; this property
>     overrides the computed value for boards whose flight time shifts the
>     DDR data return.
> 
> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
> ---
> Changes in v2:
> - Retitled to "dt-bindings: mmc: cdns,sd6hc:". (Tanmay Kathpalia)
> - Renamed cdns,ddr50-* -> cdns,ddr-*. (Tanmay Kathpalia)
> - cdns,ddr-read-dqs-delay-ps is now in picoseconds. (Krzysztof Kozlowski)
> - Replaced the read-DQS source selector with a cdns,ddr-no-lpbk-dqs
>   boolean. (Krzysztof Kozlowski)
> - Reworded the phony-dqs-timing text. (Krzysztof Kozlowski, 
>   Tanmay Kathpalia)
> - Dropped the SD4HC note. (Tanmay Kathpalia)
> - Scope the new properties to the extended-read DDR modes (DDR50 and
>   DDR52). (Tanmay Kathpalia)

There are no lore links in the cover letter to previous versions and b4
diff fails.

b4 diff 'cover.1791459448.git.tze.yee.ng@altera.com'
Looking up cover.1791459448.git.tze.yee.ng@altera.com
Checking for older revisions
Grabbing search results from lore.kernel.org
---
Analyzing 5 messages in the thread
Could not find lower series to compare against.

Why aren't you using b4 to send patches? Why making it difficult for us?

> ---
>  .../devicetree/bindings/mmc/cdns,sd6hc.yaml   | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml b/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
> index d5ea2717904b..911ce58f8dab 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
> @@ -74,6 +74,36 @@ properties:
>      maximum: 1000
>      default: 24
>  
> +  cdns,ddr-read-dqs-delay-ps:
> +    description: >
> +      Read-DQS delay (DLL_SLAVE[7:0]) in picoseconds that centres the read
> +      eye in the extended-read DDR modes (SD DDR50, eMMC DDR52), which have
> +      no CMD19 tuning. The PHY runs the DLL bypassed in these modes, so the
> +      driver converts this to delay elements (divided by
> +      cdns,delay-element-ps). The 8-bit field holds at most 255 elements;
> +      larger values are clamped to that limit.
> +    minimum: 0

Drop, 0 is the default.

Where is the maximum value?

> +    default: 0
> +
> +  cdns,ddr-no-lpbk-dqs:
> +    description: >

Drop > everywhere

Best regards,
Krzysztof

