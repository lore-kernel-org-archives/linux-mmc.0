Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD70A30E0D2
	for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2025 10:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514522; cv=none; b=UI8FL8NfI9l9VGQZc0Gxib1fxkcLt1DJT1DrzxXB6tGXAQF1NN2cM22YPwpljvdnUdOFC9kgN3lumfzZo6Kn1d0BbOv0LstzPy3dt7OjeIzy51YjXwhJW1GYP6m3QDE5qFIAnnaSojaNe58XbtQ7xmALbQbL7TbIlAQdiNRkxaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514522; c=relaxed/simple;
	bh=/gdGHTrneWQqmOYRuvh9CIob29j8iPfzhl61xeqmBF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWgZCIdtAZXulbFAZ7JyIdDh0ssjMxEi9TOqUATYo6/+vJ20EOtljfCFOxPNqWTAybC2i0M6YYx9Gk0HEXkFQbisfXkafhhU9soN7LjE9Zc/EGYDRt6kJ1qQGpVSZX6cvv/HnBnVIHf0s5AM0zYovV0QE5HDMw9s59/VVTOu2jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OF7IOqeb; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OF7IOqeb"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d603f13abso34523927b3.0
        for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2025 03:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755514519; x=1756119319; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CIznuZ7T7PsTVuExPL1E/1VfmJgJv6V7rfdbbABcMss=;
        b=OF7IOqebzp4B/GdXZ7M1on4q3vS95oCZIPQyeP9vzsfKvOXXTQb6i/ZFf92kSP6pna
         DPAgDVa38F0n2TTyn1RfGhN/NlrSfKaBOludYR2Po4dGuXqlFjk21G/9hUsDogW0oSS3
         stFgmfEWo2omNgMv4oRuWZikMsBo0UVPlqsUvNsakSdbqiwtNJCwgEnR8j8vTiGhYVNy
         BRSWMCp/P2HArk3rKfH24DeuPvfW2nD/rKUai0jtBsW/aaVEt0SwnDIDLKIJtpKTO/mG
         cqbC50rIB4uTBGl0AmL/d0ESaFGZUhpn2p/HtdBvH6t0X2umtTadoOxnjKlYjtL1OiZ2
         h8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755514519; x=1756119319;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CIznuZ7T7PsTVuExPL1E/1VfmJgJv6V7rfdbbABcMss=;
        b=fwJRErVyJWIL7Xq+3JW2oBv9QQ6+pIEtwT0NNW/3cDpw/20dRI/k4H9okSujRCFs1h
         aOSk2DtDyK02dnoLAIAvtqrjp/d/J8RAqlnAtLUymoSFkKMbCBqxfqgSIg953Qld1S22
         pi+LcNDhne1BkPy+Rp249FvVXBJTYHl5ac03xaZ3KcwxUhr4Hjfi8xLfvw4RBT0JR1/V
         5B6OngQXOgrH5oMhl1gqvCPtnb1ljp1ZpdkCUJhO7nhxLijC4Tp4K0CIHEZhgIaJq33Z
         d3xBjgfijKIoiXZw8XH8SKLSrP1t4xZ54To4cxa5mOYrJLbqNHAK3PO8xiX4/FTqm0XA
         Dbvg==
X-Forwarded-Encrypted: i=1; AJvYcCVw5z/Qiadzrp6VLOZEHJStqPk7VNDJogl27C+EVABiTZW7u3wrHoUkOTDqe6ZwzaQrHXx/zB1rlAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuq2JdHXV6HG8fQxTqv5ReAAemnsU2aemIsFERpEBW1rDfR+AC
	zEPIi9HZ4fGiHZyM8Kpvf1aykuEtoV6kQRyL9BJUV5icjd5p3vspJUTiA1vcSfPnIZP2YiA399f
	0fIUyQ2IzYjht2wyqKh7ayAzdKDjt+8DK7YPpLzqkrw==
X-Gm-Gg: ASbGncsx+icIOmuL1ZQwKcN0/LeLmelwG22tF8IbtMvPga94oCkOrm9Fr0HQI/TM/3V
	9gDEX5Kq7X7Js1xdiKkIjLpOR91F0zBSNBi4tgoib6kHLLoDu1jgfWGKwp+/lSg2RJGyg9D5BVW
	At/Fml8BfZn6dPCa0/F7Jd+D9QSTfD178pSjlN1L7tR96RJzpIv9YEOaZD+HbUHWjpo9rd44+SE
	68QRRF2
X-Google-Smtp-Source: AGHT+IH66Dj8WNKlffsTjeVMHpVPRufHU47TKI73ywlHa/Ok4uJvh4KyxWFO4feX4WNsCgPnN/DCJXQlKj8LP+ouHSM=
X-Received: by 2002:a05:690c:680b:b0:71b:6950:c6cc with SMTP id
 00721157ae682-71e6de26037mr157669637b3.35.1755514518726; Mon, 18 Aug 2025
 03:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725060152.262094-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20250725060152.262094-1-alexander.stein@ew.tq-group.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 18 Aug 2025 12:54:42 +0200
X-Gm-Features: Ac12FXygjZDpxgBwolikr0do3iLHNX20_TzBAu8skyfNiyVUVQRmQ-7AdMiWBKk
Message-ID: <CAPDyKFoWF4G-T72Hhb4_VDvHzTWebpFwq7o5LDH421_VUQnkPA@mail.gmail.com>
Subject: Re: [PATCH 1/1] dt-bindings: mmc: fsl,esdhc: Add explicit reference
 to mmc-controller-common
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Jul 2025 at 08:02, Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Even though it is referenced by mmc/mmc-controller.yaml it still raises
> the warning:
>   esdhc@1560000 (fsl,ls1021a-esdhc): Unevaluated properties are not allowed ('bus-width' was unexpected)
>
> Adding an explicit reference fixes this.
>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> I don't know if this is a tooling problem or whatever. I would have
> expected that mmc-controller-common.yaml is added via
> mmc-controller.yaml. But apparently this is missing resulting in the
> given warning. Hence adding the reference
>
>  Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml
> index 62087cf920df8..f45e592901e24 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml
> @@ -90,6 +90,7 @@ required:
>
>  allOf:
>    - $ref: sdhci-common.yaml#
> +  - $ref: mmc-controller-common.yaml#
>
>  unevaluatedProperties: false
>
> --
> 2.43.0
>
