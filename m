Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2E1214232
	for <linux-mmc@vger.kernel.org>; Fri, 22 Aug 2025 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856749; cv=none; b=ULwueyWQdQMNA4NMyEXqExAc1JkBPdQAWh7UCAisBqa8NJC4B0B8nFjMOGlJ4Q55AjZNkSWAuh0otn+SQLy0cFjDabSjJhzdN3YwSFqItSlBNz1CzdR7qT8D8I/iaNH9NRdZVzVPp6CR27mFBPVrJT5SRdWCjZMeqSAjuT5QpYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856749; c=relaxed/simple;
	bh=7WEzRGVljcpFgpg5kYtiRuG6GnKMyevCXLfY3vki8nY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOTD6N0OfYxMpXlgBU0EqdBObFG9jNtafp4+TZmP3PGUQ0/nys9rF6j8iNriw9i7MJKGk6+JlszeRvuCK4CkJhDiM1lLuYVNgH5zz3HhW+0Wdg3S0rL1VrOgiECxBSbY4hAggKnbE8y6VN8t5ixtgvgdxlpLKRh8KG6YXADK5QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ShkGEimb; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ShkGEimb"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e951dd06849so426396276.2
        for <linux-mmc@vger.kernel.org>; Fri, 22 Aug 2025 02:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755856747; x=1756461547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4jzcaBapb+6lT57he/oxZQhjVy95ULktosVCVAZaO2s=;
        b=ShkGEimbB6WTDwfaOIsjNTt3VPdnCBTn0Wk9MzSqERkfim0wxeQAdMvVfhJAjfy+Zd
         Smax5Iv5WJeXbIcEAASoNuBVuhPtydXJHB3V4VCKqUmYL4RZrptLV5MNkpOskR6OvAi9
         sflmH3AMRtOFXlkHNthZrb+ZGBwXILfRDMkCmnruqeeYbBB5qhtOUBYAQotuS5Bta+T9
         SovXRnG3Rpfxob8KdxqLl9tR0kiLpwgDE+LhDBiT0KjxnTdC02frTJ7G4vR5teqK1bFp
         XVYVWCbcKKJjyN6fJ2K3teSRelOchrHJAO3XVdmZ6mcBdNifq8qa8NFcImbnXiFwZRal
         AD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755856747; x=1756461547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4jzcaBapb+6lT57he/oxZQhjVy95ULktosVCVAZaO2s=;
        b=jFBZcm5czAOM1Uj3wf1hVC6c4Y24/Iddm0drrQUQIG+UtmZ87EqMt45wDe47twrbnj
         8cFSl3mOU4F06aVTY+pzgePpEWrCnrhEclEF3YbBwBlnOtSfizddoPDchVPzla1gRpvc
         n9qwGZdUuLWfhMQzn5Ty+tPhBxEq3i0IMTL3Qdw/Rt6KSAimO7lMgjsHqGsgjLNRy2e0
         taQ7wiRI7ncNHHA8+MJfchgUuWDaSuVdluzmvOAVVDjBSz5IQT028p6lM6qgskKvpi1q
         HAzMbQ/T7gW914/YAGhtHUiFxggTp+noecuY7CCmEuUozTdftiHlFImeSQeOeKvueZRR
         gqlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBe5RhtbGPrDbSKYVZumuEJFtL0hqIE8mRkdeVrchU71exNkrTz3nN504P4f4dlVGlKm9KRE2WV/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww/8f03xUGOaw0egyzcUX3eZntCgJ/+dTHRygx97iDQYXzhXKo
	GNq57/v6qZ1i6IYggUrYyt6MYwUPW44qOKp9yzeZt/ATPByjPHqo1w6D11e4mPYdvSblBQs9o61
	bhyIq0aYLJjFJUbQjDuyGWWW1LHjgldQYQ1n/w0qPNw==
X-Gm-Gg: ASbGncsghxWSlgkM/zyQbVnXbz4neC+seKmJuNLpFOCGO6ELgHvN1PATE1YYhkqPIXl
	CC+qGaYgXLBWU4gKU/D5d2HcA6aV8vllHdWiiLcieSc4oKiQFOn50OVpEtUZr1CWCn8DPUm7IIV
	dwNYfhyOhoNketdI71Bi8B8k7okb5XtmOS8bpAnWOYRBxlkHFf6PqkAL5QEe56eemXflrjhKwJ6
	CX8kSzn
