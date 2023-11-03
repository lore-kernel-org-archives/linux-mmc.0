Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2D6C4332F
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Nov 2023 11:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346616AbjKCLRQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 3 Nov 2023 07:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346626AbjKCLRJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Nov 2023 07:17:09 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D6E18B
        for <linux-mmc@vger.kernel.org>; Fri,  3 Nov 2023 04:16:57 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a7fb84f6ceso23348077b3.1
        for <linux-mmc@vger.kernel.org>; Fri, 03 Nov 2023 04:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699010216; x=1699615016; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9eA8efKOPXzUzYKsuUX5NbXDmCYD0utTiCrivhgq71I=;
        b=clreFg0cxUHkmLnUkW1GWW/RDuUk/AJ88WfNAMQOakldVXHuvub6iO0D9EdpEjvQtB
         qxjxn0XKCBzoA/Kb3DXotsZy4S8gHo3mmpX8YiF7MK5IGMUgZO5IIgW2r6ZClqlFqaE0
         jwJuxYXZOHhCRwjiH1h8jQxZsK4m3pL5ZiQAn/RaS+l59bBosyO2B8txdd626wo0DWOW
         yvQGPQoqhT0E8Ys2snUl4W38hUd1ruJiuI4mLtNzvxXQ/Yo9wfy7TY1TGcTj2XhVMMIZ
         FGJODgBGbtztT4TujvO0RhxI9n+omro05/roxWK2QM0MfCN7hTipmneKtqigDKvO2geM
         l5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699010216; x=1699615016;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9eA8efKOPXzUzYKsuUX5NbXDmCYD0utTiCrivhgq71I=;
        b=BGZ3WjHuTyhLps2C3096Kw8i43wNkDfaheSMasVaIT993uQzq57YAsb3EO8E6TWBzy
         AGTCaSU9v0mhdsSqo/VlXPCPw3R2S1wTj4xEBx2heCToXh9YdPgLXZKhI7aeFRK9Nv9i
         iYB2AdsK589r6V1MFLK4MoPMXbw+V8wTBGx/TFcQyWBa/q6BSgS7AXjf/mSmXvOMrbcz
         mXpY6lks1iWQhoEtmLRQt5yfSq1Zr5i6ST7q8/FsYnHp4H0dsc3W0S2StMesjBIQzxs5
         Q9bo5RGz7SUlVFLU1Yo8drv3fNEF4kcHQxUAGoK9DsZIut+hONEvPJ+2GQkOAb0tpcks
         jwTw==
X-Gm-Message-State: AOJu0YzqoKFt35sZ+P/tqG/Vkw/AnL91BEmAF7mqu3yEihH967HYnz/2
        ExF0+1YBHPVvS16mGch0X9Jl8FxRzFd3xRSNnCfSoQ==
X-Google-Smtp-Source: AGHT+IGFr/4fnxq3hTHWQYUSTvNr3iWFzoC5V9kIq8qHxBgrMwioqwRQgDyzjZNIOBCQDjh83t+jl6o/P71DDEgT8Io=
X-Received: by 2002:a81:7c03:0:b0:59f:535b:52a7 with SMTP id
 x3-20020a817c03000000b0059f535b52a7mr2128058ywc.48.1699010216748; Fri, 03 Nov
 2023 04:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <0769d30c-ad80-421b-bf5d-7d6f5d85604e@moroto.mountain>
In-Reply-To: <0769d30c-ad80-421b-bf5d-7d6f5d85604e@moroto.mountain>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 Nov 2023 12:16:20 +0100
Message-ID: <CAPDyKFoYUtQzMCPKhEHrzxAA5_zk8KiwR-Knj30X+9FebdxW5A@mail.gmail.com>
Subject: Re: [PATCH] mmc: vub300: fix an error code
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Tony Olech <tony.olech@elandigitalsystems.com>,
        Deren Wu <deren.wu@mediatek.com>, Bo Liu <liubo03@inspur.com>,
        Justin Stitt <justinstitt@google.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 2 Nov 2023 at 08:51, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> This error path should return -EINVAL instead of success.
>
> Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/vub300.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> index de3f443f5fdc..fd67c0682b38 100644
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -2309,6 +2309,7 @@ static int vub300_probe(struct usb_interface *interface,
>                 vub300->read_only =
>                         (0x0010 & vub300->system_port_status.port_flags) ? 1 : 0;
>         } else {
> +               retval = -EINVAL;
>                 goto error5;
>         }
>         usb_set_intfdata(interface, vub300);
> --
> 2.42.0
>
