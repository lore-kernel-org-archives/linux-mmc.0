Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5E9C433FE
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Nov 2022 20:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbiKGUOK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Nov 2022 15:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbiKGUN5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Nov 2022 15:13:57 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BBD29CB5
        for <linux-mmc@vger.kernel.org>; Mon,  7 Nov 2022 12:13:48 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso11307069pjc.5
        for <linux-mmc@vger.kernel.org>; Mon, 07 Nov 2022 12:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yBX7bP/gwxEljJXsETpLzrWEKb+h/tZlh4zFSZMZ+JM=;
        b=EaWLlRUfN99T1tpwYDtLn1udAavbXE3Ox/meorFJyzbYEI6uv5Q3iBRCLH4MC0ouvR
         OyuXiU8XhXJrR8VDe6WSoWhMKO3Vudqp2S2gFTV73n6OP3HpAEMwbU7uJftI9fbN3RI3
         1kGihthIWlgyCjVRCFI4W6m2MADND+w66zQAgcUU7caxuSQrI8hfv3fqjkWANZaffiJ4
         ytVdUEpG9TRt7hbTly4BZiTSX3DCheF/VRlZ+T/SXUxF7QnaGFNyL1p+/Bl8e/YT/cp2
         sn/BgMK9ZXQ+OBA8rXPytijbMa2ZGtAVReWOdlni2ivXG2IsP652Q0DbWyLAYEdX0Ais
         W7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yBX7bP/gwxEljJXsETpLzrWEKb+h/tZlh4zFSZMZ+JM=;
        b=iyg6x+jX7GmoZe4FoCagS0RRkM1GTtNDYNf0qmPDiYUN0CA+DdM4WwhEsYEb6tCO2T
         VJSUJUrhMRHz6B1Nl8cB264l/yl80o+ba2c0VynBwuh9c2ErDVSwdmhw7AQX2SIfp1q7
         aYuk4tNW9WAUo23pLbsmjIzfCcn7zU1wJ4XvLU4iyTtTwwSx6elWBpX3+d63SdIfr5e+
         r31U2qWbPJiR8/ns8MgMIjHGkvpfnExtmOc+Y+6cODkHUaOayGVk8tIxaVJiyaS0e9az
         08AxVNyWUZ5jz3QKRSSShn7QjVrdK/s8B44VdAfWce5JyMaob/Rx3seQ7wslfyU/O1S1
         9IpA==
X-Gm-Message-State: ACrzQf0gYaex2Uz7tVEjDIKJRp7L9GFQdJ6XnJ2uWJzJPFoJey7rbbpw
        diW1URZe0MHL8+xXWwYBxkkGduY8I4vnokSj28pj/UT7TjY=
X-Google-Smtp-Source: AMsMyM68Scjlv1d33YvplbBEG04Ll6paEM/4IYsDTKIsyW2w8AjsJkizX7m5+A/n3VE4oIgJ+FwK37z0+ldsvRXaRQY=
X-Received: by 2002:a17:903:100c:b0:186:63a1:3b5d with SMTP id
 a12-20020a170903100c00b0018663a13b5dmr53387571plb.148.1667852028404; Mon, 07
 Nov 2022 12:13:48 -0800 (PST)
MIME-Version: 1.0
References: <20221101105242.2019036-1-matthias.schiffer@ew.tq-group.com>
In-Reply-To: <20221101105242.2019036-1-matthias.schiffer@ew.tq-group.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Nov 2022 21:13:11 +0100
Message-ID: <CAPDyKFoknFVzuF=uuR+NccPa3KjwjeEkkaYM6BA0UQya1BkQFg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci_am654: Use dev_err_probe() for mmc_of_parse()
 return code
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 1 Nov 2022 at 11:53, Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:
>
> Checking phandle references like mmc-pwrseq can result in -EPROBE_DEFER.
>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci_am654.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 8f1023480e12..4e17efa8ab97 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -835,7 +835,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>
>         ret = mmc_of_parse(host->mmc);
>         if (ret) {
> -               dev_err(dev, "parsing dt failed (%d)\n", ret);
> +               dev_err_probe(dev, ret, "parsing dt failed\n");
>                 goto pm_runtime_put;
>         }
>
> --
> 2.25.1
>
