Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B029C4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Oct 2022 14:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJMOVY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Oct 2022 10:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiJMOVX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Oct 2022 10:21:23 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE3C481D8
        for <linux-mmc@vger.kernel.org>; Thu, 13 Oct 2022 07:21:22 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 128so1702466pga.1
        for <linux-mmc@vger.kernel.org>; Thu, 13 Oct 2022 07:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QslV9665L65zG9Gm0pYGNEWgIRNaVZVdsPZkFFyGy6w=;
        b=U4YGN8frK0VJYapVchJEbRJh7BaYK/HQN944aQ0aZ1KGomEe7i8SVtXuhsBAedZfHt
         k25aAxLxmqdWdLib1XPs9wAw9Xrqyz6yUPwfmK7x5EMfIouXr2pUn0PfQfO+zAnXoh4/
         UhZ5P5IJr1JUs9EkGoaPukz4Wn4NYDQnQ+JTvLzGeQzPl1/BAMiZ/dwv7yVau17+W4U3
         lUuqWuChBXmTrAM2d+53GfW0dVP9X7jdypxW/jD8YHZyAupchs1gUokUO5ZuHUucR9mM
         1eIDlPDyGiMjeHHlmzoUbqqr3pNgP7mVv9VaVbPwbSdMLPPadB4H1CGgyl87dmfWID0O
         UKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QslV9665L65zG9Gm0pYGNEWgIRNaVZVdsPZkFFyGy6w=;
        b=MmIFKsUEc8Q9GyOUlogoAifOZhe3JmX/yNc2xh+Qe9K4D+y0WEstihY+AfKjUeaORV
         IkNgeTsa12Jod6KiOtoFZgoPnF8QDUKUzmgkdzP9oamolQiT28jFXUhRLROzjz6S2w65
         btMAf1qAw1SbbtJ+wROSzDwD8OPR9uHFsTAfVpIoBTqyAsLdpKZD1pNK4rQ09Hm90oPD
         xFRwL3DpA72LO35fFLsPoTOrn/y3M9JGGabqYfGbGUccGFWQco4bS4yIuFUnpAT63MRx
         iLdIRAycb5iPxCRTxhWvIt+LQ6ftDof5Ilc3JXHykkzLiQN0vtsMmlHH/2MaSEIsIvBl
         P63w==
X-Gm-Message-State: ACrzQf0XpTbUQSbwoaQAAXw3AA7o6f2MJdN+23NPDBUWcXbHDRDnuj3v
        HVtUuCL/RO+XFmXOqmTw/UciZPrPvrPNm++fr2NOSA==
X-Google-Smtp-Source: AMsMyM6luYJp9htQXndrF1SxY/62xT+d6WKet202Lamm5hl8r1j1Aw7jo0GNlj13Y81bRQDZ5c76LYwvC9OI6BYFI50=
X-Received: by 2002:a63:90c4:0:b0:45f:c571:67eb with SMTP id
 a187-20020a6390c4000000b0045fc57167ebmr64326pge.541.1665670881622; Thu, 13
 Oct 2022 07:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <c865c0c9789d428494b67b820a78923e@hyperstone.com>
In-Reply-To: <c865c0c9789d428494b67b820a78923e@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Oct 2022 16:20:45 +0200
Message-ID: <CAPDyKFoKZbY456VF9hwvyNSsuZ-H2Lh-BfaPreK7PfFkGDWWzQ@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] mmc: queue: Cancel recovery work on cleanup
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 7 Oct 2022 at 17:43, Christian L=C3=B6hle <CLoehle@hyperstone.com> =
wrote:
>
> To prevent any recovery work running after the queue cleanup cancel it.
> Any recovery running post-cleanup dereferenced mq->card as NULL
> and was not meaningful to begin with.
>
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> -v2: Use cancel instead of flush
>
>  drivers/mmc/core/queue.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index fefaa901b50f..86be55d7cf55 100644
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
> +        * the recovery not quite finished yet, so cancel it.
> +        */
> +       cancel_work_sync(&mq->recovery_work);
> +
>         blk_mq_free_tag_set(&mq->tag_set);
>
>         /*
> --
> 2.37.3
>
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
