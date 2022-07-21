Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B09C43334
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jul 2022 16:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbiGUQO3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Jul 2022 12:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbiGUQOL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jul 2022 12:14:11 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3E488E34
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jul 2022 09:14:01 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id q7so2368800lji.12
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jul 2022 09:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q7QxXiKuOMghvUoMABhfwVp87oQHsGQTWf296DamJr8=;
        b=CG2JQ4EukEwGNSvxcr9I3T1ZqzVuaQtGpMQsL2kTdDNk7uY6tPpBLFsetBDclPBiAm
         nzCgYCI22VulV+wGp1y4hhQnmI/lf2pajB2NoMdaMq5RIk9WZBGds+YGY+9PrALc3rJo
         B8aH5HjNGnaMap00UsKhV94JwgExvmDZzk/6l6sokRz7EN4JZa9jzQLm+8hzZ6QW+xOi
         ujUdN9ihoFCutB5cOgfZfF+McWOLfSJjgQmH0MSm0+OWCZspR8A1luxaGavkrDWntEl+
         jCmEFEKzPtzbph5MxBT8vXqBluLwkYs3vEcpK26KcGofZXl7VhVeNPFqOXbzc1r91TF8
         T5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q7QxXiKuOMghvUoMABhfwVp87oQHsGQTWf296DamJr8=;
        b=ZlapARS45vy7BgPPKSdfZQGafWjaSm//hrgwL/46VNG9XFOHqRiEPREtOgERosmZFq
         +F32ZnQEtPfQTMaL4QgwhQ90T+1bS1nQhnE0L/YltIdIEreepfO7QMygPZvo7IyeHw+j
         0v5ROI65BQtPnZqLomEN0YkeOdXxxJ7ZS1MlQPblZRtcOPlYdkGMuBrVn3R9j8lO9NNo
         riY850Pa2j7KtG+Z3t2f9sugrXnKzdwOHZZ056QQQIOkZKl2Xa7cnBFIaZm/5PU9h8Xw
         QdFcfMSF5Av0sSjgYInyaGCH4v91KI5cBU63l/XLhuus82q+QENgcDUAbxar/tcNrOuC
         8lZg==
X-Gm-Message-State: AJIora+gPvRjMRcQSuzQZWK1V2XFfNH3kkALn5bihbyC6zIC4DpXC7CW
        0Ln49p7WFOyaCHUBDbKG3jILrsE+fJDrtzXmBzOsAP5q5nA=
X-Google-Smtp-Source: AGRyM1uaTibP1p6+rVwjenRGlQLD3r3GqYUVSCWFdRSfgFkvi3+039aelzZqBQRVzAJLimaklHPFf5iNtEMlwtAX0L8=
X-Received: by 2002:a2e:804d:0:b0:25d:d98a:a908 with SMTP id
 p13-20020a2e804d000000b0025dd98aa908mr2589681ljg.4.1658420020702; Thu, 21 Jul
 2022 09:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220719091051.1210806-1-windhl@126.com>
In-Reply-To: <20220719091051.1210806-1-windhl@126.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Jul 2022 18:13:03 +0200
Message-ID: <CAPDyKFo=WZAAKYxQsveMr4aDG7K5OuvPJWAhnUEp+ux2YoAV5w@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: quirks: Add of_node_put() when breaking out of loop
To:     Liang He <windhl@126.com>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 19 Jul 2022 at 11:10, Liang He <windhl@126.com> wrote:
>
> In mmc_fixup_of_compatible_match(), we should call of_node_put()
> when breaking out of for_each_child_of_node() which will increase
> and decrease the refcount during one iteration.
>
> Fixes: b360b1102670 ("mmc: core: allow to match the device tree to apply quirks")
> Signed-off-by: Liang He <windhl@126.com>

Applied for next, thanks!

Kind regards
Uffe



> ---
>  drivers/mmc/core/quirks.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index f879dc63d936..be4393988086 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -163,8 +163,10 @@ static inline bool mmc_fixup_of_compatible_match(struct mmc_card *card,
>         struct device_node *np;
>
>         for_each_child_of_node(mmc_dev(card->host)->of_node, np) {
> -               if (of_device_is_compatible(np, compatible))
> +               if (of_device_is_compatible(np, compatible)) {
> +                       of_node_put(np);
>                         return true;
> +               }
>         }
>
>         return false;
> --
> 2.25.1
>
