From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] RFC: mmc: dw_mmc: Always go to STATE_DATA_BUSY from STATE_DATA_ERROR
Date: Mon, 8 Apr 2013 16:09:39 -0700
Message-ID: <CAD=FV=V+ZZ0MUtuWKUOgR9NPyAquUjFC6KtHvAP-4iHXAYpjqA@mail.gmail.com>
References: <1363382956-14557-1-git-send-email-dianders@chromium.org>
	<5146EAB0.1030705@samsung.com>
	<CAD=FV=Ww-iK=-vg4jnJe6w4836-yQUoUyxNvCYsDQ5w0q-OMMQ@mail.gmail.com>
	<515E88E3.5070507@samsung.com>
	<003401ce3453$19d1e8c0$4d75ba40$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:59140 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760209Ab3DHXJl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Apr 2013 19:09:41 -0400
Received: by mail-la0-f48.google.com with SMTP id fq13so5911716lab.35
        for <linux-mmc@vger.kernel.org>; Mon, 08 Apr 2013 16:09:39 -0700 (PDT)
In-Reply-To: <003401ce3453$19d1e8c0$4d75ba40$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@gmail.com>, Bing Zhao <bzhao@marvell.com>, Ashok Nagarajan <asnagarajan@chromium.org>, Paul Stewart <pstew@chromium.org>, Olof Johansson <olof@lixom.net>, linux-mmc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Seungwon,

On Mon, Apr 8, 2013 at 5:17 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> I guess Doug are debugging it with wifi, right?

Yes, we're debugging it on the Samsung ARM Chromebook on a part that
has an SDIO WiFi module by Marvell.  Bing Zhao (CCed) has a unit in
hand that generates lots of CRC errors and has been testing patches
I've sent him.


> The problem happens when dw_mci_stop_dma is called in the middle of data transfers.
> If data error occurs in the end of block, EVENT_XFER_COMPLETE might be set. So, it's fine.
> Actually, dw_mci_idmac_stop_dma stops the dma working, there is no further interrupt for dma completion.

That sounds right to me.


> There are two solutions we have applied.

I'm a little confused.  Have you already applied one or both of the
solutions you list below, or are you proposing them as alternates to
the patch I submitted?

> #1. deferring the call of dw_mci_stop_dma until EVENT_XFER_COMPLETE flag is set into pending_events.
> In this case, dma transfer will be continued with error.
>
> @@ -1062,7 +1062,6 @@ static void dw_mci_tasklet_func(unsigned long priv)
>                 case STATE_SENDING_DATA:
>                         if (test_and_clear_bit(EVENT_DATA_ERROR,
>                                                &host->pending_events)) {
> -                               dw_mci_stop_dma(host);
>                                 if (data->stop)
>                                         send_stop_cmd(host, data);
>                                 state = STATE_DATA_ERROR;
> @@ -1155,6 +1154,9 @@ static void dw_mci_tasklet_func(unsigned long priv)
>                                                 &host->pending_events))
>                                 break;
>
> +                       dw_mci_stop_dma(host);
> +                       set_bit(EVENT_XFER_COMPLETE, &host->completed_events);
> +
>                         state = STATE_DATA_BUSY;
>                         break;

I can't say that I'm quite familiar enough with the intricate details
of the driver to know whether this is a good idea or guaranteed to
work.  Do we really think that we'll still get the end of the transfer
properly if we've seen an error already?  I worry that we won't.


> #2. set EVENT_XFER_COMPLETE flag when dw_mci_stop_dma is called regardless using_dma.
>
> @@ -299,10 +299,9 @@ static void dw_mci_stop_dma(struct dw_mci *host)
>         if (host->using_dma) {
>                 host->dma_ops->stop(host);
>                 host->dma_ops->cleanup(host);
> -       } else {
> -               /* Data transfer was stopped by the interrupt handler */
> -               set_bit(EVENT_XFER_COMPLETE, &host->pending_events);
>         }
> +
> +       set_bit(EVENT_XFER_COMPLETE, &host->pending_events);
>  }

This is fairly similar to my patch but goes further.  I believe my
patch has this effect but only for the call to dw_mci_stop_dma() in
STATE_SENDING_DATA in the tasklet.  Your affects all 3 calls to
dw_mci_stop_dma().

This seems reasonable but I don't have confidence in my understanding
of this driver's state machine (especially with regards to the error
conditions) that I can say which is better.  If you think that this is
a more correct solution than mine then we can give it some testing.

Thanks!

-Doug
