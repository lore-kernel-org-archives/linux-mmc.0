Return-Path: <SRS0=U+Jx=5C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC37C10F29
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 09:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD540205ED
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 09:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hY4715Py"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgCQJRh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Mar 2020 05:17:37 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44185 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgCQJRh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Mar 2020 05:17:37 -0400
Received: by mail-qk1-f195.google.com with SMTP id j4so14646570qkc.11;
        Tue, 17 Mar 2020 02:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JxwfgSOGHypAS3R1BbLW4z9bLpsckg8eAQy++ZdyVho=;
        b=hY4715PyB7C+ViqAVN3GXwFpli9VZ7Sv1gFD3fFm0l/YQB4kzb+QrJmL24y2LzpOAS
         OIgNLfiio9yk5ewmwgHwwbusjzOEQYLPxqaHZkv6AV4vqQeUarTNqoU6kc0SRfx7DJ3k
         50YLOZ1uVjR8mGofC12QxQTqRGSjtBE+DnBS2psDRodhCv6QywMQr6HYrcOacFSELzHn
         D99wh62pebTw5JAuXrec25GG5tvT72eJR4el6pMrH2OQCw/oS1oeoqhGDU1lv3vbSuE/
         UNZdKI9op5+QOUbc84GDunkdSNKjvpZPrCKllqbb6W2hAq4Okynsfrv+d/GuIhQwUAwX
         7lVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JxwfgSOGHypAS3R1BbLW4z9bLpsckg8eAQy++ZdyVho=;
        b=Dbsq7qcJsvt4tX6KFlnBt3z/93bjyQlcM3Vu3KRssfK17FZHNi7glD5869u2hhLbex
         uS+ZXZIS1deIc+QF/Vh5qpVZOZl1CPDbQGIYKFX072DUPMfnKG0Yl8KezJWizZBkrXTn
         39qfcOlIwN+fR/Q+I94uCAj9L+tHv9LBghKzLX1UlkN3p3JLh4mLjJyNZyEl0+Bo/zpV
         HZy04VA/0I64VHO65VadJC/twaXGY3NS/XbORaWy+gd8ofJ3trXQRou2BLHQGPcNHuJ+
         5J4p0elkwRbyK2ttJ5G/cUCeDiPlNHV/0KME+14l33yOB+Csss/TR58Qc709eHK5t8Mk
         0peg==
X-Gm-Message-State: ANhLgQ1fhQzgBUcVDKJ4bX2hTblIXmOQzE7jrcTkJgZrH9hgbxOBcZK+
        VPSWSyhp2i4IkJZWq+iHWC1onXRDrSks5Ost7hs=
X-Google-Smtp-Source: ADFU+vvF1DDXNjDJYo5wU8kxADBIVCRfGTwnrTR6r2t8QcHB80KCEYO+gWK60KCNIcslradmUPM7cHOORp3y6fbeIIc=
X-Received: by 2002:a05:620a:10ae:: with SMTP id h14mr3793460qkk.170.1584436653751;
 Tue, 17 Mar 2020 02:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583307441.git.baolin.wang7@gmail.com> <ace53bca354e2846f19684bd33a9c0f3c2ee2c44.1583307441.git.baolin.wang7@gmail.com>
 <dd44e606-3eb5-f7fc-5995-021705a9b5d9@intel.com> <CADBw62ojVB7nvwE9OM8-A_HfVBBXz7tuaxfqDCmQ39b1YiDBag@mail.gmail.com>
 <ea70f7a4-78cb-25b4-4363-c6493d885795@intel.com>
