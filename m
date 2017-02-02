From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: mmc_card_blockaddr() now private
Date: Thu, 2 Feb 2017 14:12:55 +0100
Message-ID: <CAPDyKFoKWJTvxRwNOpXDDeQcnyAhAG32sT=VKOLCvOm9g6OZoQ@mail.gmail.com>
References: <20170130135219.GA10099@wintermute>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35398 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbdBBNM6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Feb 2017 08:12:58 -0500
Received: by mail-wm0-f50.google.com with SMTP id b65so89968394wmf.0
        for <linux-mmc@vger.kernel.org>; Thu, 02 Feb 2017 05:12:57 -0800 (PST)
In-Reply-To: <20170130135219.GA10099@wintermute>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 30 January 2017 at 14:52, Jan Glauber <jglauber@cavium.com> wrote:
> Hi,
>
> preparing mmc patches against linux-next I noticed that
> mmc_card_blockaddr is now private to the mmc core.
>
> We've been using that in the (not yet upstream) Cavium mmc driver like this:
>
> static void prepare_ext_dma(struct mmc_host *mmc, ...
>         ...
>         emm_dma->s.sector = mmc_card_blockaddr(mmc->card) ? 1 : 0;
>
>
> So the hardware controller needs to know if we use 512 byte blocks
> or not which seems to be dependent on the medium size.

mmc_card_blockaddr() is not about the size of the block. Instead it
tells how the card translate the address to the data.

For old cards, the address can be in bytes, while newer supports the
address being a multiple of sectors.

>
> Any ideas on how I can implement this without mmc_card_blockaddr() ?

Seems like you probably should use "blksz" from the struct mmc_data,
which your driver receives as apart of the request.

Kind regards
Uffe
