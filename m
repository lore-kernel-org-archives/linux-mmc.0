Return-Path: <SRS0=Un3z=CS=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3719C433E2
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Sep 2020 11:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 873B720897
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Sep 2020 11:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QAazgdff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgIILfL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Sep 2020 07:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729521AbgIILcO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Sep 2020 07:32:14 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721BEC061786
        for <linux-mmc@vger.kernel.org>; Wed,  9 Sep 2020 04:24:58 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id b16so1115355vsl.6
        for <linux-mmc@vger.kernel.org>; Wed, 09 Sep 2020 04:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=YwF7oGdkWmJxr0DaGGL2B5zSMTxCBRgZEPjg5JlP9Ks=;
        b=QAazgdff84HXGeKSgLpqmQVikaFSdP5UNb6QrEEWjbfQtYZbq/0ISulDu4wVRDbAgV
         Blzaz406rfa9YdqqZ5byBj240HvKycb6mfHlmdSRBOaSWl+UNf/kM3UM8Nu53SmvTycg
         3DG2b4SlvINhCnVkLOheyROaLI1GgGzumTLHyV1QTg1hRGVrFNoeyAQ+WuglXbW6AUCl
         mGwzRhpfqjEiby8FgSU1jXPWUl9uJGpKpD6VcUs0sl5sTt910ES8bg+jdlhLxGjQsC+1
         1LCpHDV2JXl79AMSuB/lgZeCe5RvygOAaXT6CdcFlDcMmv25hU03bv87mITUk7WP9GAD
         AQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=YwF7oGdkWmJxr0DaGGL2B5zSMTxCBRgZEPjg5JlP9Ks=;
        b=h0U8qwlZoVAu09VrbPj0k3LI25iBbGt2+eEqF5XsgwWZcWb+k+ouIBEoDZvdsc/x6/
         lStt9bG1ZTL1vvVH0TEXxnJEd0pWoxuIgy7vtkG6jf8W/gb2DBGYiclxeF+gfIeJEUBq
         x0CsNsl8VO7Xi9BJG3IBmzBa5jdihgOhajT9RzqzLihQI10vVo8lOi9kJI3RBm5WRVyZ
         /jE/jaqRzvt1F9c56+8+Nuq/IeXl0+RjSzMjZ5ppmUIETjDx/JtYEQFkIeZr5cLLiKc4
         cz/4fcsdZTNh7cRKJ8OC6+YTzdTDQKKTc6dEhuE5kaXXd4J0rdgXnjXZJDxoFEhtU1IH
         v/0w==
X-Gm-Message-State: AOAM531hVq9RVZ7BmGgEPqY8wOZEh10ZbZyJXlSDekQIU5dp3+bzC+gB
        dAeFEeehhk5nNR7xxQQm4mD6hwMLCYn8Drfj/66/m4iEeRhIhw==
X-Google-Smtp-Source: ABdhPJyX26PiK8pf7hK5CA4/JStCB7QVEAiAc0iFsKHA7XBKfawE+lpIL55g2UGbvOG2rRpZZjOsbTjNKTGylQm5SnU=
X-Received: by 2002:a67:e355:: with SMTP id s21mr145683vsm.50.1599650697707;
 Wed, 09 Sep 2020 04:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200821081654.28280-1-wsa+renesas@sang-engineering.com>
 <CAPDyKFp7rsHDY2vREakrR+PFJLs0n8JBR+URV1vCu5bydEhHuA@mail.gmail.com> <20200830130357.GA2194@kunai>
In-Reply-To: <20200830130357.GA2194@kunai>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Sep 2020 13:24:21 +0200
Message-ID: <CAPDyKFr24YxoJ3m5r1C_4-UAdtJQp_MK0+wwZjsQXzrs5dxLjw@mail.gmail.com>
Subject: Re: [RFT] mmc: tmio: reset device on timeout, too
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 30 Aug 2020 at 15:04, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > This isn't how mmc_hw_reset() is intended to be used. Instead, the
> > idea is that it should be called by upper layer code, when some error
> > path is triggered for an I/O request.
>
> Hmm, there are some wireless drivers using it as well. I am confused, is
> this considered "upper layer"?
>
> drivers/net/wireless/ath/ath10k/sdio.c: ret = mmc_hw_reset(ar_sdio->func->card->host);
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:        mmc_hw_reset(sdiodev->func1->card->host);
> drivers/net/wireless/marvell/mwifiex/sdio.c:    ret = mmc_hw_reset(func->card->host);
> drivers/net/wireless/ti/wlcore/sdio.c:  mmc_hw_reset(card->host);

Correct, these are "upper layers". The same applies for the mmc block
device driver.

In this way there is a guarantee that the struct mmc_card is still present.

>
> I'd like to understand, so I can add some docs. Because the intended use
> is nowhere documented to the best of my knowledge.

That would be great. I appreciate all kinds of improvements on the doc parts.

>
> > However, let me think a bit about this.
>
> Sure, thanks for the help!

Thinking more about this.

Perhaps a better option is to return a specific error code for the
last request, that makes the core run mmc_hw_reset(). Or potentially,
add a host cap and let the core treat some error code, specifically
for hosts like tmio.

Kind regards
Uffe
