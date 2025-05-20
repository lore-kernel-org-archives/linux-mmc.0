Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853821FFC54;
	Tue, 20 May 2025 19:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747771179; cv=none; b=VV2Odl2P6CQk7OH+0nxnq0BbRdDNuaaNlZymeGr63ht62VpmfRmWFNpEC2Pms3nrDv+jPasrxNz+nBkcsWcgBXUnLEHaViy0oF75Aj8Fy00qf5r3IExr8ZpLB7ndO7vjkXI6VAX9Ycy2xF8O8+XLNygQOloTVghz34U0eYxe+RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747771179; c=relaxed/simple;
	bh=pYVFlS69XDxsHN23lybt9RSWuBOvdx2W2TJ4J67ytOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBD3Opurd9VjWOBsGc9NXlZrWD1OgRnQ36b/UTmggWuQcQIcJi8be9U+eiz43cT53uNPO9acoY5VoaT7+ZiHn8RbERS9gB4jVo8ldFrSLkaHYx3HATJ4/srTrQrdDLVZHrE0EL22V7Hy5QZjpNbUGZ0x672RyRWUHCZxFNr9QQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eccU5JfO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eccU5JfO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C674AC4CEE9;
	Tue, 20 May 2025 19:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747771179;
	bh=pYVFlS69XDxsHN23lybt9RSWuBOvdx2W2TJ4J67ytOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eccU5JfOabmAf7qbz66mkoZeidMaFmn+BtKQqlt05ksQf5cbyiQ8YHrnIhRkvx2iV
	 pLi3Uvm9kdSDCdv8k7fMO+kJzIyfz7vPOTN9Az0cmsEF91UJID6ecvKQQCVkQB8kRx
	 DcrZh/S0v3v5xNwOVW3iysVp+5kBEyfqBifQVZlWGYteffmNeVV6iqNCDnO2QPhXeh
	 3e9C/mVqJ8XGLz07WQORwxVl/2QUmFhM4tFD7Az7Nv8oXlW7fkpcoeZhMoI+wUZtid
	 JpePLGkLIFBgKcbm9wwpSFRa343y45CPfdlOzj+rX/nYzJ1WXScoHyBb8OlqthNYvg
	 dZuJbJ7cYFc2g==
Date: Tue, 20 May 2025 14:59:36 -0500
From: Rob Herring <robh@kernel.org>
To: Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: mmc: ti-omap: convert text based binding
 to json schema
Message-ID: <20250520195936.GA1261173-robh@kernel.org>
References: <20250519-ti-omap-v2-1-2a0dbc08fb9c@gmail.com>
 <20250519-unstamped-tabasco-05d9c7223289@spud>
 <314cdaf1-b989-4cae-a275-d962186bd46c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <314cdaf1-b989-4cae-a275-d962186bd46c@gmail.com>

On Tue, May 20, 2025 at 10:06:50AM +0530, Charan Pedumuru wrote:
> 
> 
> On 19-05-2025 21:29, Conor Dooley wrote:
> > On Mon, May 19, 2025 at 01:11:17PM +0000, Charan Pedumuru wrote:
> >> Convert TI MMC host controller binding to YAML format.
> >> Changes during Conversion:
> >> - Add new properties 'dma', 'dma-names' under required.
> >> - Define two separate phandles for 'dmas' in the examples.
> >> - Include appropriate header file for interrupts and use
> >>   it in the examples.
> >>
> >> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
> >> ---
> >> Changes in v2:
> >> - Added include statement for irq interrupt controller and
> >>   modified the interrupts under property to use header.
> >> - Changed maintainer to Rob Herring.
> >> - Defined two seperate phandles for 'dmas' under examples.
> >> - Rename the YAML file name to the compatible 'ti,omap2420-mmc'.
> >> - Added missing type and maxItems to 'ti,hwmods' under properties.
> >> - Link to v1: https://lore.kernel.org/r/20250510-ti-omap-v1-1-588b0ccb1823@gmail.com
> >> ---
> >>  .../devicetree/bindings/mmc/ti,omap2420-mmc.yaml   | 64 ++++++++++++++++++++++
> >>  Documentation/devicetree/bindings/mmc/ti-omap.txt  | 26 ---------
> >>  2 files changed, 64 insertions(+), 26 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/mmc/ti,omap2420-mmc.yaml b/Documentation/devicetree/bindings/mmc/ti,omap2420-mmc.yaml
> >> new file mode 100644
> >> index 0000000000000000000000000000000000000000..195db77e0063b867f318ffc6b5f8811adb531515
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mmc/ti,omap2420-mmc.yaml
> >> @@ -0,0 +1,64 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/mmc/ti,omap2420-mmc.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: TI MMC host controller for OMAP1 and 2420
> >> +
> >> +description:
> >> +  The MMC Host controller for TI OMAP1 and 2420 family provides
> >> +  an interface for MMC, SD and SDIO types of memory cards.
> >> +
> >> +allOf:
> >> +  - $ref: mmc-controller.yaml
> >> +
> >> +maintainers:
> >> +  - Rob Herring <robh@kernel.org>
> > 
> > This patch looks fine, but I don't want to ack this with Rob's name
> > there. Tony Lindgren <tony@atomide.com> wrote the original binding
> > as far as I saw from a quick check, maybe he's a more suitable pick?
> 
> Sure, I will add Tony to the maintainers then.

Replace, not add.

Rob
