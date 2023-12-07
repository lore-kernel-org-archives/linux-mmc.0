Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kxLlZvpq"
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71BE10F4
	for <linux-mmc@vger.kernel.org>; Thu,  7 Dec 2023 06:02:02 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5d3644ca426so7673857b3.1
        for <linux-mmc@vger.kernel.org>; Thu, 07 Dec 2023 06:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701957721; x=1702562521; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xqSN2wz/zGfROIqFiurJMPD+/BJpUqBprXGsU0gwv9Q=;
        b=kxLlZvpqxT4FoowXREhO+D/r3/lncVGKrOhheT1Q8TsbSJG5FAscSUOWyLGiyBXgDH
         mtmKRe+GT6p40OIScxDv5Nki87K9XWRs+a8/NiLa54PMSfrNc4CTuHrpjZvkspPw37/5
         2e8JGMElffVGJCb+cZ/uQW0fewQclDYAykaxesgj5OazgG6HoziVZTbvSm4cXrN3iOk0
         hfKk5z3dJLdrtBv8VROAMNKMGkIx+CyA8StbXGEfneD1zEWfcPZJYTsnuahuEVaWB430
         3YaHCYz8Om6T1+GrIqhSrqoLQn8HRzqj9Odn9FApmIt18lQ9WRdyxs8xhjHuX+APk2+J
         Q16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701957721; x=1702562521;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xqSN2wz/zGfROIqFiurJMPD+/BJpUqBprXGsU0gwv9Q=;
        b=Gkd+9xI1mVTcKh2Q6hUSPagy9MjSmiNFEDCc7b6ENPBxMOJ+G3LS9G4QE0aWlN9ary
         di/R9l3GyfR4Tk0KMcSQL8rwLeFQWjavaI5q+sbbvOYJgXkemMxu8TQnQAf1aYtPUbHw
         UOORk7UORONpnlbA5lGcRzrPpmkpw7XXV++/03woOs3kkp6Tc3HXkELHf6eE9p5VY7SO
         L2Ikps25Nc7sU94qoYfTIbxxTyGaHuB2384Kf3ShTwcGkrnCwksmY9B9Vu2rCppNEscb
         NSCCxtJ5OZWUo3YTprUmxR/EWtnZ0of8eqgS4yRdiM8dM07GZM9agnspfhLBiKYd84Ol
         Dh1w==
X-Gm-Message-State: AOJu0YzBcxlToKIDjFXm76I2INa/0OP0pem10Hj4uaqhgSYXNlHEC5WH
	Iv2cg7qZP2HvRiHBGBXul4Zk2i7VWNDKx8FevOPZwQ==
X-Google-Smtp-Source: AGHT+IH3A+kfMVFWXCHHzW1EoiuSi/T1nkVcCCM0Y1P3XBgusQEyXxhBLp9MTbatm83rnaE5ppyGAiBDsLZJiNAzu+I=
X-Received: by 2002:a0d:d88b:0:b0:5d7:1941:3556 with SMTP id
 a133-20020a0dd88b000000b005d719413556mr2618248ywe.61.1701957721714; Thu, 07
 Dec 2023 06:02:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201102747.3854573-1-treapking@chromium.org>
In-Reply-To: <20231201102747.3854573-1-treapking@chromium.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 7 Dec 2023 15:01:25 +0100
Message-ID: <CAPDyKFrAvkzgHUttY_mVAHK3HXCV_eE6=KhQkdQyLq22zstX8A@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: mtk-sd: Increase the verbosity of msdc_track_cmd_data
To: Pin-yen Lin <treapking@chromium.org>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ot_shunxi.zhang@mediatek.corp-partner.google.com, 
	linux-mediatek@lists.infradead.org, Chen-Yu Tsai <wenst@chromium.org>, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Dec 2023 at 11:27, Pin-yen Lin <treapking@chromium.org> wrote:
>
> This log message is necessary for debugging, so enable it by default to
> debug issues that are hard to reproduce locally.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
>
> Changes in v3:
> - Only print the warning when -ETIMEDOUT or not in tuning process
>
> Changes in v2:
> - Use dev_warn() instead of dev_err()
>
>  drivers/mmc/host/mtk-sd.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 97f7c3d4be6e..6ae5e0a9fca9 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1149,9 +1149,11 @@ static void msdc_recheck_sdio_irq(struct msdc_host *host)
>
>  static void msdc_track_cmd_data(struct msdc_host *host, struct mmc_command *cmd)
>  {
> -       if (host->error)
> -               dev_dbg(host->dev, "%s: cmd=%d arg=%08X; host->error=0x%08X\n",
> -                       __func__, cmd->opcode, cmd->arg, host->error);
> +       if (host->error &&
> +           ((!mmc_op_tuning(cmd->opcode) && !host->hs400_tuning) ||
> +            cmd->error == -ETIMEDOUT))
> +               dev_warn(host->dev, "%s: cmd=%d arg=%08X; host->error=0x%08X\n",
> +                        __func__, cmd->opcode, cmd->arg, host->error);
>  }
>
>  static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
> --
> 2.43.0.rc2.451.g8631bc7472-goog
>
