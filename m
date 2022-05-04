Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9FBC433EF
	for <linux-mmc@archiver.kernel.org>; Wed,  4 May 2022 09:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346889AbiEDJMe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 May 2022 05:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345902AbiEDJMd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2022 05:12:33 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8074E1D0E4
        for <linux-mmc@vger.kernel.org>; Wed,  4 May 2022 02:08:57 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p10so1216249lfa.12
        for <linux-mmc@vger.kernel.org>; Wed, 04 May 2022 02:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5c+QX1+5JA50duqNcGfay1+wV5nv/a3KdvPCeKfT4pc=;
        b=NgK54GM4aokbIxczLXJ/dN+bzF9IL8vgtmdlpX/nVXRf5t8fI32yFeXyQlczYwfCcP
         fveCnS7cBOQMlGcio9DlALNY4kdogFFxRp0/EFtjSBVzabeJpl21BpC8SnxyDl5OdfqM
         88jX1lR4VpS2zLX+72dTPRf6wrur0W8pLYDFK43igYmBh9e/wNi6wRG8lv+h2XlURl/U
         6gGbKpAE5zDLDeVK9AC9Qbz86yrkgYHn+PHJ9lB9Kpg9LWt0l4U+s6EPAY7l8JUKDQxB
         +wtT1eypWJu4Y2quanC+E21OSpLxe7NxQfgudO7uAL1hHOR+w4QauqDU8YD7nqbfawbG
         isKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5c+QX1+5JA50duqNcGfay1+wV5nv/a3KdvPCeKfT4pc=;
        b=BF85Urr8GC6+xVYneIfU+7fnJ175ArNw1QlHpNxx+e75sfU3N/uGiaiMzkPUhc7G5F
         pF0AF9T94sZ8Fwd6/wyRHBUzpOpBf3uNfiYXRKe128rkqLReIgBdd5UjxeGCjNJ35YKl
         EORoJJxYhTV+5nZJp3yEzRLTb4hsNv/wDJKzwd8fPd2fyQYv6+oi1ZfAuPQsyT+3vKor
         +MupN1QI6douR6t6cnnpnMXhcy5Xroa5CyH/w7/T1guPnQFhu3Qp4bJdnnWV7vf8GniC
         LjIBfUxuaqg2NL2WXR5g/Dk/apofSzhLECC0iQWrOrPr+N5Tx3RacipwZ2x2co0vtlLf
         zJnw==
X-Gm-Message-State: AOAM530yamVlI4/xO9W53K9b0d08+qDCMtRfIiDsM8dBTArI4uhXkgwm
        s5XBfvEmTyLCr07ohkmKkt8MuqUJvIQBaCXooLUmjw==
X-Google-Smtp-Source: ABdhPJzLbEZ5HQ1NesIENes4Oo5j6+uhU6gI2bADA0qJA1+mznHE+1x8wdW8SsACfpqsFaiA2T3ppaIfc4ww7y3dKCc=
X-Received: by 2002:a05:6512:5cb:b0:472:f7e:a5f5 with SMTP id
 o11-20020a05651205cb00b004720f7ea5f5mr13010182lfo.358.1651655335817; Wed, 04
 May 2022 02:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220304105656.149281-1-ulf.hansson@linaro.org>
 <CAPDyKFr1PzSaiKqB4ZoqTS_8bGsEH=aB3ARhxyGu+cYeRqeBew@mail.gmail.com> <20220504054652.GA7851@math.uni-bielefeld.de>
In-Reply-To: <20220504054652.GA7851@math.uni-bielefeld.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 May 2022 11:08:19 +0200
Message-ID: <CAPDyKFrBVyYx+BybGR2P8paS6qA=V2EHAXH+vPUc9JzxoXn6+g@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Restore (almost) the busy polling for MMC_SEND_OP_COND
To:     Jean Rene Dawin <jdawin@math.uni-bielefeld.de>
Cc:     "H . Nikolaus Schaller" <hns@goldelico.com>,
        Huijin Park <huijin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 4 May 2022 at 07:46, Jean Rene Dawin
<jdawin@math.uni-bielefeld.de> wrote:
>
> Ulf Hansson wrote on Mon  7/03/22 13:17:
> > On Fri, 4 Mar 2022 at 11:57, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > Commit 76bfc7ccc2fa ("mmc: core: adjust polling interval for CMD1"),
> > > significantly decreased the polling period from ~10-12ms into just a couple
> > > of us. The purpose was to decrease the total time spent in the busy polling
> > > loop, but unfortunate it has lead to problems, that causes eMMC cards to
> > > never gets out busy and thus fails to be initialized.
> > >
> > > To fix the problem, but also to try to keep some of the new improved
> > > behaviour, let's start by using a polling period of 1-2ms, which then
> > > increases for each loop, according to common polling loop in
> > > __mmc_poll_for_busy().
> > >
> > > Reported-by: Jean Rene Dawin <jdawin@math.uni-bielefeld.de>
> > > Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
> > > Cc: Huijin Park <huijin.park@samsung.com>
> > > Fixes: 76bfc7ccc2fa ("mmc: core: adjust polling interval for CMD1")
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >
> > > Jean Rene and H. Nikolaus, if this doesn't work, please try extending the
> > > the MMC_OP_COND_PERIOD_US a bit, to so see if we can find a value that always
> > > works.
> > >
> > > Kind regards
> > > Uffe
>
> >
> > Applied for fixes and by adding two tested-by tags from you, thanks!
> >
> > Kind regards
> > Uffe
>
> Hi,
>
> with the current value of MMC_OP_COND_PERIOD_US = 1ms I still see
>
> mmc1: Card stuck being busy! __mmc_poll_for_busy
> mmc1: error -110 doing runtime resume
>
> regularly. The same with 2ms. Setting it to 4ms makes the messages go
> away. Would it be ok to increase MMC_OP_COND_PERIOD_US to 4ms?

It doesn't look like we have a very good alternative - unless the
problem is tied to a particular type of eMMC card, is it? (If so, we
can add a card-quirk).

The only other option I see, would then be to add a generic DT
property for eMMCs, that allows us to specify the OP_COND polling
period for it. See
Documentation/devicetree/bindings/mmc/mmc-card.yaml.

Kind regards
Uffe


>
>
> ---
>  drivers/mmc/core/mmc_ops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 180d7e9d3400..1fd57f342842 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -21,7 +21,7 @@
>
>  #define MMC_BKOPS_TIMEOUT_MS           (120 * 1000) /* 120s */
>  #define MMC_SANITIZE_TIMEOUT_MS                (240 * 1000) /* 240s */
> -#define MMC_OP_COND_PERIOD_US          (1 * 1000) /* 1ms */
> +#define MMC_OP_COND_PERIOD_US          (4 * 1000) /* 1ms */
>  #define MMC_OP_COND_TIMEOUT_MS         1000 /* 1s */
>
>  static const u8 tuning_blk_pattern_4bit[] = {
> --
> 2.35.1
>
>
> Regards,
> Jean Rene
