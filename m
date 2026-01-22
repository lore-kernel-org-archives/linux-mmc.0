Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1877536F410
	for <linux-mmc@vger.kernel.org>; Thu, 22 Jan 2026 18:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769105049; cv=pass; b=IqSAuI3eKq4R3At99/9xHibQSODqNCo4kk6ZFj85G9hJYW4fk0pngrMvVuB4oR5u78uEcmGs+DGyN2mjrpfcPXlgYYg1jLfitbxlmpSDZ8HcwdD1s79Cc/DVYVy7sviLBwwZHucSQiT43jkcR4LO6hKrbE6/yhAbX5OmqqxnnGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769105049; c=relaxed/simple;
	bh=8jD9gT522mnc4zg9by3zUhj/0pPE1/ck9u5VK+KIprs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPj4QcG8XDxWPxtdGI5v/jsNCRcGhBuMlQ94Tm+YRu3WsFDlPUl7ZcgSHwpKCGzD6KDKt+voKrytl/Kc6Rn05d//EHUAkHMylGQBSl8u8wBgq1AFoE245TR7UjsTh3X3iUgbXsEVC9ZNa06zACpr0Tt6EESCbyXFmHbCDpy94oU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KizHPpkh; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KizHPpkh"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59de2d1fc2cso743498e87.2
        for <linux-mmc@vger.kernel.org>; Thu, 22 Jan 2026 10:03:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769105035; cv=none;
        d=google.com; s=arc-20240605;
        b=cqZFJUnXEwUhlUE5S75/KZ8D+wW6y9gNUGPGdn91LcdRhLfiF8Y3pA8dYwXHWyA5OT
         il1iR/yJFvdPP2XAxGKpwyQSSU66hTx8ayG8LyE4I8k1ZKa2jE+HV2+ns7dAv6Gf6Xas
         KrzMEV+lrDo758BCe6zXYg991S6g0FY884F3NB8l9Fm/yLg+f8kk3/6pJByDmINwYg6s
         alaaKT+CaRpAcnsJjtCLcsJbpS8Vl8Jgxan95HvdMOTpP1E118ILz7xTTf8UVUlp8Av+
         1Xlqk/yXZItuL4qEwvZZ6GzB2s2RBIJNIT6HtcY/H38/9sak4cCXPzT5/nJfgy4CArO5
         epWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uNo8YH9GloHxEQ3/ovfh0KC+3wUSw5DleRSez1yBJUg=;
        fh=vLeGzKHZI2bK6etu1z9xmrA2N09lx3vFpAvGpYQ0ozI=;
        b=BFW5EJwhbNyClvLd8CNsYO4iOjY5sPYFNeqi4E8j7LInRb2GnaFPpC02Ms2Zo2NzPs
         R68gPgU9XlUnc/mJSRhTEo8kCT8S5zGXvotKXVi+l2owR9tBaTCzN4Ul12ivSrWLRFoW
         vMscs3GDqCugoXmB53Igh6nZN0C/DuzFl/uHa6O2U2eSjZvr0B/Kwm5TU49OMTa3u4+N
         Awv+Pj3lKicx0LfhJyHHcsm3jPQ9J3En7WB27iFLkEn8Stgq2DkTeccUJU3aRfJGfIk6
         yrKxt43ztq2kxOfFzQmJN4mr3lR10aYQMk2+IQR+jcfgjaYYxUFaAf/fwrfY55CbNtjm
         MyXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769105035; x=1769709835; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uNo8YH9GloHxEQ3/ovfh0KC+3wUSw5DleRSez1yBJUg=;
        b=KizHPpkheFeTMOkqvwTANoQzKja2sk8ZNhFTjn5L2cK+0CjWtWGB3AtbM1zAMb/KS0
         lwmnMSNgs/5vxHrbiEg29gG2mbac8NdABtl4TogeRG5j9JsWUTwG3CKz604UBNLdrlAN
         xpddZsy73EwmzjgZEAQQcMNIE5QLpbbMqlppYfRCOWMzC0y7PWWnUKItukiFGn/2E1Lp
         7DVP3TAJLVvbNdTKsRDaqSjW3MJBJwUTJncAShFSQV+YZhMadNu86XmYse0+EHvavsUq
         xh49e4wfQ5o/ci5jkzZpNgGkBYxApShp7OjzkP179lXv5GR3oz/2j6cPQlC5WMmbk8Bd
         4kkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769105035; x=1769709835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNo8YH9GloHxEQ3/ovfh0KC+3wUSw5DleRSez1yBJUg=;
        b=wXrAZk/fQhwMIRPN+FteN1cozF1QjcNTlyUuxnNZmFaEFa13jNmhNVt5Tx5vURyEcC
         6LV7cTj7ejWbCx9raMTJ7TAGEIsOK1hJpBxNSWAzJYi3JiXXqBXQbcmBHC0EKskYYAHK
         vC+O8nn//0+Ii9Y2sNVqE9/+tF4WJykKcxP3ORtbkSvHSbOksNwz5VhuPHbRecO2Y9uF
         53rB4hmCFRK9lpWrFtIhRjc5c7WxrHrf+FbuAOUHiuZnbgdo52FGl/tgMPPOLY8ykMQD
         7UkdkEl3reM6GvA6Fr/6iTJjqNORvtJyAQy1LjWWhTWaC2zicqJbhSGyqeJsEdD61/Ls
         xpqA==
