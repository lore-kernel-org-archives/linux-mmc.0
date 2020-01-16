Return-Path: <SRS0=GOb8=3F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A29C33CB1
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 14:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6AC02077B
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 14:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qOx6+lzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgAPOIA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:08:00 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:41173 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgAPOIA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2020 09:08:00 -0500
Received: by mail-ua1-f65.google.com with SMTP id f7so7663218uaa.8
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2020 06:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wKsTzY7TBQ0hsXgCv04UaYQDo6ubwiFa9SGKia4Q60g=;
        b=qOx6+lzEgd/NEFwd9y0NQRwKzgBJ8f0M1bs6J1SvelBNE+FUyFZzRxiltAWe9lDZ2s
         o3xiARCuTvOyTpRMR3wI5evNffSpEn4vPejkXE0RR9YlaJpplbFwOlSH+ufe1BxKh2jS
         587qYtZoO1GIj+eekalbtq8knupM23wBRSi132hPQduN2pGPfregX8J8AF6qiUVrcaBN
         hTEsWQee2Ja2nBDETbGcQyCSp2gEX12uYoShnBW5y39E54t1cVhbf5B3Orp5UM4ldi6s
         vzjGGUKZLPRsG4a/x5kpNyN1iR5hzlqJFEwLcpyG91aK02x0/PefwyeYcDKEol/4iuA0
         P5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wKsTzY7TBQ0hsXgCv04UaYQDo6ubwiFa9SGKia4Q60g=;
        b=he3jIoVL9c2oySNEbX1TB+LbOO7j62w+vOu9YpjURNi96jpsrBesvQUvUbofuDNlR1
         g+dgXuXRgxEC3ya9r5u5fnU6NVXOJKHUI06rzcdZYXYS5dHhoK7iCVtHf4LhfpTw1kma
         ZMNnUkeR4eZxu5GY0Lsy6tc+Hsa+e7lyTcmc6DplHnd81utQ/5HoQcxu630jBUB58GbY
         eMIesgoDHkfrukmM1qB7D5XeZ7F1ycwFHvh2VFoQYa2hi2mn9niSnRSs2erK6/5MdfI+
         Oszh5E8Qg3KbHTSxAMqKEpVCu9nmk5afaLQICVIqiJ19h5pzn+f0dTBDc6JNzZFhENSs
         sOow==
X-Gm-Message-State: APjAAAVfMf1sAsOaG9zd7R+DFEQqUw65rR4eyz/tf3eIT6xBlNlm1wPs
        +PLCLzNEwgnSSMC2VQ01bnQ+xyGPaCpa1kxRqDjsBAdp
X-Google-Smtp-Source: APXvYqxbll2Ts5dDaerJeqewzVDPGIJrq6RMLH8CH8DMR1HuhP81L0LKZ03MMhAA3SAgmyHo7PCfL9kcjsbqDLXRNlg=
X-Received: by 2002:ab0:e16:: with SMTP id g22mr17201443uak.129.1579183679045;
 Thu, 16 Jan 2020 06:07:59 -0800 (PST)
MIME-Version: 1.0
References: <f471bceaf237d582d746bd289c4c4f3639cb7b45.1577962382.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <f471bceaf237d582d746bd289c4c4f3639cb7b45.1577962382.git.mirq-linux@rere.qmqm.pl>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Jan 2020 15:07:22 +0100
Message-ID: <CAPDyKFpZWnkK7UmCZ8M4UnM05wR3MQsPrpEjOJuwkKcN2gePSg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: limit probe clock frequency to configured f_max
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 2 Jan 2020 at 11:54, Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmq=
m.pl> wrote:
>
> Currently MMC core disregards host->f_max during card initialization
> phase. Obey upper boundary for the clock frequency and skip faster
> speeds when they are above the limit.

Is this a hypothetical problem or a real problem?

>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/mmc/core/core.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index abf8f5eb0a1c..aa54d359dab7 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2330,7 +2330,13 @@ void mmc_rescan(struct work_struct *work)
>         }
>
>         for (i =3D 0; i < ARRAY_SIZE(freqs); i++) {
> -               if (!mmc_rescan_try_freq(host, max(freqs[i], host->f_min)=
))
> +               unsigned int freq =3D freqs[i];
> +               if (freq > host->f_max) {
> +                       if (i + 1 < ARRAY_SIZE(freqs))
> +                               continue;
> +                       freq =3D host->f_max;

This looks wrong to me. For example, what if f_max =3D 250KHz and f_min =3D=
 50 KHz.

Then we should try with 250KHz, then 200KHz and then 100KHz. This
isn't what the above code does, I think.

Instead it will try with 200KHz and then 100KHz, thus skip 250KHz.

Maybe we should figure out what index of freqs[] to start the loop for
(before actually starting the loop), depending on the value of f_max -
rather than always start at 0.

> +               }
> +               if (!mmc_rescan_try_freq(host, max(freq, host->f_min)))
>                         break;
>                 if (freqs[i] <=3D host->f_min)
>                         break;
> @@ -2344,7 +2350,7 @@ void mmc_rescan(struct work_struct *work)
>
>  void mmc_start_host(struct mmc_host *host)
>  {
> -       host->f_init =3D max(freqs[0], host->f_min);
> +       host->f_init =3D max(min(freqs[0], host->f_max), host->f_min);
>         host->rescan_disable =3D 0;
>         host->ios.power_mode =3D MMC_POWER_UNDEFINED;
>
> --
> 2.20.1
>

Kind regards
Uffe
