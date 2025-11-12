Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CFF35CBDC
	for <linux-mmc@vger.kernel.org>; Wed, 12 Nov 2025 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948087; cv=none; b=kTZdTqs8h5TjmpdAyeqGXntJkLg4iB9TlDr79UEXpft7MA0X2wsXcupFnRaPzckvdpxKKAeJ+PhQ6vKsxx4REWxqwqcVvINayq3f0F5Nya/BushgpuW4REzQ0oQk04BAAH2SEybQOOA6vYHmnMbwlV2mIS1VjBTFjKLj7y1NIV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948087; c=relaxed/simple;
	bh=Uwb41rWcXhn20LmPDTaWHH5IlD+BDwkay9vyog60ELQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oh4XwtRPMVmLawLpCDQT9zvuUtBct/c3uZs6lwHEC6+ZeUPrCpdmhhUTyXbnobwdmOdviz97C2dr58ydn3ybvF1MatJiT/ePn1W2OfOT8L8Ik1KLqymq1MrM1rOt7M6fV1jnpC9C4P1j8ggHQQ5B2YnD7AbNGV/LpUnuRf539OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PtholQXf; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PtholQXf"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-640b4a05c1cso808475d50.3
        for <linux-mmc@vger.kernel.org>; Wed, 12 Nov 2025 03:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762948085; x=1763552885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7NYJ5WXgey5rhIW+17o6Oy776CE+t0Py5K1K/GHn60w=;
        b=PtholQXfqYoGRk8JYWLe+Xdg2UqrY5aH7iW2U9CDkHJGT8b2QGJbu3k1rmIKfeDmDX
         +4bcEWDXSwFDhXv1ALhCQh634sA3yJMR4W5a4hXo+7ISe9SbH2mqkFl70biJsyK4Im80
         1YOAS0HiX8JYvJ7sSCGc7cfJGFwOMzXrbQUmrS5iY4laKJ2OELZ8Db+/YOp/DmAlZbwS
         UpHGOtC0PpI8Tzc8vQh28TmwutUdcLqX0GCaf5L9X8mlpamwlEtuBB5Xxn7mA5/UdZNl
         x81tZGYYf28yfLA/JwWcOXosBaS9trRqWCAg+HlkSjwNNLdXuECf9eSRN4IqfigerA10
         09Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762948085; x=1763552885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NYJ5WXgey5rhIW+17o6Oy776CE+t0Py5K1K/GHn60w=;
        b=I8cQzDO2Kvr+W6AZaYFA/QVywnymEH3YpVnhTrrt649hGBpL6MSzEpktC79M/rzRW3
         +FUvc7inzB7aOSYntWkyYPbCsKpsmgq0fJJck41HHHlnAz3gVkTQcYXxyPxVTDng3+SA
         MLl1/nmXiN/erLQRCb92Hq/EouDfp6Z7CMbuXc5i8xz98J69Y4V+aOJ/bkBI6caWZWNi
         gnm6sv4pxpzwYWiajHsAbSYf4SOo3Tbf4uU8hYm2sFrVSlUW6h16ysVqgRFIO0R2dRwR
         clXb9VKtq4ro6lxDc+EzVLMC7jDB2MUpnO6gvhPbIl53BHAXNX9IVPpY1NmeKbK4Y8dQ
         T60g==
X-Forwarded-Encrypted: i=1; AJvYcCU/YOy/si4pzhjTHTlFyX/ZOQ7s0J/3LmNkMWrkKYQ/yj7PA4Xfyqv8Q+Cvfg0RstxhW3BBC+RegNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoaSc+/HARfgg2AKWKEw0wTXoPY6im8b7zwJ71eUmn+NHgY5+r
	VpMPX8CNCfwEria3bq3adTLZ/l2ytBCIw3oHzBWa5N3ZhtBRPgAlbeDusw0nhPkW56FPS5X9M54
	x/H7NJZa0PvP21Olwyxqq1O8Q4Dk+wwYTItNkMWrwLg==
X-Gm-Gg: ASbGncuf7R+aHYOugniODT1Hcz7wDaOjNffTMVz9xNYx62Wz1BIg4cWrpizTbeEAaGu
	kadQkoC+yv6RvdJhjziA+NqOpSkSmAEh6c42t9qC7eUopiyz0epb8zSNh9A+t7WiGzHNl4nhz/8
	K6BgKg/+dHrPq700GpNtQHZgBSFNycfPKeP4gj9GjTEJfQq6mW/kUpkZq8X5vHkvz/LMlsc0hoe
	1otjXRF8N4GWDeBbd2ui8OtEV7kvPCxNirsND6dDnU0iZ3R+8Xb8riJziACBw==
X-Google-Smtp-Source: AGHT+IFiUv9DZGhLP17pAviEb4zykVtbiDE2N23Gp6WltS2iVYg5GcikToAPGfGrPEL4MPtOHRWU5J8Khj4lVV7ZSGc=
X-Received: by 2002:a05:690c:39a:b0:788:c07:25d0 with SMTP id
 00721157ae682-7881363c8eemr23751057b3.16.1762948084802; Wed, 12 Nov 2025
 03:48:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1762242094-55346-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1762242094-55346-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Nov 2025 12:47:28 +0100
X-Gm-Features: AWmQ_bkZ1Y2Ii5nZkzj_CzoJh36uphyJIU_qIDOUvcUy8PYPZsxhRvAdRL_lH9w
Message-ID: <CAPDyKFrGPYKB4eY+r6LKxbujJQt-5F_Ha4paeV0AT3kmY6DQwA@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc-rockchip: Add memory clock auto-gating support
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Nov 2025 at 08:41, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> Per design recommendations, the memory clock can be gated when there
> is no in-flight transfer, which helps save power. This feature is
> introduced alongside internal phase support, and this patch enables it.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/dw_mmc-rockchip.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index 6813549..62c68cd 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -19,6 +19,8 @@
>  #define RK3288_CLKGEN_DIV              2
>  #define SDMMC_TIMING_CON0              0x130
>  #define SDMMC_TIMING_CON1              0x134
> +#define SDMMC_MISC_CON                 0x138
> +#define MEM_CLK_AUTOGATE_ENABLE                BIT(5)
>  #define ROCKCHIP_MMC_DELAY_SEL         BIT(10)
>  #define ROCKCHIP_MMC_DEGREE_MASK       0x3
>  #define ROCKCHIP_MMC_DEGREE_OFFSET     1
> @@ -470,6 +472,7 @@ static int dw_mci_rk3576_parse_dt(struct dw_mci *host)
>
>  static int dw_mci_rockchip_init(struct dw_mci *host)
>  {
> +       struct dw_mci_rockchip_priv_data *priv = host->priv;
>         int ret, i;
>
>         /* It is slot 8 on Rockchip SoCs */
> @@ -494,6 +497,9 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
>                         dev_warn(host->dev, "no valid minimum freq: %d\n", ret);
>         }
>
> +       if (priv->internal_phase)
> +               mci_writel(host, MISC_CON, MEM_CLK_AUTOGATE_ENABLE);
> +
>         return 0;
>  }
>
> --
> 2.7.4
>
