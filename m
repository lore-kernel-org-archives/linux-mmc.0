Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C733A1CE1
	for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882641; cv=none; b=pxxRARwWW0qMjtB91Y0gt41N7eHvmg4Jj6J0VUEe6mJma5/1ePOZWmT36ZO1TssxsWYBwYFnGPNm+zNuxnlrB4doVYZ5J1sdWPCl3mdtLKUDx2DxlMto61GPLa9LNDH/ibs8md7xTSoZv9heOjxnr3AbwPNyS9CJCgUGw0SPyl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882641; c=relaxed/simple;
	bh=CfGSUR4o5N9TNuUTcv7dWSuXXhOPdiBc/Dw38CZCoAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5GhPqRdZCqZG/AAMu2elDm5RXo6b+jjGIcr+O2KWvrekDW96g77LLsD7CHQhX6uUlPw3vAIJ/KW+vFwiJr+29uItdnd95pfNyqhYPxViAq60lTJz5uQgzkvJgrtLSxRXWAdafMVN5Junr5dYQHF4IznJNJKQqfGzv3fyntR05s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fpu5rOl9; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fpu5rOl9"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-787be077127so45150617b3.2
        for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 09:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762882638; x=1763487438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1c/bymNR9xRZKC9iA6kuq2HmsWA5RSbpmlA89vid2uo=;
        b=Fpu5rOl9cnkVpiwR6zUGDFXVR6KiPCZk3PjFHptRVnMhpJ1BrvezcXRE0B9Kh/vEjc
         4U2dTF4c0LuF66ubxArxDM+qTAo5e9VozBQ3RDAHaDcgVzPUi3cUGq25xga7K/3v3lad
         fh7q2sCo+1q3lcAB03Guo3F5QDpQ6AZG7XBDsqetYC6lj3jRTX994sz5kmU7ill2PemW
         9a0HOQd279GRY1UomcRdLy9yOqzRFBMEgs7GhiO/AvPHSVD1UW2OC4k9iTzXoyGYj2HM
         FE//uzPHsFpdNYMkv55IrnzN4DQldGkqjAXGGFWV/9hHVniBNzRVoPjZd9ZdLdnMHQ7R
         x63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762882638; x=1763487438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1c/bymNR9xRZKC9iA6kuq2HmsWA5RSbpmlA89vid2uo=;
        b=GwYrFvIL1yrwRbe+AhUtDRq3PUcuERCvVST2udCZ+ND2Z8wR99BAAp/D3Fs19bKMA7
         1ScX9qJ6OcfAj1CjJ5WxoRjuDxLekxnJOcGY/hYV8ZOcAGvwofb4HNc3e+Q2+2Q9HFrZ
         ejRln3nuJ6CH7RxJlsBIkwd+Aphaju5/6zNUQgvJvRXGDLwUaMaoNsvbtj7a2G88aEO+
         JvT/YVWtuvwX0eH9R7Lb8yFY7QSJUtMizf4mSNGj+WJMbmJltFh1VRDElE+PgJuHsF0p
         y9d87RuPDDxL4T59SiyoICMqRrysQ3/zvxR6w2xrS6G4sX566AbM54QBsG9UNsfAdlTR
         4UMw==
X-Gm-Message-State: AOJu0Yw516CD9NahsSzTPYaefsI4nnzsQSElyg90EmAjh/wz/cylgE9m
	FnEBoJzM6nP+JYKpN7hnlxM0qibbql/06mUPPSLfJZVcLF1RWoTvEXLpneRgClV3+8mVOUPZhyu
	YgHVBFfHnluQ/E35b6ahWkuO+ubyp5Sf4vewaeimqaxIqOevl+YYx
X-Gm-Gg: ASbGncukngH4LXOed7nlaRiadPHmnjzaxq4vstFO12kBXKzkxgXn5fztNNGTpJOT9PV
	r5UUU/x95+pvqyG8ZG3LAhULEEHnKOtwpFnIlWoshytjZUYmiq2fAqzXhsLI4MNiHBZ7tf5CUlV
	aryzUSS2PV5de1s71/lpAw+du6zugsBX2vd1gL3uJ+Duamm0c/yue5Pw7jGEg+qaMen/k6akSNl
	t2YedC/7hcsV7YTRdSggYXDfNCdhWJXxEz1VZWMB+u15zDdNRUBgRLXqIwIYg==
X-Google-Smtp-Source: AGHT+IEX+JzqRQl8eTTw62H/mI5FTTodjazuAyHVtBuUVGwbXFWWcwo92wKtU6BykhcY2Ch9Gv4+0AzO1g0U81xG+nQ=
X-Received: by 2002:a05:690c:6f89:b0:787:fb60:efd9 with SMTP id
 00721157ae682-787fb60f8a0mr58672277b3.22.1762882638467; Tue, 11 Nov 2025
 09:37:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104200008.940057-1-peter@korsgaard.com> <20251104200008.940057-2-peter@korsgaard.com>
In-Reply-To: <20251104200008.940057-2-peter@korsgaard.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Nov 2025 18:36:42 +0100
X-Gm-Features: AWmQ_bmBI-fFGCCt6MhfZgxOa3H5P_r5NBb1wuCGVm3GOywsdd_IThaMp9SxgRw
Message-ID: <CAPDyKFqk-Pv-0seo=6Wxja1zkgGZ2KKq+dYm+dmtnAFPExAx0g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc-utils: lsmmc.c: print_{mmc,sd}_cid(): correct
 month names
To: Peter Korsgaard <peter@korsgaard.com>
Cc: linux-mmc@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Nov 2025 at 21:00, Peter Korsgaard <peter@korsgaard.com> wrote:
>
> The month nibble is 1-based, E.G. from JESD84:
>
> The =E2=80=9Cm=E2=80=9D field, most significant nibble, is the month code=
. 1 =3D January.
>
> So mark 0 as invalid and shift all month names.
>
> Signed-off-by: Peter Korsgaard <peter@korsgaard.com>

Applied for mmc-utils master, thanks!

Kind regards
Uffe


> ---
>  lsmmc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/lsmmc.c b/lsmmc.c
> index 7331c1b..dd3ab83 100644
> --- a/lsmmc.c
> +++ b/lsmmc.c
> @@ -512,10 +512,10 @@ static void parse_bin(char *hexstr, char *fmt, ...)
>  /* MMC/SD information parsing functions */
>  static void print_sd_cid(struct config *config, char *cid)
>  {
> -       static const char *months[] =3D {
> +       static const char *months[] =3D { "invalid0",
>                 "jan", "feb", "mar", "apr", "may", "jun",
>                 "jul", "aug", "sep", "oct", "nov", "dec",
> -               "invalid0", "invalid1", "invalid2", "invalid3",
> +               "invalid1", "invalid2", "invalid3",
>         };
>         unsigned int mid;
>         char oid[3];
> @@ -570,10 +570,10 @@ static void print_sd_cid(struct config *config, cha=
r *cid)
>
>  static void print_mmc_cid(struct config *config, char *cid)
>  {
> -       static const char *months[] =3D {
> +       static const char *months[] =3D { "invalid0",
>                 "jan", "feb", "mar", "apr", "may", "jun",
>                 "jul", "aug", "sep", "oct", "nov", "dec",
> -               "invalid0", "invalid1", "invalid2", "invalid3",
> +               "invalid1", "invalid2", "invalid3",
>         };
>         unsigned int mid;
>         unsigned int cbx;
> --
> 2.39.5
>
