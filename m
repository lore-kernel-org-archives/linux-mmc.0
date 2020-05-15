Return-Path: <SRS0=CGCI=65=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FF0C433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 14:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD7912075F
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 14:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20150623.gappssmtp.com header.i=@timesys-com.20150623.gappssmtp.com header.b="K9qEJ1Dk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgEOOMG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 May 2020 10:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726254AbgEOOMG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 May 2020 10:12:06 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88278C061A0C
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2020 07:12:05 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id g7so831721uap.7
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2020 07:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7kSxGRJ6w61a80RNctp28azsgtfkSiiQ/upjlad1YrI=;
        b=K9qEJ1DkdRbSZxAKyaE61i7gGS7izkyzb5rswvdcn2YpfawYpppzXtoltkbwMTRsch
         oThmo39kXogWu0sYDvRIcM6FUeeXu2O7SJPRTewMhk1wxU2UQyZYs8BuRfgSOoX19I/r
         Z2jWY+wlGTeUlgoRv5rrkeV1p5RRV9nAIcnHGIDgEU7mWTfF9n8r6YWC9IdAqPw8sR0r
         H78puEfTMTxtcXSFGYimwF/x1xkuwPfRTeFQ4vpKFzw2G0cQqHOHSuwObSYjqGt75svj
         H7cQbeDYKJZTxA9eGyuLWgHOpqgqzlFQjXrNtMjea0Td8MhrVjaLdc5UYXKqUF17BgV9
         M0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7kSxGRJ6w61a80RNctp28azsgtfkSiiQ/upjlad1YrI=;
        b=dKp9ZVBrCWjw04i0Q9jNX3J8BII7Xedvk+D3rFMyWYFnfHtxeUkUaAKnj/XJiEPU89
         SHLeWdfshvekYIMkLCh04R20XZVMEJL3dfF4PlgBfuO8elZWxtuVWXGT3jFd2BY9+Mle
         Soovqo0BvSN3nMJ3jmQymMZCcc+bdvbhA3UpVqqE34HznLeEC+Tz5cmVLSc0upUpdMak
         qfluxt6Kc7xiFXufmOpeW1iV2uiEI3nB9xVU3Dqwn3YC0iKCLsLJdXHtBDiRzjhsvpoB
         cichRHr/o7DGXMWnk6vfhnb/VfB5VWHdhAJZfUPMSQmsP6n1Qit9R/NFHBkel9HzirUt
         8IwQ==
X-Gm-Message-State: AOAM533lwQN6IwZky1hp596PuYLaK6g+vYMVlVAf37WGnCH5elek9XKc
        9jBEUJVTXvkL2h7qmrrBQOOXbkP42gE7sB7Z1vBypw==
X-Google-Smtp-Source: ABdhPJzVXBXQ/DZsxYx6Xmm2q0WUdV+Qrsy/pgu09meaJN1cOrIXZSjqBMVZs8OFSJ90hHU+EyV5HxRMD0dKHZLz7ao=
X-Received: by 2002:ab0:7356:: with SMTP id k22mr2977755uap.122.1589551924711;
 Fri, 15 May 2020 07:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200513204133.2540568-1-angelo.dureghello@timesys.com>
 <20200513204133.2540568-2-angelo.dureghello@timesys.com> <d1be973e-87b6-f45c-bea6-4b6660a8465c@intel.com>
In-Reply-To: <d1be973e-87b6-f45c-bea6-4b6660a8465c@intel.com>
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
Date:   Fri, 15 May 2020 16:16:52 +0200
Message-ID: <CALJHbkC4O3tjBSEq4w65dsDuP-VKWKtg0YCA7mnUMQyKhA0GwA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mmc: sdhci: add quirks for be to le byte swapping
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Ungerer <gerg@linux-m68k.org>, linux-mmc@vger.kernel.org,
        linux-m68k@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

thanks for the feedbacks,
providing v5 in short, will run also checkpatch with "--strict".

On Fri, May 15, 2020 at 3:38 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 13/05/20 11:41 pm, Angelo Dureghello wrote:
> > Some controller as the ColdFire eshdc may require an endianness
> > byte swap, becouse DMA read endianness is not configurable.
> >
> > Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
> > ---
> > Changes for v3:
> > - add post request callback
> > Changes for v4:
> > none
> > ---
> >  drivers/mmc/host/sdhci.c | 7 +++++++
> >  drivers/mmc/host/sdhci.h | 2 ++
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 3f716466fcfd..d3bfbb6e11d5 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -637,6 +637,13 @@ static int sdhci_pre_dma_transfer(struct sdhci_host *host,
> >                       sg_copy_to_buffer(data->sg, data->sg_len,
> >                                         host->bounce_buffer,
> >                                         length);
> > +
> > +                     /*
> > +                      * Endianness can't be swapped in the sg list,
> > +                      * since the sg list is processed again later on.
> > +                      */
>
> The data in the sg list must not be changed because we don't know how
> else it might be being used.  Maybe leave out the comment.
>
> > +                     if (host->ops->pre_dma_transfer)
> > +                             host->ops->pre_dma_transfer(host, data);
>
> Let's make this slightly more generic i.e.
>
>                         if (host->ops->copy_to_bounce_buffer) {
>                                 host->ops->copy_to_bounce_buffer(host, data);
>                         } else {
>                                 sg_copy_to_buffer(data->sg, data->sg_len,
>                                                   host->bounce_buffer,
>                                                   length);
>                         }
>
>
> >               }
> >               /* Switch ownership to the DMA */
> >               dma_sync_single_for_device(host->mmc->parent,
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index 79dffbb731d3..076054308423 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -653,6 +653,8 @@ struct sdhci_ops {
> >       void    (*voltage_switch)(struct sdhci_host *host);
> >       void    (*adma_write_desc)(struct sdhci_host *host, void **desc,
> >                                  dma_addr_t addr, int len, unsigned int cmd);
> > +     void    (*pre_dma_transfer)(struct sdhci_host *host,
> > +                                 struct mmc_data *data);
> >       void    (*request_done)(struct sdhci_host *host,
> >                               struct mmc_request *mrq);
> >  };
> >
>

Regards,
Angelo
