Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34C5298CAB
	for <linux-mmc@vger.kernel.org>; Wed, 27 Aug 2025 11:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756294476; cv=none; b=G27b8DZ5gKAx+4TZsDMIsNS6WsltxsK8vybeHKXcc2DBSqxHtmHS8ifvNPhm0Dp/NtAvs4mERZKzV07e3QyDaPsLY7eLZqXlIlNjGHzDxXEF2W6OkW58WKnMci1r8yQVOqlG3woEdfgprvj4h4WWVoc7V/gToL0ENUpbRa7VabM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756294476; c=relaxed/simple;
	bh=I0+inmiWtU61dXbcgR2SpqeAI9tYtFw+kp335l2T7XI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eny07/83pdwRPMPbzqjpH51tUjWBimLM/QTfKsiEdbZtlHT8SW8o+mbSaXRHIupP9DJqwbgDTYBLtePxO4MN+7CeAfoKSIc+gIXBzJ4+2XNyqT5iP+6r1z/QsQlv/cey5LYmFKBw7zoX/duSzXtZ8VvB5EdFazIGFGA1bhIZY4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qRWfjm5B; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qRWfjm5B"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d603b60cbso52944707b3.1
        for <linux-mmc@vger.kernel.org>; Wed, 27 Aug 2025 04:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756294474; x=1756899274; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SQP3POnWLwdh4gSankJGbSD3AH7y+QQYMzA+YsTanJY=;
        b=qRWfjm5B7ubIFZNguTfe5m4tvoLYYXWWmLZF6z9oYLnQTewq3FnwwVH35kq++n4ytZ
         fZQtrML0NzJZnfC0FiIkLMjjzMdmjf15CKmI60GXniaU/iMFPbGwdlcrGNfchv1ely0n
         LDX1bOgrSCVOEiB2zC8uC6pYebk48gKGq+f+bKIGoUGabsi23Njdld4tK57RcRjIdSgS
         r3FDiVvj+wcYHM0COb+FYWySsGKfYd+t4PCaRbrPaQ9MIUOKwdhXmewY5T5+Wz0nFwhd
         ZCM7jrfzwtBSMZyBNsplx1a8Wa1LQ66hQyroc45Iw1DX9IQ3ERaYZv540l9IQw8t6DMX
         0SQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756294474; x=1756899274;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQP3POnWLwdh4gSankJGbSD3AH7y+QQYMzA+YsTanJY=;
        b=LxI0KPaUwSOzMHJsh5D6YT4cYOxGwe1u2To4waQBIg1VoDHsJGKIJArX2jyHPxpP4n
         ThLfRrSUUiAL5GGXNkMacWHTCICH61oLvLXCmmOq0ZAqFT9H7osVCA990dL8e0kGUYZZ
         dy3WC/bRi3xnqDzHjSTivPdk3oeqPJ1E3EY+fzwrmKGuXcSqszY4mOxdjUgIDrYH7DNf
         8dSHBbM4oNOopZ2Z746Gqa0a5WapoMfQ38lo/2swTiTsMRdmGYCi4mY9Xe1qyN8WgWkl
         O2nv6AKWaK09ijS3ncuHJc9s4rkopckBAcKue5kZFreottqI7xRDcftwz4M6uAf32G3t
         GxUw==
X-Forwarded-Encrypted: i=1; AJvYcCXiGoe4YI7MaRbqt8LYVfQJGr1UWbZTMBb45LCVrIhIZGOzvVs7vnbJ/4B1edWgBPxBUfYPekmnKKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBW9cvg3N7MEi6r5FzVeIWC70jMNLbUg3h5WkLZiCk2xPpzBlQ
	vxeXc1Qko/7Jv24x3ViKgY6lEnQFSoMzT/MhtQ6UMZY6Yn5BtLtp1o2LEknrvvKnNnsYHjRMa+w
	3Dr0BhJti+rSdWrM3xUow7FPHtL+SAYrNx+YImk3YLw==
X-Gm-Gg: ASbGncsNFOg3ognvI1JgeKnlW1QMRCRTpH9BAbVWssksWO9kVaDy1j9mKnneIZebhkT
	fOsCQ0GrrBZH9wsegzOmvsnek+BLcq2UemWtIOLdQxMGpPxmub1HxtWCtr+LKGc4I0KtiJPRuK1
	5yLxS0E/4HZZVmczMuKd6Vk2omONH+Y8acahlDFXjYPnniROEbLnRt5DfzJE3ezvzdZQDxVM04P
	ss+IWU=
X-Google-Smtp-Source: AGHT+IEGYDfr3AO1H3X4bA6l4+sJTsSb81gSwG2hF2J0ZtRhMDZjiYt/ib/SF+R25XRB+MdDv004M0EvKZOUkf07zYw=
X-Received: by 2002:a05:690c:6d8f:b0:71f:f24d:1adf with SMTP id
 00721157ae682-71ff24d1d0dmr178250247b3.39.1756294473782; Wed, 27 Aug 2025
 04:34:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827101236.927313-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250827101236.927313-1-claudiu.beznea.uj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 27 Aug 2025 13:33:57 +0200
X-Gm-Features: Ac12FXyaVa7AtwnWzwHjhQmKX8rG5UcyGXCeSmAzrw3pHhVEssS_yT1clYz720s
Message-ID: <CAPDyKFrWOkDvfNmwTDVGC0VAFb_f0jA+vWas5cUEaPTt2t82=w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdio: Drop dev_pm_domain_detach() call
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mathieu.poirier@linaro.org, rafael.j.wysocki@intel.com, 
	wsa+renesas@sang-engineering.com, rafael@kernel.org, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Aug 2025 at 12:12, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Starting with commit f99508074e78 ("PM: domains: Detach on
> device_unbind_cleanup()"), there is no longer a need to call
> dev_pm_domain_detach() in the bus remove function. The
> device_unbind_cleanup() function now handles this to avoid
> invoking devres cleanup handlers while the PM domain is
> powered off, which could otherwise lead to failures as
> described in the above-mentioned commit.
>
> Drop the explicit dev_pm_domain_detach() call and rely instead
> on the flags passed to dev_pm_domain_attach() to power off the
> domain.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/sdio_bus.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index 656601754966..10799772494a 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -200,7 +200,6 @@ static int sdio_bus_probe(struct device *dev)
>         atomic_dec(&func->card->sdio_funcs_probed);
>         if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
>                 pm_runtime_put_noidle(dev);
> -       dev_pm_domain_detach(dev, false);
>         return ret;
>  }
>
> @@ -231,8 +230,6 @@ static void sdio_bus_remove(struct device *dev)
>         /* Then undo the runtime PM settings in sdio_bus_probe() */
>         if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
>                 pm_runtime_put_sync(dev);
> -
> -       dev_pm_domain_detach(dev, false);
>  }
>
>  static const struct dev_pm_ops sdio_bus_pm_ops = {
> --
> 2.43.0
>