X-Google-Smtp-Source: AGHT+IGB9RjTkkD7B2b1TNcFgf/SbdNxy4Un5NVzcbV0bGgOMYvHf6W1mefgrwFYH3AHHfmz4nw0AMYxpykQ3SJwTgw=
X-Received: by 2002:a05:690c:9c05:b0:71b:66e5:9b54 with SMTP id
 00721157ae682-71fdc3d087fmr22061587b3.28.1755856747069; Fri, 22 Aug 2025
 02:59:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821200701.1329277-1-david@redhat.com> <20250821200701.1329277-29-david@redhat.com>
In-Reply-To: <20250821200701.1329277-29-david@redhat.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 22 Aug 2025 11:58:31 +0200
X-Gm-Features: Ac12FXxyJ-t2LbDQilDuu2ZIZImx4clXac153FHlc5EW2k5KLO2D2OEzTjtN-RU
Message-ID: <CAPDyKFrvsyB-1Gs5jW92o2RAs6i0dF6sPxGr7us5QZymFcdQdQ@mail.gmail.com>
Subject: Re: [PATCH RFC 28/35] mmc: drop nth_page() usage within SG entry
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jesper Nilsson <jesper.nilsson@axis.com>, 
	Lars Persson <lars.persson@axis.com>, linux-mmc@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

- trimmed cc-list

On Thu, 21 Aug 2025 at 22:08, David Hildenbrand <david@redhat.com> wrote:
>
> It's no longer required to use nth_page() when iterating pages within a
> single SG entry, so let's drop the nth_page() usage.
>
> Cc: Alex Dubov <oakad@yahoo.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> Cc: Lars Persson <lars.persson@axis.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/mmc/host/tifm_sd.c    | 4 ++--
>  drivers/mmc/host/usdhi6rol0.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
> index ac636efd911d3..f1ede2b39b505 100644
> --- a/drivers/mmc/host/tifm_sd.c
> +++ b/drivers/mmc/host/tifm_sd.c
> @@ -191,7 +191,7 @@ static void tifm_sd_transfer_data(struct tifm_sd *host)
>                 }
>                 off = sg[host->sg_pos].offset + host->block_pos;
>
> -               pg = nth_page(sg_page(&sg[host->sg_pos]), off >> PAGE_SHIFT);
> +               pg = sg_page(&sg[host->sg_pos]) + off / PAGE_SIZE;
>                 p_off = offset_in_page(off);
>                 p_cnt = PAGE_SIZE - p_off;
>                 p_cnt = min(p_cnt, cnt);
> @@ -240,7 +240,7 @@ static void tifm_sd_bounce_block(struct tifm_sd *host, struct mmc_data *r_data)
>                 }
>                 off = sg[host->sg_pos].offset + host->block_pos;
>
> -               pg = nth_page(sg_page(&sg[host->sg_pos]), off >> PAGE_SHIFT);
> +               pg = sg_page(&sg[host->sg_pos]) + off / PAGE_SIZE;
>                 p_off = offset_in_page(off);
>                 p_cnt = PAGE_SIZE - p_off;
>                 p_cnt = min(p_cnt, cnt);
> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
> index 85b49c07918b3..3bccf800339ba 100644
> --- a/drivers/mmc/host/usdhi6rol0.c
> +++ b/drivers/mmc/host/usdhi6rol0.c
> @@ -323,7 +323,7 @@ static void usdhi6_blk_bounce(struct usdhi6_host *host,
>
>         host->head_pg.page      = host->pg.page;
>         host->head_pg.mapped    = host->pg.mapped;
> -       host->pg.page           = nth_page(host->pg.page, 1);
> +       host->pg.page           = host->pg.page + 1;
>         host->pg.mapped         = kmap(host->pg.page);
>
>         host->blk_page = host->bounce_buf;
> @@ -503,7 +503,7 @@ static void usdhi6_sg_advance(struct usdhi6_host *host)
>         /* We cannot get here after crossing a page border */
>
>         /* Next page in the same SG */
> -       host->pg.page = nth_page(sg_page(host->sg), host->page_idx);
> +       host->pg.page = sg_page(host->sg) + host->page_idx;
>         host->pg.mapped = kmap(host->pg.page);
>         host->blk_page = host->pg.mapped;
>
> --
> 2.50.1
>
