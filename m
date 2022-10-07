Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C8EC433F5
	for <linux-mmc@archiver.kernel.org>; Fri,  7 Oct 2022 13:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiJGNNR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 7 Oct 2022 09:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiJGNNP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Oct 2022 09:13:15 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459A1CBFF4
        for <linux-mmc@vger.kernel.org>; Fri,  7 Oct 2022 06:13:14 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id x1so4510725plv.5
        for <linux-mmc@vger.kernel.org>; Fri, 07 Oct 2022 06:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bx1A8VZz2C9MrIadfwpDwtJ95gIG5yP6liuo34oI2JU=;
        b=klfdocq1WkN/CJB6VFdoFVsNBhv2or+S6nkqOOeN+5/2YRV/U4XmlES4zvcZfA4a4k
         DvSgiVZMPhP979+YaFDhbOxrLiAFhYlF2L8NnPuocmimP0nMRALkcWwBhzo1N5sqEF50
         Sup7/NvbiGeRh97GYXxzXxN2VgBmdByVeugdayYBWYoMIa9h7x2S6oldfIlzx9seWajQ
         tXiekocjVamz9qFgCqeDele+fBqURG1PIZ7kWPLgLannPAIlsfqwP08nWsZCqCT91DDW
         XCmPtKGcJJMx/n1D89j15MOfGwDr/XkxuKuVLdN3OKFbekMEFTDbT3NEiOsj80xYEeZG
         i6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bx1A8VZz2C9MrIadfwpDwtJ95gIG5yP6liuo34oI2JU=;
        b=ouSJHWh2KycNk/R2YlblBQ7axB/FgmPSNrYwQlVpeEMULQHY2r0t9tsd/D46XB238s
         ZjChFd9UTdcBpVDvEhPXVE0r4CTGbKTm1+4m7KpJkH/b3o5FYL21ep4Jr95AgfAJOU3l
         vhEionNl9JcKna7CFLGlctMqhF4wfbu+IyPdBlklxnL70GuOPIaYLv8ZGFiAva4OJyUK
         tSiSNJRJ8SoRFQ5Cf4o/d/aTgSLIhbpYz+5iAYB4l99hOiGlDaZveIFD9C/RfhIWRFEC
         9N3o5SCi4zTY32BCxbfY4rvPLCrhrfTLtsWR/hB9aNxLPwZX4m+BPl3AW9VQotpLx4xS
         as1w==
X-Gm-Message-State: ACrzQf3uc/N0pAJCRCVsdgYgRnVLKxr4JhUYk8uKBdNcLu3vwwa6dXXH
        D0ChJ1DMCVY6GwO85sGyv6lc8+C7TrT+NEQFMztfu1bV1BA=
X-Google-Smtp-Source: AMsMyM7tGKO3Q1AzhonCNeE4O6rxBaH/B+z+9vUkBMit50X+3vZ9txh4xN776AnHvV+41w+DJw5eWc/WdYcyjyZyq7U=
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id
 mw7-20020a17090b4d0700b001ef521cf051mr16774732pjb.164.1665148393003; Fri, 07
 Oct 2022 06:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <08aac29e2d8545a6b56e092bc508409e@hyperstone.com>
In-Reply-To: <08aac29e2d8545a6b56e092bc508409e@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 Oct 2022 15:12:36 +0200
Message-ID: <CAPDyKFqw2CNS+M5iMcP-_FyBThrUvGbyECMrEJheUD4YP7fwEw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: queue: Flush recovery work on cleanup
To:     Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 6 Oct 2022 at 15:39, Christian L=C3=B6hle <CLoehle@hyperstone.com> =
wrote:
>
> To prevent any recovery work running after the queue cleanup flush it.
> Any recovery running post-cleanup dereferenced mq->card as NULL
> and was not meaningful to begin with.
>
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  drivers/mmc/core/queue.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index fefaa901b50f..a1b985d3dfda 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -493,6 +493,13 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
>         if (blk_queue_quiesced(q))
>                 blk_mq_unquiesce_queue(q);
>
> +       /*
> +        * If the recovery completes the last (and only remaining) reques=
t in
> +        * the queue, and the card has been removed, we could end up here=
 with
> +        * the recovery not quite finished yet, so flush it.
> +        */
> +       flush_work(&mq->recovery_work);
> +

Not sure if it really matters in this case, but isn't
cancel_work_sync() the more proper thing to call instead?

>         blk_mq_free_tag_set(&mq->tag_set);
>
>         /*

Kind regards
Uffe
