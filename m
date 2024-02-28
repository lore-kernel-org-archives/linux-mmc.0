Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E41E151CD7
	for <linux-mmc@vger.kernel.org>; Wed, 28 Feb 2024 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125476; cv=none; b=M+UWYLODjGfVR+eNWhmajlJmcVJVCFSdARiLdjmwHPyv3cMn6CRsLcGMFVvTHk3pMNYekFwbE0f6HixJCE/qGON84RNuOvbCjORY18DFRQHJGCoG8GiPkox4hW5AnpNJg9mjtiNVzfdGfWWjCqwWW544KQsdBc8Rxwjugb+FKXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125476; c=relaxed/simple;
	bh=FZB5bau4XS+CfL8L2++Na5Xn+x8eJG95NbayiKGChrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jf5DJg/NAb8lQ+xtYnM2pgmdgmP26Qm/4m0jULW75cuY8ouTR/UxFnX+1f8Kx3yVkMRlWP7pPixzB877wdCC9flTuQW+m74eq6vU+MmMyyKXw4DF/7j/+Gp55lUnFUrxmDFb4fwtZ4aupxdOLS+C/2pvdG9xa1L9rLULd+xW5/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lItC6RnK; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lItC6RnK"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso5698680276.0
        for <linux-mmc@vger.kernel.org>; Wed, 28 Feb 2024 05:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709125473; x=1709730273; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P0H9CjwYlrXXMXgZMM3y9R8B4NNOlSm7B7Wu2SJEefo=;
        b=lItC6RnKEVIC9+iqU7C7yBuLcvQCQh4R/xFe62spLD1BiCvgmPdlpxX0AIUEMrO5w3
         1Wby7KWTl/2TuShPNgc3knDicqHATsGn0jZ5dLv/BQc998sxSpgrjiDN8S5jQAA+cUpT
         TBD7RE9HFcBo5O3y54+ylDzWQh5uQhIJD5HE+MFqc4XDOoRl0jtROSjf0ZyNC4mPTPvq
         5auwcOMCU284Xm5fIvEAvrA0rTnW+JM5U4vwdis5iXKfHoLHx26YM+oRbt/BG/DIOm2+
         BXraVm1cAUSrY61TEX1eFmuG6ufdKvusweyBJRL0qCmqt+TPpZIisRWMYDQASfXfzwwO
         X8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125473; x=1709730273;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0H9CjwYlrXXMXgZMM3y9R8B4NNOlSm7B7Wu2SJEefo=;
        b=CRsmxBXlHkoglQdkSrGlwwYWK0CwgI9/VTyF9rCdtLu/qFMcjSMqcZmspk+ejAYMBr
         jQMkwkfVGsbEfLrIAbZjK456xW+lbewntBTUjkwmIbiXmTmENypbPRqJDiuBnS79i5w7
         HOc117GUahL4dzIQeVMUX7W9BnlkHJ4TIZOzT2Ym0VjxzvSoodZNAfeAtnoLhB4PUAIo
         l4M5C1h4QGLvCYTzn9+rhPlS4ECqcJTCH1cLvwutVmVPFg9JRGt+BEbYqD5FsW1rEZES
         KbBzS1VgOw+MbJbJ/hykrl+Dp4cGHGuD9I5W/JDe7rjGs1UO82Sk1pZnzfacLxVW5KIc
         zBOA==
X-Forwarded-Encrypted: i=1; AJvYcCXueBS53tZJQxmdWT8HzM1Udy6IK92sQ+PWRzNsXOTYm1LwuM/I71omPo6X61NdkE4s1yLG3VxKtxBaJtVVb8dcu6R6MW8QjRl1
X-Gm-Message-State: AOJu0Yxi6WpnVY2hVmm4f3xXRNhnwhzhm1375X7nTiek1Cs7C8saQsDD
	Z9SmqAg2OS+UjmAsy42LZElp7HXp9p5rBgucyi7RrNjN2pw1ooED4LNN1+Bjfb7NQq9TmcJOVOv
	McEftDqZI09b4houzpbpGiL6R5EwqjlCRF7M0XrI2fnpRZ7m4
X-Google-Smtp-Source: AGHT+IFMY1lIqqJ8UyC7C9qZOEupjve8bfAWSVebXLSJSsfev7YwuqlxCnewklXnZfsQy4eqjDlfkEIXJTMwgj5NBbQ=
X-Received: by 2002:a25:ae8d:0:b0:dcc:d455:2ab9 with SMTP id
 b13-20020a25ae8d000000b00dccd4552ab9mr2499464ybj.27.1709125473477; Wed, 28
 Feb 2024 05:04:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222143911.979058-1-festevam@gmail.com>
In-Reply-To: <20240222143911.979058-1-festevam@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 Feb 2024 14:03:57 +0100
Message-ID: <CAPDyKFowNCc5TgG1DcfduzaK-XQYboAxpE9D4Nr=JHgFebgDcw@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mmc: fsl-imx-mmc: Document the required clocks
To: Fabio Estevam <festevam@gmail.com>
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	Fabio Estevam <festevam@denx.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 15:39, Fabio Estevam <festevam@gmail.com> wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> The fsl-imx-mmc hardware needs two clocks to operate: ipg and per.
>
> Document these required clocks.
>
> This fixes the following schema warning:
>
> imx27-apf27dev.dtb: mmc@10014000: Unevaluated properties are not allowed ('clock-names', 'clocks' were unexpected)
>         from schema $id: http://devicetree.org/schemas/mmc/fsl-imx-mmc.yaml#
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes since v2:
> - None. Just fixed a typo in the dt list.
>
>  .../devicetree/bindings/mmc/fsl-imx-mmc.yaml         | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-mmc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-mmc.yaml
> index 221f5bc047bd..7911316fbd6a 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-mmc.yaml
> @@ -24,6 +24,14 @@ properties:
>    reg:
>      maxItems: 1
>
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: ipg
> +      - const: per
> +
>    interrupts:
>      maxItems: 1
>
> @@ -34,6 +42,8 @@ properties:
>      const: rx-tx
>
>  required:
> +  - clocks
> +  - clock-names
>    - compatible
>    - reg
>    - interrupts
> @@ -46,6 +56,8 @@ examples:
>          compatible = "fsl,imx27-mmc", "fsl,imx21-mmc";
>          reg = <0x10014000 0x1000>;
>          interrupts = <11>;
> +        clocks = <&clks 29>, <&clks 60>;
> +        clock-names = "ipg", "per";
>          dmas = <&dma 7>;
>          dma-names = "rx-tx";
>          bus-width = <4>;
> --
> 2.34.1
>
