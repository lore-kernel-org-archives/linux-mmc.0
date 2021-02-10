Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F847C433E9
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Feb 2021 12:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11F5564E40
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Feb 2021 12:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhBJMJq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 10 Feb 2021 07:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhBJMHk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Feb 2021 07:07:40 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB400C0617A9
        for <linux-mmc@vger.kernel.org>; Wed, 10 Feb 2021 04:04:09 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id j10so408631vkp.12
        for <linux-mmc@vger.kernel.org>; Wed, 10 Feb 2021 04:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7JGcu4XrZnVMUC12p2OysDg1RTccXXXiNHN8GvUfYp4=;
        b=NbuVn1/8+zBeUV+oY6fiklCAfoOn87rMBO9H1Df2Vl9lP49WxgMUQEWv6+7MfbdZpN
         CctjR2BPOTc8Vkfv/3ovv+X7Y8ooTVF+u9QIwrYzYp/wsK8Hr5P+z08vyvj+6v6XWrqG
         UyDiq/qF8jaQyHwmfTXFMm1JsJ/RSpcAwZFszEoedxCaonjBEHlNXaNNCpZ576TSQGbn
         Y2MuhioNv3vGU8cEiRQWNNhBDOHE5QnRRwWDQPVTj3q/TRDqMnpEwngT4e+rljuKLggS
         Uj3r9ocvwLvjaOo2D36krEPLMSPShxRL1Fv/STl4onxRtNgH6tJnpGNRnihgBBlRoms6
         gzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7JGcu4XrZnVMUC12p2OysDg1RTccXXXiNHN8GvUfYp4=;
        b=O2Z0y8w8xDz+WGRrEMc+tSLPc5oDR0X1AFNjt90jSbV5lJtdk5qMW7KUyMWa5khk8z
         yAAQ4zQxhzeFzQxc4jpyfLXuRN6WsmL9FYThh5G1n9PublehGAIC96EZsGzErTUP8IAC
         ZqWmh70h0nr4+nspsWlwDpOKILAkxjONodDx/e+0xm8Rl5lZukuwGP/3qIHwb1tSO1l0
         gY87o75T6WQDYcAh6u2gISCBZmpK0ly46g65yRr4liQh411qeE7vIR8l8QmRcfTjDNL1
         4bPLDuAnpn6wBmuxL0Rp+8IA+5i+ZJbslKy+awGP2y4BvCopfppZ5dhzK+C5q16B8H2Q
         z97Q==
X-Gm-Message-State: AOAM531zON7XboqbqrrR63Wmm7L5XmX+cZN4uToB8RlIq5/mDdEZccvC
        LRk16Xi2m/XSB5TF1HpFM209p7PWuxMHNrMxg3MSDQ==
X-Google-Smtp-Source: ABdhPJyiXqhi4Rde5/I/fRmwtVV0L9TllaXMGAsYvebOp5+kccg16AKc3h45Ief4uLm87jf2DGMPwUA+DslrYQsYZZM=
X-Received: by 2002:a1f:a102:: with SMTP id k2mr1289757vke.15.1612958648968;
 Wed, 10 Feb 2021 04:04:08 -0800 (PST)
MIME-Version: 1.0
References: <20210204120547.15381-1-yann.gautier@foss.st.com>
 <20210204120547.15381-2-yann.gautier@foss.st.com> <CAPDyKFqdtK33HSW_AM0s9172V=cBM6wnKuHubXSOGCVqJ8nzFg@mail.gmail.com>
 <e31df871-ae1a-7c80-d741-0813f90532c7@foss.st.com> <1c1814dc-f87b-ef5c-24b4-b9a6ec570dbc@foss.st.com>
 <CAPDyKFq26Q3jwwJ71vp6s-+ux3jUnL6+m2FEzfi_gh5z8meqrw@mail.gmail.com> <cc8a480c-77dc-f44b-ae98-309ab59c4e13@foss.st.com>
