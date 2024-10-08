Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45041DFDA4
	for <linux-mmc@vger.kernel.org>; Tue,  8 Oct 2024 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398191; cv=none; b=Jr2b3v0EYQ19/KCSQ+ytrkN7H8e/pvWsYuEsemhJGQkGF1Ke5evjE+TEcD3xnIbaToqPzxmSRMKh8T3jPmQqLCT9HD3sgwH9m/IilEG04vEYvZYiwsQLLOmoy5F92TEZzLnAfF339k5yiZkIrTWCA/eAmGtzyCrMmRZyHvz0yQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398191; c=relaxed/simple;
	bh=trhP2fQ5tQcbrAcoOmy+SrWN61xKTxkCLLzO4F17ztc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4eFQIJnFqcQ9AboQ0JqW1J1sHfQauvEIn6XhnWqiPzWdPcK1rU1cSce0JBJBHRD3CgkPvCA3hFHZifkxXWRtS1FDaa6xEbbXeKne2aIJlChDFAVumKrTp1P4BKw9049lmPWwQUbUvLlSfcQDcWwzSt0zsac2gt5Ae/yCJt7Ws0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dv4N+39V; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dv4N+39V"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e28ef761190so685501276.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Oct 2024 07:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728398189; x=1729002989; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BAg7ZidTPorvVYHmDce4EjXWI2oNXBm6unQqHawkopY=;
        b=Dv4N+39VHrFx5b92LvIVvlnb6REu+ZYGjkinLIFcE8A5Mc/R0RH3GuU97a+qrbCIUy
         FjfEofgi01xLSwLtOWmCt425/h/NkaOyozUWQcafRIMPoNVznjO7CfNpTGbBPyzZe9x2
         AAsVRBH34MLR/BtstDO7/aD+EF4u3OGPOrNi+aPDSmfOrWVAqGCgtgVb8nfFs8b1ZXvq
         9RLBL0dn1HqsgoBC15LXS3CjGSofWLxcW1XYIpAM9RfvRns1l/XshB1XwK4CnTT1GoHc
         HOj1hvYobE1uDD5Na8trdKh+IZxO92ejriGFx6PZlbWUKjzoLcjE+dh84GEsl/FO6BDd
         ayHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728398189; x=1729002989;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BAg7ZidTPorvVYHmDce4EjXWI2oNXBm6unQqHawkopY=;
        b=NO1sRKtzeW5M+hKIrEBDR9U8+XvZNmdgkazrVhP1m+uc2pbF7gs7J2iXaWc/mFUavA
         eAXLTxWyEGROuHhrqVNJsuUrZ595I+9L3xmZ6BErIUzO8CAEeJTG0ae5SLyzFItgLdSV
         QhqFg2CkxA1IOhCo1CZvL1cPTUGZOsEBZsSVgwEagPwKqLyJfPdZQwxdz4C08rsP55SR
         NRVzIJJdBPei7lRYPa1aD6b04aJ8Y81IAvSTtqlQBMmXrNzO+b7GN5AL/NsnB+be5ffz
         pIpU5CGs3mKU0CbaEkglZ9QpX5WX+nGXImKTJop9pfPxDBVf+bkGxQleufH9yl3q/atf
         Kv8A==
X-Forwarded-Encrypted: i=1; AJvYcCU4/KDe9QVjUs/duO3LKdJPShy3Pc3AYsZLvONB9uzsbB8OY76FIvCJhxCWEwIVLvXXoKso2LO//XE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjez6vcBMyM6XO08A8Gp4iZA2bMjpJeX2+YU3cZMxYYxqliWcr
	vLww2jrHAz2wAFcwzB99jn//61Q4j1tg3oyVu6Re7aA7b93F9gTCHgMX4tIOwekI/ANG9oAbSCc
	811CxSScHPiYbcJyV4o2Yn/O9Qz7N8e70ZUhBOQ==
X-Google-Smtp-Source: AGHT+IElQGC355Tl6gUscWB/+cWTaMDp3U8oY/mskRAuU/uZktLuiXA3kZX0imsHGtcNvu2zACQAimf/q0UcsteCplI=
X-Received: by 2002:a05:6902:2289:b0:e20:25bb:7893 with SMTP id
 3f1490d57ef6-e28939282b3mr11151806276.46.1728398188940; Tue, 08 Oct 2024
 07:36:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6509d6f6ed64193f04e747a98ccea7492c976ca8.1727540434.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <6509d6f6ed64193f04e747a98ccea7492c976ca8.1727540434.git.christophe.jaillet@wanadoo.fr>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 8 Oct 2024 16:35:50 +0200
