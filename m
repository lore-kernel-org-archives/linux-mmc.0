Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3BA36CDF5
	for <linux-mmc@vger.kernel.org>; Wed, 20 Aug 2025 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755708250; cv=none; b=MLmjPVzWCsZLJFcofYdMajmMynUlSvK9kqBJOzpdfgRuWhhqCcydC+KLu2Gz+HzOs5cugzIqxjLgGXRpAt2jbxj6NXCMD6ZajlOBjLGcRPfuy4mJrC7xSY89aeZg4bEUO6sfSN4RTL2HEOmghjrSresJ24jLtZvLfdQilrr/L5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755708250; c=relaxed/simple;
	bh=rlf4MbI1vwsNRKdLc8cJukyH+as7zfttKIVUPC62vTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFCniXuGhrkpcQXB8rxPskQWVYfPn9hiG9rpwpEzuJbDG1gWiFAuehExyRt0yfgEPWEUzU4wITMqx7d83oN4ITuC3FuZZXZLug4zXO7ZUWopUAyAKF5d3DiYXMX8V64yz5089i5FlGIKFJaUsOAAuoO+c6KZKoEiuZzKc+6Ks/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ahPYc7oS; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ahPYc7oS"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d6051afbfso105227b3.2
        for <linux-mmc@vger.kernel.org>; Wed, 20 Aug 2025 09:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755708248; x=1756313048; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5lasJ3h7RVrddAHM1lvs/E5g0tBvN03o3fKd+WqO+A=;
        b=ahPYc7oSqTj/teiJxWiX0xImH7K5WYq5RtH2ZXIa03q8qE3IlSbbIv7vZXKa8eVh7V
         OmGRkY8lwjy+t2HB0lwK4s/KcPTaAak7QP+tGwsU6H/L8eAW6A+OsN94h9a08FGnaGmY
         Hz7fSuCXOmW0DvcvbVy/417pyAnvRIvrnqIKLiy3C4RKLGmdTE9yPjjJDyRtofUiOcXd
         aIizQttbbYLauQzQ53wC3QPVYoFHKjJg5TwFohFGPhsur1+JsJfqtihMXOp4udrjrLZI
         Anqdcp82zNUTTkXcsrAJgXwYslimjW8ftepsPCqjRiN5ElIx88Gp5OumiOv7y5VAKfjq
         WvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755708248; x=1756313048;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5lasJ3h7RVrddAHM1lvs/E5g0tBvN03o3fKd+WqO+A=;
        b=gKOcbfb7MZNpZZsBVBEPzxfjehgV82bpIETpBdC0sHpmDlvXLmUDl9lRHru0dr9cHi
         8eQJ2VcLOvRT2hWNzP3q1esFB3HnxD6MTHFYEvDVeLhsE2fZBb0JGhOuh3KKVks9gv0B
         8n/O/YKS3pBdmX04p7OdO8wV2aJrkloqe+RdkM5f2CPPr37eMpsYT/saB62jHPx+7hsk
         lqe/RTDyTu+BMIyh4wjv+07+t8rh8LUCz7IrN41ncANnnMYMbbLXL+94Dls9ps6/EYso
         V4sU4oUhXu757k2INuMeYufORK3YxUuTValsHro3gaXDbeIxU+uV0jVIR+FDe7sF/2n5
         VAMw==
X-Forwarded-Encrypted: i=1; AJvYcCUZDPkXDWNlEyqzdGz06buY/Chm6rgLu7E0/wX4SlZXyXdlkBh78Kdeh5NAYBymdAcZGFCzmEablZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/QpAhVKAvT564fODhb1pfp62OqEJBgrry4o7c++2RyNF5k61g
	xQ09wL052Hf8Q1OK5zgL6wHdbaYhee5dh0t1AQt+ekN7S/f5vxkhD59unNTDTfZzEkE3fMG2Mwi
	hSaOmp1HbxS2RLJiL+gwCXxwgwBgKCb5OmLFu0R+sodx43BHxsT0x/78=
