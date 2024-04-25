Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B2B14E2F6
	for <linux-mmc@vger.kernel.org>; Thu, 25 Apr 2024 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062158; cv=none; b=TXGWz0QAQYgS7YgXWIQl2cZatUngZQ8K4pYySPHCeYds0UWDj1M4y9Q7YBCBMe5bPijp9SIhMjZE55RFt6VDnWXgWM0HPjrbGzKSBrjHdf/8fCZYMxqZnaBVc7+I7mfDNdCwJtqb6o40XeWjb9gTEAqGw1ztDpTRt7B/LBDobzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062158; c=relaxed/simple;
	bh=soJ4e2Be5E/28n6EP0uEAyQBnAneLGzDxl82q/3VMn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fv+zyNB+0gUm8BZhLFTgN+AN56f3UKNF2tz6t18qFZnWWXQFzVlwznfj6SRE7K4Z+pb+pyDqpGWC2axvVT9dVuqkwO6TwTFqDWBWgDwbibpQAvQeLaPi7p5bIBKLlZIxnGQQLeGUSi0/SyRuEB82H9irsofRipo+TtlbwGkMsMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z0IsAlRW; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z0IsAlRW"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-de45dba15feso1443231276.3
        for <linux-mmc@vger.kernel.org>; Thu, 25 Apr 2024 09:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714062156; x=1714666956; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V574SESgh2+rYtF8TeBicNT/LuR9F9YD9f1Bdo/Dxxg=;
        b=Z0IsAlRWDa04oFkSql5nCgb8+QweqAQ0xikF4J5hCSwBKV/gCWWOLzg5K2hTe52tbp
         SpSl7QoLsB4JkJ+xqyrl5KmpUarVbCqL7eINNttyM9KjzGRgJQdywb/9mJH8QlWun5hZ
         8RlUM934JIq0rtm91ENCylA14RTzQQhUCQF5FMDqYij05MUpFUtLSaZTnXKwjJAUZWqC
         //zkxumWq0Ge9DJF8syjAIjnJZUvPS14LypE18eh7CKjbYnl1+vOnrYW3GKCgyh03hBZ
         BPcIwLjm5BJiHw8a/9N74E2y11skg3iHkXxVtH7bUiNzRu1O2qY36fbij7HeL4dnOI2o
         9jxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714062156; x=1714666956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V574SESgh2+rYtF8TeBicNT/LuR9F9YD9f1Bdo/Dxxg=;
        b=rXpZzikY2ILMgL24LczP4sWpySXx18+IF7AY5++To7TRKyOxwY96yPkiw0JCLVcGjV
         XVN17x1TAz1rYZQvVDaWusYr/iSgHRZKpjL+J+dqS+uUjdDhsah5WVifCcszizrvwFnX
         IXHR63KKaltvc+K9HiO1f8O7RT0nGU9ypf316qLMgBTzpRn6eRGK8vYCPJOCKTAg6xW6
         DtVAq/FLZhKCwXN/N+s64NyvIbTZRZbNyIPcM32rr5oVjWf3ckfQ5WaRQqxhUHPBt5GY
         h5s5gqdPdrSYHSeY7HSv+SgMcHmgjnEw62SyXOGom/tzJBJH+7E9t+wJizobsgb++I4a
         2E4w==
X-Gm-Message-State: AOJu0YyT6ObzSXy8o2NSWYBPbEnyFmsOJdVDAXJpq1Hr9Qety1EDwPTd
	GjKPjwObBRCQEGLepu1EBjFaFx4fD+gLec2yq/qh0Ce7tdS2zB9f3mSLw6AhWZpC7SRSVoOwsRc
	S173fT5XKSRBokxfPOXZheT+ll/Z+S0ycVIj+Eg==
X-Google-Smtp-Source: AGHT+IHUTvwaHPVoEIq/fnuf/498offNgdC6i+R36zlkaoxj0us+rm6maKoCeiyM25kh0vCYrmIf6UFA6Jz1uuqPot4=
X-Received: by 2002:a25:8212:0:b0:de4:8c46:e7f9 with SMTP id
 q18-20020a258212000000b00de48c46e7f9mr118995ybk.31.1714062156175; Thu, 25 Apr
 2024 09:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417084500.152486-1-xiaokeqinhealth@126.com>
In-Reply-To: <20240417084500.152486-1-xiaokeqinhealth@126.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 25 Apr 2024 18:22:00 +0200
Message-ID: <CAPDyKFqdA8yisf6tY4gJ-ejk5azTUOZOkZhySYjeHJKibVraLg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mmc: core: increase the number of retries of the ACMD41
To: Felix Qin <xiaokeqinhealth@126.com>
Cc: linux-mmc@vger.kernel.org, dsimic@manjaro.org, Avri.Altman@wdc.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Apr 2024 at 10:45, Felix Qin <xiaokeqinhealth@126.com> wrote:
>
> Extensive testing has shown that a few specific SD cards require
> an increase in the number of command retries to successfully
> initialize.
>
> More info:
> Platform: Rockchip SoC + DW Multimedia host Controller
> SD card: Xvv microSD CMH34A17TMA12 (Made in Korea)
> Note: The SD card is custom-made by the customer in collaboration
> with the wafer foundry.
>
> Signed-off-by: Felix Qin <xiaokeqinhealth@126.com>
> Acked-by: Avri Altman <avri.altman@wdc.com>
> ---
> v2: Add more info
> ---
> ---
>  drivers/mmc/core/sd_ops.c | 4 ++--
>  drivers/mmc/core/sd_ops.h | 8 ++++++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> index a59cd592f06e..b3b6e8725b80 100644
> --- a/drivers/mmc/core/sd_ops.c
> +++ b/drivers/mmc/core/sd_ops.c
> @@ -127,7 +127,7 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
>                 cmd.arg = ocr;
>         cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
>
> -       for (i = 100; i; i--) {
> +       for (i = SD_APP_OP_COND_RETRIES; i; i--) {
>                 err = mmc_wait_for_app_cmd(host, NULL, &cmd);
>                 if (err)
>                         break;
> @@ -147,7 +147,7 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
>
>                 err = -ETIMEDOUT;
>
> -               mmc_delay(10);
> +               mmc_delay(SD_APP_OP_COND_INTERVAL);

Rather than extending the current loop above, I would prefer if we can
move to use __mmc_poll_for_busy(), similar to what we also do for
(e)MMC and MMC_SEND_OP_COND, for example.

To help out a bit, I just posted a patch [1] making that conversion.
Please try it out and explore what values you need to set for the new
defines, "SD_APP_OP_COND_PERIOD_US" and "SD_APP_OP_COND_TIMEOUT_MS",
to make it work for you.

>         }
>
>         if (!i)
> diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
> index 7667fc223b74..80c5c836ccd1 100644
> --- a/drivers/mmc/core/sd_ops.h
> +++ b/drivers/mmc/core/sd_ops.h
> @@ -10,6 +10,14 @@
>
>  #include <linux/types.h>
>
> +/*
> + * Extensive testing has shown that a few specific SD cards require
> + * an increase in the number of command retries to successfully
> + * initialize.
> + */
> +#define SD_APP_OP_COND_RETRIES  200
> +#define SD_APP_OP_COND_INTERVAL 10     /* millisecond */
> +
>  struct mmc_card;
>  struct mmc_host;
>
> --
> 2.34.1
>

Kind regards
Uffe

[1]
https://lore.kernel.org/all/20240425133034.79599-1-ulf.hansson@linaro.org/