In-Reply-To: <cc8a480c-77dc-f44b-ae98-309ab59c4e13@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 10 Feb 2021 13:03:32 +0100
Message-ID: <CAPDyKFrA8iV3HXjf18N7vJw=Q1dtrAQJY8cLqxybXKDJtzoMrA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: mmci: enable MMC_CAP_NEED_RSP_BUSY
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        ludovic.barre@foss.st.com,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 9 Feb 2021 at 15:01, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> On 2/8/21 4:03 PM, Ulf Hansson wrote:
> > On Mon, 8 Feb 2021 at 13:16, Yann GAUTIER <yann.gautier@foss.st.com> wrote:
> >>
> >> On 2/5/21 1:19 PM, Yann GAUTIER wrote:
> >>> On 2/5/21 10:53 AM, Ulf Hansson wrote:
> >>>> - trimmed cc-list
> >>>>
> >>>> On Thu, 4 Feb 2021 at 13:08, <yann.gautier@foss.st.com> wrote:
> >>>>>
> >>>>> From: Yann Gautier <yann.gautier@foss.st.com>
> >>>>>
> >>>>> To properly manage commands awaiting R1B responses, the capability
> >>>>> MMC_CAP_NEED_RSP_BUSY is enabled in mmci driver, for variants that
> >>>>> manage busy detection.
> >>>>> This R1B management needs both the flags MMC_CAP_NEED_RSP_BUSY and
> >>>>> MMC_CAP_WAIT_WHILE_BUSY to be enabled together.
> >>>>
> >>>> Would it be possible for you to share a little bit more about the
> >>>> problem? Like under what circumstances does things screw up?
> >>>>
> >>>> Is the issue only occurring when the cmd->busy_timeout becomes larger
> >>>> than host->max_busy_timeout. Or even in other cases?
> >>>>
> >>>>>
> >>>>> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> >>>>> ---
> >>>>>    drivers/mmc/host/mmci.c | 2 +-
> >>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> >>>>> index 1bc674577ff9..bf6971fdd1a6 100644
> >>>>> --- a/drivers/mmc/host/mmci.c
> >>>>> +++ b/drivers/mmc/host/mmci.c
> >>>>> @@ -2148,7 +2148,7 @@ static int mmci_probe(struct amba_device *dev,
> >>>>>                   if (variant->busy_dpsm_flag)
> >>>>>                           mmci_write_datactrlreg(host,
> >>>>>
> >>>>> host->variant->busy_dpsm_flag);
> >>>>> -               mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
> >>>>> +               mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY |
> >>>>> MMC_CAP_NEED_RSP_BUSY;
> >>>>
> >>>> This isn't correct as the ux500 (and likely also other legacy
> >>>> variants) don't need this. I have tried it in the past and it works
> >>>> fine for ux500 without MMC_CAP_NEED_RSP_BUSY.
> >>>>
> >>>> The difference is rather that the busy detection for stm32 variants
> >>>> needs a corresponding HW busy timeout to be set (its
> >>>> variant->busy_timeout flag is set). Perhaps we can use that
> >>>> information instead?
> >>>>
> >>>> Note that, MMC_CAP_NEED_RSP_BUSY, means that cmd->busy_timeout will
> >>>> not be set by the core for erase commands, CMD5 and CMD6.
> >>>>
> >>>> By looking at the code in mmci_start_command(), it looks like we will
> >>>> default to a timeout of 10s, when cmd->busy_timeout isn't set. At
> >>>> least for some erase requests, that won't be sufficient. Would it be
> >>>> possible to disable the HW busy timeout in some way - and maybe use a
> >>>> software timeout instead? Maybe I already asked Ludovic about this?
> >>>> :-)
> >>>>
> >>>> BTW, did you check that the MMCIDATATIMER does get the correct value
> >>>> set for the timer in mmci_start_command() and if
> >>>> host->max_busy_timeout gets correctly set in
> >>>> mmci_set_max_busy_timeout()?
> >>>>
> >>>> [...]
> >>>>
> >>>> Kind regards
> >>>> Uffe
> >>>>
> >>>
> >>> Hi Ulf,
> >>>
> >>> Thanks for the hints.
> >>> I'll check all of that and get back with updated patches.
> >>>
> >>> As I tried to explain in the cover letter and in reply to Adrian, I saw
> >>> a freeze (BUSYD0) in test 37 during MMC_ERASE command  with
> >>> SECURE_ERASE_ARG, when running this test just after test 36 (or any
> >>> other write test). But maybe, as you said that's mostly a incorrect
> >>> timeout issue.
> >>>
> >>> Regards,
> >>> Yann
> >>
> >> Hi,
> >>
> >> I made some extra tests, and the timeout value set in MMCIDATATIMER
> >> correspond to the one computed:
> >> card->ext_csd.erase_group_def is set to 1 in mmc_init_card()
> >> In mmc_mmc_erase_timeout(), we have:
> >> erase_timeout = card->ext_csd.hc_erase_timeout; // 300ms * 0x07 (for the
> >> eMMC card I have: THGBMDG5D1LBAIL
> >> erase_timeout *= card->ext_csd.sec_erase_mult; // 0xDC
> >> erase_timeout *= qty; // 32 (from = 0x1d0000, to = 0x20ffff)
> >>
> >> This leads to a timeout of 14784000ms (~4 hours).
> >> The max_busy_timeout is 86767ms.
> >>
> >> After those 4 hours, I get this message:
> >> mmc1: Card stuck being busy! __mmc_poll_for_busy
> >
> > Okay, I see.
> >
> > This means that we end up polling for busy in __mmc_poll_for_busy().
> > However, not by using CMD13 but rather with the ->card_busy() ops (as
> > mmci has this callback set).
> >
> > Could it be that the ->card_busy() callback isn't working correctly
> > for the stm32 variant?
> >
> > What happens if you temporarily drop the assignment of the
> > ->card_busy() callback, thus force the mmc core to poll with CMD13
> > instead? Would this work?
> >
>
> Hi Ulf,
>
> When ->card_busy() is stubbed for MMC_ERASE command, CMD13 is running in
> loop, for ~66 seconds.
> The card status is just 0xe00 here, no errors, just prog state, as
> awaited for CMD38, and READY_FOR_DATA bit not set.
> And after those 66 seconds, the status changes to 0x900.
> But busyd0 is still set to 1, during the CMD13 and after.
> The test continues, with a CMD25, still with busyd0 and DPSM so the IP
> is stuck, and the STOP command is sent (mrq->stop in mmc_mrq_pr_debug).
> And here nothing more happens, wait_for_completion() from
> mmc_wait_for_req_done().

