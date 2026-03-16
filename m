Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F523A3E9B
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674168; cv=pass; b=EhOI1CVWtSUjsUNDfz7Vesm2l4/E4yLwjiAL2UVF7zapAe0nRypUoVKyTWsDBDF+Eo5mnhCyf2NNvyB2JdgUrT3lPivl+AgqvtSpE6SGJ00tN0Vl3+gH20/XLPhrpzs/ijBU7rIaeWfCJp27iHZdLpmg/ia41/zRUPv33H/TO5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674168; c=relaxed/simple;
	bh=MlbPjgkbDjZzy97rL4tyaIWnLS+hi31RbU0SxYxTQpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SjSoawNz1HvSLlg4lqCKqCPJsaWmidAOfsL6C89pKlHmK0Trrk3zqsw8LTRC3/jkpuynhmiv8tu6tD5MEc1fV/vYo2tKS4YZXfdqeRWazawlVFnrYBwOCCw7ZU66q9PsYRmQOHBugm15Z8GK7HVt/W7+KzxrpjGKUq4g9TXlVmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tdjRcFbl; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tdjRcFbl"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so5599935e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 08:16:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773674165; cv=none;
        d=google.com; s=arc-20240605;
        b=AbJ21oIiXLUMwsdLJFoj8BfbKPW7rABqqT0IZdJgXF5nUXKV5K7rpCkVsqWsy4yD/J
         Sbya06t9x6G2oma/CgBn9I8UbvUwFsqSnS3af5tqTY8oGsn/XECPKm1wIc8Vq6Mz5xqB
         3nI7DoyMWSGoGgUeZGdJkmwjmN/h3FFwNsO3b4FQ3aRCyZMOAbsve/I4T2vr3h0bcYeu
         zjxY+U0Hf80DrcHibxpBoNw6HhO4H8m1fOBlMvKtl29ldE1utq7GzTJSmqFvumoGy4sW
         HlBJNPMPjwdtt4ke/Z5FNtBDi78h9lBBpKpqFk0OEc4SO9sXtpgbVgmUD/aOpOANUFne
         XUoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KlM6cFVmM/SaOx6burFPACi9y9V71qm4hfXUPER/Krk=;
        fh=9YxUi6yA2y+v5fAUjCYYNgPcsaFiOqE3TB3KWnXRoN8=;
        b=ANfLj8Dpn5ujZJESJQCh2wRVQcQoOW0JeP544ypc4qz4+veDXBOYvVrwcsn+sT2HdC
         PrvxmOaAURA3pJCgsPtHzyQIrqdJcXZgGb6Uo3mrILg1+/9Z+l5/J2XEwSdTsJOMj+x7
         JW85arKpPtYSj8JipI3phW7QGW9IBUVPaIo0hVps3+oy09Zk5c22+camfFON13oBXZhz
         grXGi99AwWQt9CcNjy6d70yMJ+yWVRYSiFcEI+aXMxTgj0jvZEqbyBV3MAPaDmW1CcVn
         SEjgZwji768VBaTkoOei4TzBxXLT5Nu4Cdw6CaP3NzNuxOryNlGeymOvRSZBGpcDaSH2
         XVbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773674165; x=1774278965; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KlM6cFVmM/SaOx6burFPACi9y9V71qm4hfXUPER/Krk=;
        b=tdjRcFblISYQRCijuCe0IYt+OcdGWF6n7IKthgKcgcl2wXbThgha3UUGe4UJRplvso
         SarN6t0TBn2iyyioETzpcS6TM4QYTdNOFj6VzNufBDCTfHFTkk9Pc1ugVePzKrieZreu
         C5qg3RviOY5kHyR756gysKRO9pzbF6pzZJM5M+F6O+GgxTzErMI1Jrd2kdtXEM8m6uWH
         To4Nl72cz6SVtLSyc/9s3rTJksExk1XmkMvkMsUVKK9CL9xJEYk5ZApef1WYqR4epieU
         m4Sn33WAvfjcoYf+BBAbuWwPaJEjVyYR5RN2GMIBcSbt4C7z2I2jo0wdjfGU3nXqULEk
         mmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773674165; x=1774278965;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlM6cFVmM/SaOx6burFPACi9y9V71qm4hfXUPER/Krk=;
        b=PiXQC+zbsJJ20CHdIG2KqgFq1LUXxIIoOlwKrK6RkqoYSBe9xcxwRfowgLIBMdosmZ
         3pFNtV/tPZWTzzDp6agmYz2bATQ/hnoeAhWN7Oyu+5Jl1cuwvyaTri1CcIhtuN4CN7aU
         R6GfK1E6viiK48BjT92268y2WrQUoENGg6MckGjqZBBlVNW7S0gL2kS4J/QO19MedQQ/
         iUtNuU60veLZuocJGRa3HK44S6Bj+2Y19bztJGBZF7fgraIgusQGwknNwooDCfnmrkCW
         68mWrJOxVyccH15vT2SYoZst7pXBfkP5IsYwiBal8TJSUXsiXmct4yIA3aMBmBqSH6YM
         Yj4w==
