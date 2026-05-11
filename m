Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA1340758E
	for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514055; cv=pass; b=MX87s3sDHxATMHmCCsHFLOaAGSn4jmdAHX0SU/LhKZiujfDstsPlBEJbVx2MSTLiP3R0AgOR864VpGbxiwVQMSTY0trCqoMDtASPwNqz/0euuU+WuKydIek8u5r47qtmiAWGCRx88c9VE8bXQIhRoyVmQ7eh8BimJ24RqDgFjt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514055; c=relaxed/simple;
	bh=IlgHgDCoiuZa4Cmmnm0RIab2e+xGzlTAxY6pPOdCTwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MFPtFBv+yKNRHYc5Pd1Mht8LrWe3MSeqzeDL4VRXZU7csjw7p0kQszNFsfiuF/WcGJBP2IiNZxVHuOgr3diKC57a5rGLawaU5PY6lKjNN/Vh0tmU03cF0kvk5egKk6DPnVYsrUcuVL1kzL9sYSJwjsOtrpBdNUZT4DURYmPMwEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vYHzbWuA; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vYHzbWuA"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a884ebba7dso4614922e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 08:40:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778514052; cv=none;
        d=google.com; s=arc-20240605;
        b=ChLt2AKnn+aS7mJTAnBKTGoQGjbw4D0GZVbzyNXFChKhDkV/vrG8JaPhVBm+aPSP6O
         +UuOgcCf2xrCSyK7XjmOSSzg5Wa49tgfI1o3Lu1MNpmCnb5aeWKCYorloSnpAbsZGiIP
         2TZXqSDpuLAEorp0v169AiLHTFQ6W6Bf6ldf7IEq2DM2qQsdpYEhWm16AB9XoTfTQOH9
         JyIBldMTp3Kcks8DOZIwjBnptbPkizQHNZaEwo+lizQV4r3s5MTgUciRcPYdYrMoqjil
         LgyMsskoZLNwWpO4zXegWQsCIeXwRvyZFLT4mHmRI7mGFl50JGNKOO0DjutX91CQutcc
         3eaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c4q16ibYcVW8OkH1EDPcUnEgqNCY/y0EPG9dEkZx/u8=;
        fh=Qogtj5jfpnpcnuTzlNvct7bwno6BC3raGnianRKe4Zw=;
        b=EMb/SERubhXNYPUae4+J9OHhzT+9sV8rJ6CzGGuhll1tFvjQlEs+8W4wCF6LfuzTIL
         X72mdXupxoAQpThwoJ2a9JbxDSOeQDUb05tkB8/RWywohQCFKOl6vmu7RR0ZaWpj7mag
         xodepJTgbbe7tghl4oPYpMvdBdYSo1CHfmsDq0lKulo0WVZU1yC8CuyrYLTHF6BRASKQ
         S3xe1l9jXBYdfTTVL99rLDrn/JabC/gfob2PRAASF3G42E4Kg/PAb3U5+qaHgVr0HRhA
         MzzC6303aTupJ01CzsnqXFkYtngtuONQw94F7KrtWElhPlk09SrqBT02ycTyzx8d+exZ
         EghQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778514052; x=1779118852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4q16ibYcVW8OkH1EDPcUnEgqNCY/y0EPG9dEkZx/u8=;
        b=vYHzbWuAx6LkxbvsTLkdW9apWrhotzPBW+w72aBjciXX9vQjCgwdSyUz57MIlAtsRk
         CAB1X30PrjGGiBIULt+iZZOuXJgQcxTNn27rjrHw6xe9P3oojFfzDS539cqIIz8Z4e45
         H3XECVTh7TjbWkxHO/MFNcLVl+++vLcAhEMzd2vHtQbKm8VmRqCpver6zETExA1bkCUC
         FGnNa8PJe+wbUQc0aOfJ++Cj/obGS4j2mayrs06XJtPQJjOT9War72ZIGH+t0umUgBjl
         IB0p1tuHgklt0bv9gE+cKA/0X++c17cG4j69c3OyqLlszywwBmu4qBg4GhG+DU0nlYcI
         oHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778514052; x=1779118852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c4q16ibYcVW8OkH1EDPcUnEgqNCY/y0EPG9dEkZx/u8=;
        b=CnrTm8cEUuMhrvye+aRlS5QbQIEdwdcTnZe0yJF4r1zxtw7YB63eOY2QI1QU20f8YF
         qfDMtZXrKSmCgVI74YqLHa2o1rb0UrdycxZnBdukzib3qgqUpTEJTb0VciKWL8x9vHur
         9X8364Oanp0zeBy9QwnV5OeRY9ohm0ctWoFD804B8B6eJUczreY1K4mv5rUHkFpvtuwx
         A5KeeTMHSb55hjKgHIgVLsrQ7tWu73Il5oDesJVvIdP5xwMZ6H2IzvcwoXkNtD/4qnyU
         eQu7h2xa5CrkGMiEiP2dysDHJvpCUlBQxnYK/SdhADVbOnBHbbSNqwU7FYIlVBU0G8zj
         NP2A==
