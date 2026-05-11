Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193863019DC
	for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514048; cv=pass; b=mlWkh0SyhAXQxhDi3I8P4a9ImGIXEviGyM2Ro1ZgOxIB/3tkQON58vKq89ajJlBAteYP2nW0tX0AUkgLFVAZfxUoc348eyR+gqXmnZqPp2FV/l5by04zgKl2gr0ziVJwy65yrberMZg0RBMkOfPfgGPGdMnMvHQCWWkezrDoQAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514048; c=relaxed/simple;
	bh=iCAqFcT9NX3fZjkDKNrQDg8D+ochKGSkZTc2/qvY8WI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XhB+OK2s3OmtIA9PMnrF3L1EtLGi7BakZiswi+v7cM+BH4LI2j940RGRY/KsZ3zIWOs/Z/e77upHzuyyu0BqSxdRozkSeDjg6McYF6/0O4cwsIhgjQjERfufc+fnQg1ZP42B6OdRq8/Pmmm8zmt8HuiMIoWWHPTT7Y28l+AoZkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gtTNE/CY; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gtTNE/CY"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a10d130b37so4032734e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 08:40:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778514045; cv=none;
        d=google.com; s=arc-20240605;
        b=COtq1VzfmxsDvDMB5NxCm5B5fq0MUS4OxhO1mBP2U6P2h2xi22QMt1L/rJWAD6E3zY
         GKD9SGarT22fTZoJ9zXizOuHeKspNEsZJRb/adWDq+FM62GvozRLbotf89oCjP4Rqmsr
         EOd3aBcukH5rJaiRqR44yuqI6UB6zszOKYN/VGlinJe3k9ItftL5lkhlm1aGdhRTQdRp
         snO28VlKj6CfCe6tkqy3PC+0sXf4AX9SXt6d3J46jnq/HtL76IqKCQ8vwXsa4/9tWja4
         eHaVHfe8kCOmiR9skUpJI0UUtY4bZK64Q7SOpIaaPhVCwCyJXFupVHoyQpiUoLtioOgt
         3lXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3JWMhWSTBa1St/FT9EYONC8eNpWkZ18pjlnscArsjYQ=;
        fh=Nq2wkhfICRNGchUSMLMDtd5jw3bm6s+HDRcsM/xiQgM=;
        b=IFwtEED3w/RN3JH5OHNCKAhInVpXeOvAhn+ME9bMykl+CdmLGu4U/DCQ5VshU+ONtM
         x3Rg4ez6elvDpvjPZLK6AHKl2tWTUrpoyl1dzPQD78QLYjsihwYeMDEU433G67ontKfd
         CAM4imfaO73aCTZmOnsAaaETJWFil3fcsZE1PsemQyeyGk2SR5VDSw4d2y/41pSMHb8D
         HGRL3FdW0s1kHRdix49IDqm9iR+NxOveJpZ3LXcOid79l3PcnoX6UegH9SaOB1C9ePWq
         FKiRzuERJlufGlVhWz04Y72hZYnF/eN+oeDqVrzKt3j/sXy+O8T+AoENhCw3N9FMGH9/
         lrOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778514045; x=1779118845; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3JWMhWSTBa1St/FT9EYONC8eNpWkZ18pjlnscArsjYQ=;
        b=gtTNE/CY9GbJFWB/1LsKXb/Wpr5w7kInVcfUuphMLuS/53gvK4+hTQH9ixl7vdg/oP
         XB7SyPGemFLi3xo+Wq6zzry6vR45B/MSaFpHmXEoFGtBV4HeXo1kw6iHHnjipPU3DLKQ
         kv0q+U+LPkk5B07pyUx5P/dx/Dsx5uVcY3I5RDv+L7c0F9LfgfqOwnFihNGoqykti7Vz
         nyV9gPEgrCMFooYKB2BwtV3l+P/OqIwulxh3FyZn29Ms3TBl1dU9VLB2SsANOK1Q9QBa
         NClclIG6DxPy6T7sV/U4foTjBgGU1fV+W0WG53HeWYXAQ1Uj3zx/l/CGeCjHmVlmYbvp
         OrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778514045; x=1779118845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JWMhWSTBa1St/FT9EYONC8eNpWkZ18pjlnscArsjYQ=;
        b=s5rRpOjvo7wUfPpfwYyiuxUDs52mm9ahcfSf9arHZN8CZS3f62CneFOaMrUaQZfPzu
         WbrsGCFDsoeyP04lFBohSpMBPVeI9Wecg5XZc4dI/yZNUy5voY1+Fv6Nf4gyA4MUy1L8
         EZwie1I4FdI+xpjRYNt4PMULVTYk91QEzsMAdj5Vk4kw0gMXrfTxKvZjN2ogk4a6Hk7W
         TaMLfCeA8gpOlXaqZ1lq0r1BZ3zOyyy7bSHqn8A2GSQF3eWOVja9IWJF12+jKPr5ZyWc
         myBSxR5N8Lvyue0yhMTwpfOWX030AbpPHbVHy9Oq0ppAPIAZYtFEZrQGPmE5GKNRigew
         Dxzw==
