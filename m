Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981912E647
	for <linux-mmc@vger.kernel.org>; Thu, 25 Apr 2024 09:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714038622; cv=none; b=Rj7eQkcn9QdawabkzIV3O9IUdcGio/20JyW6DtSR0XOwGDFIti3j2MN6zrwWAaqUYG6OV3sM+YXLctDtyyNzjOlIb7xvvelo7oAS0A0ztx8Nozdl6oFf1kvP6Z1mOhBenQKBXJjIv5N4aC4QQx8LW4OiVW9n/7ZTQbbui4nPXx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714038622; c=relaxed/simple;
	bh=GhBZ3Jmjax4VUASI4dW/rusvD1PRyRRQhwNKF2lPSEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ucqnnVGpisqL97eTDQAk/RDqKGFeuP1tyCJXVuHIk6+xVWD29DabKiMnG89nVzP9M8EEy/Hr3YkhelAiGtv/YvDBy8WvxrodXbhEBQLz0tCq0F2RlN/YwLU+zerd98Iyia4ZUOTb0j6ioFEs51JLx/tY/hvRbsy8J2EeKjooRnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L8dUW+gL; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L8dUW+gL"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dbed179f0faso1462708276.1
        for <linux-mmc@vger.kernel.org>; Thu, 25 Apr 2024 02:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714038618; x=1714643418; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dGU3DaKNSTtJ72BC/IE3k9ofyCHohc65XekJ83HHlQ0=;
        b=L8dUW+gLleFz7tlzc4/M6IO+IdxTaY5MqREKWAFv+kkuTPJ2hLltoyMaqqTiFJipQh
         jY8DXNO13/TAL2w9D8tFM0EFMEVBMy0w6fAXtrBIyxhis4Umfd8Z3FSj3yrYse8JJ+7u
         5TqSMrZf2CEZBpSs3JAIVY9NDwFoUpiu8cklX4NJpMOgs1GH1UVIUt1fS24b8I8AWQF3
         98QOhX40LiY9I1xP9nJ9yyn18aXGpxaUwc6SejDlhI/NT+LFfxScRqnj8Ge/nxeioT2L
         yPDLB5VHcVWq8zpWIe2sRTdugEW4+mUuEQklCr3pKCkHHwaPYzTZrds0Pwr+qjqiWRym
         OrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714038618; x=1714643418;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dGU3DaKNSTtJ72BC/IE3k9ofyCHohc65XekJ83HHlQ0=;
        b=pFVUVDxWf7GFhfwKa9x+VD5SEuPrgMhOcOVaJQCywOXL0Vdb2LwyIwh/mjsg3gNcAz
         dhe7rwwm7ynGeT+jsC9KU6c25yBEi61sQlZTu4nR4tYelh+Bugv4jMNkHo7Lv5XPSboT
         d9zOOQhM3DVV8mmDyXIRax2Nq/D+uNEdNljgg7C5T4+kvvisOrYiOq3Mp0VaflYpnJD9
         c2vhueywPiqC3DtKjGMz89zLKWCE4suSjZokQabWyauFykoTTv6a3L5SCXQsTHAPahEK
         ALBTtx7prdnDbhI+PQGi/XQGXCnsPqo/vMtqu3Lr6gkNiC/xCqcPv6QLA8e6BTK7p4Ho
         3QEQ==
X-Gm-Message-State: AOJu0Yx3H30sewYRAgUqDqZiiW8G43rN2u0WlUuHa73H4gOAsudrWUmv
	OB67FXcfOBVy+HQts4qDmM2GJWj9XThQ8ZmHwt9dvsFu/PPytPtzBO/zkIZ893c8qBhMZ0LeYbW
	L+pbIJruWJNnTbnQLzxkDC1iIDCByvWEAARoG1A==
X-Google-Smtp-Source: AGHT+IEh1aNOcE1EWqa5SB+pPSQDM8zBDGimINTWTmIb3MThQkUvYyafMsUCxx/cLuE/UDnbuzzQ2SFF3eYiECqiOkI=
X-Received: by 2002:a05:6902:983:b0:dc6:d258:c694 with SMTP id
 bv3-20020a056902098300b00dc6d258c694mr1702289ybb.19.1714038618515; Thu, 25
 Apr 2024 02:50:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408103824.11476-1-Joe.Zhou@mediatek.com>
