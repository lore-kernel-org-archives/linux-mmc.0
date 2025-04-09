Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D6D266562
	for <linux-mmc@vger.kernel.org>; Wed,  9 Apr 2025 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744204465; cv=none; b=F+p4aFykQ6puJGs8w+Xz4m6Z2u/CLKSlFd2XyL2uTjOHl4/76g23YJ7V4/wyi6aOyVuSG7Qnk+CIu7in4Yl7pOvIHBJwVQfrvrcxKoEB66FVNNTOQZjSh7hvWy+Q5+VvodhK90YxC23JTNpJ+giNU6XhLpT2/2ZU5AUY/qzpbgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744204465; c=relaxed/simple;
	bh=ySJvfaqcIjQusXoLi91ha5mTlR84r6YRHDDkPiChFbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVUk25rWNlCPViI0jtEPZ/bVl3Cf91EszappQLnrr5e3YkbFCR4Pw/dBtzjjCbUZ7GrgObSJGpg6vYqR41mp/ii9T5IybNVGqi8XK5J0zy9gO6dJa3XAFgggTYeMLOcsKKDjPFCEBFVSaBMAIuNgAJnCtoA2b2GNNvQzHydV3YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gu86Sccr; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gu86Sccr"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6fee50bfea5so55897367b3.1
        for <linux-mmc@vger.kernel.org>; Wed, 09 Apr 2025 06:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744204461; x=1744809261; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UvXD6Vit4/XQjMh5TPDqTHybFGmBm72KRNvjczpWe7Q=;
        b=gu86SccrI2mowXYBUQ9vRdTFzp+jPCXJ0LvIHDye9QRh6X8Y3/w2IM7ZjC45p6vnS2
         I1VHRGJ7lEYqb2oMINlJo3okQIppjBaPR+d85hSg+syW02zF3zHLYMGnrgHc129UohHg
         pA2PFd+OxPLbU6i03KEjAHNOmWh5a6Nbve8aXRY5DgSuF1x5Lrp7fR/MX87cMAH79xZ3
         dJYU5muk03TKFQmaW+oqy5nOUHKCVL5h6QYJuBN/B4KxOHS0lAvbV5oPcspfyqwFN7iu
         M03Kr7XO3PujPxVHoSAGeNiRJ1MOi132ixv5P3Pfxx7OZZmH+cY+yWzUcFUMzbNrE3wS
         bpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744204461; x=1744809261;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvXD6Vit4/XQjMh5TPDqTHybFGmBm72KRNvjczpWe7Q=;
        b=Q+h///7FPrIyv2mmOQPJjz8ihpxT93zSlx+CX3SsiC9fmNA8l4K9nU2DasY0+qaKEh
         TeY3RuA8BcioU6yJVN1DbPQFaeymbV4mAZS6rXPVYdgum2eYHlJPBafSr3KVYVkUEQmq
         u6lqXSmuLzkHZYjyRW6mQyFUTqg5eN2e2hnJI5SE4lb4TFF9n5VhPBuCJwRhpyCIBZhE
         ca9vX/u2vtjhGDSE8i2Ol/H7tbRNti6620M1w4D8GbZ+Bcg+M9VELGifO4s1J1UP2rNO
         /my+dExjjmQbuIhZQ/VykiK2uRGFpcgZDGUBVi60RRdgWUmYuEDcbGUCZdQ2TRFPXpd4
         JyCA==
X-Forwarded-Encrypted: i=1; AJvYcCVqsxlbi01o/NYHESGjNoxnD4tRN+f8x0iQDdveHOPO+xPnSK0ebCM89CH/X3XWadj/ZDP9z/QGQQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyzAKCSWFd5LiTalbADmooghKF4XjTipJBEodt+UZ4QsP/ULqS
	85I4IFGy5uInGt+Asf3b0aQpqJsB8tqwo74FGXEKEBnq/SuuQBY1jX0wahTROBDczg4U3MEbASV
	gEvyYtKnDnu2ggE37bDQUWPTWmcYbee5u2t8+pg==
X-Gm-Gg: ASbGncuzAADvyiObwF73WwU+rwbNTA5+FUSEnCDGQT37cpcZT3AVpR/Jiwd69h7xQo7
	PoiT/dfLTdeSRfE1dqGo4YYFpyuvyooqyOqbg6rHrEdBqz78Nf2wnMtiqq5dyLEU35dbH/O6fff
	SkxE5maiBeIicq2ju1RmbrPiSFSfUcdlh3mw==
X-Google-Smtp-Source: AGHT+IF0dYUcGFOQShsjgMB7MWZa3hGFQ5HoYrn3mxhacjMhN42yQdkHkcaUjnE7l38towq7w5aGVEUc5+fQUoqpduA=
X-Received: by 2002:a05:690c:6608:b0:703:c38a:229e with SMTP id
 00721157ae682-7053ae70ab2mr35235947b3.26.1744204461697; Wed, 09 Apr 2025
 06:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407092144.35268-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250407092144.35268-1-biju.das.jz@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Apr 2025 15:13:46 +0200
X-Gm-Features: ATxdqUEjkzeXMVIPgTN-2xEByLyfZHo9DXGRUHrwmDK1e9Gasj0zeSRmlDSOjOU
Message-ID: <CAPDyKFq9rrGDMP7npb1m+dcszTKo9X14sdbwbSEdGRudJ-fUFg@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: Use of_get_available_child_by_name()
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Apr 2025 at 11:21, Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Use the helper of_get_available_child_by_name() to simplify
> renesas_sdhi_probe().
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index fa6526be3638..e26e7995754e 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -1166,12 +1166,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>         if (ret)
>                 goto efree;
>
> -       rcfg.of_node = of_get_child_by_name(dev->of_node, "vqmmc-regulator");
> -       if (!of_device_is_available(rcfg.of_node)) {
> -               of_node_put(rcfg.of_node);
> -               rcfg.of_node = NULL;
> -       }
> -
> +       rcfg.of_node = of_get_available_child_by_name(dev->of_node, "vqmmc-regulator");
>         if (rcfg.of_node) {
>                 rcfg.driver_data = priv->host;
>                 rdev = devm_regulator_register(dev, &renesas_sdhi_vqmmc_regulator, &rcfg);
> --
> 2.43.0
>