X-Forwarded-Encrypted: i=1; AFNElJ/L39k73bcA0fVVkJ79rv6Uu40jbEhH+aZSepU9fsgaBgs2aQdsEmHJJV31CB2Em+RC4n/71JLK9yA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl9Tbl+Bbi6ZZS5Ad2kxiX/xs7ZQSed+c1knURAny5JdXh0oto
	g/GT+079r/JJXLcfb/kYP0Afiq1zMV801c3XtHk9Z/ShfTDwBG9cC3yF2b+yoTVdBwGpWFMv7PE
	i75gZS/i1D5F5Q3PB6CogpachacbRIhZhgyGa1HLeKg==
X-Gm-Gg: Acq92OGyVX2Mkmg9cWPfffjtfKG3beVYb0lhqus7Pr4U2VY2R3+9kPVsKoyjhc488zz
	/ELfxAfH5yQKoeWD9oNu4eH8ROuUcypdD6vFgaUPSYQ2IFvtSwjGL0pLaxIQDi5Sg9iprytBtnC
	5lNBinvE7F5F8ULjHjQSBAfcJ8W75VaRsvrS3lEzuXrgnBAmm8hH3HZ7oE2hLaELeHXD1uAEY0c
	AY3GraEu6j2duAs/2TfBf1FYEIwbTCDMKij8BeJyzx5ZGTp72LMIoo077q+Odu1p0HRRcmO/IuN
	4DHVJ0tg
X-Received: by 2002:a05:6512:1081:b0:5a7:4912:1a50 with SMTP id
 2adb3069b0e04-5a8e0f2ec60mr10052e87.20.1778514045188; Mon, 11 May 2026
 08:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504144534.43745-1-marek.vasut+renesas@mailbox.org> <20260504144534.43745-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260504144534.43745-3-marek.vasut+renesas@mailbox.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 May 2026 17:39:53 +0200
X-Gm-Features: AVHnY4LEtYRDfcFkDKKMsfq944FdAC52H0vJFxs1kLbNHgSvbuAlOvG-QOqCQEs
Message-ID: <CAPDyKFpO5RyaSGRZibAsygRcfs_En-TohTOrO6a7dUdVdzcuxA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] mmc: renesas_sdhi: add R-Car M3Le compatibility string
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, Brian Masney <bmasney@redhat.com>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Magnus Damm <magnus.damm@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 May 2026 at 16:46, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Add support for the SD Card/MMC Interface in the Renesas R-Car M3Le
> (R8A779MD) SoC. R19UH0260EJ0100 Rev.1.00 , Dec 25, 2025 Notes 7.70.
> indicates that HS400 mode is not supported.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Cc: Brian Masney <bmasney@redhat.com>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Ulf Hansson <ulfh@kernel.org>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V2: - New patch
> ---
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> index f6ebb7bc7ede1..b716a518f2650 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -285,6 +285,7 @@ static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
>         { .compatible = "renesas,sdhi-r8a77970", .data = &of_r8a77970_compatible, },
>         { .compatible = "renesas,sdhi-r8a77990", .data = &of_r8a77990_compatible, },
>         { .compatible = "renesas,sdhi-r8a77995", .data = &of_rcar_gen3_nohs400_compatible, },
> +       { .compatible = "renesas,sdhi-r8a779md", .data = &of_rcar_gen3_nohs400_compatible, },
>         { .compatible = "renesas,sdhi-r9a09g011", .data = &of_rzg2l_compatible, },
>         { .compatible = "renesas,sdhi-r9a09g057", .data = &of_rzg2l_compatible, },
>         { .compatible = "renesas,rzg2l-sdhi", .data = &of_rzg2l_compatible, },
> --
> 2.53.0
>
