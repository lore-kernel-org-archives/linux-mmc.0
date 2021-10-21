Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4939C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Oct 2021 19:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E495610A3
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Oct 2021 19:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhJUTyu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Oct 2021 15:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhJUTyt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Oct 2021 15:54:49 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF62C061764
        for <linux-mmc@vger.kernel.org>; Thu, 21 Oct 2021 12:52:33 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id u21so167049lff.8
        for <linux-mmc@vger.kernel.org>; Thu, 21 Oct 2021 12:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+zVZ+nbJtZWhlj2/ed9v0QWdYMsDJw3mMWJiJuWBebE=;
        b=PKzYVeQSm/a5Ri8uV2DdArWjpIE/BFwMjp5OF8Hf/xaiBfYof3K9mFeqMy0fWiWtFh
         QZ36jaeFPyyHsl85TN5AHwvttiLzCMI2W1HArXQX3LagpNrcGTKMZ6gdpyz7qOZxJGhj
         9TdNgwGU4aejSeKLpovmIiWSWD9FdMRxekGMEk3qT1SLbVD0uELcWWFhidu3R26oq/hi
         j/mz4PcKnLXPZinHbSLsPIkxvsNWBTW/d0UbFk/zy/S0lOg0vE7Ew60xXzfi3fJEGCPr
         XqHQToNr6r+iCftQV7dqLgG0ncZjp0lOVzbCHWHzn7lAb4Ucydi6vqsz7pko5yVR2UDU
         70lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+zVZ+nbJtZWhlj2/ed9v0QWdYMsDJw3mMWJiJuWBebE=;
        b=gbEcnJs56AM0PDVGcJ63LgqdbGPkFe0om5PDdcFZOnmniT0tH8WKFZo45w80mt7COY
         tb6gItfmo6+ZvDgAMN+PpyqMl3vjqgzWNvTnC2wivzCZKIK2FHDXTgiBNO4onFDOgh9d
         9fUDG5bplG+kJLhQnAgyF81AyOOv535aZ4W0uXKUF5y5VVibuQ1DPKtEQcHRdnorxTXs
         HVBIvVnhtyGcU80PhodfGix/DqlWD3z5knhFQdUovjh00vZDl4TU+78Cm1GYPRbD87yU
         VFvX8NJG+Wenf0JMBZN0fugONoySvm6Oh51lC5pHgs4/GVGhWq7z7WPhEh+qNxgJsbfT
         B79g==
X-Gm-Message-State: AOAM530DeX6uwDDNEHFmc0gyrSNcLmP8B+LFm6YxCOc8wcHYQAKO9Rz+
        OoyuzhSB636tu30HnKS27L+u32iY70CnfRGsYoIu5w==
X-Google-Smtp-Source: ABdhPJyKMWfBbMJ/Ey1q9ERUniXOj0GI/V3nKEzhUltikMyn4722zope2gTZVHr6fAQaCopZvf+khpM3/Z/S72+ZtKc=
X-Received: by 2002:a05:6512:4029:: with SMTP id br41mr7577383lfb.233.1634845951630;
 Thu, 21 Oct 2021 12:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20211020102907.70195-1-ulf.hansson@linaro.org> <CAD=FV=Wooy9c+S2QpQRn2Y0qKf16Q4cS6RtJ311NjkRSwrpeiw@mail.gmail.com>
In-Reply-To: <CAD=FV=Wooy9c+S2QpQRn2Y0qKf16Q4cS6RtJ311NjkRSwrpeiw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Oct 2021 21:51:54 +0200
Message-ID: <CAPDyKFpzw2E7i3ZtkobBQcjWd9LnyH8MbPcxvt6ro3t6enMU7g@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Drop use of ->init_card() callback
To:     Doug Anderson <dianders@chromium.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 20 Oct 2021 at 18:01, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Oct 20, 2021 at 3:29 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > For dw_mmc, the ->init_card() callback is being used to turn on/off
> > automatic internal clock gating for powersave, which is needed to properly
> > support SDIO irqs on DAT1.
> >
> > However, using the ->init_card() comes with a drawback in this case, as it
> > means that the powersave feature becomes disabled, no matter whether the
> > SDIO irqs becomes turned on or not. To improve the behaviour, let's change
> > into using the ->enable_sdio_irq() callback instead. This works fine,
> > because dw_mmc uses sdio_signal_irq() to signal the irqs, thus the
> > ->enable_sdio_irq() is never executed from within atomic context.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/mmc/host/dw_mmc.c | 39 +++++++++++++++++----------------------
> >  1 file changed, 17 insertions(+), 22 deletions(-)
>
> So it was a really long time ago now, but I swear that I put it in
> init_card() for a reason. Sure enough, commit b24c8b260189 ("mmc:
> dw_mmc: Cleanup disable of low power mode w/ SDIO interrupts") talks
> about this. Your patch is largely a revert of that one. Looking at
> that commit plus commit f8c58c113634 ("mmc: dw_mmc: Protect
> read-modify-write of INTMASK with a lock") makes me wonder whether
> it's indeed safe to do all the modifications that you're doing in
> dw_mci_enable_sdio_irq().
>
> I think that back in the day dw_mci_enable_sdio_irq() could be called
> in multiple places: directly as a result of the interrupt handler and
> also by other code that wanted the interrupt enabled.
>
> Oh, I think I see. Commit 32dba73772f8 ("mmc: dw_mmc: Convert to use
> MMC_CAP2_SDIO_IRQ_NOTHREAD for SDIO IRQs") is the key? After that
> commit then it makes sense. The place you've added the code is a place
> that is _not_ called from the interrupt handler.
>
> OK, so this looks right to me then. Feel free to add:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks a lot for reviewing!

>
>
> I also wouldn't mind if you added some of the research above to the
> commit message

The commit message states:

"This works fine, because dw_mmc uses sdio_signal_irq() to signal the
irqs, thus the ->enable_sdio_irq() is never executed from within
atomic context."

But I can throw in some more background and refer to the commits you
pointed out above.

[...]

Kind regards
Uffe
