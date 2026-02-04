Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE983B9608
	for <linux-mmc@vger.kernel.org>; Wed,  4 Feb 2026 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770215739; cv=pass; b=VihaGKmvO9/GWEvUSiOMYeni0M65K1cTX1qzVKKEhO8FrMMf8aNVyt10M3yX28UoBe9Fdjnlg0chooIVN8bkmGO9RZr6aKEqAo320qaA3hgDRFnX5M7krUkyLi9QZaHDbB1IeratIHI6/CYK25HhptOh6IPJbYZprpoTCvLIRnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770215739; c=relaxed/simple;
	bh=3Kfxgfz8+hMqJ+CSaKY6huvPu3M3fgkwD3bUrxvkB3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dr7hlUl9ddmatFDjKU3LNk2pa2hPCkOrUDxDFXqH+6QXl8WalsKf5Xeb7ttFFploo+LtszI8Ji7/GK/NGNEdKyV7nNU3+zp6a67Ivc4vnq+dmqyQjBghU430Un8ITjJBdVFwqu0/vCz1QAXlzQccHYHdYQcx7BnD4ROvx+F4aEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eVbvp4Ir; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eVbvp4Ir"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64937edbc9eso6116186d50.2
        for <linux-mmc@vger.kernel.org>; Wed, 04 Feb 2026 06:35:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770215738; cv=none;
        d=google.com; s=arc-20240605;
        b=FS3ZjEYy6WLIUbURxUhQ9DIRup6+s0vhDHSnCPAIlA16SFedyrCggh3Vx5bx3osjiR
         5DGjCZYk6LKhg+7+QZNdj8fKY50L0NPuIP+gCKyXnfDPAHeR943P3KtwZ08xLOa4w9Va
         BPXyioPkhiNUC4SeJlCBRZxs1LHM2Ru6+JodwbQzKGcI/fLP0OXzyVspo7NXQ4UiHeFC
         feWJ+lvhcxBzbbgAq5cf/ylUjHy+ImWd5MIZcsJ6eZbPClEFLvwHv/bS6dIU5+xcPUyx
         3/StI/BzMk6TKYYxF8PBTlkdlVSA4pXqa3WlLmbfi5oERiJ75WrJHxPMeRaBisHasWnH
         2X4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qs8kXAX9DSECmo0hIsKWGPWeQx+EzOKrLeqIOYIIodk=;
        fh=fZhRGYfvkA3/d9nHtXiq0Kks8NUcoo6ayIRE6BWdhSI=;
        b=BXdAL+zzKA0KIbi2cVPOlw6W60lt0PrNj6oz3Uukcs/A2fSqrf7QkzhLZwUKeAPAv9
         8VOv0hUR1UiCzNOV+rrsNUD0PFgpQXYhISTAVqnnRfYVS8Qp9i+asem7jDDe7ydP+3GF
         Sg4cAFA4ULTXjxJoRV/QpGaIHBiTlXi8ZfNkky+bTxFGVvdazcUB4U7TsdPNDV1ovGKL
         HuqE0ePSydllRZbNFLLdKnUKhJ33twMaTOpFsdWps5e2Ve73vIw7Z2zUyWAdg8ubvJBz
         F+TobvgvfBC5XDkRH27F8anfor0gDa1PCSLrsvpZgojqQ+ZkO0OXytf46bw/eOxM2aeq
         7F4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770215738; x=1770820538; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qs8kXAX9DSECmo0hIsKWGPWeQx+EzOKrLeqIOYIIodk=;
        b=eVbvp4IrLL7uq0EJhC67L2x6/q1d+7bBKAyImWrx3paVgm/Wh3JmN2U6Be0siM3WDt
         QV3Y0QdGR9jQhS8yBSXPumNVt+18J4eCO3MehrxMN6TkxZ2Y3KLgG2PMbmO0+uCLnCzp
         G7WhqBUCyjyJ/D1kfQj8tHLrEdpDLq4fyQzRtdf/hQD9n+VUA8AdQYa09dbYp0vaBHij
         UbkDu9nbJFDR5Bo4wehrqBzzH23YghNsBdDHkt27ZT4TuGWgKDHib4yMv/O1MEo+Mcd1
         eogaqxoX4cZWfb3yLZoOBkc8iqqC2yU98ZWgLjBvIrGHs9EJDjViB3r1D5DbwZn/CR40
         FnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770215738; x=1770820538;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qs8kXAX9DSECmo0hIsKWGPWeQx+EzOKrLeqIOYIIodk=;
        b=jOfgjwXla+rxEo23QTxkPmksyjgJymu37CWoe1lS6DAHrVJtyPawsIAZeydElcqw5f
         PT2PizC09oNVTnbkcbwCkbxPHJvw5a9Zy1X2QAhc3F8U4vW8AvRM0HEtRuBKPvWG4SZO
         IWo1rmV2e1eZFz8Klsdwu151hcgCbQk+kk/wbHJUSZbrd1HLrahiTNeoUrJIeBW6GRLD
         6/8t6lwgWMiGuZqWR5tugprLUPvBTAAJ2OFHbP2dUHSK7BeqfnjQVKQQZC1k5IpS9mRp
         G9TGzKi9YB6vPu66D1za2owaIzZpQsx98LY8QrTeAX8T8U+BS4HIEXZ6iA6vYKhKYdhf
         lyNg==