X-Forwarded-Encrypted: i=1; AFNElJ+P4r25pP121Hk2h8urx/sIDeDU/D3DXIT3TLuyf3zgHPcw5VxiRmlkKEOEt0fIDJR2x6gB09TYE4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6/HhxwVbLm2H1aZtxRJT4b6njX7Xo1CXk68WvaqS0dyMefdI0
	nXl7MmJnRTMnGtjEQhw/xjCSw8sLFwz4Rln7+HOvz/YPGUN42Kha9u3H4HeHuIFUCmonnApxn9z
	aPxLJxzeZQbcTPhUs2VFPBFMZtTiI3jEKy29say64rA==
X-Gm-Gg: Acq92OFzkCEAX9TS71cr10BNmHAOqpXk5jfDELcg4wpL3yUbKwWzsvbKyvAL0rE8HCS
	CuGvUhEtV4p74fedBJmSQ008Jp8j7yq6lmwVdd21HBzrPcD69pxY+lDMPHg3yP7812V56qn3Gku
	2zbUycJJYfAuUsODXpvA9DaKp0rr+bboy4IBYjrF8WYAXqaEDRKaHvr7ZKJZvj+sf7d0zAgt4nP
	nfZCMn/oKynYfiwMcStPyXsBWY/w3w56wPE4gU8/4LL0jy9QxjPT57zBzMOcexHGI9uSbL4ZuqJ
	0Z3yPEKo
X-Received: by 2002:a05:6512:1153:b0:5a8:a558:63ae with SMTP id
 2adb3069b0e04-5a8a5586466mr5114965e87.13.1778514051821; Mon, 11 May 2026
 08:40:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507161008.3423977-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20260507161008.3423977-2-u.kleine-koenig@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 May 2026 17:40:05 +0200
X-Gm-Features: AVHnY4KGh-Q-8xbXfWp4QchtU0hySTWODCMTW3RIsxcraaYlX1WvlmF-rq2QCv4
Message-ID: <CAPDyKFqJWfOWKyMXPTPHhn-d8oOfq13DKRaC5n9yi22uOeeMkw@mail.gmail.com>
Subject: Re: [PATCH] mmc: via-sdmmc: Simplify initialisation of pci_device_id array
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Markus Schneider-Pargmann <msp@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 7 May 2026 at 18:10, Uwe Kleine-K=C3=B6nig (The Capable Hub)
<u.kleine-koenig@baylibre.com> wrote:
>
> Instead of assigning the pci_device_id members using a list (which is
> hard to read as you need to look at the order of the members in that
> struct in parallel) use the PCI_VDEVICE() convenience macro to compact
> the initialisation while improving readability.
>
> Also drop trailing zeros that the compiler will care about then.
>
> The change doesn't introduce binary changes to the compiled driver,
> verified on both ARCH=3Dx86 and ARCH=3Darm64.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Hello,
>
> this is a preparing change for making struct pci_device_id::driver_data
> an anonymous union (similar to
> https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre=
.com/).
> This requires named initializers for .driver_data. In this case the
> initialization can be dropped as the driver doesn't make use of
> .driver_data at all.
>
> Best regards
> Uwe
>
>  drivers/mmc/host/via-sdmmc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
> index c628b3bbfd7a..8c049f8355cd 100644
> --- a/drivers/mmc/host/via-sdmmc.c
> +++ b/drivers/mmc/host/via-sdmmc.c
> @@ -323,9 +323,8 @@ struct via_crdr_mmc_host {
>  #define VIA_CMD_TIMEOUT_MS             1000
>
>  static const struct pci_device_id via_ids[] =3D {
> -       {PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_9530,
> -         PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0,},
> -       {0,}
> +       { PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_9530) },
> +       { }
>  };
>
>  MODULE_DEVICE_TABLE(pci, via_ids);
>
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> --
> 2.47.3
>
