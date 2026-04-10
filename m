Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A333A544E
	for <linux-mmc@vger.kernel.org>; Fri, 10 Apr 2026 08:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775809890; cv=pass; b=i+OOZ1l1RPJ1Uv6yrady5XlNh/pC64fXpZ4el0m6zRi3bobo5oH50zMHGJG4I//nx5n3ieXYN4ZXqJX0oONTUxdOAbgelOoEPOidfieTU8lqpKnPE4liWsdSYRDCUTDiGAmvgsGtxAQ6NCRO8CbT8Zb2wTwfzcXEtC2ls6QmOy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775809890; c=relaxed/simple;
	bh=402Q/LEjsil+pHuLqlPEUXJ3L6aFG5rDH+20SRXqqw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/VsY3EnJIv1T4FjYYocXoaaXSq8P26iJutkh8XgfDtyTzG+LZ1Opnccy69MQzCeC0cyA74j9TS7vDYBALMuQn34acStHHMdAH2u3/gaGxlAdNwFKQRPS3wLVBQ/Wp57qpkv1nkx+ifxV+k1dP+Of/LEM3AZh8eOtu2Bv5MF/XI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=COoctWWO; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="COoctWWO"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a2967e5de4so2646309e87.3
        for <linux-mmc@vger.kernel.org>; Fri, 10 Apr 2026 01:31:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775809887; cv=none;
        d=google.com; s=arc-20240605;
        b=K221zijvDaJ1Dr3pyXXBXvqlk5Ktw5SdhCk7y7eU2unMeKJPjVGgFKY21w6Q4lPtm7
         tLdu8M6CnlzahA4kj7Bdgck+arrSO+Vl0CvOtyCDu+Bp0Th5yzXwsXfrVv1oYg1Pui1v
         RTV4YAPS5W2UkfRE4I2nBi8sGDwASAWm+nIqIlbswr7vnfaGkSDqD/0WlhshZJJRv2cj
         oGdBwmyVId1q/FAdtuaSoR7Tsn/kYxldUf/l5TxY5z3lFQ4C1XxbePLiKonAR7NPGfI7
         6prWtjMMiBvSS2OolXNp+C7QzBS+T23wIFWuS5gABaHhVvkenjcrujyRUHdI3kcfPKt8
         47JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KEJjrIfQId/h77djj7M4y4n3Tb/7Xj1HxO0kKsRBFF0=;
        fh=B95tgFo2HWccRQwhDeLumDN8wK6hSZAQWChWDXILoLg=;
        b=IejtEfKRqK1STjgw/NrcWfoG6rQ4lArJbSyJA85QV4AVMX6jegeQc3RniokMUAQS2S
         z8drF1sdAz6uRYsM0T5M/+xi9ZI4bdu530TvkFyC6Gqj9zFRcUzA2FVMkrGWXan/6EoA
         G+VcpxO+pxDj2joJaQbJXI26B16gulNgLdHCqiC6UPX3AhcimyBCCnMUXLQcQ1pdmEoc
         X9rA8HbV7P5Ar/ho+HeAX/K1EkK26k2I4V875QenJ6pekVKMrPDcDUJVHkBuWgoXnzxr
         oj0kDDxVghEbiM9j/jq0bf0pjxlJoO4GWNyz/syrVPYuJLgAtJ1GczRfOABO4TeKuGW3
         OA1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775809887; x=1776414687; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KEJjrIfQId/h77djj7M4y4n3Tb/7Xj1HxO0kKsRBFF0=;
        b=COoctWWOZZwmFLtqj5+KD0CT6B6aGMz7AmqwWAESsU9puJSkNLECLPd6GRzpIaw/Ls
         IlHqwYQarriTXWp0eb4KJ43uCbQZAJT5KPy3auZ7AgjMBkNDCDI+4slG6KLa972Ev5Sz
         k4rsrfE4sqNYFU1HKDHw18I8FRZHfJaH6NUowozoFyyXb+aXh9dfzr6FoG/f08a/Ltk6
         +ASiczmOoOa3FtASR7B7BgY0bc8iANsBTY8+cm25esXloyPI2+Qmf/loJbX/NODCydRm
         63qZdMPFrsKz60ahEF0tYZFKvlzeMPlMVOz3uVTuE+g+xRnlg3cUPuXhDluHez7daODS
         S5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775809887; x=1776414687;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEJjrIfQId/h77djj7M4y4n3Tb/7Xj1HxO0kKsRBFF0=;
        b=tD2TJkR9AO4v1qpSB+oFW9uENNuiwNewiaAbJzLmEKWDgJdsnzoy3mnrxUZuz1pM8i
         5r8NZOsWwrhrVCT4Ok/mhMb8lXBBr5xTl8q1FxUkZJ/RVtO9zElW4HI7HT4S/zaxMk8l
         66r6rD7HPt8QxqY3bWsrgAXdhKZBX33xCjAFyzTZG6N8BxRNKxbI4uxRJpJOk//L4QeB
         rHXWyotEpfsYRUNlmBx63s/tK1l3BEhrGU39hwEnxTn9f3AbIdrt14Z3W3r4+HKnCySJ
         yIrGAWThY/0ENIWd9IKsC2n/4Yq3K0is+wI4dCz0ADmQ+sgF87t+eAscVIljfLkBoU84
         DEBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+0Y+Qv+DMeZtNzNewTKlcwn/FHQYVjG2dwXyyBKndmAbpIfFGaiPNWy5whdHPVAufzPp5zLu9InE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPSfflxqCBeRqQw6EgizxktrFTzRWD4Y6fXCty9iK8G+CuhpWN
	wHEuW5C9RcJu0IH2WX+1to+SARVLpf/2TVSU+Y3JOvwMKKpJmp2j1tfIueRsIQuXNahjrzb5Qzt
	xWcuWhn2TBe1pH8sPK3Rfh3/8zCHhH+5MC0+SyOxwww==
