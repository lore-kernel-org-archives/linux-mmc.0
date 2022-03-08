Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21B6C433EF
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Mar 2022 13:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbiCHNiH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Mar 2022 08:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347172AbiCHNhz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Mar 2022 08:37:55 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F086C48E78
        for <linux-mmc@vger.kernel.org>; Tue,  8 Mar 2022 05:36:57 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id w27so32278102lfa.5
        for <linux-mmc@vger.kernel.org>; Tue, 08 Mar 2022 05:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iYBVyOw/jQFGIr6GyFmmUL1KjMeFXQPX2EGW015MmY8=;
        b=XEJKHgW+qOM9hCTAxVOsEciI9wGIDg/n2/0NwnRFHY/AvPWXNtqow+SKVqr/L3UYQB
         5LCHnu0y/cBxqFX4Q9xygJRMI1qhWkCucvcUQLYFf4ZIYc1x4v5MtdiZiURsKvRwKp0u
         WBxEke5AQ1sjdbz1Kg9Vvu8DLK/PXkaVZsjotNOYz2zvt7nBC5qB5fik4bWRMkw+waoF
         r+spnuNgehJXE8qnmxWmYYKbLIoSkAA3H7bxIuzsWzHAAe7SI4m8mMzaP1qsvAeCkk2T
         4NI3Kdx0mMN0SKr2hvqlIik3LPHu9tCQwsVe/yZSJD3UnKFGtyYTdxkrE8341CRxg7Hl
         xOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iYBVyOw/jQFGIr6GyFmmUL1KjMeFXQPX2EGW015MmY8=;
        b=wQg0iU/SaEuBZumT6Ul1FscvKqlcsy/q/eLp8X/ypEateXkduT6lOBjRAfrtsN3sOf
         DJl2fMZFjVGCcwreYOCgqJELArsUZweaCwCsOi/I0gGcuKdf0l1G3U+ygz6bcrhEZ/1/
         zf9zUor+wtrrtw5bAz/X9jI4VBD5LzxeVa9SqA1QWUbdD5YloNPwzdPEGrjFGdqCDgT2
         QwMJzkhoJa9cb4DUoyyv6fnnX9Beoj8+8QZ99jFYQGuwuHTHEK5/aE/kaBFjCTHH7HV9
         XmhI+Uhi/+O9RHc0P2H8v7ALy7eBlnGA4TlqvTMTzMOrKe2UALRMzaocvX+cbt7CTAne
         B+hA==
X-Gm-Message-State: AOAM531MnjpPJcm2oTA2yZne5HX+UJox8AzdzP/i1mi5JbylNT6CGIID
        R1Jf1NkVNcCSFHSwmDBjl8+LXLcqR2y/UhVUqBWbog==
X-Google-Smtp-Source: ABdhPJyaBZXPpHXunr37L3bMLyy0YhR1BIKiVTwgDDKe5fvRDAjPt+D0FS9J/HXwRCPXeCEZQBp0IXJ+JUNhUVcU3sM=
X-Received: by 2002:a05:6512:308e:b0:448:3826:6d68 with SMTP id
 z14-20020a056512308e00b0044838266d68mr3948099lfd.184.1646746616253; Tue, 08
 Mar 2022 05:36:56 -0800 (PST)
MIME-Version: 1.0
References: <bf2e2e69226b20d173cce66287f59488fd47474b.1646588375.git.christophe.jaillet@wanadoo.fr>
 <20220308125445.GE3293@kadam>
In-Reply-To: <20220308125445.GE3293@kadam>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Mar 2022 14:36:19 +0100
Message-ID: <CAPDyKFpdghX5je_Dvy+aam3zmbJpArFocrqURK1LVCZNwAvVSA@mail.gmail.com>
Subject: Re: [PATCH] mmc: wmt-sdmmc: Fix an error handling path in wmt_mci_probe()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 8 Mar 2022 at 13:55, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Sun, Mar 06, 2022 at 06:44:56PM +0100, Christophe JAILLET wrote:
> > A dma_free_coherent() call is missing in the error handling path of the
> > probe, as already done in the remove function.
> >
> > Fixes: 3a96dff0f828 ("mmc: SD/MMC Host Controller for Wondermedia WM8505/WM8650")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > I've not been able to find a Fixes tag because of the renaming of
> > function and files.
> > However, it looks old (before 2008)
>
> You did add a fixes tag and it's from 2012.  :P
>
> > ---
> >  drivers/mmc/host/wmt-sdmmc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
> > index 163ac9df8cca..8e18f01c0938 100644
> > --- a/drivers/mmc/host/wmt-sdmmc.c
> > +++ b/drivers/mmc/host/wmt-sdmmc.c
> > @@ -863,6 +863,8 @@ static int wmt_mci_probe(struct platform_device *pdev)
> >       return 0;
> >  fail6:
> >       clk_put(priv->clk_sdmmc);
> > +     dma_free_coherent(&pdev->dev, mmc->max_blk_count * 16,
> > +                       priv->dma_desc_buffer, priv->dma_desc_device_addr);
> >  fail5:
> >       free_irq(dma_irq, priv);
>
> This isn't quite right.  If of_clk_get() fails it should call
> dma_free_coherent() but it does not.  You need to add:
>
>  fail6:
>         clk_put(priv->clk_sdmmc);
> +fail5_and_a_half:
> +       dma_free_coherent(&pdev->dev, mmc->max_blk_count * 16,
> +                         priv->dma_desc_buffer, priv->dma_desc_device_addr);
>  fail5:
>         free_irq(dma_irq, priv);
>
> regards,
> dan carpenter

Thanks Dan for reviewing, I have dropped the $subject patch from my next branch.

Kind regards
Uffe
