Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726F81D0958
	for <linux-mmc@vger.kernel.org>; Tue,  3 Sep 2024 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367076; cv=none; b=AGiYDf2gD3j8BvwPYmUXhqPgj8nZDeV8gz8O6C9qXdxepMBNi5D1wwMkVPOSbRzwpAbljtM/yrc5qI4heS8gkf/mfzTa8K+LIR3hVcKMiIUt+xoTofB6ACIe2+dbVSdPywD09HsjDhutDvlv11BBVeXvkS0JQA3/c2dsiX69sxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367076; c=relaxed/simple;
	bh=ZIRFzy8O/JFEsQSefz4z/A5D21hKvmWKwaIPahrMiZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WFVDC7blJvTU9uE3HN5VBNkMPyaMVkMVPGESK1clwvyvQosozUke4nb3ikYfk/QdO7PuRiOnGowxBo+efmSZoTg4F+zUoovlUMJ/mhZnps9MUGd7PPY5sIvPjCphq0oACCkVTzMU68YoPpWHoIzFy/3wlbqXz0IwoGAbLDWcnOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L+6+HTbL; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L+6+HTbL"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e03caab48a2so4035214276.1
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2024 05:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725367073; x=1725971873; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bowRaP9KnP0kRw4rrPkc8McUFkoLeQptHo1hDde4lEk=;
        b=L+6+HTbLPCN/uX4X5CiLPL3GlOD2peWBawL6ChdIJVm7nX1h0acsP41YytQQPqi/rA
         5Ewf50ZzDedyKYQoB2HN2G7IItQlJ/kaAa6hfbM7fEyL2dJxD3X3CsHfhEgb0AAC3qKr
         LzFmu6vc7fa3gi6SSi6RPoDPTUYFCETMZ/9ujyQCN2QlB8bQiQ83reBlHaxkZ0sAzZ7x
         RdKjIPMwC0YtCR1hYeh+8BSDoSOgfexCr+/Sa1T76mUKc+BECN0O2mMmPXkDJMmv71oo
         /xYXfiVQVlUNfw50VZ8S9sWk94SBEgILyp9R0hujcaCeQuWOkoJJvu0f2oqdbhkybgtt
         uqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725367073; x=1725971873;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bowRaP9KnP0kRw4rrPkc8McUFkoLeQptHo1hDde4lEk=;
        b=caBQuvH0aKvn1rlCUb6ISF14N8QlNX9jromeHUFkqM1DPP72+Pg+E9pdvNC4RA6f57
         s1DxmX0EHnyc2dBbmADdjEr2cvzyTv7rIjhfQJsF2o9G0elPZ1y2RtqrJWwFUA9sqsZb
         5KoiWjuWWyLEcHLz0P/p7q8AvwiW33Bho9YUFA8fNYhU05WcvwJzYWZPgUy44edJrauU
         4oTG6NJ+CgsvcB2vatFEBcV2uqAfIQEB9qFm5V/EyD9fsPzmrTx2/QnrO3Z6KxwM3JYM
         xCRfqVMbVVoOkHwvKjc+ZXFLvqIIn3syw8cSFAswHiuGlbFk4yhbLpX9oWH5jbncH+Z9
         Y2/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDyM+kH2SOtK+j+SD2dzhwEEqlA/wZxUSfMtu5UUNFHf1zk5k0xTO3vosZrOtIqQmsvroFOBIJHS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9bAAtcDHfrAYVgi3paCBcBouHzI0XVU9sFWYdjJfC1eJofNqn
	9ubqGwIv+cbEz3IqSihbfqjPNWA+hIwURfwcDokJ2NR4CYNjlVV3+gGPKBdtW34qpopHttKkcZL
	eCwVNTV9JAObxog5WCjYggb0TaQZnXBuLF2eg0m81OkT/C5Q2
X-Google-Smtp-Source: AGHT+IEaowgdIJ3AzaGZI6j/OEXNzDMqgE0yQw9WffqvnjW3A9WpWnsw2p2fKeOMZaFS9fN+AIIW+6GY8wPVS5fO5fQ=
X-Received: by 2002:a25:8583:0:b0:e1a:89d7:9271 with SMTP id
 3f1490d57ef6-e1a89d79563mr8359242276.21.1725367067352; Tue, 03 Sep 2024
 05:37:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240829024728epcas1p2847ea2802d1cc4edeb74559c67925622@epcas1p2.samsung.com>
 <20240829024709.402285-1-cw9316.lee@samsung.com>
In-Reply-To: <20240829024709.402285-1-cw9316.lee@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Sep 2024 14:37:11 +0200
Message-ID: <CAPDyKFqPq3QOj948WfARerU3fByaVoAsfeu5kEdEhHHV6iVCEw@mail.gmail.com>
Subject: Re: [PATCH] mmc:sd:Replace the argument of mmc_sd_switch with the
 already declared define
