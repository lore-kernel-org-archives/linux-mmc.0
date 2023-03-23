Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3189AC76195
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Mar 2023 12:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjCWMPP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Mar 2023 08:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjCWMOl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Mar 2023 08:14:41 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0E426C19
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2023 05:14:10 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id e71so24537438ybc.0
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2023 05:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679573647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5NKR7SYBvWpREo0MMAoKbqMCXotiJ17PbmiLaS6x+lw=;
        b=Va/q1CMCaXzBFX0bn3P83b2ChgiFn2WVQ8bCk81bQSlKPcXiZ+1+brIcbwXBOv32eF
         56uZxcPBHwE3iD5zEQ5WQaqcgfCkrH4C6clcAtn68/Et7Hl5OVCWO4pWC55Cws7vKqmm
         zMhijmNoI83GtgdKQ5uVbG6vzCOznsv54jCMh48jVjC9nMRhvLmUmjJjyBeqFcsuZCmv
         USeEFaBxUphyd2nxNtTePqsgzxHvN0Zg0QvyHvsJY2jFbRVlD0TT7fXSQ1FhmIZC1ytv
         lkKd/60i5srHA1ZpwOil02W3b7dWXfyD78nH7JyCzvL4fZjPP3YQ40/YkU44ZhYQjqWi
         tpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679573647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5NKR7SYBvWpREo0MMAoKbqMCXotiJ17PbmiLaS6x+lw=;
        b=27Yr2y4XS3EQq3FVrbrJYAcagq+t8e6bQqjDH8VZrxxflqVQ9t8NX1dKc99KFNdEJ1
         iRMoDwJUsgvwZMNeamJKVO0qpyz3t6B/GfBaRMFIQDPeYj5vYEuHEurILpF1B0MgzlBs
         3qReyUdGXLGS7d47hKYb8qP3zAI1C9VHNGZY58yu6WOu/HCLDqsbJNVGFbuhsJapMbeT
         2dl6/jWLYVT2eu+mMSLfSOGMEzgV35xaRqxSUaWNBjl8EeCb4QZ70VoMvDo97iuNECYn
         /9Pq9nf8I+ZxIxqK/izWAPwXxtyVGlNcNO7WZP8C8MSZxerrbv8oSpXhZ9qqxtI2A06r
         D2vQ==
X-Gm-Message-State: AAQBX9eyE8gffJ/lw8utOqQ+ic3Mf/EvzEnc4uotc7Q95ksuE4xHCofS
        J+XTiqRVJ+6jsvY3tmfvL0YfQblKFrybH9qb8iJ6XCkvNwTC/YJt
X-Google-Smtp-Source: AKy350Y3csOipYNvmlN0E9VYnS6UZ7MTsB9nbcmQZBbf1aNX4uvsptpDrA3C8IAlkZjE+aatt3Qfv5VqOykNt6LHGeo=
X-Received: by 2002:a05:6902:1895:b0:b69:bf76:2243 with SMTP id
 cj21-20020a056902189500b00b69bf762243mr2100817ybb.3.1679573647378; Thu, 23
 Mar 2023 05:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <d2444591-c91b-a94d-71e2-9dedc3b6c514@free.fr>
In-Reply-To: <d2444591-c91b-a94d-71e2-9dedc3b6c514@free.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Mar 2023 13:13:31 +0100
Message-ID: <CAPDyKFo7z9c9A0ccqBja98WCvp+zJHU2Ni9AZ=UK=fy-nsuKXA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: log empty non-removable slots
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Pierre-Hugues Husson <phh@phh.me>, MMC <linux-mmc@vger.kernel.org>,
        AML <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 21 Mar 2023 at 19:01, Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> An empty non-removable slot might be the symptom of probing too early.
>
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

I took the liberty of adjusting the code and the commit message a bit.
Please let me know if it doesn't look good to you.

So, applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 426c7f66b3492..b8137baecee7c 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2257,6 +2257,10 @@ void mmc_rescan(struct work_struct *work)
>                         break;
>         }
>
> +       if (!mmc_card_is_removable(host) && !host->card)
> +               pr_info("%s: no card detected, check post-power-on-delay-ms",
> +                       mmc_hostname(host));
> +
>         /*
>          * Ignore the command timeout errors observed during
>          * the card init as those are excepted.
> --
> 2.25.1