In-Reply-To: <20240408103824.11476-1-Joe.Zhou@mediatek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 25 Apr 2024 11:49:42 +0200
Message-ID: <CAPDyKFoB+r7KMdbV-svz9d=WdPm1Zvd6oZppzbsPDWqX7YN_Kw@mail.gmail.com>
Subject: Re: [PATCH] mmc: race condition between "sdcard hot plug out" and
 "system reboot"
To: "Joe.Zhou" <Joe.Zhou@mediatek.com>
Cc: linux-mmc@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	wsd_upstream@mediatek.com, "Peng . Zhou" <Peng.Zhou@mediatek.com>, 
	"Sophie . Wang" <Sophie.Wang@mediatek.com>, "Wey . Zhang" <Wey.Zhang@mediatek.com>, 
	"Yijian . Jia" <yijian.jia@mediatek.com>, "Sharp . Xia" <Sharp.Xia@mediatek.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Apr 2024 at 12:38, Joe.Zhou <Joe.Zhou@mediatek.com> wrote:
>
> In mmc driver, a race condition may occur between "sdcard hot plug out" and "system reboot".
> How it happen?
>
> sdcard hot pulg out:                SyS_reboot:
> CPU0                               CPU1
> mmc_sd_detect()                    _mmc_sd_suspend
> {                                  {
>
> ......
> #Step1: detect SD card removed
> if (err) {                          ......
>     #Step2: host->card is NULL
>     mmc_sd_remove(host);
>                                     #Step3:_mmc_sd_suspend claimed host
>                                     mmc_claim_host(host);
>                                     #Step4: use host->card(NULL pointer)
>                                     if (mmc_card_suspended(host->card))
>                                     ......
>                                     }
>     mmc_claim_host(host);
>     mmc_detach_bus(host);
>  }
>  ......
>  }
> we can prevent it occuring by add claim for "host->card = NULL" and add "host->card" validity check in mmc_sd_suspend.
>
> Signed-off-by: Joe.Zhou <Joe.Zhou@mediatek.com>

Thanks for your patch!

Doesn't commit 66c915d09b94 ("mmc: core: Disable card detect during
shutdown") take care of this problem?

Kind regards
Uffe

> ---
>  drivers/mmc/core/sd.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 1c8148cdda50..38c0b271283a 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1593,7 +1593,9 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>  static void mmc_sd_remove(struct mmc_host *host)
>  {
>         mmc_remove_card(host->card);
> +       mmc_claim_host(host);
>         host->card = NULL;
> +       mmc_release_host(host);
>  }
>
>  /*
> @@ -1702,18 +1704,19 @@ static int _mmc_sd_suspend(struct mmc_host *host)
>         int err = 0;
>
>         mmc_claim_host(host);
> +       if (host->card) {
> +               if (mmc_card_suspended(card))
> +                       goto out;
>
> -       if (mmc_card_suspended(card))
> -               goto out;
> -
> -       if (sd_can_poweroff_notify(card))
> -               err = sd_poweroff_notify(card);
> -       else if (!mmc_host_is_spi(host))
> -               err = mmc_deselect_cards(host);
> +               if (sd_can_poweroff_notify(card))
> +                       err = sd_poweroff_notify(card);
> +               else if (!mmc_host_is_spi(host))
> +                       err = mmc_deselect_cards(host);
>
> -       if (!err) {
> -               mmc_power_off(host);
> -               mmc_card_set_suspended(card);
> +               if (!err) {
> +                       mmc_power_off(host);
> +                       mmc_card_set_suspended(card);
> +               }
>         }
>
>  out:
> @@ -1729,7 +1732,7 @@ static int mmc_sd_suspend(struct mmc_host *host)
>         int err;
>
>         err = _mmc_sd_suspend(host);
> -       if (!err) {
> +       if (!err && host->card) {
>                 pm_runtime_disable(&host->card->dev);
>                 pm_runtime_set_suspended(&host->card->dev);
>         }
> --
> 2.18.0
>
