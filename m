Return-Path: <SRS0=1974=Z2=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241B6C47409
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Dec 2019 06:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E2D12081B
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Dec 2019 06:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sLiSre6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbfLDGAY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Dec 2019 01:00:24 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:42606 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfLDGAY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Dec 2019 01:00:24 -0500
Received: by mail-il1-f196.google.com with SMTP id f6so5582597ilh.9
        for <linux-mmc@vger.kernel.org>; Tue, 03 Dec 2019 22:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VdV6rCozgHYZC1UpVIIfAR60tQ/+k5Yb502oXvuDz3s=;
        b=sLiSre6x3ZGPGJEwfJi37mQMNCDlG8fNqJ4SC0nPSpVXUMgQOgDyKP60YVuZcVrviO
         S1ZaCo2bSZY+tdpp3M1Nw9hEK1JNqVa/wTbTgzT8IGFPkTKlIrArH4Zsq/j9BVOKdVtx
         /q4BployNyl+zOqvBmxb36qHJOuRSPdoxzwujtgx0LatEgeSLSaqwxWcc3pdtgGxAGll
         4N5jP+2ohs1DDJVP3W0PCG/lLfge1jF0qf3FA8JJM5A8HkpT+fFAvljAiNShcU1+xPrB
         eOSIinX7d/LZcDWDWuuntUcDxXVm6bu2E7y3rdovcWJrghsESri92nhcLtym1xR9WFOc
         MWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VdV6rCozgHYZC1UpVIIfAR60tQ/+k5Yb502oXvuDz3s=;
        b=ga4PLTKEfdlijAdmglteryjpacnHo3Eug9+VRcD8dhCSqI9zlVrmIpCsHCTaMWnswt
         YaxgQuoFxNwsxfLrzoM8pS54B/cDekk5ZOtGk6wRxDUBo30DLAqoVzwqejTDkRvJXMw9
         4Km2htfJhGgEr3wNcut0aMyPxul8l9Ki4+ffRJjl2EUAVSbDlQsUuy9+YDd3qooXsicb
         ti1pMAbu1kZZUAEMebHtYBvhVpyDZ/4w4gZLCYzs10yHX5bCH0tjB/h1fsOGjZYjxT4h
         7G1n/OEmbZtxeNfxPAsAGq//BapLpgffzaGOWPVIjNsgcfYknwoP9JigecbS7EXtwzum
         IoWw==
X-Gm-Message-State: APjAAAXrs9ToKx9lB0g/yxNAxWQ3WIPSvTUHiuRU8YxTc2x1O8wfMbCz
        6rGqJENpQrqRhfmGv0gNfPerDSyYF/YKNbWAlk/saw==
X-Google-Smtp-Source: APXvYqwxAn017aiVFDpMhAlXk+WZOqTquu3v1T0UEfmGothdcpPH6MdJ2S0McNjPU5fcYDDUrHZeSaRbP4kyc7RuuFM=
X-Received: by 2002:a92:a30d:: with SMTP id a13mr1965620ili.186.1575439223157;
 Tue, 03 Dec 2019 22:00:23 -0800 (PST)
MIME-Version: 1.0
References: <20191202144104.5069-1-jun.nie@linaro.org> <20191202144104.5069-5-jun.nie@linaro.org>
 <20191202175202.GA6488@infradead.org> <CABymUCM09L3TfLsPhLWPkoYXJ6OVGhHvd9_o4FCO07_Z3Y6A8w@mail.gmail.com>
 <20191203073620.GA360@infradead.org>
In-Reply-To: <20191203073620.GA360@infradead.org>
From:   Jun Nie <jun.nie@linaro.org>
Date:   Wed, 4 Dec 2019 14:00:08 +0800
Message-ID: <CABymUCNHMKvVCkKdwnOcDZC9rNhLTEHLfLoH_O+CEf9XuZY+_A@mail.gmail.com>
Subject: Re: [PATCH 4/4] mmc: sdhci: Add DMA memory boundary workaround
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, adrian.hunter@intel.com,
        linux-mmc <linux-mmc@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Christoph Hellwig <hch@infradead.org> =E4=BA=8E2019=E5=B9=B412=E6=9C=883=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=883:36=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Dec 03, 2019 at 11:29:15AM +0800, Jun Nie wrote:
> > Thanks for the reminder! So I need to parse the segment_boundary from
> > device tree and use below code to set it, right?
> > For the max_segments accounting error, I did not see it so far though I
> > believe it is true in theory. Maybe it is due to segment boundary value=
 is
> > very large.
> >
> > +++ b/drivers/mmc/core/queue.c
> > @@ -374,6 +374,7 @@ static void mmc_setup_queue(struct mmc_queue *mq,
> > struct mmc_card *card)
> >                 WARN(!blk_queue_can_use_dma_map_merging(mq->queue,
> >                                                         mmc_dev(host)),
> >                      "merging was advertised but not possible");
> > +       blk_queue_segment_boundary(mq->queue, mmc->segment_boundary);
> >         blk_queue_max_segments(mq->queue, mmc_get_max_segments(host));
>
> Yes, I think should do it.  Maybe modulo a check if the low-level
> driver actually sets a segment boundary.

For the block device, such as SD card, it is right solution. But I
have concern on SDIO case. Maybe we should add workaround together
with block layer segment boundary restriction. How do you think about
it?

Jun