X-Gm-Gg: ASbGncszLi+5NWFVZgYE/lpDRIDCHyZerZC69luq+aPxk/8QKieHSxl6Rr42Qbo1IBT
	7qTJro2uWsJzG/4ybu2/vIXnaAO9ySaxymDJKXKy8Vz6giUPbnVc8y/h1TJeNjXaqqvqXIyYb4p
	7FUly0/m9mvXbc+03YFXZM54T6+0E/2oZSXBcs+JA9vFl84pO4tK6uLN2STRkmt4jiv+NmKgQ2A
	Yx6idei
X-Google-Smtp-Source: AGHT+IH6m3Ww+OjQuVs+Bfy8fafay2w24/TuXvOFcHZfUby02NoUSl9x/4nPk4fk2gOIDJz6QPD6Mw+/dyMYSAB7qgc=
X-Received: by 2002:a05:690c:94:b0:71e:727d:7dc5 with SMTP id
 00721157ae682-71fb322b559mr43302807b3.36.1755708247693; Wed, 20 Aug 2025
 09:44:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-mmc-sdhci-cadence-fix-uninit-hrs37_mode-v1-1-94aa2d0c438a@kernel.org>
In-Reply-To: <20250819-mmc-sdhci-cadence-fix-uninit-hrs37_mode-v1-1-94aa2d0c438a@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 20 Aug 2025 18:43:31 +0200
X-Gm-Features: Ac12FXy7rDHN8USe2ZYWKKe_XNpSU7YSWOYPW1bMeT7tRaJLRvVitFbGjplVTcY
Message-ID: <CAPDyKFoHOWrrwud-gxQdN6TJjCwheWqv2XPj+B2jHTO4CBU4Ew@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-cadence: Fix -Wuninitialized in sdhci_cdns_tune_blkgap()
To: Nathan Chancellor <nathan@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
	linux-mmc@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Aug 2025 at 19:29, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Clang warns (or errors with CONFIG_WERROR=y):
>
>   drivers/mmc/host/sdhci-cadence.c:297:9: error: variable 'hrs37_mode' is uninitialized when used here [-Werror,-Wuninitialized]
>     297 |         writel(hrs37_mode, hrs37_reg);
>         |                ^~~~~~~~~~
>   drivers/mmc/host/sdhci-cadence.c:291:16: note: initialize the variable 'hrs37_mode' to silence this warning
>     291 |         u32 hrs37_mode;
>         |                       ^
>         |                        = 0
>
> A previous revision assigned SDHCI_CDNS_HRS37_MODE_MMC_HS200 to
> hrs37_mode in a switch statement but the final revision moved to a
> simple if statement. Pass that as the value to writel() and
> remove hrs37_mode, clearing up the warning.
>
> Fixes: 60613a8b9b81 ("mmc: sdhci-cadence: implement multi-block read gap tuning")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-cadence.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index a2a4a5b0ab96..eaa88897a256 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -288,13 +288,12 @@ static int sdhci_cdns_tune_blkgap(struct mmc_host *mmc)
>         void __iomem *hrs38_reg = priv->hrs_addr + SDHCI_CDNS_HRS38;
>         int ret;
>         u32 gap;
> -       u32 hrs37_mode;
>
>         /* Currently only needed in HS200 mode */
>         if (host->timing != MMC_TIMING_MMC_HS200)
>                 return 0;
>
> -       writel(hrs37_mode, hrs37_reg);
> +       writel(SDHCI_CDNS_HRS37_MODE_MMC_HS200, hrs37_reg);
>
>         for (gap = 0; gap <= SDHCI_CDNS_HRS38_BLKGAP_MAX; gap++) {
>                 writel(gap, hrs38_reg);
>
> ---
> base-commit: 7138017038c42feb682445407974ed736e1ff308
> change-id: 20250819-mmc-sdhci-cadence-fix-uninit-hrs37_mode-cc1246cb39d8
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>
