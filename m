Return-Path: <SRS0=q7gx=CZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10735C43461
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Sep 2020 09:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4A9B22247
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Sep 2020 09:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JjoWgMgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgIPJrw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Sep 2020 05:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbgIPJrs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Sep 2020 05:47:48 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83E7C061788
        for <linux-mmc@vger.kernel.org>; Wed, 16 Sep 2020 02:47:47 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id j185so3656345vsc.3
        for <linux-mmc@vger.kernel.org>; Wed, 16 Sep 2020 02:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7P+jxsvFFS3Yki3uqfybz90Ph0CsUCCdpMR0ItdA0M4=;
        b=JjoWgMgpDD9SG5nHIqJY7WvFokPSY7qNVS8OVH++a5tOkk//5ocqvTyVIZGOIGM8s8
         EHWBumFRAtJB8cqIIIkgoXGLYkuWS2kKP/WRvY4xt+U16bhMAeAGaGE5YD7JsZeMfrUd
         V5yLLz5opo+ZZShW9raXtu16Xmv1JJAEv11QNwYT+G7zcxuTNaNtof/dlGjHSnFP+tdS
         vUfUBnCUlhxwXADo+GbCpvH/kXdVwMnOseuT4ZYm0YpqXEXdWqKjWKK+11jgV/Z8Zko5
         zyP0An524zzpyOrKdFg5Wy12EVdzZsnewt4grkqyjmfw4OL/dVgrH4FIw+1Pasut5nep
         ayzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7P+jxsvFFS3Yki3uqfybz90Ph0CsUCCdpMR0ItdA0M4=;
        b=Uk/gEg8/tIpysSjQQ+zntpJ7/bT+i1rr8LUq9WZdlIX+Q528L0DL7ctZ0MNAs4vKIf
         OeB4AECpik1czQDcauA6zHuhMjekeb8nBKI5Af2f6rU1uVaDvrDVEKYEqrRWAX3uzdG2
         Ru3FY3bQjv2ZFnuLAq14eolGujzoIfdinubAX+2PIS4ttuMEIPhIEWY30BUnyXeUejH9
         N6AKzdJBoxZ2soZRCO5fGHbtyt5osX1rrZtFXqNzfPxd+PnYE+NLHBNgwmtFI4ScCc36
         FRKg6bzI8UE6BxKFIJfmP2HcT1nOmXYRVmVi62P3AgUH1yKq833G1XyggimL6AwJChIi
         yvdw==
X-Gm-Message-State: AOAM532B3Fe+K30WHftfxXxB7CmRlVf9naNaqQBwBFS6hzf/kIRCQOhN
        amEGV4fFpmtEM4XjisgJxRvqzQRkNgFXDoq0Jzezy8szc2kzD1ib
X-Google-Smtp-Source: ABdhPJyVcCEiMQDaexRK+LutCz+LjLsEHzITROaqIPVXoSGFJnvdTG0NSHDwRbOsM+uzjK4J1N6+XwBiQ/BLf5RtqlQ=
X-Received: by 2002:a05:6102:910:: with SMTP id x16mr3957492vsh.42.1600249666784;
 Wed, 16 Sep 2020 02:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200916090121.2350-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20200916090121.2350-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Sep 2020 11:47:10 +0200
Message-ID: <CAPDyKFoUw=xkPbCORSJ2io7Gs34dbbXQaGXdTsuzUqd+WEdR=A@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: document mmc_hw_reset
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 16 Sep 2020 at 11:01, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Add documentation for mmc_hw_reset to make sure the intended use case is
> clear.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> While working on this, I get the feeling this function should be renamed
> to 'mmc_card_reset' or something similar. 'hw' is still confusing
> because it could easily be the host controller, too. I volunteer to
> prepare a patch if we can agree on a better name.

You have a point. Although we also have mmc_sw_reset().

Another thing that I would like to change is to make both of these
functions take a struct mmc_card* as in-parameter, rather than the
current struct mmc_host*.

Not sure that it would completely solve the confusion, but at least it
would be a little more clear.

>
>  drivers/mmc/core/core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 8ccae6452b9c..a9ad72a18d1b 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2063,6 +2063,16 @@ static void mmc_hw_reset_for_init(struct mmc_host *host)
>         host->ops->hw_reset(host);
>  }
>
> +/**
> + * mmc_hw_reset - reset the card
> + * @host: MMC host to which the card is attached
> + *
> + * Reset the remote card. This function is only for upper layers, like the

Perhaps make it clear that it's a full (or hw) reset, not just a reset
(as it could also be a soft reset). Moreover, I think you can skip
"remote".

> + * block layer or card drivers. You cannot use it in host drivers (struct
> + * mmc_card might be gone then).
> + *
> + * Return: 0 on success, -errno on failure
> + */
>  int mmc_hw_reset(struct mmc_host *host)
>  {
>         int ret;
> --
> 2.28.0
>

Kind regards
Uffe