X-Gm-Message-State: AOJu0YwiMvNApwmT6ZDDCNqk4XqytO8n3f5w+HzIRJvxZMx32PS3Ftti
	lDhgH38AwIlpeiFrOojJNREeLPuVghkreb9HSyLVDpaetj2CJlOeDE1y2ABDYJN4Ulu2SF2bQ/m
	PSkeFgloDiFnvFWRd1HhdfuFObvGMA2WXTwO3mYKdstLDEn+rsbNs
X-Gm-Gg: AZuq6aLQ3rC1KDH0exE0yBnCP4i3N5mnvUfR7whaaxdE1MhWWIkrXrzo7F/K2bt+a1V
	189Nf5u0yuZjxu3aSpejj5XX0y0PnHJsA4KrON1H8KoR5/RidLrQ130UVN7wRW2ro38QX7K2Til
	46GEUqXyQC6KAGyz+Z36VGV27V9SCfB3sJxqbjccYl9TbL4/scUjmUMhD7AWLij3b8j/kb39UQj
	vhhiMn1RfmDhpnC8mShbIYHV8xf8vBokVDcrXYIrUOujpqYqv9KFpeXsSrTAOKzTYi8KaiK
X-Received: by 2002:a05:6512:2c07:b0:59d:df5e:bfdf with SMTP id
 2adb3069b0e04-59de4921d1amr42527e87.33.1769105035138; Thu, 22 Jan 2026
 10:03:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113031517.244714-1-jeff.chen_1@nxp.com>
In-Reply-To: <20260113031517.244714-1-jeff.chen_1@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 22 Jan 2026 19:03:19 +0100
X-Gm-Features: AZwV_Qj0pOAv1r1Ag1eEbFUHxg2MKHeEeGABciCJLePEhB_UBllLqaz-C1f-x-A
Message-ID: <CAPDyKFp0+70OSrW_zrV+-fdr-BUScKkyNzTHkN==+9k52Z5j3g@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdio: add NXP vendor and IW61x device IDs
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Jan 2026 at 04:16, Jeff Chen <jeff.chen_1@nxp.com> wrote:
>
> Add NXP's SDIO vendor ID (0x0471) and IW61x device ID (0x0205) to
> sdio_ids.h for future support of NXP Wi-Fi chips over SDIO.
>
> Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  include/linux/mmc/sdio_ids.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> index 673cbdf43453..39ac2b612e4a 100644
> --- a/include/linux/mmc/sdio_ids.h
> +++ b/include/linux/mmc/sdio_ids.h
> @@ -116,6 +116,9 @@
>  #define SDIO_VENDOR_ID_MICROCHIP_WILC          0x0296
>  #define SDIO_DEVICE_ID_MICROCHIP_WILC1000      0x5347
>
> +#define SDIO_VENDOR_ID_NXP                     0x0471
> +#define SDIO_DEVICE_ID_NXP_IW61X               0x0205
> +
>  #define SDIO_VENDOR_ID_REALTEK                 0x024c
>  #define SDIO_DEVICE_ID_REALTEK_RTW8723BS       0xb723
>  #define SDIO_DEVICE_ID_REALTEK_RTW8821BS       0xb821
> --
> 2.34.1
>