X-Forwarded-Encrypted: i=1; AJvYcCUPIbmaWrU4H2rKh23P1rrJf2XWIjy7pfEK4zov0g9A6E71wEhQSZJR0HzJf4gOwomyvucA5cz/XZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YysIxTpP/9Txu+W3VVLlg8+Oh7VV17LtX1kebTFK3kSXm+vZwxH
	kDEmZPh1cpcGq/xnEALXyInG9IqJQdplK+0io+QgeE2ircaDFkZBF10/LkJJczmDYTfcboWQxsn
	2BLvElLmspP0fyDcWyJUN1EyKaOVxtiQkE8G197G18A==
X-Gm-Gg: AZuq6aJFntJynjh1uheDX2Y4PoEYG/o8viMpBZ7DzA8uvKRftcQwm37ytaLOhwV8kBd
	yi47eVuy9igSPpdXCdTGq0CauMbsGg/bbL2MNaf/XZ/H76wWuQqpNFJVJxb0Cas3vd28B0o968i
	SoU/i0Q8aRxbXD9DsTo4749nJqqBmIMvLWPcaX8HQyb93uTsvBrukt699/Vewoxm+u+Q7MbxNcA
	KPHx+hCVUE4S9Ks1JBA6VAB7S/d5feHWZm3oPJntDNNgYaaNVNogMy99Svg/uQSP16HxqXGSfBc
	w1mxhKg=
X-Received: by 2002:a53:c0d0:0:b0:649:d4ce:243f with SMTP id
 956f58d0204a3-649db33fb9cmr2174177d50.3.1770215738543; Wed, 04 Feb 2026
 06:35:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204020709.24604-1-ot_cathy.xu@mediatek.com>
In-Reply-To: <20260204020709.24604-1-ot_cathy.xu@mediatek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Feb 2026 15:35:00 +0100
X-Gm-Features: AZwV_QjKyxhBAxAWnQN3ZmPtmDSh2TTxzwvjZf3Uhrpoyqis27NsaHph3OPTLhw
Message-ID: <CAPDyKFrGgf1+vYVA6S1SJTZ8+n9WJo91e1VWeWq8p3RNHz1qtw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mtk-sd: disable new_tx/rx and modify related
 settings for mt8189
To: Cathy Xu <ot_cathy.xu@mediatek.com>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Mengqi Zhang <Mengqi.Zhang@mediatek.com>, 
	Wenbin Mei <Wenbin.Mei@mediatek.com>, Andy-ld Lu <Andy-ld.Lu@mediatek.com>, 
	Yong Mao <yong.mao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Feb 2026 at 03:09, Cathy Xu <ot_cathy.xu@mediatek.com> wrote:
>
> Disable new_tx/rx and modify related settings helps avoid data
> transmission instability, and better compatibility for mt8189.
>
> Signed-off-by: Cathy Xu <ot_cathy.xu@mediatek.com>

Should this have a fixes/stable tag?

Kind regards
Uffe

> ---
>  drivers/mmc/host/mtk-sd.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 302ac8529c4f..b2680cc054bd 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -682,15 +682,15 @@ static const struct mtk_mmc_compatible mt8189_compat = {
>         .needs_top_base = true,
>         .pad_tune_reg = MSDC_PAD_TUNE0,
>         .async_fifo = true,
> -       .data_tune = true,
> +       .data_tune = false,
>         .busy_check = true,
>         .stop_clk_fix = true,
> -       .stop_dly_sel = 1,
> -       .pop_en_cnt = 2,
> +       .stop_dly_sel = 3,
> +       .pop_en_cnt = 8,
>         .enhance_rx = true,
>         .support_64g = true,
> -       .support_new_tx = true,
> -       .support_new_rx = true,
> +       .support_new_tx = false,
> +       .support_new_rx = false,
>         .support_spm_res_release = true,
>  };
>
> --
> 2.45.2
>