Okay, I see. Thanks for sharing the details.

>
> >>
> >> The second erase with MMC_ERASE_ARG finds an erase timeout of 67200ms,
> >> and uses R1B command.
> >> But as the first erase failed, the DPSMACT is still enabled, the busy
> >> timeout doesn't seem to happen. Something may be missing in the error path.
> >
> > Assuming the eMMC card completed the first erase operation
> > successfully, then yes, the second erase should work.
> >
> > However, what if the eMMC actually failed with the first erase? How can we know?
>
> In the case where ->card_busy() is used:
> As busyd0 is still 1 in the STATUS register, we cannot know if the
> command really finished. And as the DPSM is stuck, we cannot send other
> read command to check what is on the card.
>
> As I said in another thread:
> "I've discussed with Ludovic, and it is somewhat related to this patch set:
> https://patchwork.kernel.org/project/linux-mmc/list/?series=186219&state=%2A&archive=both
>
> The STM32 SDMMC IP needs a specific reset procedure when a data timeout
> occurs. If it is hardware, this is managed with the threaded IRQ. But if
> it is a SW polling (if R1B is replaced with R1), there is nothing in
> frameworks that could call this "unstuck" procedure for STM32 variant.
> I don't know how this should be handled."
>
> Are there other things I should check?
>
> The main issue here is that we cannot use R1B if timeout >
> mmc->max_busy_timeout, and SW polling won't be able to call our reset
> procedure in case of trouble.

Right, I understand.

As a simple initial fix, I would suggest you to set
MMC_CAP_NEED_RSP_BUSY for the stm32 variants. This also means you need
to cap the used timeout written to MMCIDATATIMER (when using
MMC_CAP_NEED_RSP_BUSY, cmd->busy_timeout may be greater than
host->max_busy_timeout).

I guess this should work for almost all cases, as 86767ms is rather long.

Long term wise, we need to think of another option. It seems to be
okay to use R1 in favor of R1B and then poll with CMD13. However, in
such cases the controller needs to be reset to move out from DPSM.
Perhaps we can let the core invoke a new callback in the host, to let
it deal with this in some way...?

>
> The second patch in the series, changing the MMC_ERASE argument from
> MMC_SECURE_ERASE_ARG to the argument chosen in the framework will then
> compute a timeout lower than mmc->max_busy_timeout, and the test will pass.
> But this does not explain why STM32 SDMMC IP doesn't react well to this
> secure argument after it has executed a write test.
>
>
> Thanks,
> Yann
>

Kind regards
Uffe
