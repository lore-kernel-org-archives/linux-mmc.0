Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87AE207DE2
	for <linux-mmc@vger.kernel.org>; Thu, 22 Jan 2026 18:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769105067; cv=pass; b=nxGdaYcV4crvBps2zQ9dWP7OXFyZ3GRKwVsbCF2Ujc3b3MRmPgckaddnHcZBeDdEgFnAM1b73zUXV4KTrJojIGs520Sm2lMzjggi/Axnq5hyjnQ6FW8m8R2AIN9UawGovPi5jsFvDgh2PzcflIjepULzMVPqQWkafwHxXrHWefs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769105067; c=relaxed/simple;
	bh=jwn1iki7W739NPph6CGujtYaaW5pQXnVefzP5pPy7hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WybrC24HpUDaCDgYfmvA3kkuOIOh5VB90isPknVQal2atNkkKXLot2wvaVuteCBuyBax8WB9jSTDSaMVn4ABftEHe5EkkvVnEvJ+MZZYXmOdBIcV3oeGBYVozUjSmF8aBmml27wVkKTHg8uewcQGL+yEngnpwKhe2GG5iDuWP+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PYn0v/Bm; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PYn0v/Bm"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-385cfc572f1so8103541fa.3
        for <linux-mmc@vger.kernel.org>; Thu, 22 Jan 2026 10:04:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769105042; cv=none;
        d=google.com; s=arc-20240605;
        b=KyP6ZlgvS7s4KtsAbtYme5iQazI39VXAlfITMp+A8W007TE34hjh1HmipAfy0DlX6g
         eCin3ZvO2evnJ2fM22ijdBAbg/qN0yrdVONNE6H2nUxfZ1BkiK8qCiy5bsv6iud2rG8k
         0fmqj7EkEMFDYl63Rs8Y105BDLvot+r5OSojOWqRwVUlvw1XctuyaaaUTGyWaIXqpW/o
         GQN5vduLgE0pk57vlDiFnrE/CR773n2YCDElnqjwSjo1T59WmI8RLMDl5aGArZxjcHIe
         Kfh3xhfZrUN/1QlIkBuIdHxFfkpRcZruzCWsVJEYKQfvS+yF4G2Lr2WPwHgejrzj/Blu
         Yr+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=44MyyOg8u+kawBMQPv0pxBijnkCh1p4X+LE9snSz38c=;
        fh=gNLAIxkssxALOakdKtoBJLm6HAxuqHlaOUDsEHSF+pc=;
        b=Y3BCjBLRXfWmM0g47OUDD6HAR8/2IWAKEQSf0QebnJdS5Cv2UXYZJD8qB6NJ5uD/C7
         bBbMLynat/mOFoQcRIRQfpiMD4rKh89IIJYqklv/il0h1yqLZgr8H9CZPXLy6Wqas1Mq
         eOg+Ncd+E2DRcpSDyhLkSDBeqXOv4m+8nBoE5k3IYjFedGORKUxiRR2Kye29yxmFTV5m
         SNIILqxErmFWLsHlHdp3817/C72lSoyOQvX56i8OKPr/gUbFDSLm0b7QzWk3kvKWhoVZ
         Ns4cQtSrVscCamhgF9Kw46mhS8fo1c63/NTKxoLASGzeXupIfGikDDc2XawacwbZewYN
         Yo9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769105042; x=1769709842; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=44MyyOg8u+kawBMQPv0pxBijnkCh1p4X+LE9snSz38c=;
        b=PYn0v/BmEIsrQuxgOAcyVmxJ2xiwz8kwp9YxPgF4fxLsAPxWS8+TOS8hhbvS6y4jyA
         g1gmG3d+Axqo5bZbyPIu+yd7lvfEOlU2SSWR8EOwUnz3p9IXDVE2efC8zZeaWX0QB1W4
         TLusvWoOJjdVCVFipEroi6zD/oL3o/gAkhlEZ81PGntsWhJaYj7m3bgB27Ms6IAn+GeC
         bRCq5liYM+Teu46ya+9MXE3V9IJYzNijChHOen0ZHNpv76rK/cHwpoJN5wdJ7TOL+n4i
         bJQA30ZxARKkb94KgMMxhdjDEE5sabjph3Jli+ybCZLPF+Ld64gMBmkMt9z/Bzd4wo0o
         KeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769105042; x=1769709842;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44MyyOg8u+kawBMQPv0pxBijnkCh1p4X+LE9snSz38c=;
        b=uriOKPj5YAXaXtErXelLx9SfygPb8J1Yqu2nIRRe7RqOp5gFIO2iRn4yCpDN9MZxET
         ud1nimZOaq/WEgmw2JhNHuXPR2GLX6VQ89uEzo5dQ4UiMPeqL2niPksLDEGmzKvJEoQn
         bV5gAiA18gm1+wR7fQ0MKven1pPqh5YAn+obwUqg+6Zxeq3j5/CTyZGOYuryoybMEAW1
         ee5IJxWPIvAtzq/BAgoXVm2HZixB3lkLQCn3VQfcvYFZ9L/TEpLgHe1rc1u4/24/fwRT
         HWWi7NemlnO9CJDpJyvG9uDH59foKzjTsdtc/Hy3MzU/6+fsDHKKRVO+1vixqudkcCJV
         L6gw==
