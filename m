Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5339C1BC39;
	Sat, 31 Aug 2024 06:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725085182; cv=none; b=T9LDDVEceiFcWrTlhNWFR9nZasezEkoPbzvDOvtue01Gnug1HRkLprFyAsG4HO4xImq24Wx4Ip8hSSnwtaq/dmOQkMUAMpChC+ud4b4M/sMSOgDp62Z4Mak4p1Na9jEWTi3pLYx/fo1uXH7koP3Ua5q3w4LARFYaKMed07eAxh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725085182; c=relaxed/simple;
	bh=5i1ejH31AgHdMEezPmR5r7ia7Xz2VlGh8jp3bOTfxAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8SBUwI22bRavWKx+pR8DZ4KvnsPtSFQwnl4ERgJTv2MCRiTQyWKe3QE7h/h9nkjnk64XUJUiwoayvd6Uy4owJnXof59d2Z886BjtJq/GhgcOprupH3PYLuh11aq17Sb1a5SyJbuxApbhBGdJyI3a9L4mbkItL6Hq9ebpxpj/P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qz7SeIV+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qz7SeIV+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CB3C4CEC0;
	Sat, 31 Aug 2024 06:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725085181;
	bh=5i1ejH31AgHdMEezPmR5r7ia7Xz2VlGh8jp3bOTfxAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qz7SeIV+TEDhZX1osB/1xQ0nkHYBuAZ0Imyol8CCxd0UcOL6NEyPcK1nIp7aEl/1N
	 ezQj+XAPUhKLMjIhaJkllUIdddFayppCUUN8fMXcU/34rBBGgFOf9li4F+Onp5g80w
	 CAjLStgRNogN4XZmFUw6J2Gh+V+0i282xZaAkrIryFMOZA2qge30Y2g+P/xLhkC3JX
	 2zaDrMs7N5iQHwnK6vAa83A59P/tbia8Z/Gel4QGF4/eiF/yLzjDBWwqfO6aXjtHDi
	 fZXR96ddX7XZQ1LCDUgQGe7ECeagj7iyq6DG52ovVoHCnGknhDKoLv/AdMJF/sWXKg
	 wtX2k7NtPp2sg==
Date: Sat, 31 Aug 2024 08:19:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Aubin Constans <aubin.constans@microchip.com>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: mmc: sdhci-atmel: Convert to json
 schema
Message-ID: <7cprvqjnmtkpehkok7lfv34t2i5vywt5fhp6q4qyfvmlivvcp5@xdsif4htcqxl>
References: <20240830-atmel-sdhci-v3-0-7c97a0872af4@microchip.com>
 <20240830-atmel-sdhci-v3-1-7c97a0872af4@microchip.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240830-atmel-sdhci-v3-1-7c97a0872af4@microchip.com>

On Fri, Aug 30, 2024 at 08:21:20PM +0530, Dharma Balasubiramani wrote:
> Convert sdhci-atmel documentation to yaml format. The new file will inherit
> from sdhci-common.yaml.
> 
> Note: Add microchip,sama7g5-sdhci to compatible list as we already use it
> in the DT.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
>  .../bindings/mmc/atmel,sama5d2-sdhci.yaml          | 90 ++++++++++++++++++++++
>  .../devicetree/bindings/mmc/sdhci-atmel.txt        | 35 ---------
>  2 files changed, 90 insertions(+), 35 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml b/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
> new file mode 100644
> index 000000000000..ba4786328833
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/atmel,sama5d2-sdhci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel SDHCI controller
> +
> +maintainers:
> +  - Aubin Constans <aubin.constans@microchip.com>
> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> +
> +description:
> +  Bindings for the SDHCI controller found in Atmel/Microchip SoCs.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - atmel,sama5d2-sdhci
> +          - atmel,sama5d3-sdhci

This wasn't in the old binding.

> +          - atmel,sama5d4-sdhci

Neither this.

> +          - microchip,sam9x60-sdhci
> +      - items:
> +          - enum:
> +              - microchip,sama7g5-sdhci
> +          - const: microchip,sam9x60-sdhci

What happened with microchip,sam9x7-sdhci compatible from the old binding?

And none of above changes are explained in commit msg.



Best regards,
Krzysztof