X-Gm-Gg: AeBDiesxE2eICwc63fRHEqi+4ZyKVAxKcrKj+KyqMAiYlwkhhCqmV0DXKAkmIm63TgJ
	7qI91RVQoHCpVBo5DjhI/0c84GzqzZu8ji4//1WOrOzvoBhdOsvhRkqULyHCvLfjGppf288Uwdh
	PkOG4G3Rvw7zKbBZyLkO2Xniq1R9St/3W/i9L1+LzMzSXPPHKQkudCgR/FWZBV9Lu4EIT9iCFDc
	IYntZqmoI0fDW2tqOWDatPc05EbtvPpfWRfsC2H0+EIkyK1lS4RdDGTbGmMX6FnbRNdXb6cG6lG
	37ity6QK
X-Received: by 2002:a05:6512:3d88:b0:5a2:a5a5:5247 with SMTP id
 2adb3069b0e04-5a3efb41a66mr856670e87.32.1775809887115; Fri, 10 Apr 2026
 01:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410065833.3189808-1-neeraj.soni@oss.qualcomm.com>
In-Reply-To: <20260410065833.3189808-1-neeraj.soni@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 10 Apr 2026 10:30:51 +0200
X-Gm-Features: AQROBzDrswIC_zPTfU0VV8YKa_B7tyiyd0t06DcGC-OIk4-kF9hovQfVfSbQBB0
Message-ID: <CAPDyKFqRUnijc3zdGszukUw9HHwfbJw+F+WxuE+vj9qpMgu=ow@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: host: sdhci-msm: Fix the wrapped key handling
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: adrian.hunter@intel.com, ebiggers@kernel.org, abel.vesa@linaro.org, 
	linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 08:58, Neeraj Soni <neeraj.soni@oss.qualcomm.com> wrote:
>
> Inline Crypto Engine (ICE) supports wrapped key generation.
> While registering crypto profile the supported key types are queried
> from ICE driver. So the explicit check for RAW key is not needed.
>
> Fixes: fd78e2b582a0 ("mmc: sdhci-msm: Add support for wrapped keys")
> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
> The patch series "mmc: host: sdhci-msm: Add support for wrapped keys"
> was originally discussed here: https://lore.kernel.org/all/CAPDyKFqRG1_1aYavfrA0Ss85B0kcTnjVBeqLgq8PUJUcSx5LUg@mail.gmail.com/
>
> Changes in v2:
> - Updated the commit message.
> - Added the "Fixes:" tag.
>
> Changes in v1:
> - Initial changes to fix wrapped key support.
> - Link to v1 https://lore.kernel.org/all/20260403105949.1007447-1-neeraj.soni@oss.qualcomm.com/
> ---
>  drivers/mmc/host/sdhci-msm.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index da356627d9de..df0a038269d4 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1926,11 +1926,6 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>         if (IS_ERR_OR_NULL(ice))
>                 return PTR_ERR_OR_ZERO(ice);
>
> -       if (qcom_ice_get_supported_key_type(ice) != BLK_CRYPTO_KEY_TYPE_RAW) {
> -               dev_warn(dev, "Wrapped keys not supported. Disabling inline encryption support.\n");
> -               return 0;
> -       }
> -
>         msm_host->ice = ice;
>
>         /* Initialize the blk_crypto_profile */
> --
> 2.34.1
>
