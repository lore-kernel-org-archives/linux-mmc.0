Return-Path: <SRS0=3zNE=ZZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FB5C43215
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 03:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA8E206E1
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 03:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lKN3u5En"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfLCD31 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Dec 2019 22:29:27 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:32882 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfLCD31 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Dec 2019 22:29:27 -0500
Received: by mail-io1-f68.google.com with SMTP id j13so2102622ioe.0
        for <linux-mmc@vger.kernel.org>; Mon, 02 Dec 2019 19:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UNSfno6VFrbTsFANjh1vBJ325iU7RkJ8idTE8kI6UNQ=;
        b=lKN3u5Ene5duJFqZ/63tmJGFu6uDfBRCC07Apwe6KM3i0pfijX29AkEP4s6fHAbG3q
         kLV5fL9r4CWF012+k3Sw4x6LdpHyhsPCWEjLwdHw5fR52SgwBpI/pw8k/FuYd0zY1tZI
         z19L7klUyULf/YCAqE6jrdsHvhYN0DVKyLj5ip3mnOHDB0wyu9aCt6c+/ZMEjPeYgjp8
         D3CWah3rLLKFnzwOJzJJimzETPdrbC8URy0V4ielMDiisOSnKBSONCzTYWUmVj2Zhbg4
         92dw3+zFc8//4KbaAA5zX8Xj0ks0TJAD5R0Li33Ug3X5q+TiE7BvrPezawpQC6BWUMyq
         gI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UNSfno6VFrbTsFANjh1vBJ325iU7RkJ8idTE8kI6UNQ=;
        b=exKwsLtnMndvNnRXWSzOfOJCrdDlSmCzSvfRU6DCGH8EXYcKzOr4jabpRRBYM5hLfg
         BVww6I242v2xqoB1D5wBlE7AfBkzNNGbBZM9nq792TIMswyCqky+j6fC0e8CFHbqMbnr
         YDHqONHTFwACoJNUxQDdh3S19WriXV070uU5LG6SvVqrI0Z+dMd3jH7R1+dJD7Dp4qkg
         NyyyzpRz1/o80gmnAFqphJt7uFoNER63tM77+TVFG9wpG5tsWEllcB/qS+Cthy5+Z8dv
         JTdNisRpDKktbScyxuFdbcgb9NRygmkCBhBmr0K3CPsg8U7h2I1IC96FlF5BAv8qQ6M2
         lpjA==
X-Gm-Message-State: APjAAAV6WwWKUvQ4/OUNpjJ+MIVxw/dZxRfyau5sMWqKk3LykL0UWeGc
        0Meug0fnekkLxLBte5733UJ08ReICYq0pXPhQwT4xw==
X-Google-Smtp-Source: APXvYqy2awg7tHK9P2F4vt99kydTVF5qCMDGh9SfmjzA2/zWBd6ZFwOECjBhTanXY7Aw8Nmiuc7TQT+s2CdsMqXSFFg=
X-Received: by 2002:a6b:8bd5:: with SMTP id n204mr779004iod.1.1575343766548;
 Mon, 02 Dec 2019 19:29:26 -0800 (PST)
MIME-Version: 1.0
References: <20191202144104.5069-1-jun.nie@linaro.org> <20191202144104.5069-5-jun.nie@linaro.org>
 <20191202175202.GA6488@infradead.org>
In-Reply-To: <20191202175202.GA6488@infradead.org>
From:   Jun Nie <jun.nie@linaro.org>
Date:   Tue, 3 Dec 2019 11:29:15 +0800
Message-ID: <CABymUCM09L3TfLsPhLWPkoYXJ6OVGhHvd9_o4FCO07_Z3Y6A8w@mail.gmail.com>
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
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=881:52=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Dec 02, 2019 at 10:41:04PM +0800, Jun Nie wrote:
> > DMA memory cannot cross specific boundary for some SDHCI controller,
> > such as DesignWare SDHCI controller. Add DMA memory boundary dt
> > property and workaround the limitation.
>
> If you use blk_queue_segment_boundary to tell the block layer the
> segment boundary restrictions it won't ever send you segments
> that don't fit.  With just the workaround in this patch you'll run into
> max_segments accounting issues, don't you?

Thanks for the reminder! So I need to parse the segment_boundary from
device tree and use below code to set it, right?
For the max_segments accounting error, I did not see it so far though I
believe it is true in theory. Maybe it is due to segment boundary value is
very large.

+++ b/drivers/mmc/core/queue.c
@@ -374,6 +374,7 @@ static void mmc_setup_queue(struct mmc_queue *mq,
struct mmc_card *card)
                WARN(!blk_queue_can_use_dma_map_merging(mq->queue,
                                                        mmc_dev(host)),
                     "merging was advertised but not possible");
+       blk_queue_segment_boundary(mq->queue, mmc->segment_boundary);
        blk_queue_max_segments(mq->queue, mmc_get_max_segments(host));
