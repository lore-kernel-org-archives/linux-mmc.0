Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D2EC433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 22 Nov 2022 15:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbiKVPpT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 22 Nov 2022 10:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbiKVPpL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Nov 2022 10:45:11 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBDE711AD
        for <linux-mmc@vger.kernel.org>; Tue, 22 Nov 2022 07:45:10 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 71-20020a17090a09cd00b00218adeb3549so6257104pjo.1
        for <linux-mmc@vger.kernel.org>; Tue, 22 Nov 2022 07:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=//83h2K3ZLQK+/apVRAjIhcjjf8VIwpKCeqeGKpSWZY=;
        b=mQ2TPmCmbeO2oEaUGOMCR5p6U+FvYLrqFxv1UfblbK31Cjk86Dzj1VRFW+3xgXHSee
         P1iLErDVURrom5YmlKKy5Hm5wUNJuwAxdKKSZLiJnuLLMyoQrIAkaIhNr/8x1+/B8sBz
         oL51ArMvrbICSV77LjYGc3nw8fBKl1m9BV5HBQC5j8X9kz1DANWKAKGYAPRQFkS+u0/q
         4m8jjWpMQi6E7XrVg/L5rGfQRM1UUfLElnsqQHWJt5X4MDL2wY1mHfeh7/YXXi0v26wu
         XYbXCaYKN1fvJT1RejRoqjjRTU3GwBweHDl21IiCEJucEIFUfTqT92ZO7H6DuqWXlBtx
         qNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=//83h2K3ZLQK+/apVRAjIhcjjf8VIwpKCeqeGKpSWZY=;
        b=DPFFSkASV4InyLDEqKUVYRmR6gSaZDQnMUBhLGGAnDY0md+qT++FwLfh4IDGwrcWih
         LVhc8xDOz5ku6BAsKPhXKkIAFhKv4ZA/H8Zv96xyjZ4tnpoXs5UPct6H+MWn8UfSEyvr
         8Gvq7AKNYvUEj3aumL+9S+CnUlFjAmowEJKCtlPAw3bD9vfoigZcVZbkVOKmcIH3MQ+v
         nVcCKfwdL2QB8JBfALGRO1oQSA/OXynjWdoYon92Sm3EpmBHeK2VuVMByPn+4+rYDojJ
         vgVbzp2UVJ1GVzsHYinA180bp76liCm6Zis6IOAHbP1IuC/MDZj5X+pY9s8dlU+Fu1in
         MXsA==
X-Gm-Message-State: ANoB5pmv17SjR6hgMffNoy34qnw0FQfeG7QKA3G2w6mhejBvHjaAqvXo
        7UCoxt4WmA9Qqe2knxX3SvOE5Loh6zkpgiQobrBh5iblrMo=
X-Google-Smtp-Source: AA0mqf4VfPCyLmtp8j0+qyvDLQRIHPDQzOIdolOfydLyrr0DoNkh3+nOSyPXEvx82CHH7wstZd8JDV/7OMBAxHAP6TU=
X-Received: by 2002:a17:902:d68b:b0:188:cca8:df29 with SMTP id
 v11-20020a170902d68b00b00188cca8df29mr10491383ply.148.1669131910075; Tue, 22
 Nov 2022 07:45:10 -0800 (PST)
MIME-Version: 1.0
References: <20221122091856.47606-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20221122091856.47606-1-jiasheng@iscas.ac.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 22 Nov 2022 16:44:34 +0100
Message-ID: <CAPDyKFoG-h65=GRSPCqZYmtVFfMkeva6007R4E7BXuaoJu-qxg@mail.gmail.com>
Subject: Re: [PATCH] memstick/ms_block: Add check for alloc_ordered_workqueue
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     maximlevitsky@gmail.com, oakad@yahoo.com,
        christophe.jaillet@wanadoo.fr, axboe@kernel.dk, hare@suse.de,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 22 Nov 2022 at 10:19, Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
>
> As the alloc_ordered_workqueue may return NULL pointer,
> it should be better to add check for the return
> value.
>
> Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/ms_block.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
> index ba8414519515..ccfdb3dea30a 100644
> --- a/drivers/memstick/core/ms_block.c
> +++ b/drivers/memstick/core/ms_block.c
> @@ -2116,6 +2116,9 @@ static int msb_init_disk(struct memstick_dev *card)
>         dbg("Set total disk size to %lu sectors", capacity);
>
>         msb->io_queue = alloc_ordered_workqueue("ms_block", WQ_MEM_RECLAIM);
> +       if (!msb->io_queue)
> +               goto out_cleanup_disk;
> +
>         INIT_WORK(&msb->io_work, msb_io_work);
>         sg_init_table(msb->prealloc_sg, MS_BLOCK_MAX_SEGS+1);
>
> --
> 2.25.1
>