In-Reply-To: <ea70f7a4-78cb-25b4-4363-c6493d885795@intel.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 17 Mar 2020 17:17:21 +0800
Message-ID: <CADBw62oK299N+M+59RxgFeie6DJPb005+7kAbxzzkMF0QRchaQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/3] mmc: host: Introduce the request_atomic() for
 the host
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Mar 17, 2020 at 3:32 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 17/03/20 5:36 am, Baolin Wang wrote:
> > On Mon, Mar 16, 2020 at 9:09 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 4/03/20 9:42 am, Baolin Wang wrote:
> >>> The SD host controller can process one request in the atomic context if
> >>> the card is nonremovable, which means we can submit next request in the
> >>> irq hard handler when using the MMC software queue to reduce the latency.
> >>> Thus this patch adds a new API request_atomic() for the host controller
> >>> and implement it for the SD host controller.
> >>>
> >>> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> >>> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> >>> ---
> >>>  drivers/mmc/host/sdhci.c | 27 +++++++++++++++++++--------
> >>>  drivers/mmc/host/sdhci.h |  1 +
> >>>  include/linux/mmc/host.h |  3 +++
> >>>  3 files changed, 23 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >>> index 9c37451..4febbcb 100644
> >>> --- a/drivers/mmc/host/sdhci.c
> >>> +++ b/drivers/mmc/host/sdhci.c
> >>> @@ -2016,17 +2016,12 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
> >>>   *                                                                           *
> >>>  \*****************************************************************************/
> >>>
> >>> -void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
> >>> +static void sdhci_start_request(struct mmc_host *mmc, struct mmc_request *mrq,
> >>> +                             int present)
> >>>  {
> >>> -     struct sdhci_host *host;
> >>> -     int present;
> >>> +     struct sdhci_host *host = mmc_priv(mmc);
> >>>       unsigned long flags;
> >>>
> >>> -     host = mmc_priv(mmc);
> >>> -
> >>> -     /* Firstly check card presence */
> >>> -     present = mmc->ops->get_cd(mmc);
> >>> -
> >>>       spin_lock_irqsave(&host->lock, flags);
> >>>
> >>>       sdhci_led_activate(host);
> >>> @@ -2043,6 +2038,22 @@ void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
> >>>
> >>>       spin_unlock_irqrestore(&host->lock, flags);
> >>>  }
> >>> +
> >>> +void sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq)
> >>> +{
> >>> +     sdhci_start_request(mmc, mrq, 1);
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(sdhci_request_atomic);
> >>> +
> >>> +void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
> >>> +{
> >>> +     int present;
> >>> +
> >>> +     /* Firstly check card presence */
> >>> +     present = mmc->ops->get_cd(mmc);
> >>> +
> >>> +     sdhci_start_request(mmc, mrq, present);
> >>> +}
> >>>  EXPORT_SYMBOL_GPL(sdhci_request);
> >>>
> >>>  void sdhci_set_bus_width(struct sdhci_host *host, int width)
> >>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> >>> index cac2d97..5507a73 100644
> >>> --- a/drivers/mmc/host/sdhci.h
> >>> +++ b/drivers/mmc/host/sdhci.h
> >>> @@ -775,6 +775,7 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
> >>>  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
> >>>                          unsigned short vdd);
> >>>  void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
> >>> +void sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
> >>>  void sdhci_set_bus_width(struct sdhci_host *host, int width);
> >>>  void sdhci_reset(struct sdhci_host *host, u8 mask);
> >>>  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
> >>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> >>> index 562ed06..db5e59c 100644
> >>> --- a/include/linux/mmc/host.h
> >>> +++ b/include/linux/mmc/host.h
> >>> @@ -92,6 +92,9 @@ struct mmc_host_ops {
> >>>                           int err);
> >>>       void    (*pre_req)(struct mmc_host *host, struct mmc_request *req);
> >>>       void    (*request)(struct mmc_host *host, struct mmc_request *req);
> >>> +     /* Submit one request to host in atomic context. */
> >>> +     void    (*request_atomic)(struct mmc_host *host,
> >>> +                               struct mmc_request *req);
> >>
> >> This doesn't have the flexibility to return "busy".  For example,
> >> sdhci_send_command() will potentially wait quite some time if the inhibit
> >> bits are set.  That is not good in interrupt context.  It would be better to
> >> return immediately in that case and have the caller fall back to a
> >> non-atomic context.  Thoughts?
> >
> > Yes, I unserstood your concern. But the sdhci_send_command() is
> > already under the spin_lock_irqsave() protection, which will also
> > disable the interrupt for some time if the inhibit bits are set. That
> > is same with moving it in interrupt context.
>
> It is, but I would like to fix that too.

OK. Like you suggested, cause we've aleady decided how to complete a
request by sdhci_defer_done(), I need think about how to change to a
non-atomic context for this unusual case.

And since the original sdhci_send_command() has the same problem as I
said, I perfer to create another patch set to fix this issue.


> > Moreover, if the previous command complete interrupt and transfer
> > complete interrupt are normal, we should not meet this issue of
> > polling inhibit bits (I have not met this issue on my platform). So I
> > think we can remove the polling here? If the inhibit bits are set, I
> > think the command complete interrupt or the transfer complete
> > interrupt have been abnormal, so we can just return the error here.
> > What do you think? Thanks.
> >
>
> I suspect the inhibit polling might be needed for some host controllers in
> some situations.  ie. taking it out would likely break things.

Make sense.


--
Baolin Wang
