Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BCB258CD9;
	Fri, 13 Mar 2026 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408128; cv=none; b=NvAOpEOk2RccRh+R8Qoniazy1uVYaKpkp0mwmi5ccF0uq5nDWYmuRtJt6pIKTEriyrS0+5OUz0qsOCr5bbN4WWdAhIaB+Glf1p3/m1rA+g1W9quTTPrXc4Y3mgadCvg+mxYumds89Kz+dGtGtQeP3zNXwyFSTmGDB5oZxy6RSAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408128; c=relaxed/simple;
	bh=vaHdUojNE5GXb0TT0LB80P3Na55BRmcF0TnOgYm2ukQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8JxtYRekJ5jxHXkqLRdNQ4WedZEbomNfEbko5bgl6y1pTJQXsYhGXG3SiWQECkkFcHiQl0zfJQcfpCa7pHB19B6bUzbh6wwWNWqVsOfdC8YF84awwBDnf+WBczHEfxcNVdSxg1OsR6bg0mMbX7dHyVoZYuhUyDa0BtIjjToFeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njfXJcBz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njfXJcBz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFDEC19421;
	Fri, 13 Mar 2026 13:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773408128;
	bh=vaHdUojNE5GXb0TT0LB80P3Na55BRmcF0TnOgYm2ukQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=njfXJcBzmwQX1R+sXfheVdpvucwZeAgVPV70OPc7ClgH83qZDACzhkfPnVkgUyFyT
	 x6jBVsa1KH6ZJMMgpQGhmLBQVsnS+L9WbvL3+SQVm421XZeX43aRlsnZXpp8QnpazI
	 B7Hwhv+tz2JtyjFue045Dl0QGS0pkZa3NrLSb0pVMy70FlW8gcFAW+f5mCSpLdXiM+
	 Iz5omDVQvowe0MOU2JWOGkXewk4+9SM82oEepEN/CHvGhYtUno8UsMHACTxgS5f84R
	 f3mD136G17PgQL85WsUM4kfeswq/ONJTy/vi8sFaBa6wI5zP4iPok12X/9PvVnboA8
	 7+qD83BIwTgOQ==
Date: Fri, 13 Mar 2026 14:22:06 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 1/9] dt-bindings: clock: add Qualcomm IPQ5210 GCC
Message-ID: <20260313-demonic-ludicrous-lionfish-fbbce0@quoll>
References: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>
 <20260311-ipq5210_boot_to_shell-v1-1-fe857d68d698@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260311-ipq5210_boot_to_shell-v1-1-fe857d68d698@oss.qualcomm.com>

On Wed, Mar 11, 2026 at 03:15:43PM +0530, Kathiravan Thirumoorthy wrote:
> Add binding for the Qualcomm IPQ5210 Global Clock Controller.
> 
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>  .../bindings/clock/qcom,ipq5210-gcc.yaml           |  62 ++++++++++
>  include/dt-bindings/clock/qcom,ipq5210-gcc.h       | 126 ++++++++++++++++++++
>  include/dt-bindings/reset/qcom,ipq5210-gcc.h       | 127 +++++++++++++++++++++
>  3 files changed, 315 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq5210-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq5210-gcc.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..aeb5d9a3f8322d5d36d2fd19a1d23b275efc34b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq5210-gcc.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,ipq5210-gcc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Global Clock & Reset Controller on IPQ5210
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +  - Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> +
> +description: |
> +  Qualcomm global clock control module provides the clocks, resets and power
> +  domains on IPQ5210
> +
> +  See also::

Just a single ':'

> +    include/dt-bindings/clock/qcom,ipq5210-gcc.h
> +    include/dt-bindings/reset/qcom,ipq5210-gcc.h

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

