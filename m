Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2578C3DA6F
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Aug 2023 10:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240841AbjHXK4g (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Aug 2023 06:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbjHXK4C (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Aug 2023 06:56:02 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7598610F9
        for <linux-mmc@vger.kernel.org>; Thu, 24 Aug 2023 03:56:00 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-58d41109351so10516077b3.1
        for <linux-mmc@vger.kernel.org>; Thu, 24 Aug 2023 03:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692874559; x=1693479359;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DmxySgPzhnxxUTeywFheyR9KmyLlbR5/9tECTYy/UEo=;
        b=UaK5oz3c2QZPwlWA0J06xzTK/xDFzZZUAeUmpvMPlZj46JGOihJGLgJIi2kLwSrrCh
         3+85Zhuv0OQ85bwUFghZXFQtLS1OKK4f1KvUvXth2VCnAq7aXfnrUJZ09nXvftIj9ug1
         vqJdglFFR2XtF59xJ0TK8crRhW3Fj4vchycRaUAYcgkMH37beDeQeJdOalJdHnOTuK3X
         mFbwzsMfl/HgjTmkkxLCKn/VFwV13ccwjMX8L0dXjxo3YiUaYbjPyWWlCPv578PLRiY1
         YafaOaRX9Y1K/VGzxbHY8nTaj6bnuCZl9TTamO7gHZSeiUSWjP2tTsB/xR/7hR+6XAZj
         gJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692874559; x=1693479359;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DmxySgPzhnxxUTeywFheyR9KmyLlbR5/9tECTYy/UEo=;
        b=GaVSAJjldhlX1a1xt6Fbdy/u946uLHhHZldUJJGPW/V4bc2shcckjBwgKFITXgK5Lo
         BMnyr3EwL2qKAz0L2GSBPW1/ITrUVH/wuFbrm6vjwyYmY4HBUIOwI/LLfUej+zg5vaw7
         Dj4Ke+f1ZAtE/XcEthS52dnPky23EmoD3DIRxxUFASQ91wlbsc4IA7I6vvCTwxHJXwJ5
         JbY3ERi/UrkwVEaytrCv5bRJApRK5AxCniQHhJKlrGlM5NRer/1ATj9miUrhGh6aho2g
         PcwGNp1KaIp+h8ukjAIVJWWDK/BGXtU/sP9A/FlAgf3JV1NAs0XRb0oJhQ3KTqF7UrGF
         iUug==
X-Gm-Message-State: AOJu0Yz7A71Zk+HiFDODA7IH2eH+bGk7exkV7QoxFbQ2+3wZ7OTasp0f
        ps+gwqjr+REdVjNtldBwg61/czZvkLI9x/g6j4gCYA==
X-Google-Smtp-Source: AGHT+IG5g981hiNWc2Virq/saq14f3u+c5agrarXaFetTlwLXn91k4F7b/MHfUOZ5lpFVRkOWRINd19ymBubd9J94eU=
X-Received: by 2002:a81:4f49:0:b0:56c:f0c7:7d72 with SMTP id
 d70-20020a814f49000000b0056cf0c77d72mr13387507ywb.4.1692874559668; Thu, 24
 Aug 2023 03:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230818022817.3341-1-Sharp.Xia@mediatek.com>
In-Reply-To: <20230818022817.3341-1-Sharp.Xia@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Aug 2023 12:55:23 +0200
Message-ID: <CAPDyKFqN0K=2e4rijUBz=9LXVfhEVvDzNgqXTyTgvaPRK-PBNQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: Set optimal I/O size when mmc_setip_queue
To:     Sharp.Xia@mediatek.com
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        wsd_upstream@medaitek.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 18 Aug 2023 at 04:45, <Sharp.Xia@mediatek.com> wrote:
>
> From: Sharp Xia <Sharp.Xia@mediatek.com>
>
> MMC does not set readahead and uses the default VM_READAHEAD_PAGES
> resulting in slower reading speed.
> Use the max_req_size reported by host driver to set the optimal
> I/O size to improve performance.

This seems reasonable to me. However, it would be nice if you could
share some performance numbers too - comparing before and after
$subject patch.

Kind regards
Uffe

>
> Signed-off-by: Sharp Xia <Sharp.Xia@mediatek.com>
> ---
>  drivers/mmc/core/queue.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index b396e3900717..fc83c4917360 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -359,6 +359,7 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
>                 blk_queue_bounce_limit(mq->queue, BLK_BOUNCE_HIGH);
>         blk_queue_max_hw_sectors(mq->queue,
>                 min(host->max_blk_count, host->max_req_size / 512));
> +       blk_queue_io_opt(mq->queue, host->max_req_size);
>         if (host->can_dma_map_merge)
>                 WARN(!blk_queue_can_use_dma_map_merging(mq->queue,
>                                                         mmc_dev(host)),
> --
> 2.18.0
>
