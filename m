Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BCB22DFA4
	for <linux-mmc@vger.kernel.org>; Thu, 19 Jun 2025 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750332046; cv=none; b=W5PhIHLGngC2PZL0KHYazv7/bg2W6G2F++NIBIHx/dOOOr1huFew49RifECtl7xGgtIfXQ3wjZGyTj83dRleXOu9ERvKkczIJFnWIqXNe96JK6+VmhmhsMegWDSLDhmeWE3HP6z5QyLDn6xbsFhGUTuD7wRCgJANT1kuJsud55I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750332046; c=relaxed/simple;
	bh=pytXLFdnJ1BhbNkSJdYUV6GaM6i+LGpFiP/9N23VDdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z36qBqJIIwWZ82KDYN+UPA4O5vP+tXJ4Wt1GYqEcFwlccF0+3EHPPkspvSPysMsFmgO/sUTRmPLZvxPxIfrM9r3jUfdh+R7NaJMuI0TYyNRLedgeQjCdXIdl9WTM5Fb5wNvIZpaoiqdPxd1+PnmjwnETczJFP+gOkC4l/FSut80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vRE9x3R+; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vRE9x3R+"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e740a09eae0so712690276.1
        for <linux-mmc@vger.kernel.org>; Thu, 19 Jun 2025 04:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750332043; x=1750936843; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=niIEC24pa2jxdKXkefJ3vkZfAtNqJpvIieuArrIyjOQ=;
        b=vRE9x3R+B147RO+ySAP4qnaE77VTrYq2I+EzieyZAek4dCffhiptE+l6qbguqGI5Mq
         dYKJeWXpAKUp8qGdwu0xm8+LojLtRV9zDgoUm8Qwuhr1Q5l8Tok8QAbCTQ63WAAhG0C3
         pOOG7lOHa7C1fO9yUFHimfbi/quhihRL+uppwBttlFHS4DpK9xioNGjojj3Kd6bG335/
         46GaaXP6YttJ9gMAE+nG9UotDYPvkB8YxR35lOQAV/gMxZXQPIUqz65MqwWVFaNie1ol
         a7VAY6A1tXEuU9B/rtBavjAc687cBDjotUTdWBBRlcxN206l5985SEM9enufSpPWi9dC
         AJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750332043; x=1750936843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=niIEC24pa2jxdKXkefJ3vkZfAtNqJpvIieuArrIyjOQ=;
        b=Ke2Fnm9RP+M8pkWY7rPTWfeAFv3m7SPKA4sb1VAWLQMZcwFiFUlUWBUQMK4fqV4hxg
         AKNXqx402cTxmENXSb0XOt838L/ReCEVcGydMAuMqkG7u31329AwVmkc1q3/SCEfw+io
         jMz9RnAfP0EV1UfZTBLxgOkAs5OLXUi55+hzazFYuvwJuGA+hXjQoBJqcMUGOMDgKxOG
         nhLOzi8NSZ7SIsI5zeSK1Lji+L8/jJehjarn7Cnaj8HDrxh/raA8nAHIxrv1jml0wlgB
         fsFT1RIVuT1QFBk+vEBTbD2Zm2e0wvr59a52qFCkcI7DMlwYn/5QEdXpV/ddT2PYoJAw
         mnBw==
X-Forwarded-Encrypted: i=1; AJvYcCWdoqyO721dioc6D2QtiwHKJyHKZ+ULcsn0YQytX/crgl9q7WMN8cVOPP2yATUlPSvPm1OTvRJbzts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ioXnHyr8ALBkd9aFY4pr0Z/y5iHp9jUZd7ckLnw2mqoNQ40Z
	gVAwCEyY5HQUGzDCwHYmIsyC0OmzWwF3tuO7pzfhOraCzZYJJzIKOEa+o0W1pjHXe+aKAgybVU5
	3TpVr0F5ElNd+fDqHtE+A4PWv6ysx3d6KQ0CKITrjkA==
X-Gm-Gg: ASbGnct0pP1dhCnqDOSKZBwSzelkX7ONWooQAMygLq3S7zkZMmh00Z8IJoUedReJNK9
	LsD+aZjTvv+oxqUkSA5QwvxXv/NBZjE9f2XpTT0uhad7yJphdy4glF89hvE1BDuMYsaxVUpG5Qo
	14BQDakXFJ3et9hAZ9QAcE6hz0FXYZJPgLWmshMIOZ4Wv2
X-Google-Smtp-Source: AGHT+IF2iE0ox/gzxKHz5bI8Q+Pkgb8UWe4OY/z3MjCCMZXinEnzR7Rqk/xTiCIm/KwZ4rpmEsnSRUYX7m4o4AQKZbE=
X-Received: by 2002:a05:6902:cc6:b0:e81:7e16:aad7 with SMTP id
 3f1490d57ef6-e822ac7a461mr27597842276.24.1750332043584; Thu, 19 Jun 2025
 04:20:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174972756982.3337526.6755001617701603082.stgit@mhiramat.tok.corp.google.com>
In-Reply-To: <174972756982.3337526.6755001617701603082.stgit@mhiramat.tok.corp.google.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Jun 2025 13:20:07 +0200
X-Gm-Features: AX0GCFvXjxV2EcT_wfBSHPu57s1TY2VkiQlHaijGThkd0p21SEv0wZoDeoPKInc
Message-ID: <CAPDyKFpCPLCxp54yjBAaLz2tJK6Ouk-ikpvs9uby7aXnic=U7Q@mail.gmail.com>
Subject: Re: [PATCH] mtk-sd: Prevent memory corruption from DMA map failure
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Tomasz Figa <tfiga@chromium.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Jun 2025 at 13:26, Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> If msdc_prepare_data() fails to map the DMA region, the request is
> not prepared for data receiving, but msdc_start_data() proceeds
> the DMA with previous setting.
> Since this will lead a memory corruption, we have to stop the
> request operation soon after the msdc_prepare_data() fails to
> prepare it.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Applied to fixes and by adding a fixes/stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c |   17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 3594010bc229..56b4999fe58f 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -834,6 +834,11 @@ static void msdc_prepare_data(struct msdc_host *host, struct mmc_data *data)
>         }
>  }
>
> +static bool msdc_data_prepared(struct mmc_data *data)
> +{
> +       return data->host_cookie & MSDC_PREPARE_FLAG;
> +}
> +
>  static void msdc_unprepare_data(struct msdc_host *host, struct mmc_data *data)
>  {
>         if (data->host_cookie & MSDC_ASYNC_FLAG)
> @@ -1466,8 +1471,18 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
>         WARN_ON(!host->hsq_en && host->mrq);
>         host->mrq = mrq;
>
> -       if (mrq->data)
> +       if (mrq->data) {
>                 msdc_prepare_data(host, mrq->data);
> +               if (!msdc_data_prepared(mrq->data)) {
> +                       /*
> +                        * Failed to prepare DMA area, fail fast before
> +                        * starting any commands.
> +                        */
> +                       mrq->cmd->error = -ENOSPC;
> +                       mmc_request_done(mmc_from_priv(host), mrq);
> +                       return;
> +               }
> +       }
>
>         /* if SBC is required, we have HW option and SW option.
>          * if HW option is enabled, and SBC does not have "special" flags,
>
