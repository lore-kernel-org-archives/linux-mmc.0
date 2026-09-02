Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5603822BB;
	Wed,  2 Sep 2026 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788340133; cv=none; b=qukL7TTyt5odHYTOwvAzec+6Q4NtttED7GSA/1aJRTXeESTsRtmTn6VLR98jrPXG49XcVLzRpWLQ2cti+A1RfmBkSh8geuV2LHTDH2AjjMqaXrZX9rTxSeYnWwx8eZd6Cla6OOoqGdOz5NRi8QRs9GgI6lnk0GNRkYK+OCsCok8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788340133; c=relaxed/simple;
	bh=hTh4HBi65e2CL/jq9QhwS1KD6mlQLO9gDKYGyzttA9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dY+00Z4Aq7NWxh+BBG1Pc9Gojrdd+blDQ0sS1Ginz5hz0Sx2iHdtAU7afFd4usXRPrq/suzb7dIyZGtNMaMksEB3xQs48MwN5oS6V5CY7W57LBLAAgz7PSDKmeaqeik3iAp11PRjXIGccwc0D5gnqw9Aom4kM6QW3Cais9ArL/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7sy56P8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7sy56P8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC791F000E9;
	Wed,  2 Sep 2026 09:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788340132;
	bh=57eOIaezP+hfLNeUwLOZ+++HYmzSI+z2PdmfbE2HKHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N7sy56P8LU6FDPUOQUKPTkTwhFsYbHk90hEOETJV7y2tEj9viu1+/gUCh7+DmjtJn
	 rwARPV6Di3pPa1/grQQ+xDpknQz+8KhttgrZ5DMP/6Z4XO6qgLdjxi0y0Le42LKZlu
	 ZwnfJlS4odbqOl2a58CATEjJM4pLHDEpGZ0K/fJhgR51dRnH9QiHtypWUQ2wfak3NP
	 xUpPHY7/ljvCBo8iqoMOroDVkJ+njt0+Avp+NNxtZ8swNUEcHCOCErQa8ENqyKdeYx
	 SnT2Ipmfht3fmDJ++6rvse+XwOXRgawn6VGXFIAybWGQdPh4sZktJu5p2y8pXU4Ol3
	 I5NJuprHlYy2Q==
Date: Wed, 2 Sep 2026 09:08:49 +0000
From: Yixun Lan <dlan@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, robh@kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
	spacemit@lists.linux.dev
Subject: Re: [PATCH 1/4] dt-bindings: mmc: spacemit-sdhci: Add
 clock-frequency property
Message-ID: <20260902090849-GKA1974@kernel.org>
References: <20260902-07-k3-sdhci-dts-v1-0-4e7909cf4233@kernel.org>
 <20260902-07-k3-sdhci-dts-v1-1-4e7909cf4233@kernel.org>
 <20260902071128.2EC4B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260902071128.2EC4B1F000E9@smtp.kernel.org>

Hi All,

On 07:11 Wed 02 Sep     , sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Introduction of a redundant custom clock configuration property, bypassing standard Device Tree mechanisms.
> --
> 
> commit 1745887406b566692891c256f7b9ab7126926f90
> Author: Long Wan <long.wan@linux.spacemit.com>
> 
> dt-bindings: mmc: spacemit-sdhci: Add clock-frequency property
> 
> This commit introduces a custom clock-frequency property to the
> spacemit-sdhci device tree binding. The property is intended to define the
> initial rate of the IO clock based on board layout validation.
> 
> > diff --git a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
> > index 34d202af909f2..f35bf7ce08dd8 100644
> > --- a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
> > @@ -29,6 +29,13 @@ properties:
> >        - description: core clock, used by internal controller
> >        - description: io clock, output for SD, SDIO, eMMC device
> >  
> > +  clock-frequency:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Rate of the io clock in Hz. When present the io clock is programmed to
> > +      this rate, allowing a board to select the rate its layout was validated
> > +      at.
> 
> [Severity: Medium]
> Does this property reinvent standard clock configuration mechanisms?
> 
> In modern Device Tree design, setting the initial rate of a clock provider
> consumed by a device is typically achieved using the standard assigned-clocks
> and assigned-clock-rates properties, which the core clock framework processes
> automatically.
> 
Ok, using assigned-clock-rates works here, will just drop this patch

-- 
Yixun Lan (dlan)
