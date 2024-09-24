Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EC814A604;
	Tue, 24 Sep 2024 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169168; cv=none; b=RX8xxgxWWiq4z86tMItdP1htxeQuYX9bqnd6ZbJJNTFzKXTadzZ+P0u6QsTPLLB2YQ/4W/qLn3/8ivUmTYDJF+pORBfdsGv4DuTRN8IHD+QqbBUQUfeoChU5XoYQ2NVMrIAqn1XLmtlLjS9glsp6BdCQBhqxHwrOZaZknib6v2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169168; c=relaxed/simple;
	bh=OWP93lxMU7Kz7NXhHpQx1nS5UtQYEswveLq4GJOZPeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHf+fHhbI6uTgSKE9temhHwpXE0wrPGfqpuGubX5v2LEIzTe4ub+nI4fDv/XE++OVjUOgBgea2FO2Z9GaIr7Er7SXeyr+LQplygSrdAZy30NDGbXUlwztUwVSj4kEq/GUoCwEp0LI7rXhx5ZHSNLgMdIQE1YB28HB4u1PG55U+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWuEqDAv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWuEqDAv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147DFC4CEC6;
	Tue, 24 Sep 2024 09:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727169167;
	bh=OWP93lxMU7Kz7NXhHpQx1nS5UtQYEswveLq4GJOZPeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tWuEqDAvLDmw+g74otC7+T/ALm+AaCx1SFASlCaSbJk0UYwqeGeXw5lH63uAOihzG
	 M6+/VdXUfX1qwTTNJsaXeVZM4jSczGcEfB+6/suJQeWfFPLjqJNpJhywOvFvi2l0Iy
	 pFiT0xg1thDnu+RAVaqZa1AuVa7cWCTMsc1nLxecD0EX+/ctZsBnK7KAezw1U3XJig
	 p0FHHhQAh1ulnvR2TwCfo/VHePqibUD5FnkmfkNotszk+d7Q/S6Od7pMZLL6x7umt4
	 8vjUSReu3lGW5tGaaOgFU9O19E41UKz8rRNveEtg0Pny1rKA0uKtEe1xUGq6WQereq
	 Pvaw4Zo5bhDYQ==
Date: Tue, 24 Sep 2024 11:12:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: controller: allow node name to
 be named slot@*
Message-ID: <qt3ivwsa3uaidcgkzbd2ewohbyd6zbzseraihftdhxpziuhnpq@xsne3f4wdfua>
References: <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-0-5aa8bdfe01af@linaro.org>
 <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-1-5aa8bdfe01af@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-1-5aa8bdfe01af@linaro.org>

On Fri, Sep 20, 2024 at 10:38:03AM +0200, Neil Armstrong wrote:
> In preparation of supporting the mmc-slot subnode, allow
> the nodename to be either mmc@ or mmc-slot@
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index 58ae298cd2fc..f797c32ea688 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -20,7 +20,9 @@ description: |
>  
>  properties:
>    $nodename:
> -    pattern: "^mmc(@.*)?$"
> +    oneOf:
> +      - pattern: "^mmc(@.*)?$"
> +      - pattern: "^slot(@.*)?$"

I don't think mmc-slot is allowed by this.

This should be squashed with mmc-slot child patch. It does not make
sense to allow mmc-slots if there are no mmc-slots.

Best regards,
Krzysztof

