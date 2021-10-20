Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7C6C433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Oct 2021 16:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EB2161374
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Oct 2021 16:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhJTQD3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 Oct 2021 12:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbhJTQD2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Oct 2021 12:03:28 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FD3C061749
        for <linux-mmc@vger.kernel.org>; Wed, 20 Oct 2021 09:01:13 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id s17so25195370ioa.13
        for <linux-mmc@vger.kernel.org>; Wed, 20 Oct 2021 09:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nGh8xwLjUotuMiU7nTi+DQvy/W64PTEcDbyGcmEl7Ao=;
        b=ic4HEJrkQ+00mdGRe3DgeBN2pK4kIaBuH1BFNpXr2+B1fbcOjQox0JkM+8P6NGIR79
         O2vWfq44Cr3mbH/Uf8n5kqNct++3KnL6369AoBwXknoYZ4RWAYKQmYGwwDCcn604znbF
         Ho6kZs45TUU1JZqzsXj0JbOMVEsWt6q9BjWnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nGh8xwLjUotuMiU7nTi+DQvy/W64PTEcDbyGcmEl7Ao=;
        b=3VqoORCdrfPmoiHTFdl4gwVm/kwAeizrS3vAw/HOSxDEpy2HNLR/d/x/CQV90qd9DQ
         zHC0HdPLNXCmT4OjPYpTSSvoKrlAq0BP5QpPKPcK/GxBefd4xms1VQX1yRANcpOuQPOh
         f7R+yki54vcZWO2gp7CVww1YHT5aeByIX3GCGZ5SPpjoU/Ld8lv0hNM8vDYSQm3fbYf8
         EV6snKfHVz2SFXMdS6XhqdhCHroHcH4AHmE6ykhtshClKr5HNRe2MH9FnjSmUpkoccTh
         APoniIsBrqo6LQi9m5ayFwruOxb8RqF9JgMYtk93svlaPSjjz3fn+gaJ46SXdZcF6VAT
         5I+g==
X-Gm-Message-State: AOAM530aslCaPdJittQxjB1HFhdecQsf5DC5NNBeh6AJmcO96pZCr1JK
        b2+RzEgGjrxFO2jVjEV8URj9np3lJvwuhA==
X-Google-Smtp-Source: ABdhPJxFTDRaruh+JqxgGZi1N7gOMQwaw9NUJENTz0DOw2u533DeQXbN0JjIUSuWKrR+0KBcsd/Yqw==
X-Received: by 2002:a05:6602:2d14:: with SMTP id c20mr23249iow.95.1634745672850;
        Wed, 20 Oct 2021 09:01:12 -0700 (PDT)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id c4sm1266233ioo.48.2021.10.20.09.01.12
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 09:01:12 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id e144so25272264iof.3
        for <linux-mmc@vger.kernel.org>; Wed, 20 Oct 2021 09:01:12 -0700 (PDT)
X-Received: by 2002:a02:c731:: with SMTP id h17mr99223jao.93.1634745671995;
 Wed, 20 Oct 2021 09:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211020102907.70195-1-ulf.hansson@linaro.org>
In-Reply-To: <20211020102907.70195-1-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 20 Oct 2021 09:01:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wooy9c+S2QpQRn2Y0qKf16Q4cS6RtJ311NjkRSwrpeiw@mail.gmail.com>
Message-ID: <CAD=FV=Wooy9c+S2QpQRn2Y0qKf16Q4cS6RtJ311NjkRSwrpeiw@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Drop use of ->init_card() callback
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Wed, Oct 20, 2021 at 3:29 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> For dw_mmc, the ->init_card() callback is being used to turn on/off
> automatic internal clock gating for powersave, which is needed to properly
> support SDIO irqs on DAT1.
>
> However, using the ->init_card() comes with a drawback in this case, as it
> means that the powersave feature becomes disabled, no matter whether the
> SDIO irqs becomes turned on or not. To improve the behaviour, let's change
> into using the ->enable_sdio_irq() callback instead. This works fine,
> because dw_mmc uses sdio_signal_irq() to signal the irqs, thus the
> ->enable_sdio_irq() is never executed from within atomic context.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc.c | 39 +++++++++++++++++----------------------
>  1 file changed, 17 insertions(+), 22 deletions(-)

So it was a really long time ago now, but I swear that I put it in
init_card() for a reason. Sure enough, commit b24c8b260189 ("mmc:
dw_mmc: Cleanup disable of low power mode w/ SDIO interrupts") talks
about this. Your patch is largely a revert of that one. Looking at
that commit plus commit f8c58c113634 ("mmc: dw_mmc: Protect
read-modify-write of INTMASK with a lock") makes me wonder whether
it's indeed safe to do all the modifications that you're doing in
dw_mci_enable_sdio_irq().

I think that back in the day dw_mci_enable_sdio_irq() could be called
in multiple places: directly as a result of the interrupt handler and
also by other code that wanted the interrupt enabled.

Oh, I think I see. Commit 32dba73772f8 ("mmc: dw_mmc: Convert to use
MMC_CAP2_SDIO_IRQ_NOTHREAD for SDIO IRQs") is the key? After that
commit then it makes sense. The place you've added the code is a place
that is _not_ called from the interrupt handler.

OK, so this looks right to me then. Feel free to add:

Reviewed-by: Douglas Anderson <dianders@chromium.org>


I also wouldn't mind if you added some of the research above to the
commit message



> +       if (clk_en_a != clk_en_a_old) {
> +               mci_writel(host, CLKENA, clk_en_a);
> +               mci_send_cmd(slot, SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT,
> +                            0);

nit: that 0 looks lonely on its own line now. :(
