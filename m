Return-Path: <SRS0=tDgF=37=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE54C3B187
	for <linux-mmc@archiver.kernel.org>; Tue, 11 Feb 2020 12:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E0D20675
	for <linux-mmc@archiver.kernel.org>; Tue, 11 Feb 2020 12:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccP7FtOi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgBKMwB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:52:01 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:46782 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgBKMwB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Feb 2020 07:52:01 -0500
Received: by mail-qv1-f66.google.com with SMTP id y2so4878871qvu.13;
        Tue, 11 Feb 2020 04:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=msU5D8ZEdFDxxqo3nG1mhJAEftZgJdXHg5DB8i9r690=;
        b=ccP7FtOinfozM6R4vDJjCau6Npe4Tmqbkt8xc6j/l11pnNzuBm6vI5fsmdieL/ssPx
         5d1ujsopUtmxY6FwQTj2bb6gY5H0LwU+T5AwI4TgaMsbfHI/lfKm2EDAeg9E8lMCa0y7
         fRE2U1e8JQtiHHh7pYrOpk1lPZiAuoYhTxvXyoKUmZO4V9KFGJZViITCvqzc2z5F1xxM
         WMB23So0V3C1qOmHSwSuAUCUsTqrDPiDHP9lHB9DSNOF1ljTVmViEgkynESAdWxnq5PP
         +JlxFV/lo9K39OYXk314wrESa58rnFNKCm/PdSHxRnGdlZF3fOxkGX0oZqVW6AwR0oSq
         8gzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=msU5D8ZEdFDxxqo3nG1mhJAEftZgJdXHg5DB8i9r690=;
        b=sjZ0G/+YaBa6SQeV+NmwxO4H7sZgTSf59BLDrnzTtlnkEXAZIl+3qTLBzylJnt4ANW
         LIC225f22RoL9yb9MBhHTXu0OHvSSqvouUx6+fu/iuaU7s6zUkYfNXf0s/ghR03lhKyQ
         lWSFyUEHUvJYxyBazLv/SiEpC2p+77yPnXgyuZG/DpYfE2snGl2v6T17fjuIfvfNRsv5
         1KWx+Wg9jN8rGSvUjR0yrHlW0YUfKLxUqhZySc3lC2SbuUqDWqtuL70yxNXy3oa8tJ7h
         6/eTq1CSqkzezRcGPxbNjoYLk05E9ysK2+Zyrf0CcWba4MGFIWuQPCLeROqjwjJ/218M
         W6ng==
X-Gm-Message-State: APjAAAUB/BKJ/9WrfRWYhSOlZY5unq5U/gWwneFKf3/IsPsez0eRnqTr
        Bz3FRmXQu3N7wjuv5wSBdzCMBqwp0ZzlepCERAE=
X-Google-Smtp-Source: APXvYqwydnhG3yipz32Mkawa1LY3shaGvP6aeMT6scUZRjDnvZWkB3pSebXbk6lUTdgpE6f543iT2FwAZB4DPHPTEps=
X-Received: by 2002:a0c:e34e:: with SMTP id a14mr14875544qvm.73.1581425520017;
 Tue, 11 Feb 2020 04:52:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580894083.git.baolin.wang7@gmail.com> <3fd82478e82b19c72dddcc17c85313725aa13ff6.1580894083.git.baolin.wang7@gmail.com>
 <CAPDyKFq_tj+2yYf3YLA2vQkHGWWrY_ULUP=6-anpSJ0q+YvkFw@mail.gmail.com>
In-Reply-To: <CAPDyKFq_tj+2yYf3YLA2vQkHGWWrY_ULUP=6-anpSJ0q+YvkFw@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 11 Feb 2020 20:51:48 +0800
Message-ID: <CADBw62oWCO=LtGU9YA-hrfVnb3-45cr1f8gh31DMNV9dggbzHg@mail.gmail.com>
Subject: Re: [PATCH v8 1/5] mmc: Add MMC host software queue support
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Feb 11, 2020 at 5:45 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 5 Feb 2020 at 13:51, Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > From: Baolin Wang <baolin.wang@linaro.org>
> >
> > Now the MMC read/write stack will always wait for previous request is
> > completed by mmc_blk_rw_wait(), before sending a new request to hardware,
> > or queue a work to complete request, that will bring context switching
> > overhead, especially for high I/O per second rates, to affect the IO
> > performance.
>
> Would you mind adding some more context about the mmc_blk_rw_wait()?
> Especially I want to make it clear that mmc_blk_rw_wait() is also used
> to poll the card for busy completion for I/O writes, via sending
> CMD13.

Sure.

>
> >
> > Thus this patch introduces MMC software queue interface based on the
> > hardware command queue engine's interfaces, which is similar with the
> > hardware command queue engine's idea, that can remove the context
> > switching. Moreover we set the default queue depth as 64 for software
> > queue, which allows more requests to be prepared, merged and inserted
> > into IO scheduler to improve performance, but we only allow 2 requests
> > in flight, that is enough to let the irq handler always trigger the
> > next request without a context switch, as well as avoiding a long latency.
>
> I think it's important to clarify that to use this new interface, hsq,
> the host controller/driver needs to support HW busy detection for I/O
> operations.
>
> In other words, the host driver must not complete a data transfer
> request, until after the card stops signals busy. This behaviour is
> also required for "closed-ended-transmissions" with CMD23, as in this
> path there is no CMD12 sent to complete the transfer, thus no R1B
> response flag to trigger the HW busy detection behaviour in the
> driver.

Sure.

>
> >
> > From the fio testing data in cover letter, we can see the software
> > queue can improve some performance with 4K block size, increasing
> > about 16% for random read, increasing about 90% for random write,
> > though no obvious improvement for sequential read and write.
> >
> > Moreover we can expand the software queue interface to support MMC
> > packed request or packed command in future.
> >
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > ---
>
> [...]
>
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index f6912de..7a9976f 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -1851,15 +1851,22 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
> >          */
> >         card->reenable_cmdq = card->ext_csd.cmdq_en;
> >
> > -       if (card->ext_csd.cmdq_en && !host->cqe_enabled) {
> > +       if (host->cqe_ops && !host->cqe_enabled) {
> >                 err = host->cqe_ops->cqe_enable(host, card);
> >                 if (err) {
> >                         pr_err("%s: Failed to enable CQE, error %d\n",
> >                                 mmc_hostname(host), err);
>
> This means we are going to start printing an error message for those
> eMMCs that doesn't support command queuing, but the host supports
> MMC_CAP2_CQE.
>
> Not sure how big of a problem this is, but another option is simply to
> leave the logging of the *failures* to the host driver, rather than
> doing it here.
>
> Oh well, feel free to change or leave this as is for now. We can
> always change it on top, if needed.

OK. I will move the failure log to cqe_enable() callback to keep the
same logs'  logic. Thanks.

> >                 } else {
> >                         host->cqe_enabled = true;
> > -                       pr_info("%s: Command Queue Engine enabled\n",
> > -                               mmc_hostname(host));
> > +
> > +                       if (card->ext_csd.cmdq_en) {
> > +                               pr_info("%s: Command Queue Engine enabled\n",
> > +                                       mmc_hostname(host));
> > +                       } else {
> > +                               host->hsq_enabled = true;
> > +                               pr_info("%s: Host Software Queue enabled\n",
> > +                                       mmc_hostname(host));
> > +                       }
> >                 }
> >         }
>
> [...]
>
> Kind regards
> Uffe
