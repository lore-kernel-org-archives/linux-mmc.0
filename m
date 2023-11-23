Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yguYbwhS"
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7F7D4A
	for <linux-mmc@vger.kernel.org>; Thu, 23 Nov 2023 09:13:45 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-da3b4b7c6bdso1048122276.2
        for <linux-mmc@vger.kernel.org>; Thu, 23 Nov 2023 09:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700759625; x=1701364425; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bKNwCpnkd4HHouKuRGDnXl3uAXRtD1+lzSL7fC1Un1Y=;
        b=yguYbwhSLCbKULZovv6wZH7UFFI8Af+Mo+t4Kdu/QUurD9MTjPfA9O5gp4BZeKVmTk
         ddwqeavTnbUnmewreFzK8iEUc99jLHUh5FBO/4jbADAH3ul8iGACY6vcfz9+5aU6tPsp
         ULDF67zAQGLh9wElRlhEuufLONoFWBN7KwRiC8EX/v3whp1ZmYn4g7AKBY/na1ay59bR
         3/HQB0mnWVNVfCLzEIhKsQJetkMt4dA7H1PqDLdMzs/e1Pxbe97pVV9rwEPrYeJBcKS0
         UwAN3gvNzEVWgbw7Rwk4nvDGEZgYb9+4IiVFuN2YwIchQ2Feo4efSGLOfx96ixnN8SI8
         fmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700759625; x=1701364425;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKNwCpnkd4HHouKuRGDnXl3uAXRtD1+lzSL7fC1Un1Y=;
        b=i7KOkNgaj11mdtNcW4ZXykzbtDXyd6nG3F4MR5fFChkaSdMfIjmhjLYkOi3qOzb9Qx
         9O0jfCIdqxFJJewdIZ7MZ5ypQz/OFbUbRtOXtAMhuBJ8aPWsHDPwqAtQfnW+uXYUYv8Y
         67i9U32jBmYniJoFI8/RCgAX3vMxT317mDPOPqi5db5jzHZPhYPfo9q7wzfSs3UwJ/EQ
         tbfP1sFWvsQlMHYkVHSXmZfyNosyYiI+MBga7BI3vJId/e6mO1n1bc1MJc8+H85RGRAp
         8flb9RY+aGvHILQ11XOHEyRE2NUgw8zwjVOgpv7lRq0M+DZvJgZpGDV8N5BqxEAf/Oe8
         9Cug==
X-Gm-Message-State: AOJu0YymIeQe5Ee/kgVSqyNoBhN3DwQcJojRq1oWlzyW8BatFx9N0sKw
	ClMFPH13qUryMZ8g2rdMKu0to79zFDq2rwdBQfxNKw==
X-Google-Smtp-Source: AGHT+IGFr6g8jlQ3HN+XUNNaKBgc8oVfUM5jYKRK0VWTl7TjhJHxHFo9KjRuS+1jJjO2xdJg2ndmcfoZW2K0mOMBkR4=
X-Received: by 2002:a25:6b06:0:b0:daf:76da:fe2b with SMTP id
 g6-20020a256b06000000b00daf76dafe2bmr6007585ybc.10.1700759624759; Thu, 23 Nov
 2023 09:13:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117095531.1693753-1-treapking@chromium.org>
In-Reply-To: <20231117095531.1693753-1-treapking@chromium.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 23 Nov 2023 18:13:09 +0100
Message-ID: <CAPDyKFqjcP2pAH8uo61Yc7wU76NM1aCMN6P1TaAoafCFfZSeWw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mtk-sd: Increase the verbosity of msdc_track_cmd_data
To: Pin-yen Lin <treapking@chromium.org>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, Chen-Yu Tsai <wenst@chromium.org>, 
	ot_shunxi.zhang@mediatek.corp-partner.google.com, 
	linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Nov 2023 at 10:55, Pin-yen Lin <treapking@chromium.org> wrote:
>
> This log message is necessary for debugging, so enable it by default to
> debug issues that are hard to reproduce locally.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
>
> ---
>
>  drivers/mmc/host/mtk-sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 97f7c3d4be6e..4469003f571e 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1150,7 +1150,7 @@ static void msdc_recheck_sdio_irq(struct msdc_host *host)
>  static void msdc_track_cmd_data(struct msdc_host *host, struct mmc_command *cmd)
>  {
>         if (host->error)
> -               dev_dbg(host->dev, "%s: cmd=%d arg=%08X; host->error=0x%08X\n",
> +               dev_err(host->dev, "%s: cmd=%d arg=%08X; host->error=0x%08X\n",
>                         __func__, cmd->opcode, cmd->arg, host->error);

How critical is this? Should we perhaps use a dev_warn instead?

>  }
>

Kind regards
Uffe