To: Chanwoo Lee <cw9316.lee@samsung.com>
Cc: ricardo@marliere.net, avri.altman@wdc.com, dsimic@manjaro.org, 
	jonathan@raspberrypi.com, xiaokeqinhealth@126.com, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Aug 2024 at 04:47, Chanwoo Lee <cw9316.lee@samsung.com> wrote:
>
> Replace with already defined values for readability.
> And since the value of the 'mode' parameter is only used as 0 or 1,
> I changed the data type from 'int' to 'bool'.
>
> --------------------------------------------------
> /sd.h
> /*
>  * SD_SWITCH argument format:
>  *      [31] Check (0) or switch (1)
> ...
>
> /*
>  * SD_SWITCH mode
>  */
>   define SD_SWITCH_CHECK         0
>   define SD_SWITCH_SET           1
> -------------------------------------------------
>
> Signed-off-by: Chanwoo Lee <cw9316.lee@samsung.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/sd.c     | 13 ++++++++-----
>  drivers/mmc/core/sd_ops.c |  3 +--
>  include/linux/mmc/host.h  |  3 ++-
>  3 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index ee37ad14e79e..d7318c2647da 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -346,7 +346,7 @@ static int mmc_read_switch(struct mmc_card *card)
>          * The argument does not matter, as the support bits do not
>          * change with the arguments.
>          */
> -       err = mmc_sd_switch(card, 0, 0, 0, status);
> +       err = mmc_sd_switch(card, SD_SWITCH_CHECK, 0, 0, status);
>         if (err) {
>                 /*
>                  * If the host or the card can't do the switch,
> @@ -402,7 +402,8 @@ int mmc_sd_switch_hs(struct mmc_card *card)
>         if (!status)
>                 return -ENOMEM;
>
> -       err = mmc_sd_switch(card, 1, 0, HIGH_SPEED_BUS_SPEED, status);
> +       err = mmc_sd_switch(card, SD_SWITCH_SET, 0,
> +                       HIGH_SPEED_BUS_SPEED, status);
>         if (err)
>                 goto out;
>
> @@ -434,7 +435,8 @@ static int sd_select_driver_type(struct mmc_card *card, u8 *status)
>                                                    card_drv_type, &drv_type);
>
>         if (drive_strength) {
> -               err = mmc_sd_switch(card, 1, 2, drive_strength, status);
> +               err = mmc_sd_switch(card, SD_SWITCH_SET, 2,
> +                               drive_strength, status);
>                 if (err)
>                         return err;
>                 if ((status[15] & 0xF) != drive_strength) {
> @@ -514,7 +516,7 @@ static int sd_set_bus_speed_mode(struct mmc_card *card, u8 *status)
>                 return 0;
>         }
>
> -       err = mmc_sd_switch(card, 1, 0, card->sd_bus_speed, status);
> +       err = mmc_sd_switch(card, SD_SWITCH_SET, 0, card->sd_bus_speed, status);
>         if (err)
>                 return err;
>
> @@ -605,7 +607,8 @@ static int sd_set_current_limit(struct mmc_card *card, u8 *status)
>                 current_limit = SD_SET_CURRENT_LIMIT_200;
>
>         if (current_limit != SD_SET_CURRENT_NO_CHANGE) {
> -               err = mmc_sd_switch(card, 1, 3, current_limit, status);
> +               err = mmc_sd_switch(card, SD_SWITCH_SET, 3,
> +                               current_limit, status);
>                 if (err)
>                         return err;
>
> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> index 8b9b34286ef3..f93c392040ae 100644
> --- a/drivers/mmc/core/sd_ops.c
> +++ b/drivers/mmc/core/sd_ops.c
> @@ -336,14 +336,13 @@ int mmc_app_send_scr(struct mmc_card *card)
>         return 0;
>  }
>
> -int mmc_sd_switch(struct mmc_card *card, int mode, int group,
> +int mmc_sd_switch(struct mmc_card *card, bool mode, int group,
>         u8 value, u8 *resp)
>  {
>         u32 cmd_args;
>
>         /* NOTE: caller guarantees resp is heap-allocated */
>
> -       mode = !!mode;
>         value &= 0xF;
>         cmd_args = mode << 31 | 0x00FFFFFF;
>         cmd_args &= ~(0xF << (group * 4));
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 7140e1a7edb4..8fc2b328ec4d 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -649,7 +649,8 @@ static inline void mmc_debugfs_err_stats_inc(struct mmc_host *host,
>         host->err_stats[stat] += 1;
>  }
>
> -int mmc_sd_switch(struct mmc_card *card, int mode, int group, u8 value, u8 *resp);
> +int mmc_sd_switch(struct mmc_card *card, bool mode, int group,
> +               u8 value, u8 *resp);
>  int mmc_send_status(struct mmc_card *card, u32 *status);
>  int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
>  int mmc_send_abort_tuning(struct mmc_host *host, u32 opcode);
> --
> 2.34.1
>