X-Forwarded-Encrypted: i=1; AJvYcCUoD1bsqIXVeaSJixricQqf621fKIo9LD5NmjWJ+b0t5+hrMcMoMvfymnfGrkuqOsRmSJ1Zil4U4yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG9UFJhO/PMnecfG2y6fCa24aj07dtDzxWodhIn8/IDmbisxh5
	hpxKAkMbgXcNVQmzqPAmPxEBjuJ/NcN/didVHyHlES3vgCU+JHH12XM1hiNGLKhNNBwW59CSnw/
	15kSZnIAZbExP+0hW6yhpR91lmR7D6jpGN/gyaBagY4gVBN5woat7
X-Gm-Gg: AZuq6aJ86BAnM+aAaiiMrMCxickOVzyTw59C12rzqnBTAFkvqE5jkNOeUpQkDYnoBlX
	IMI9SXUzjb5oZq063x0GN6qyNmtAoPIpACelMQWqShtJQsf8kgSMiLEuB2gqaL4yEWXwuwMKu/r
	Z/mtnxtk98iC0Fst9jeEgg0kuz8D5h8bH7bmMCu6E8t1OSQeW03t5kSFxKFaWzJeCOaA5oR/Ts1
	fVBNbNIBAn8YKJGDPdv4pesGbVng5SWf8ZwpzkJ52driAt3rbjfmQpPKmabvzFTYcIR+bje
X-Received: by 2002:a05:6512:61a6:b0:59d:d65c:ba2b with SMTP id
 2adb3069b0e04-59de490a921mr69586e87.19.1769105042267; Thu, 22 Jan 2026
 10:04:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120-mmc-no-advert-v3-1-1c7a6a55ef9c@kernel.org>
In-Reply-To: <20260120-mmc-no-advert-v3-1-1c7a6a55ef9c@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 22 Jan 2026 19:03:25 +0100
X-Gm-Features: AZwV_Qj-pTJLH0Yy6UqyEsJ9NNZ6UWDTtTvMv7DsKPT68zX8czML7g-4Qi3H86o
Message-ID: <CAPDyKFpAid8zkLfZxi2fzouYyibPYYvhDZ+bsH8=hZAewMGyeQ@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: sdhci: Stop advertising the driver in dmesg
To: Linus Walleij <linusw@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Jan 2026 at 14:05, Linus Walleij <linusw@kernel.org> wrote:
>
> From: Linus Walleij <linus.walleij@linaro.org>
>
> As much as we have grown used to seeing this message on
> every kernel boot, it does not add any technical value.
>
> Drop all messages from sdhci_drv_init(), and drop the
> module_init() and module_exit() calls as well since they
> now become empty.
>
> The modules becomes a pure library module, meaning it will
> get pulled in by modprobe() when the symbols inside it
> are needed, or compiled in if any users are compiled in.
> Kconfig already makes sure this module is compiled in
> the users are compiled in.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v3:
> - Rebased on v6.19-rc1
> - Link to v2: https://lore.kernel.org/r/20251008-mmc-no-advert-v2-1-45bc00006fb2@linaro.org
>
> Changes in v2:
> - Drop all the messages instead of demoting.
> - Link to v1: https://lore.kernel.org/r/20251007-mmc-no-advert-v1-1-0e16989d28ef@linaro.org
> ---
>  drivers/mmc/host/sdhci.c | 16 ----------------
>  1 file changed, 16 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ac7e11f37af7..1ff15fa9b042 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -4997,22 +4997,6 @@ EXPORT_SYMBOL_GPL(sdhci_remove_host);
>   *                                                                           *
>  \*****************************************************************************/
>
> -static int __init sdhci_drv_init(void)
> -{
> -       pr_info(DRIVER_NAME
> -               ": Secure Digital Host Controller Interface driver\n");
> -       pr_info(DRIVER_NAME ": Copyright(c) Pierre Ossman\n");
> -
> -       return 0;
> -}
> -
> -static void __exit sdhci_drv_exit(void)
> -{
> -}
> -
> -module_init(sdhci_drv_init);
> -module_exit(sdhci_drv_exit);
> -
>  module_param(debug_quirks, uint, 0444);
>  module_param(debug_quirks2, uint, 0444);
>
>
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251007-mmc-no-advert-8f5646c44dd6
>
> Best regards,
> --
> Linus Walleij <linusw@kernel.org>
>
