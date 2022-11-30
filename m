Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFABC352A1
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Nov 2022 10:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbiK3KFF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Nov 2022 05:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiK3KFE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2022 05:05:04 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F45165BB
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2022 02:05:04 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id f9so15576161pgf.7
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2022 02:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p+yt+polAYGWkxe5XK/5FXnciL8HR/33O9D6Q+Xt574=;
        b=NJ/8BLLOmf100W4hr4eODpPgmL4v0vhacEbadQo1Ds2mgcuw66j9XtIVn+BAfr7fBp
         S90Lf487KK/0o5s30+Cnbng+JrU41S5TeKvNh+PBaCAkNG3vJrUFtHf+rKwT/JBPnp2D
         KM0q4EcNFueM8dGeB7ABFc7UBKlKICpBl4Ng81kTMhPSbeiB0LMLHPMpNjLOdKsRVVOe
         SrYFPLeFxtMQoynqilrAnGLi5nq0FGBkwT0gl8FTsXzy+9YFWmAoei1kL9OLn7i0Jg/U
         /luBIrJ38MxImY+824/2sZGzXfbvlrVJMLcrMGF9fbUDfGZK+v8+JfEMdKcWlVfHhYH7
         ri2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+yt+polAYGWkxe5XK/5FXnciL8HR/33O9D6Q+Xt574=;
        b=5nS5QMQYS9K6s/SyJU1PdR7jeahwLBG0M0nJ30J6+XqTCpS4j0K/7lUVPhxX6W1CBP
         b2Dk8PTwqrEbSpIKuOlCOKoCzKt7xGhLrizWiNfsB/OzV67lHXJ6TuhMmL2sSzpnk4gx
         VXehBGUqnQaJ+e1PWoudYZBJFsCoO6HeSFtRXWXeEphrD8Sic2jz/8k0JItBobsdVYTG
         aIxrzfSoXyU2u+fr9CslfNj3S6IkR05TTdUse7sJLiTQyeFQ+URH1+35HW7fRc2Rjuvd
         M7THiwuORMa+JTVm0XDqj1tkJatx4DV2auHNqc9iZdDarR8O1V8YJsK60ptibyeMR8ZV
         8SUQ==
X-Gm-Message-State: ANoB5pn7WvuTzIaf8uwpAjYTeuSZhfRalue42kn9zP6SHsBMiTwGdn7H
        V7O69H/mocrvm05+ZOSl6KCYK4MNy9OxCWh/R0u3TQ==
X-Google-Smtp-Source: AA0mqf7olze2ulbSbK/lUjhobNgKgIS0hqBKaJrXrO5CT1xYpROW+WEywkC2ce39BQ29fnNSnU17q2k2dbNY1oCmpN8=
X-Received: by 2002:aa7:998a:0:b0:575:6907:662a with SMTP id
 k10-20020aa7998a000000b005756907662amr8969604pfh.57.1669802703491; Wed, 30
 Nov 2022 02:05:03 -0800 (PST)
MIME-Version: 1.0
References: <20221130092847.2092-1-thunder.leizhen@huawei.com>
In-Reply-To: <20221130092847.2092-1-thunder.leizhen@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 30 Nov 2022 11:04:27 +0100
Message-ID: <CAPDyKFphNdR-TorULpbsMtM6MzqsaK_UdSmG9Hin=wunUwJwJQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Fix error return code in sd_read_ext_regs()
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 30 Nov 2022 at 10:29, Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
>
> Fixes: c784f92769ae ("mmc: core: Read the SD function extension registers for power management")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/mmc/core/sd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 3662bf5320ce56d..7b64f76f0179ca8 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1277,6 +1277,7 @@ static int sd_read_ext_regs(struct mmc_card *card)
>         if (rev != 0 || len > 512) {
>                 pr_warn("%s: non-supported SD ext reg layout\n",
>                         mmc_hostname(card->host));
> +               err = -EOPNOTSUPP;

The original intent was to not return an error code. Simply, because
the card remains functional and all but the new features from the SD
function extensions registers can still be used.

Perhaps, we should update the comment a few lines above to better
reflect that this is in-fact what we intend here.

>                 goto out;
>         }
>

Kind regards
Uffe
