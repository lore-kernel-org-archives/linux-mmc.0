Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3125C07E95
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Jul 2021 02:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D95F61374
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Jul 2021 02:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237439AbhGNCSL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Jul 2021 22:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237409AbhGNCSL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jul 2021 22:18:11 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DCEC0613DD;
        Tue, 13 Jul 2021 19:15:20 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id w13so852543qtc.0;
        Tue, 13 Jul 2021 19:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ihUz2ub3dK3zageyv2Hu+IeY9LSRCwULU5UjPrUxU5E=;
        b=k6LsXReISAP/dzPe3s/81fdm6FGDdft8OfrDMiFhY5bgJ9YDC0wOJGUNl0c3qB+U0b
         xBwuN/n2yWHakqYZGbowTRV6/+MsP0DXb926LcN2TvJwAGcPvRDKX1XRXesDXnANTfhL
         TGeVGCOFi1hoWzVIaioD4c6MN76ybEvf+n+P+Opteg7A4UgRZLbXS2hYs6aE7qjE1gnR
         g/sNmfp+jA9xMtN8MF+A8PM/C7WAVbcpGtUTl/AN7NW33D7bqkxLDPKNfUtRJ9SLl/jb
         a12uF+Vol6wv9HN2ErflDbbCSfKLPX12NAvkCLm6+p6atHQTVTDCigsS8oD9LKzGoe1B
         T0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ihUz2ub3dK3zageyv2Hu+IeY9LSRCwULU5UjPrUxU5E=;
        b=IVGeqa1htSrXIeQPQVIu4sLH6HfUqiD2sSFGw4kCzU98iYrr5+YoM0OAXLpGSVpvYc
         N4DgIN9SmAk/jlsTSjiEz0YGFdQpe4mLL84CgsNT+mPPFV8JSdEcDiEdBX501GXwI90z
         QWahVysxFxkidc3WxosfYGurDzufXzGYHCTvajnfvveix1bFuCCyHjv8NXe7n5dZXVhK
         p2HdduDET54MDGAq+L9d0/lfHZqSgTJLn4/NbLc3EM/rGzTnjSld8KS4cfz2iy20eZbM
         KSJh4YTAATkDpkxkEN5h0s05j/hn5r91o5WF/BDo554xYYeAcy/AGnL1A75u48lXFME4
         p9rA==
X-Gm-Message-State: AOAM533DKuOlyvSdsfd8BGMiXTSsNZnM+YFxk050fKCW2sNQUGVvngBZ
        i6JxE8cg7eqqe5Q1Ui4fykl/QAACPRxSUg5RWVk=
X-Google-Smtp-Source: ABdhPJzHgode6yZ7b6qJjH7wITPjRVWeZnZ14AG5ycpzEdjguBpPDh2cFWVhu1JG6WMhiIl7EZMf1a1hhYnnJKMJCCY=
X-Received: by 2002:ac8:5401:: with SMTP id b1mr7027141qtq.112.1626228919907;
 Tue, 13 Jul 2021 19:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210705090050.15077-1-reniuschengl@gmail.com>
 <CAPDyKFotmw-HQpZKCOD_8kThEa0_KSPnn36FNFLKRyUHYRHQjQ@mail.gmail.com>
 <CAJU4x8u8JPBJ3V6MCi1XcO4Qim-COPuxOhTdUnor7JdNCUFb=w@mail.gmail.com>
 <CAPDyKFqXsn91BvkJXMYSnc7X=RP9DXxXp2nKMmv+aMPoNdK2Tw@mail.gmail.com>
 <CAJU4x8srB7skGFVcj1SPrzEZSnVkwKiW3OPN0GQxvgtRG7GAAQ@mail.gmail.com>
 <CAPDyKFq0yHxX7wb4XGeiMiSGGiOf8RKJ5ahhFQ+_vodqnyPV9Q@mail.gmail.com>
 <CAJU4x8uGxb5VD1WVV5-QeLkVzuuR09-NacL-9nuXe8Zofzb2=w@mail.gmail.com>
 <CAPDyKFpvCFYQVEp77hiRHY6CVDej-ffF5UE=LH=HSGcqMZA02w@mail.gmail.com>
 <CAJU4x8t+aOqq82EJMUNDpWiE3GPeyZkjFhy=AkmctcDE3mx6fA@mail.gmail.com>
 <CAPDyKFoSOk+4pmW60uGzKaYw3XOXshx+NSNqF_po=VLkK1-7Qw@mail.gmail.com> <CAJU4x8sMJSOnfBwDq7tVygRGFRw-SyrM1z8GBsF_Mur64-Y3_g@mail.gmail.com>
In-Reply-To: <CAJU4x8sMJSOnfBwDq7tVygRGFRw-SyrM1z8GBsF_Mur64-Y3_g@mail.gmail.com>
From:   Renius Chen <reniuschengl@gmail.com>
Date:   Wed, 14 Jul 2021 10:15:08 +0800
Message-ID: <CAJU4x8uCAQoozeAqa6icVba61uo_eP+NtOxgnLzsXh6g2HeQdA@mail.gmail.com>
Subject: Re: [PATCH] [v2] mmc: sdhci-pci-gli: Improve Random 4K Read
 Performance of GL9763E
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <Ben.Chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrain,

What do you think of this patch?
Or do you have any ideas or suggestions about the modification for
Ulf's comments?

Thank you.


Best regards,

Renius

Renius Chen <reniuschengl@gmail.com> =E6=96=BC 2021=E5=B9=B47=E6=9C=887=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:49=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Ulf Hansson <ulf.hansson@linaro.org> =E6=96=BC 2021=E5=B9=B47=E6=9C=887=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=888:16=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > [...]
> >
> > >
> > > Thanks, I understand what you mean.
> > >
> > > I simply searched for the keyword "MMC_READ_MULTIPLE_BLOCK" in the
> > > drivers/mmc/host folder, and found that in some SD/MMC host controlle=
r
> > > driver codes such as alcor.c, cavium.c, ...etc, there are also
> > > behaviors for monitoring the request in their driver. What's the
> > > difference between theirs and ours?
> >
> > Those checks are there to allow the HWs to be supported properly.
> >
> > >
> > > And if the code that monitors the requstes does not belong the driver=
,
> > > where should I implement the code and how to add some functions only
> > > for GL9763e in that place, in your opinion?
> >
> > Honestly, I am not sure what suits your use case best.
> >
> > So far we have used runtime PM with a default auto suspend timeout, in
> > combination with dev PM Qos. In other words, run as fast as possible
> > to complete the requests in the queue then go back to idle and enter a
> > low power state. Clearly, that seems not to be sufficient for your use
> > case, sorry.
> >
> Yes, the runtime PM, auto suspend, and PM Qos are all about the
> suspend/resume behaviors of the system or related to power states such
> as D0/D3 of the device. But these are totally different from the ASPM
> L0s/L1 for link states. Entering/exiting the ASPM is pure hardware
> behavior on the link layer and is not handled by any codes in
> drivers/mmc/core or drivers/mmc/host. We'd like to try to modify the
> patch by your opinions, but we are also confused about what or where
> suits our use case best. So we wonder how to start the modification
> and may need some suggestions to deal with the work, sorry.
>
> Thank you.
>
>
> Best regards,
>
> Renius
>
>
> > Kind regards
> > Uffe
