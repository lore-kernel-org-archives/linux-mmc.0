Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDAEC0018C
	for <linux-mmc@archiver.kernel.org>; Sun, 20 Dec 2020 02:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E96A22D6F
	for <linux-mmc@archiver.kernel.org>; Sun, 20 Dec 2020 02:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgLTCGD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 19 Dec 2020 21:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbgLTCGD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 19 Dec 2020 21:06:03 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CCEC0613CF;
        Sat, 19 Dec 2020 18:05:21 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id j13so4079099pjz.3;
        Sat, 19 Dec 2020 18:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8vAJhtcnlmR0zuqlLalCyJpLf4qWM/qYJIE1uR2kv+o=;
        b=lgJsdSHkqmPd+lGQpOuxo/BQACNoudnJUUT8uihKs5KlWVeAkWzu1SPoqXEdcOkRcp
         M8/jeh7IPRNlFOz47a/5vyyTUSBKQuVv1BVkGX8OU+e0x4nS4RCkCFp356zXIbquOyJ1
         kUG/FgxcvTm/rWzd5bohBc+dOP5JMqnj6Jziq3FWt95B3QJBR7n9QhTvQqrjSUiaRcyJ
         UGmPmIxao0b7VAsXrxMwoi0B//tKCRENHto02WttC+HDcn4j8ZikECh0eU/Ies6VnWfG
         fBcukb4h/tmnH7xVfTAXMb76pw7a1AH+rq914z5yGu7w8M1BtN5QBxsiSU5/LjPoOGhc
         smpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8vAJhtcnlmR0zuqlLalCyJpLf4qWM/qYJIE1uR2kv+o=;
        b=S3ZsPVM6V8B/8d4bs9J84XoUUI2F3J3Li5G5eHXqaSuos3vycgtSmDFVW5OmxxBLCo
         337n0+zpMC67vn8pATlrGcsfDwCBCNl1JrugjBrWYxMxq5DOxqSbGIcXZp8gAABl2yQP
         9FCdB8vF+4+pKipSEgVHQfWzFvRQVmEogPN3TwojqZnOCIkQMp9VnLWBLAT5ga+ri9oH
         2Ig9cdGI4kEHLRLExHnoYUXdzOqb+mHeDcuIG6z1a76koyBZAnr1HcdlbnnC9EuCZ4oM
         cuue3PP3YaVM/Yjh90PbVQcIWID3Hz+QvDGfqnR6yB0frz2tZrZn6b06m6xdE1ugKMdD
         UwqA==
X-Gm-Message-State: AOAM532C61A5nHd1p6QRSShzvMPPzx+aLt9faijPtCqxeYVrSyG6mLfW
        XmKjYZ3de0xfsWc4RveU0PqBvnT08ymFUaCMSgs=
X-Google-Smtp-Source: ABdhPJyF9aZl56KQrxBRg+MgfI6zjzpndBr8sunPbj3G0qErvkYhSIkwJ02z5edLdH1F4Oqy5VDfPrluGQmGrMXAy/I=
X-Received: by 2002:a17:902:7d84:b029:db:feae:425e with SMTP id
 a4-20020a1709027d84b02900dbfeae425emr10900360plm.43.1608429921087; Sat, 19
 Dec 2020 18:05:21 -0800 (PST)
MIME-Version: 1.0
References: <20201217204236.163446-1-christophe.jaillet@wanadoo.fr>
 <CA+H2tpGkv0sPQ2e6OfUVuW2xFx-KSpZy_vYY3TG_9JBWvFZxAA@mail.gmail.com> <83712f89-deb7-b266-8e8a-99f0df4c6782@wanadoo.fr>
In-Reply-To: <83712f89-deb7-b266-8e8a-99f0df4c6782@wanadoo.fr>
From:   Orson Zhai <orsonzhai@gmail.com>
Date:   Sun, 20 Dec 2020 10:05:09 +0800
Message-ID: <CA+H2tpHQvnmv_rCby0CUP3nnFXFg75fVEVQYRHJTW9Ebpfc7Gg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-sprd: Fix some resource leaks in the remove function
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>, linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, billows.wu@unisoc.com,
        Wu Hongtao <wuht06@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Dec 18, 2020 at 9:46 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 17/12/2020 =C3=A0 23:55, Orson Zhai a =C3=A9crit :
> > + cc: Billows
> >
> > Hi Christophe,
> > On Fri, Dec 18, 2020 at 4:50 AM Christophe JAILLET
> > <christophe.jaillet@wanadoo.fr> wrote:
> >>
> >> 'sdhci_remove_host()' and 'sdhci_pltfm_free()' should be used in place=
 of
> >> 'mmc_remove_host()' and 'mmc_free_host()'.
> >>
> >> This avoids some resource leaks, is more in line with the error handli=
ng
> >> path of the probe function, and is more consistent with other drivers.
> >>
> >> Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host c=
ontroller")
> >> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> >> ---
> >> Other adjustment may be needed.
> >> I'm not sure at all of the 0 passed to 'sdhci_remove_host()'. Some dri=
vers
> >> pass 0, some have some more complicated computation.
> >> ---
> >>   drivers/mmc/host/sdhci-sprd.c | 6 +++---
> >>   1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sp=
rd.c
> >> index f85171edabeb..5dc36efff47f 100644
> >> --- a/drivers/mmc/host/sdhci-sprd.c
> >> +++ b/drivers/mmc/host/sdhci-sprd.c
> >> @@ -708,14 +708,14 @@ static int sdhci_sprd_remove(struct platform_dev=
ice *pdev)
> >>   {
> >>          struct sdhci_host *host =3D platform_get_drvdata(pdev);
> >>          struct sdhci_sprd_host *sprd_host =3D TO_SPRD_HOST(host);
> >> -       struct mmc_host *mmc =3D host->mmc;
> >>
> >> -       mmc_remove_host(mmc);
> >> +       sdhci_remove_host(host, 0);
> >> +
> >>          clk_disable_unprepare(sprd_host->clk_sdio);
> >>          clk_disable_unprepare(sprd_host->clk_enable);
> >>          clk_disable_unprepare(sprd_host->clk_2x_enable);
> >>
> >> -       mmc_free_host(mmc);
> >> +       sdhci_pltfm_free(pdev);
> >
> > I saw a lot of drivers also use mmc_free_host().
> > Do you have patches elsewhere to clean them?
> >
>
> As far as I can see, all drivers that use 'mmc_free_host' also use
> 'mmc_alloc_host'. (based on 5.10.1 and unless error)
>
> The only exception is 'sdhci-sprd.c'.
>
> So no, I don't plan any other clean-up.
>
>
>
> To spot it, I run one of my own cocci script which compare functions
> called in the remove function and in the error handling path of the probe=
.
>
> So I caught this one because 'mmc_free_host' is used in the porbe and
> 'sdhci_pltfm_free' in the remove function.

Thanks for the clarification.

Acked-by: Orson Zhai <orson.zhai@gmail.com>

>
>
> CJ
>
> > Thanks,
> > -Orson
> >
> >>
> >>          return 0;
> >>   }
> >> --
> >> 2.27.0
> >>
> >
>