Message-ID: <CAPDyKFpBK_aGqJh-k=mRYJoupJTULgGW7MueYzQXimLMAaUwTw@mail.gmail.com>
Subject: Re: [PATCH] memstick: Constify struct memstick_device_id
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 28 Sept 2024 at 18:21, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> 'struct memstick_device_id' are not modified in these drivers.
>
> Constifying this structure moves some data to a read-only section, so
> increases overall security.
>
> Update memstick_dev_match(), memstick_bus_match() and struct
> memstick_driver accordingly.
>
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text    data     bss     dec     hex filename
>   74055    3455      88   77598   12f1e drivers/memstick/core/ms_block.o
>
> After:
> =====
>    text    data     bss     dec     hex filename
>   74087    3423      88   77598   12f1e drivers/memstick/core/ms_block.o
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Compile tested only
> ---
>  drivers/memstick/core/memstick.c    | 4 ++--
>  drivers/memstick/core/ms_block.c    | 2 +-
>  drivers/memstick/core/mspro_block.c | 2 +-
>  include/linux/memstick.h            | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
> index 9a3a784054cc..ae4e8b8e6eb7 100644
> --- a/drivers/memstick/core/memstick.c
> +++ b/drivers/memstick/core/memstick.c
> @@ -26,7 +26,7 @@ static DEFINE_IDR(memstick_host_idr);
>  static DEFINE_SPINLOCK(memstick_host_lock);
>
>  static int memstick_dev_match(struct memstick_dev *card,
> -                             struct memstick_device_id *id)
> +                             const struct memstick_device_id *id)
>  {
>         if (id->match_flags & MEMSTICK_MATCH_ALL) {
>                 if ((id->type == card->id.type)
> @@ -44,7 +44,7 @@ static int memstick_bus_match(struct device *dev, const struct device_driver *dr
>                                                  dev);
>         const struct memstick_driver *ms_drv = container_of_const(drv, struct memstick_driver,
>                                                                   driver);
> -       struct memstick_device_id *ids = ms_drv->id_table;
> +       const struct memstick_device_id *ids = ms_drv->id_table;
>
>         if (ids) {
>                 while (ids->match_flags) {
> diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
> index 47a314a4eb6f..c572f870fcf1 100644
> --- a/drivers/memstick/core/ms_block.c
> +++ b/drivers/memstick/core/ms_block.c
> @@ -2279,7 +2279,7 @@ static int msb_resume(struct memstick_dev *card)
>
>  #endif /* CONFIG_PM */
>
> -static struct memstick_device_id msb_id_tbl[] = {
> +static const struct memstick_device_id msb_id_tbl[] = {
>         {MEMSTICK_MATCH_ALL, MEMSTICK_TYPE_LEGACY, MEMSTICK_CATEGORY_STORAGE,
>          MEMSTICK_CLASS_FLASH},
>
> diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
> index 49accfdc89d6..13b317c56069 100644
> --- a/drivers/memstick/core/mspro_block.c
> +++ b/drivers/memstick/core/mspro_block.c
> @@ -1349,7 +1349,7 @@ static int mspro_block_resume(struct memstick_dev *card)
>
>  #endif /* CONFIG_PM */
>
> -static struct memstick_device_id mspro_block_id_tbl[] = {
> +static const struct memstick_device_id mspro_block_id_tbl[] = {
>         {MEMSTICK_MATCH_ALL, MEMSTICK_TYPE_PRO, MEMSTICK_CATEGORY_STORAGE_DUO,
>          MEMSTICK_CLASS_DUO},
>         {}
> diff --git a/include/linux/memstick.h b/include/linux/memstick.h
> index ebf73d4ee969..107bdcbedf79 100644
> --- a/include/linux/memstick.h
> +++ b/include/linux/memstick.h
> @@ -293,7 +293,7 @@ struct memstick_host {
>  };
>
>  struct memstick_driver {
> -       struct memstick_device_id *id_table;
> +       const struct memstick_device_id *id_table;
>         int                       (*probe)(struct memstick_dev *card);
>         void                      (*remove)(struct memstick_dev *card);
>         int                       (*suspend)(struct memstick_dev *card,
> --
> 2.46.2
>
