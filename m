Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215283128AC
	for <linux-mmc@vger.kernel.org>; Wed, 22 Oct 2025 09:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761126886; cv=none; b=vF81yXCOcfDwysZCYFG5Ov2jHslb6ahxQGNshPBKzGrxXUp9wcBfE1scbCWL6IrxaPH4wATJnwC8gGiThQmabcuRvDTqbkJc3UQBIw+MisyBGQsyxBSZXrK8PP1KWSETzSSjl5N53s6mdXmtxsyODHXAqH44wBlfIGswXDbWMBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761126886; c=relaxed/simple;
	bh=HB1y7cWvJVBaffceb4N2grQDkRK84MOxaGljtCDtKQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOL2H0eOiX4dVIC3d1cicrBDaa4QJwQ/vx8zL65HE/IA7TW4hNCrJo+bCmPXKJwrYKnMnTYhm3Xix3DbTQrjGjiuv/beGyXoE43byTWh6Fd9l01862oeAhPKhf7u6M9ehIVmdtVkIJZPztCKVtGoDYpK/cc/4Hw9cO11SfRsI3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MrKHwu/4; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MrKHwu/4"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63e0abe71a1so2535920a12.1
        for <linux-mmc@vger.kernel.org>; Wed, 22 Oct 2025 02:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761126883; x=1761731683; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/BE3p8f/tb4AmnzEBEYSIcdIiv74xFJHBlZnCilZ3pE=;
        b=MrKHwu/4HGuNYZRe9NfyEn/r6PYiIzIyDjhvEywd38xFpAjXvTbeBjxbJb9ncwGMA7
         BmgGTxiqVR5ujIx2nyrueqN6Vh5Hr+uOqHnz0b69YfDJhqlU0ytNKMLcwXeRkyYhayUU
         NQJCY1qYsAmw45rDACQP/EJfWr585ufAc2XgU82MNMIJJUanEEmDDwJRHiWea/JR95f4
         2zO2l3ZIjV0dRlmrKr8VFcokTlx7n2bW4aTaSpV2xSKY5/Lrz44BVqx25oFv4qVu4ffa
         qtHre8Bn/CTMSJ/rgPL5luimvWFH429lu0yN4wyfxjVou9EZbRo8f/umIGycNlEl2SmR
         /LMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761126883; x=1761731683;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/BE3p8f/tb4AmnzEBEYSIcdIiv74xFJHBlZnCilZ3pE=;
        b=Ptu3O9PJh2Sinsn9ZAarGZ6R3ulxLJTfnzklu7Y8oOVd+aVgqK+oHqPwhoIlIoN4VY
         oRYvILGWjtWyPAOzvtg+ws1HTTubmh5Tnq3n/QcmcBNNJw+wA+ydtbh7880jIyluGKgf
         Z/fyWV4vlvooj8K4GmmhOD2oWOH+gJnfU2PBxVTM1IOG5KkxfA4R90QOcTDv9PzMj/ia
         Zi9aAUCmWiRmCah4c+z57ilBuFLtGGl6Ctv78B3R423tFBATh/8P2+qWbanaa2TK2Ns6
         +7nOT5w2SfY1Fz8WZ4MT2muR9cPhUWdY0G3qEnzNti6/5wtn9hN2rfE6qnNFBKmEV9dq
         bGkw==
X-Forwarded-Encrypted: i=1; AJvYcCWUMbdBtz8RNBuwVgCYxkAwFq2pv4i25h2YXwt6BhfGCdventLXt8ZCXi40TrJNkyuapgVj56of8JI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZjxgAbU1qyG99d7xaepzIAAha0QX+iXXTowZb0B4wPuDXFYjT
	44hZ3PHk7s2SxWCkaNpfdoSemUY6Phc/NSMH1t/FVokwV2QWUNP3AEFVLF9Cgax0FqXUGEl50jX
	XtVMwck+WY/7iQWK/VJhqE35zAP6TDVKsDG4NmQDtXA==
X-Gm-Gg: ASbGnctFAhiCuUJkEWcTDFaRzwpZOaJpxo+voXGHOL0APHYBPrH7EJGrHH+0LIIZPCy
	jreGuLG4/IcY8tKuLslJF3WpxwEc1lrxDZgyavmknImIAzgEGnUVSiOJuJIeV6PU5nZVQLL2zUw
	AlWohyQ8xCenpNrRbnxkzsf2WvxUxjG/K4GNMVHDAQJ3Wsw8V3eYUACv3zQCka8y1njSu6ik0Wn
	cRUqAn8+YTMIiLz8Nqg/inmFlu/T0DYZWYdG/jpxvElTHtmb+rcFspRWlubmtW0kkKcWPua
X-Google-Smtp-Source: AGHT+IGxvyYJRi71ypaY/f+2tvs/h/Gx3CtsJRVjqydJdRQpedqCN+n+dBFxLmYoHUas/Vv3sBj08NYXtnVui6clXA8=
X-Received: by 2002:a05:6402:5212:b0:639:dbe7:37b6 with SMTP id
 4fb4d7f45d1cf-63c1f63081dmr20417683a12.3.1761126883450; Wed, 22 Oct 2025
 02:54:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021222955.193323-1-heiko@sntech.de>
In-Reply-To: <20251021222955.193323-1-heiko@sntech.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 22 Oct 2025 11:54:05 +0200
X-Gm-Features: AS18NWAUdMZHC3UmuDzl3MkQoA2Eup4bT1W9-ZX5g9xcPcRU8J3IcH9rg1TAlQY
Message-ID: <CAPDyKFpGC292uOpWh542_=yS2XP5tAUWiJhj6tp_CPVrZ5VKkw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: rockchip-dw-mshc: Add compatible string
 for RK3506
To: Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Oct 2025 at 00:30, Heiko Stuebner <heiko@sntech.de> wrote:
>
> The dw-mshc controller in the RK3506 is compatible to the one first found
> in the RK3288 SoC, so add the RK3506 to the variant list.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> index bf273115235b..acb9fb9a92cd 100644
> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> @@ -38,6 +38,7 @@ properties:
>                - rockchip,rk3328-dw-mshc
>                - rockchip,rk3368-dw-mshc
>                - rockchip,rk3399-dw-mshc
> +              - rockchip,rk3506-dw-mshc
>                - rockchip,rk3528-dw-mshc
>                - rockchip,rk3562-dw-mshc
>                - rockchip,rk3568-dw-mshc
> --
> 2.47.2
>
