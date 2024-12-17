Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976AF1F2C23;
	Tue, 17 Dec 2024 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734439398; cv=none; b=YFt7KBDZswcybKCr9uKLBOZbmX9qb7g51EDlPpwv+/m7uOYGG2sROSOpvJynQzSTTy/mgRQ+UsTLrRpKwxaE0i3wNcJVJ5IGOhDm98wXAVQPWrgchd2a3J75v86fVPDphGxQY2hVEd92X67gHCPg8tM1+NtFzsZDRiNLgK37xUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734439398; c=relaxed/simple;
	bh=YJD5j6axAfcKPnmYpT9mtMCTx0yWBgcnrv0V5xHFMqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPV5v2Jrw9mHCY4HMjVtKQ7OwOBbuQbBWHC/oZsUWJFA4WxP4oy/HocXkqKFHGf9LzL8MnUGg/llJcVF0Xlo6ZHFhSc441oUe3jujy54oUt1MMNOXgqWouPeqwrFrjIP80GzcMfvmOdHg8fx+ShgSKfXqKjU4XO4+QsnC098GJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=na08JaC7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="na08JaC7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C050FC4CED3;
	Tue, 17 Dec 2024 12:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734439398;
	bh=YJD5j6axAfcKPnmYpT9mtMCTx0yWBgcnrv0V5xHFMqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=na08JaC7s/BwOgzsBqRm2F22zocI122O+xG8ZxTDuDT5FKgrTByKNw2z4fzDbXrm8
	 tkoUxAYA1yuHxYivexqtwP/hMF9OH5ujj0OWej9qqjSR1X1D9Uie+IrHdJR51cpSUv
	 tUAslkLgIcfr5ePMA5VrihVuhFWrSPWM1V/oeqYfC9jgMRoUsI/5iRWKm3uYu9a6No
	 sDOj6f2uy2FczZDWYeRZGZabMHmcnO2XgKnjnWbN1CJ1QRwhlyXaej6o5Adw/9nUR4
	 chvLT0TJvRxdZevDujgGvLhrT9aJ6ThmuF5Xj9uVGnLPw4TPWbxWoTD9jmRbDkBm+M
	 sWTVhz0HQlonw==
Date: Tue, 17 Dec 2024 06:43:16 -0600
From: Rob Herring <robh@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Aubin Constans <aubin.constans@microchip.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: mmc: atmel,hsmci: Convert to json schema
Message-ID: <20241217124316.GA1136537-robh@kernel.org>
References: <20241209-hsmci-v2-1-b5a6d7c59b67@microchip.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209-hsmci-v2-1-b5a6d7c59b67@microchip.com>

On Mon, Dec 09, 2024 at 10:02:30AM +0530, Dharma Balasubiramani wrote:
> Convert atmel,hsmci documentation to yaml format. The new file will inherit
> from mmc-controller.yaml.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
> Changes in v2:
> - Drop the duplicate properties in the slot node.
> - Link to v1: https://lore.kernel.org/r/20241205-hsmci-v1-1-5a25e622dfed@microchip.com
> ---
>  .../devicetree/bindings/mmc/atmel,hsmci.yaml       | 110 +++++++++++++++++++++
>  .../devicetree/bindings/mmc/atmel-hsmci.txt        |  73 --------------
>  2 files changed, 110 insertions(+), 73 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/atmel,hsmci.yaml b/Documentation/devicetree/bindings/mmc/atmel,hsmci.yaml
> new file mode 100644
> index 000000000000..26686ada6288
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/atmel,hsmci.yaml
> @@ -0,0 +1,110 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/atmel,hsmci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel High-Speed MultiMedia Card Interface (HSMCI)
> +
> +description:
> +  The Atmel HSMCI controller provides an interface for MMC, SD, and SDIO memory
> +  cards.
> +
> +maintainers:
> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> +  - Aubin Constans <aubin.constans@microchip.com>
> +
> +allOf:
> +  - $ref: mmc-controller.yaml
> +
> +properties:
> +  compatible:
> +    const: atmel,hsmci
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  dmas:
> +    maxItems: 1
> +
> +  dma-names:
> +    const: rxtx
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: mci_clk
> +
> +  "#address-cells":
> +    const: 1
> +    description: Used for slot IDs.
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^slot@[0-9]+$":
> +    type: object
> +    description: A slot node representing an MMC, SD, or SDIO slot.

There's a schema for slots now queued for 6.14[1]. You should use that. 
One issue is 'compatible' is required. Either that would have to be 
dropped as required or you could just add it in your .dts files.

Rob
