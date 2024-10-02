Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C449219EEBD
	for <linux-mmc@vger.kernel.org>; Wed,  2 Oct 2024 23:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912207; cv=none; b=IT4WN1wKLj1gPJIal7+rG3sVw3l2PiiBX5w3LEzKwm/R9LTehsEdrRXj05bdjRY9bUCmhbuq7F9BRaO4EWOGWoxfRF5QEJLpvHej+76ykVrbiNLoGxXft952LsVx3VyM6bpURNkohJ/gxly5fPwFQGfe+wWN60TPqLnerrWOt9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912207; c=relaxed/simple;
	bh=rOZgG+gsXianEKZTK5XyYy1qU43hBALX2PDyvo7vO2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aDmV6DgdRBzLp3lo6kHyWwUOTj9N6uO6xB1lqykcHzrXnNA2krvV7WBphexQMz5BGRDhfhqrpNF6IeaMNUUpVHPHD7T42OenTD6MRNkpNfD0fgB/pROUDwiOjy+J/AMJBSO5CNp62yNHasTk4/oe6YCSGbu2Iz/KsHMBNEa7C5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rWgx7/wP; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rWgx7/wP"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e260b266805so338068276.0
        for <linux-mmc@vger.kernel.org>; Wed, 02 Oct 2024 16:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727912204; x=1728517004; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X024ptzefyB8VQ2TszNaeDmPmn0oYGPKjzQobGj4E0Q=;
        b=rWgx7/wPe1zK7A5YNRIEeyqBqenXF+ZVPUxCJnENjW3etWv95bS/qAKmujRMkTJk7G
         5z6EWVefC4cKbYcgahu7aOdr1nUNJqFecpGPbCbbxFRjwLb37yWUvXaTwu2JC2rwUnfp
         vI2a/XNc1Zj5YZojcf7i+BBdnT8DcbceeiDNUvxi51+VxLKSztjyRGRiqcQve24ony71
         UaUUvFIFkxA+hryLWPeRRHy7vqC9da8w9kEIguYQpZZwaT5iny4D8fU8WyTvLT65hNFw
         +rszm+H5yGpZ+6kwuaYWmZNrDl9MeK8X52OPFrCPaKIZphlt0nLfsZGkl0L8dAHsQ5ZA
         fQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727912204; x=1728517004;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X024ptzefyB8VQ2TszNaeDmPmn0oYGPKjzQobGj4E0Q=;
        b=h3SSq8G7doQq8RPAxB3akiORhW3bcnTl8/RB3m+Pi806rI3LVzp/Q6AbgJ1yPjuMbs
         akGb8iKrzwRfbQJvgaheouFPeyoBGu69CKUny/bIUaJb6r+EKwdm0q05Vinr4yvwP9I9
         FCHlJd+A+HmIXQiH8Yld1yOt9xg0wSuoiW0HfM8Wk8xfAYm77AszZtdUpWqeeVxWF7Vz
         YJnFMIPrVWaMTdlEIUqjgIfXLUHp5ovKg+NX2CHAfCQw8kxAxDA7wF5Rty7C8gBHNe2R
         F35YxHVSRc/xVHnA3KRqUzn7WDhXQolxwbtq1jZP5Y3SchACu0XaywHwvtgZLr5NzdjV
         2cZA==
X-Forwarded-Encrypted: i=1; AJvYcCUt0vTsvDMY54CtkrLT/aDdrbtWIq2VPuFYsOBe6fC2QgSc979CIcKYCoihb9tJ0QGojidK0CxclaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YybPrAyv/Vez35687N/GyU2N12m7czjYTgEKTz6V09LRcHYNOvl
	D8PrnkrAm/HS4ICYXTJIUxMRNpFixZIq5jKtOUhsXJ5A8CSsEzm/X+5uAnbvkNIk/CthCF0Gwv7
	mdfvccWXcbkzOwze/O162LQVX4lDu0/kjt/ccZg==
X-Google-Smtp-Source: AGHT+IHhVLQwoAzI5exBQTwAX41kCwO1IgOgu326ohmJA+OTKU337eKS6j3/2WCTqoct9eNB6s7naZI4VA/F9HAIrwo=
X-Received: by 2002:a05:6902:2389:b0:e26:c80:d3ab with SMTP id
 3f1490d57ef6-e2638442094mr3736927276.57.1727912204640; Wed, 02 Oct 2024
 16:36:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918081640.1493847-1-yujiaoliang@vivo.com>
In-Reply-To: <20240918081640.1493847-1-yujiaoliang@vivo.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Oct 2024 01:36:09 +0200
Message-ID: <CAPDyKFqOT_C0hBp1QLNrxFWK1-ig1_zbWevcE5Koro+P5feoUw@mail.gmail.com>
Subject: Re: [PATCH v1] memstick: Fix typo in comment
To: Yu Jiaoliang <yujiaoliang@vivo.com>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, 
	Jens Axboe <axboe@kernel.dk>, John Garry <john.g.garry@oracle.com>, 
	Ming Lei <ming.lei@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Sept 2024 at 10:17, Yu Jiaoliang <yujiaoliang@vivo.com> wrote:
>
> Fix typos:
> exectly->exactly,
> cylynders->cylinders,
> intersting->interesting,
> inteface->interface.
>
> Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/ms_block.c | 6 +++---
>  drivers/memstick/host/r592.c     | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
> index 47a314a4eb6f..c0383959dbb2 100644
> --- a/drivers/memstick/core/ms_block.c
> +++ b/drivers/memstick/core/ms_block.c
> @@ -996,7 +996,7 @@ static int msb_verify_block(struct msb_data *msb, u16 pba,
>         return 0;
>  }
>
> -/* Writes exectly one block + oob */
> +/* Writes exactly one block + oob */
>  static int msb_write_block(struct msb_data *msb,
>                         u16 pba, u32 lba, struct scatterlist *sg, int offset)
>  {
> @@ -1684,7 +1684,7 @@ static int msb_cache_read(struct msb_data *msb, int lba,
>   */
>
>  static const struct chs_entry chs_table[] = {
> -/*        size sectors cylynders  heads */
> +/*        size sectors cylinders heads */
>         { 4,    16,    247,       2  },
>         { 8,    16,    495,       2  },
>         { 16,   16,    495,       4  },
> @@ -1729,7 +1729,7 @@ static int msb_init_card(struct memstick_dev *card)
>
>         boot_block = &msb->boot_page[0];
>
> -       /* Save intersting attributes from boot page */
> +       /* Save interesting attributes from boot page */
>         msb->block_count = boot_block->attr.number_of_blocks;
>         msb->page_size = boot_block->attr.page_size;
>
> diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
> index 461f5ffd02bc..544a31ff46e5 100644
> --- a/drivers/memstick/host/r592.c
> +++ b/drivers/memstick/host/r592.c
> @@ -675,7 +675,7 @@ static irqreturn_t r592_irq(int irq, void *data)
>         return ret;
>  }
>
> -/* External inteface: set settings */
> +/* External interface: set settings */
>  static int r592_set_param(struct memstick_host *host,
>                         enum memstick_param param, int value)
>  {
> --
> 2.34.1
>
