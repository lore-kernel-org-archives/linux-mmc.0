From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: mmc: tmio: why enable/disable SDIO irq on every transaction with IOMOD?
Date: Tue, 29 Nov 2016 09:52:21 +0100
Message-ID: <CAPDyKFop3a6eHhOZq1E=BdFiHzmpu4uEx0F79nyBVCOu6z6usw@mail.gmail.com>
References: <87h96qkdn0.wl@dns1.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f173.google.com ([209.85.210.173]:35692 "EHLO
        mail-wj0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755990AbcK2IwY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2016 03:52:24 -0500
Received: by mail-wj0-f173.google.com with SMTP id v7so138577850wjy.2
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2016 00:52:24 -0800 (PST)
In-Reply-To: <87h96qkdn0.wl@dns1.atmark-techno.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yasushi SHOJI <yashi@atmark-techno.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms@verge.net.au>

+Wolfram, Simon

Looping maintainers of TMIO/SDHI.

On 29 November 2016 at 07:23, Yasushi SHOJI <yashi@atmark-techno.com> wrote:
> Hello,
>
> We've been using tmio_mmc_pio.c and seeing the following message:
>
>         "sh_mobile_sdhi sh_mobile_sdhi.1: timeout waiting for SD bus idle"
>
> While searching for a fix, we found some code we don't understand.
> I'm sending this question with a hope that someone would enlighten us a
> bit.  So, here goes.
>
> The SDIO spec. seems to allow sending SDIO IRQ between the blocks of
> multi-block transfer.  The hardware, SCLKDIVEN bit of SD_INFO02, is
> set to zero (0) and prohibits to access IOMOD bit of SDIO_MODE
> register while multi-block transfer is going.
>
> The current code, however, tries to disable SDIO IRQ by setting IOMOD
> to zero in tmio_mmc_enable_sdio_irq() all the time, even during
> multi-block transfer.  This prints the above waring.  What we don't
> understand is that the code does both masking and disabling the IRQ.
>
> So my question is that "What is the reason behind to disable IRQ with
> SDIO_MODE?  Is there any situation which masking with SDIO_INFO1_MASK
> is not enough?
>
> Thanks you,
> --
>            yashi
> --

Kind regards
Uffe
