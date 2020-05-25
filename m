Return-Path: <SRS0=RjyY=7H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64C0C433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 25 May 2020 06:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDB4A2071A
	for <linux-mmc@archiver.kernel.org>; Mon, 25 May 2020 06:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="oH0jGp/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbgEYGOi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 May 2020 02:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbgEYGOh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 May 2020 02:14:37 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6348FC061A0E;
        Sun, 24 May 2020 23:14:37 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id k5so19435094lji.11;
        Sun, 24 May 2020 23:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xxPp1YhKBxMDmxPDlgA3r6L4BPVtYqrACCbiDdkf2HU=;
        b=oH0jGp/2CUEdGLq6EDmu5s+PiAb/IDEiXKtMl/yTpb3Y3fg51+Iq4kgQCw95Q9cV6e
         DTYwCy/OywCcfPMYn5cyMejV3EqYTyRuZhqXotrPwKh3AWq/xRhhzrrRgwdJBeITWTHp
         spvmnFufI/vuLUzULK9+q3fPphWeh6BPVRV0qBbZaUn1BZxFRO+aUi/Za0m/FqFKkQma
         v379pALdXZRKuwU3JFSw2RZVsKj0VyGXKElz5a+wMKXOfo1gARzxdVps067fQh/WdOhG
         WXSshs0r4TkX8K7MBUeYGLKpvju5PvJJmcIFKpd8DKvuZLs6dAsjuINXeFIyMnVM0Mfa
         5iYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xxPp1YhKBxMDmxPDlgA3r6L4BPVtYqrACCbiDdkf2HU=;
        b=PIdWB5zCeMhDwqcimL4YVAX7KmkC4oncnZKcadKKrsDFr0dyCccTCxmj5yBMYLZYVl
         N2T+2/Nb7MxCFQKwhD8+22+u5b6JouRQqorch0Pu1e9Z91wIGKHpaHK5PDkJZftHlkqy
         746G/NpiN8wjECzmNceIRe5URMvkregozzcVU86FIuSJA7pR006AC9gfbLtaPQ75T0nq
         6w+FFC7Vhb1EfT9AQcdJ6Mi7YO2gMAbD5qdhiIc0DcLP1vK+Sq8ElpuP06H7/7dmPLOK
         ZpRPyePNRcCnqBh8+prF8KVmHC+KIBhlDDbWV16geaQGxbIImZuj5qYqf1sgyW1F309H
         u+2g==
X-Gm-Message-State: AOAM530fL3p2RMVAR5kINSEMu7xraBHX/A3Y6h43oiscts5jAzgomM+Z
        aJapJNWyigZhFnZO0jJysBD5wqSNoPVSp4VuOdc=
X-Google-Smtp-Source: ABdhPJzaVD3W8XB8LNxW925jXvFBvaW8onNuO96IUdcvivMzSYciGrsBcQqGjF7n+6WXCtsIuyKlXvmMkqyksGWw2uM=
X-Received: by 2002:a2e:d1a:: with SMTP id 26mr13109692ljn.160.1590387275853;
 Sun, 24 May 2020 23:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200517222907.1277787-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20200517222907.1277787-1-martin.blumenstingl@googlemail.com>
From:   Thomas Graichen <thomas.graichen@googlemail.com>
Date:   Mon, 25 May 2020 08:14:24 +0200
Message-ID: <CAOUEw11pirqhOHTjO_xHnZpnSgKNuJk5ysh43B7jWJokuGPB2A@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: host: meson-mx-sdhc: fix manual RX FIFO flushing
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, May 18, 2020 at 12:29 AM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> For Meson8 and Meson8b SoCs the vendor driver follows the following
> pattern:
> - for eMMC and SD cards in .set_pdma it sets:
>   pdma->rxfifo_manual_flush = 1;
> - for SDIO cards in .set_pdma it sets:
>   pdma->rxfifo_manual_flush = 0;
> - before syncing the DMA read buffer is sets:
>   pdma->rxfifo_manual_flush |= 0x02;
>
> Set the second bit of MESON_SDHC_PDMA_RXFIFO_MANUAL_FLUSH without
> clearing the first bit before syncing the DMA read buffer. This fixes a
> problem where Meson8 and Meson8b SoCs would read random garbage from SD
> cards. It is not clear why it worked for eMMC cards. This manifested in
> the following errors when plugging in an SD card:
>   unrecognised SCR structure version <random number>
>
> Fixes: 53ded1b676d199 ("mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host")
> Cc: Thomas Graichen <thomas.graichen@gmail.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Tested-by: thomas graichen <thomas.graichen@gmail.com>

BEFORE: on my meson8 based mxiii i got the above error and the sd card
was not useable

AFTER: no more error and sd cards works fine

> ---
>  drivers/mmc/host/meson-mx-sdhc.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-mx-sdhc.c b/drivers/mmc/host/meson-mx-sdhc.c
> index 5c00958d7754..53e3f6a4245a 100644
> --- a/drivers/mmc/host/meson-mx-sdhc.c
> +++ b/drivers/mmc/host/meson-mx-sdhc.c
> @@ -586,10 +586,17 @@ static irqreturn_t meson_mx_sdhc_irq_thread(int irq, void *irq_data)
>                     cmd->data->flags & MMC_DATA_READ) {
>                         meson_mx_sdhc_wait_cmd_ready(host->mmc);
>
> +                       /*
> +                        * If MESON_SDHC_PDMA_RXFIFO_MANUAL_FLUSH was
> +                        * previously 0x1 then it has to be set to 0x3. If it
> +                        * was 0x0 before then it has to be set to 0x2. Without
> +                        * this reading SD cards sometimes transfers garbage,
> +                        * which results in cards not being detected due to:
> +                        *   unrecognised SCR structure version <random number>
> +                        */
>                         val = FIELD_PREP(MESON_SDHC_PDMA_RXFIFO_MANUAL_FLUSH,
>                                          2);
> -                       regmap_update_bits(host->regmap, MESON_SDHC_PDMA,
> -                                          MESON_SDHC_PDMA_RXFIFO_MANUAL_FLUSH,
> +                       regmap_update_bits(host->regmap, MESON_SDHC_PDMA, val,
>                                            val);
>                 }
>
> --
> 2.26.2
>
