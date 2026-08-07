Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EE02C21F1;
	Fri,  7 Aug 2026 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111011; cv=none; b=ryMTb6zDZuhfa9aofWKhnGrOipLk5twLmUdB2IJFD322fpzC5IsOHpkaaEcqszK32ShK6yKj6fqf8xyWs69VE1kPR4VOUbRF+SLZAAtwnG9HMUQwnJwNi1IDNYg9HMd+O3D6tmMPKxk6XN5hH4ae4+LR/zWtq+m3ZphzbJe4qvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111011; c=relaxed/simple;
	bh=Q8124jl1mOacnezf+Ks9x7d0mYgCrxXRfVy4mLrv8gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVsI/u5TjBJgNY9bcPyx0hC9LFW+jLjJzEFoEU+/nMI3vClnrAUyFo/cYLUWP2VcIyS+4eSqpxRBRWDbbBVX2khfBCXX+JdmeQer/yWx9hJhcsP/jtSm9SehCoCu8+/HhwkUA25EMJYhlSQvqeoj4k5HiC4cviVAnlgDiMlScBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AENq5IgV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AENq5IgV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E72A1F00A3A;
	Fri,  7 Aug 2026 13:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786110999;
	bh=DxgY0bb4BOQCmncK6Z/sKqPNiJtjxxMvm+CmP1Xszak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AENq5IgVL8UdEra4AKauo4MZgTGd+xLA4oOKq2C7RhSXLEGRXEflKyktodLBqCY4g
	 by8mpX/XyB4R1/EcmbRjWFIpohrY/c7KW72/HRiOXkwj7eAexB+/oCnJHJgbkQIJS+
	 m3xYM+hfPmNnXGpMBwl00eAzq/bIq+dQjCticiLhgGiFWGlSUMyubmK+4LQItP/EC+
	 ZTSrlJYGF+N+OJARsEc0WDEKKTMg6ThT8itjaqBp1IzlAZJTBSrKAuUKT9/VAxBsBm
	 tSYs3jJye1Ai0RbZK+NfogxiJqkHsNYwCDZsTFnQVFxAidaCKSUsH1Co9zuagWFa/G
	 MVrt2Sm/CBBCw==
Date: Fri, 7 Aug 2026 08:56:38 -0500
From: Rob Herring <robh@kernel.org>
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: Ulf Hansson <ulfh@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Avri Altman <avri.altman@sandisk.com>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	Erick Shepherd <erick.shepherd@ni.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v7 2/3] dt-bindings: mmc: Add reset-card-at-resume
 property
Message-ID: <20260807135638.GA67309-robh@kernel.org>
References: <y>
 <20260805222500.2567801-1-kamal.dasu@broadcom.com>
 <20260805222500.2567801-3-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805222500.2567801-3-kamal.dasu@broadcom.com>

On Wed, Aug 05, 2026 at 06:24:59PM -0400, Kamal Dasu wrote:
> On some platforms, firmware or other hardware accesses the card
> during suspend/resume, before the kernel's own resume path has run,
> leaving the card in a state the kernel can no longer assume it knows.
> Add a flag property so such boards can tell the mmc core the card
> needs to be reset before it can be used again.
> 
> This is expected to be paired with keep-power-in-suspend on boards
> whose firmware needs the card to stay powered and live throughout
> suspend: since the card is never power-cycled, nothing else would
> force it back to a known state on resume.
> 
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
> Changes in v7:
>   - Added Krzysztof's Reviewed-by.
>   - No other change here; patch 3/3 now requires this property
>     alongside keep-power-in-suspend for (e)MMC rather than treating
>     them as fully independent in the driver -- see that patch's
>     changelog.
> 
> Changes in v6:
>   - New patch, per Ulf's suggestion: rather than fold "needs a reset
>     at resume" into keep-power-in-suspend's own meaning, describe it
>     as its own independent property, so the two can be combined only
>     where actually needed (brcmstb sets both; SDIO's existing
>     keep-power-in-suspend users are unaffected and set neither this
>     nor a reset).
> 
>  Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)

sashiko issue needs to be addressed
