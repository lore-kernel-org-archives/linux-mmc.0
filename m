Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEB6C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Nov 2021 16:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238882AbhKWQSO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238844AbhKWQSL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Nov 2021 11:18:11 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EFDC061574
        for <linux-mmc@vger.kernel.org>; Tue, 23 Nov 2021 08:15:02 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id k23so12261029lje.1
        for <linux-mmc@vger.kernel.org>; Tue, 23 Nov 2021 08:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1/M8/TbMw2+bg8CP1g2Qa/yEQ2sPxMoDxHHt0iItv3k=;
        b=sKybRDpkGeiFZMJgsGd9hp98heI5epsxXD/mRJsUdUkSM1IE+uycLqAQHeWYLI2/Cd
         EVVTYBwBx5fBXJeqhTbEwcZgUc+n7yK9xxJwDDZe+I4qm5k1CB080RAnps/y9axGsWTw
         lth9H5D3KalF+QUvatCE/ShPEmO7pXoaVV1dVogwpOhhOHjukOKM3FJQfG5qe+esqzVS
         z+gVApA+thXSXmnI2Ft8EvAnvrbwMsmuCYS4/onlzWe7Y35b159ntRSETK562DEkuJOA
         nQwsoRrygoxJsORI35hN4vLznToYf8CQ9wFiUU9lJoWDnzpY41enooiTQt4opquOrNTl
         8XJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1/M8/TbMw2+bg8CP1g2Qa/yEQ2sPxMoDxHHt0iItv3k=;
        b=QEPmM4oyK6rps4pAFYC14Xi/MHnyvc8azb02k5zy4RC7EkD8iukyF2OCt0sHqwM3rS
         DoezwC15AFP3mzIRnzcn6AOkqK1cm8+P1AiCzGY9kCrhJWRFPYg/8c8YMpX099K/Z/8/
         XbLJT/BCvu8Q93GQcLezrB9lxt8zuUszKX9sDaPDciv5waaPnil2ppBOlOvoPhtEYrCn
         XmV+2GI7HiJ7ZVFdyLdquj2UJVaiXsCL+WA+WnK/6pSg9ZJ3B6UZi7BRtbLHRQo93jgO
         BYpyj0pklUTEKKmQeGkervE/V1FMedLjrZaGPX8wyjFRatYLN6xiDZGQFWGa/6wlDarg
         crkw==
X-Gm-Message-State: AOAM532GCisXrT1+QUm996kcatJT0fHPHs51IMyWrKHdi5QXpO8xVFxD
        GP6GFtKCnNi6Ln4/P+XNlTbR9UEe4yp/fpfOvCtPwz6Qgt16AQ==
X-Google-Smtp-Source: ABdhPJz2OQIkPHuviN3voFUT32CIBpBVvOS0Emtx3t3DGrqeSJ91ZMgzgYmaIa86pU/AY+h65EDCq0IwQjz7L7+T8L0=
X-Received: by 2002:a2e:a5c8:: with SMTP id n8mr6705979ljp.367.1637684101255;
 Tue, 23 Nov 2021 08:15:01 -0800 (PST)
MIME-Version: 1.0
References: <20211115160226.20885-1-wbartczak@marvell.com>
In-Reply-To: <20211115160226.20885-1-wbartczak@marvell.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 23 Nov 2021 17:14:24 +0100
Message-ID: <CAPDyKFrkLQaFp_L0uZzB_KWnNkehg8ECK4cnf8o1yGCB9UZkBQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: cavium: Ensure proper mapping between request and interrupt
To:     Wojciech Bartczak <wbartczak@marvell.com>
Cc:     linux-mmc@vger.kernel.org, rric@kernel.org, beanhuo@micron.com,
        tanxiaofei@huawei.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 15 Nov 2021 at 17:04, Wojciech Bartczak <wbartczak@marvell.com> wrote:
>
> The MMC block in octeontx2 uses architecture, where data lines are
> shared between up to three supported cards. To keep the track of the
> request hardware reports bus_id for the command complete interrupt.
> At the same time the driver keeps information about the request on the
> fly. This change combines these information to ensure proper mapping
> between the request and the response.
>
> Signed-off-by: Wojciech Bartczak <wbartczak@marvell.com>
> ---
>  drivers/mmc/host/cavium.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
> index 95a41983c6c0..24ea03f5a7c0 100644
> --- a/drivers/mmc/host/cavium.c
> +++ b/drivers/mmc/host/cavium.c
> @@ -438,6 +438,8 @@ irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
>         struct mmc_request *req;
>         u64 emm_int, rsp_sts;
>         bool host_done;
> +       struct cvm_mmc_slot *slot;
> +       int bus_id;
>
>         if (host->need_irq_handler_lock)
>                 spin_lock(&host->irq_handler_lock);
> @@ -455,7 +457,19 @@ irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
>         if (!req)
>                 goto out;
>
> +       slot = mmc_priv(req->host);
> +
> +       /* Get response */
>         rsp_sts = readq(host->base + MIO_EMM_RSP_STS(host));
> +       /* Map request to cvm_mmc_slot */
> +       bus_id = FIELD_GET(MIO_EMM_RSP_STS_BUS_ID, rsp_sts);
> +       if (bus_id != slot->bus_id) {
> +               dev_err(mmc_classdev(slot->mmc),
> +                       "Remapping, request for slot %d, interrupt for %d!\n",
> +                       slot->bus_id, bus_id);
> +               slot = host->slot[bus_id];
> +       }
> +
>         /*
>          * dma_val set means DMA is still in progress. Don't touch
>          * the request and wait for the interrupt indicating that
> @@ -493,8 +507,9 @@ irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
>             (rsp_sts & MIO_EMM_RSP_STS_DMA_PEND))
>                 cleanup_dma(host, rsp_sts);
>
> +       if (mrq->done)
> +               mrq->done(mrq);
>         host->current_req = NULL;
> -       req->done(req);

This looks unrelated, please drop this from @subject patch.

>
>  no_req_done:
>         if (host->dmar_fixup_done)
> @@ -669,6 +684,7 @@ static void cvm_mmc_dma_request(struct mmc_host *mmc,
>                 set_wdog(slot, data->timeout_ns);
>
>         WARN_ON(host->current_req);
> +       mrq->host = mmc;

Please, no. We don't want the host driver to update the mrq->host. If
that should be done, which is kind of questionable to me, that should
be managed by the core layer.

In this particular case, an option could be to store the bus-id that
corresponds to the slot for the request that is about to be started.
Along the lines of how we store host->current_req, below.

>         host->current_req = mrq;
>
>         emm_dma = prepare_ext_dma(mmc, mrq);
> @@ -776,6 +792,7 @@ static void cvm_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>         mods = cvm_mmc_get_cr_mods(cmd);
>
>         WARN_ON(host->current_req);
> +       mrq->host = mmc;
>         host->current_req = mrq;
>
>         if (cmd->data) {

Kind regards
Uffe