X-Forwarded-Encrypted: i=1; AJvYcCXJhtJ/FYv6+Y4Dzh4p24j3kVPKwujNhEo5LqSXdW8xR5VseSYvdcEGdSW6qGqLcNcHMvLuagAEDPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/y9s8Zg3W6vZ6kGuBJLA8jeMl7yoexqjc4eOvgX102u5JSK6Y
	mEqmrWlyeoZos1IyHo7LIuYwELp9/EWcCWB6GKW/AZowTh78WEJMGQCY5HbUYpJF0D08TqvYhQ0
	iiBKGsL4yqC6OfOaoTiFNq0lUOfw8gFAayYcz/rIFwQ==
X-Gm-Gg: ATEYQzw3SGLpa44DT3UhgsjaDb0EXabNfHpNRF4A+p8k1r4xIcyBFbSFy7HFzTR2TId
	T7t+7/PdcsF/wfeAd7NO+fLdvJnT+fhAxBVqFE9ZMjtlqrcIUh21BDntmoudgYtee6YyiU6U4Ql
	eZV1M9aliXz/Viyt3PrUNcxQ+jrzIVZHhKsgZkB1ggUqn71+pNOnsRZiaE2ZRmTM25y2fz+pRpJ
	QWVGg9p4TyOmPrqIT4JUedcSDwsqPddzKcCpMK0G4X+oknGf8xCQZwkEKo2wzo1RNst3ni1a+0H
	viNWz8fL
X-Received: by 2002:a05:6512:1558:b0:5a1:448b:317b with SMTP id
 2adb3069b0e04-5a162b08ea8mr3109007e87.42.1773674165204; Mon, 16 Mar 2026
 08:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311095009.1254556-1-ziniu.wang_1@nxp.com> <20260311095009.1254556-2-ziniu.wang_1@nxp.com>
In-Reply-To: <20260311095009.1254556-2-ziniu.wang_1@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 16 Mar 2026 16:15:29 +0100
X-Gm-Features: AaiRm50g4ixBgJVGHgml85tjVL8FL6K6omKlK_jwEmgNVXMLTx5qLAygbxIzv3g
Message-ID: <CAPDyKFqbNj0vxNNRoZQ=xSijASA1eWCHfZVabPznQqJ-vrBUYw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] mmc: sdhci: fix timing selection for 1-bit bus width
To: ziniu.wang_1@nxp.com
Cc: adrian.hunter@intel.com, haibo.chen@nxp.com, Frank.Li@nxp.com, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	imx@lists.linux.dev, linux-mmc@vger.kernel.org, s32@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Mar 2026 at 10:48, <ziniu.wang_1@nxp.com> wrote:
>
> From: Luke Wang <ziniu.wang_1@nxp.com>
>
> When 1-bit bus width is used with HS200/HS400 capabilities set,
> mmc_select_hs200() returns 0 without actually switching. This
> causes mmc_select_timing() to skip mmc_select_hs(), leaving eMMC
> in legacy mode (26MHz) instead of High Speed SDR (52MHz).
>
> Per JEDEC eMMC spec section 5.3.2, 1-bit mode supports High Speed
> SDR. Drop incompatible HS200/HS400/UHS/DDR caps early so timing
> selection falls through to mmc_select_hs() correctly.
>
> Fixes: f2119df6b7646 ("mmc: sd: add support for signal voltage switch procedure")
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index b1a3cd574c84..605be55f8d2d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -4539,8 +4539,15 @@ int sdhci_setup_host(struct sdhci_host *host)
>          * their platform code before calling sdhci_add_host(), and we
>          * won't assume 8-bit width for hosts without that CAP.
>          */
> -       if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
> +       if (host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA) {
> +               host->caps1 &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50);
> +               if (host->quirks2 & SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400)
> +                       host->caps1 &= ~SDHCI_SUPPORT_HS400;
> +               mmc->caps2 &= ~(MMC_CAP2_HS200 | MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
> +               mmc->caps &= ~(MMC_CAP_DDR | MMC_CAP_UHS);
> +       } else {
>                 mmc->caps |= MMC_CAP_4_BIT_DATA;
> +       }
>
>         if (host->quirks2 & SDHCI_QUIRK2_HOST_NO_CMD23)
>                 mmc->caps &= ~MMC_CAP_CMD23;
> --
> 2.34.1
>
