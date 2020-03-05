Return-Path: <SRS0=i1XN=4W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD14C3F2D1
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Mar 2020 01:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FC52084E
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Mar 2020 01:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTLQWIpE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgCEBRA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Mar 2020 20:17:00 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35779 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgCEBRA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Mar 2020 20:17:00 -0500
Received: by mail-qt1-f193.google.com with SMTP id v15so2970479qto.2;
        Wed, 04 Mar 2020 17:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sY0CZ7bX/TvtEb9RG2ruFM/a3w224Wrlm/HI6Fy2x74=;
        b=eTLQWIpESCoR79GrNvW8NEfd8vIXr0eNjaxVx0zZ7YASgAocojIA8LvWOU7hxumFzR
         dLdRCzMlOyJcEPSq9OS9B2sv/YfjplxgkalhsgEF6mfxxWDcsoboywcnL2OSI4ggeqTL
         v61AWrZnlgyDkmNPV//HfvhcA6RGLmQ9OI8vgDV+Hbvcwn/TKuRS1FF3qsV/KCluUgv8
         KrGLVEWZ7YthqYk+lAEo7x5mCrbkdA2mczV9b1XUvjyMBDEhq7fnqnaLr3HY/ZME8wns
         /4LEu77oeseLpj3QGsxAPsDY2V71J4RULKy9CvIXtYB4WTe4ULhQAbDS8H0nERulRUwO
         w1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sY0CZ7bX/TvtEb9RG2ruFM/a3w224Wrlm/HI6Fy2x74=;
        b=Dm/OUia3XBxapjxt5GcXh9Njrh/iBEIOV03zb6k4YlkTZZ18JgPYtyuTzvIkdZCrHP
         p5kgO5LOABjOfF+aotGS4e2v24h5EhgH4Dd1uDHnk5dot5XtLwQSx86/rAB9VNyQLWyG
         Ixs8KsrHw2NpSsLYjLjvdUArkjJ4PsyrJP1We9OU4hwhYH6Bobej1KzAjGCCp5Qbzv8P
         hxCKi0owJ4CeqTHHE34BNHB1FLucuJF/UUmYI3eu53VRQVkhRXGKqIgywPPiX5NyFUk0
         AtP9W4n5crDvnnSl8FFpxlBs5pFOa5XCs4XmAw3yJzUyiHEUeVlTdRZdfySdSMMpstFt
         ADrw==
X-Gm-Message-State: ANhLgQ1Dd6LyrSdO409YBh2kxiU8AeLlRv9qL/X/YZlmyloVpKs5Atj8
        r1BS7kLfUb6xNdrizbUrdzanN8+22piC2XEYsQw=
X-Google-Smtp-Source: ADFU+vvfF0/xAGkvLfcIvu9gK8RLKIfUhlZE47c1kGBg/aU8scWgsn6UFI1E82WDmMA1BrfXEygIbNEzNVaWON3MwMs=
X-Received: by 2002:ac8:7cb0:: with SMTP id z16mr510747qtv.276.1583371019304;
 Wed, 04 Mar 2020 17:16:59 -0800 (PST)
MIME-Version: 1.0
References: <96f16647f6a6e8cb058c44e46c61b122df027059.1582535202.git.baolin.wang7@gmail.com>
 <CAPDyKFr+BRhCQd70L8hMTtq8hfq8N-Z5+PAEmJhPy-rtuP3jMA@mail.gmail.com>
In-Reply-To: <CAPDyKFr+BRhCQd70L8hMTtq8hfq8N-Z5+PAEmJhPy-rtuP3jMA@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Thu, 5 Mar 2020 09:16:47 +0800
Message-ID: <CADBw62otZT3WPhA0r-tdEoRtoH_SYE1QaYwFc9EUsNXK-YJCVg@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: sdhci-sprd: Set the missing
 MMC_CAP_WAIT_WHILE_BUSY flag
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

On Wed, Mar 4, 2020 at 11:35 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 24 Feb 2020 at 10:09, Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > The Spreadtrum host controller supports HW busy detection for I/O
> > operations, which means when the host gets a transfer complete event,
>
> I assume HW busy detection also works for R1B commands, so I am adding
> that information to changelog to clarify this.
>
> Please have a look at the next branch to see that it looks good to you.

Looks good to me. Thanks for your help.

>
> > that always indicates the busy signal is released. Thus we can set
> > the MMC_CAP_WAIT_WHILE_BUSY flag to remove some redundant software
> > busy polling.
> >
> > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
>
> So, applied for next, thanks!
>
> Kind regards
> Uffe
>
>
> > ---
> >  drivers/mmc/host/sdhci-sprd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> > index d346223..2ab42c5 100644
> > --- a/drivers/mmc/host/sdhci-sprd.c
> > +++ b/drivers/mmc/host/sdhci-sprd.c
> > @@ -556,7 +556,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
> >                 sdhci_sprd_voltage_switch;
> >
> >         host->mmc->caps = MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
> > -               MMC_CAP_ERASE | MMC_CAP_CMD23;
> > +               MMC_CAP_ERASE | MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY;
> >         ret = mmc_of_parse(host->mmc);
> >         if (ret)
> >                 goto pltfm_free;
> > --
> > 1.9.1
> >



-- 
Baolin Wang
