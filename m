Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4D156754
	for <linux-mmc@vger.kernel.org>; Tue,  6 Feb 2024 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218333; cv=none; b=LR+z3rNTClh5kQIFXPFuWszNtIeZQjrrKhkvmg3/TgBWM2RTDtgZraZCTIrP0lJGqC2WiPOj1nkZKcaN8n/t+h1HVLiorlFUn6IIHulkmDF0gZfIlJ685pj2tRIKZd2s4l7A1HMH0EPo/KxIYDFaufOiohhj51A6B1yjdN0DHos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218333; c=relaxed/simple;
	bh=RAUcQj04TyEXEDqfDrWDiMlYnTPZzSWd7J0PrXfQYhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebdB1r6oj5RA6zotgDdcBy0oTNPmILfI0AE3BGMY9wjrq5PbJFv5f3mht2nptxpoNoBuMmlkY23/zDsySBtx3vs3DGovkdnaZgzDbgg7FmoueKv6d4aJiQzOt4tSs5IEZ+Si5D5kO8mQr/ZXAGduy3xz3C6AKVUyM+SmS/Qw4MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y9DR9RcL; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y9DR9RcL"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6d94b9961so5313783276.3
        for <linux-mmc@vger.kernel.org>; Tue, 06 Feb 2024 03:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707218330; x=1707823130; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e345+swzPUmQgd41l0m3kNKJ/xmdbW17sX8/bM58R7U=;
        b=Y9DR9RcLqQquZMzl8oG+qCFOpkWKgKCZWiikR6jOKzHT0OmKaujpl377FvtPE42WhT
         Gj2Nb0qHAUy4L/ovHudsCz1YiH4ECaZoQ059ROUZDbUNkA7u4bw4jjieiRoPhpiezaa2
         cKEt8jdbQXgkIUpXgOoVnSMci9XxjMC49hwiJdmE5BQNpKemXLkOwdTRxJJZ0b26VjH5
         12pXlumv80QUZ3owU4AzbtaUGrJbfACXG0f26o5Wdl/uE6STcYMxVTpJp0S/JKUiK9Dn
         GiR1iOU5kGEGCbyzqKhPAphO8AJY29h4NSowg/FNXAJ+1IzgzOEOKA8tIJh+XLRwRS9C
         +ZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707218330; x=1707823130;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e345+swzPUmQgd41l0m3kNKJ/xmdbW17sX8/bM58R7U=;
        b=sDZGLxw5WgBBzy/KdsHlmweLP7+VlOPmHI8+ZNSRaHTH+vwxtJRjlayvTb646/gz/0
         f4t6DsxDdaS5ReYnC//HpFoLPgwoiLkKGmdT0iXkklEmONOYhUtZ36KX5EKrB6PfTQWp
         YDW7XPe86vzblLcIlfuhyDsoabUjryMMyEcZaQ85qhqlTxZfN6kNEvgYeDhkHyzhJjRA
         Nt3owQSZnZ579Qj4lwIms5L9PGco0XVIGOanxg2Qx5OORgK1qW/UAScOtfOiiVlD5Edd
         L2SI5laHFsFUUPTUU6xt3FknsB1zAcT1UoO9Vrcf7Maz0uRnk5q+CZJ9FHof0kipcBT8
         jnQA==
X-Gm-Message-State: AOJu0Yzx/NX1k/vPCgfe///Sy756KG72+uQP7dNoi8CntGLKxczc3fhg
	ZEZZ6smtdFmd+y6kCkv3rdIJ6OnNx6NU8cbTteAmvW+MdG6+IjPfv3cNrDqRfEbok58iRIWAXw9
	7wJyP8uTGf7+sFPURywLvJaSc3NlRmaq+QIH/i25LhjXu1EsBhSVqWg==
X-Google-Smtp-Source: AGHT+IH5fKEJpfHApHOplFSXWwd53luljuax/eSuatIgasfLKxsU+SyYcCYNNtHkP+jet8LCGSrmSvjmsvLU/HM9H40=
X-Received: by 2002:a25:840c:0:b0:dc6:e8b3:9ffd with SMTP id
 u12-20020a25840c000000b00dc6e8b39ffdmr1292874ybk.53.1707218328670; Tue, 06
 Feb 2024 03:18:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205191310.1848561-1-colin.i.king@gmail.com>
In-Reply-To: <20240205191310.1848561-1-colin.i.king@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 6 Feb 2024 12:18:12 +0100
Message-ID: <CAPDyKFosojWAaSWATX6hGh8cJ7yU3zCxheMSiKUsMgJmB1Y-+Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: wbsd: remove redundant assignment to variable id
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Pierre Ossman <pierre@ossman.eu>, linux-mmc@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 20:13, Colin Ian King <colin.i.king@gmail.com> wrote:
>
> The variable id is being initialized with a value that is never
> read, it is being re-assigned later on. The initialization is
> redundant and can be removed.
>
> Cleans up clang scan build warning:
> drivers/mmc/host/wbsd.c:1287:4: warning: Value stored to 'id'
> is never read [deadcode.DeadStores]
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/mmc/host/wbsd.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
> index 001a468bc149..f0562f712d98 100644
> --- a/drivers/mmc/host/wbsd.c
> +++ b/drivers/mmc/host/wbsd.c
> @@ -1284,8 +1284,6 @@ static int wbsd_scan(struct wbsd_host *host)
>                         continue;
>
>                 for (j = 0; j < ARRAY_SIZE(unlock_codes); j++) {
> -                       id = 0xFFFF;
> -
>                         host->config = config_ports[i];
>                         host->unlock_code = unlock_codes[j];

A few lines down there is check "if (id != 0xFFFF)". Looks like that
is a redundant check. Would you mind cleaning up that part too, as a
part of the $subject patch?

Kind regards
Uffe
