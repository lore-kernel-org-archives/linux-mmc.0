Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF9BC433E1
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 09:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40F0B619C1
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 09:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbhCaJmB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 31 Mar 2021 05:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbhCaJle (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Mar 2021 05:41:34 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCB9C061574
        for <linux-mmc@vger.kernel.org>; Wed, 31 Mar 2021 02:41:33 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id y20so5746958uay.6
        for <linux-mmc@vger.kernel.org>; Wed, 31 Mar 2021 02:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cqSVyx6IfZiNsTA4tIIoWXj6mim+5+/341jQX3JUpQU=;
        b=o/bCBMs7fN/z3Lrzm5a1KDBl8l2hJWqLZc+1RUehKMpZiJB5qWgJNpra/qo3HR4MLH
         bTz+74eNLn9tQ9XbF+WGsJvTAFuwoNzyji01IzMJtpAhPc+HpwDbcyBHL1zRnM9++S5V
         YSDDFzleUjWfquMk7nTVnOsq9RnMkUrZ7wanCG6RlJ1WVV7hwvllLOmWXI6uRYP5zDJY
         YtoLV98j1+qh0gad32LTLlP8QaHV2MAdWL+UQF93ioNMtcVC7WyoRMxrlmwMoD/PFkBR
         qlndJFQHRWg5PwBSeIpfHlcwXI1TTNOeOSm7ViGYCXHtMk1YxCMlCnWmG2xWpU2vLJpk
         SL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cqSVyx6IfZiNsTA4tIIoWXj6mim+5+/341jQX3JUpQU=;
        b=p+1lrHybEeNP8cP+VgwP1UHJY/azm4INDRdxoshnyT/y2UgBJ8b8N9RD7gDaXCmEet
         sWYjwLe9C20rIk0eoPZaxDI1iXUOGpOYV2ZhPXYrgQ0uSclhOL7+EfBTj4RegwZUZjtg
         mOKlL4hlIuxGcGL80h8WVYwmoLTZpQBbn9Qjuot4HygFk1dh2uBuu2zIRFK7W39gheix
         5hNhr/oAZNo2XeiW373tUhEXLghtor5lhRTWP+FVMynnOR/ZziMv2PKP8u3oPrIdcjrX
         g8trsjdsNRp/EVVbKN5QpJFMv/4NZ5IF/g9utV0rnkGlrkX8cM6WhaiZXeCwvoujoqoT
         T9bg==
X-Gm-Message-State: AOAM530U2ogMPpipOJ44lmGBfZsOItEXvLrU3BVqE0hXfsvc5TgLLGpc
        F14Q/b9ky8uhbhr0CJCdGtIsry62NZBAouqp3/sVVA==
X-Google-Smtp-Source: ABdhPJzPSBs9PuV/3K4Grr9lPb1TZW7aHAAmv+/IPFG1vOWszMZ/wct8QvdJUIDccR5mVBf3ejrwoaUY3T6q8yfH7Ss=
X-Received: by 2002:ab0:2c16:: with SMTP id l22mr816434uar.100.1617183692953;
 Wed, 31 Mar 2021 02:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190928185107.21125-1-fontaine.fabrice@gmail.com>
In-Reply-To: <20190928185107.21125-1-fontaine.fabrice@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 31 Mar 2021 11:40:56 +0200
Message-ID: <CAPDyKFpHCvVOWpFmFX9=GpPbcgCLMKi338JP-x_K545sOa4E9Q@mail.gmail.com>
Subject: Re: [PATCH] mmc_cmds.c: fix build with gcc 4.9
To:     Fabrice Fontaine <fontaine.fabrice@gmail.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Avri

On Sat, 28 Sept 2019 at 20:50, Fabrice Fontaine
<fontaine.fabrice@gmail.com> wrote:
>
> Fix following error with gcc 4.9:
>
> mmc_cmds.c:1918:9: error: missing braces around initializer [-Werror=missing-braces]
>   struct rpmb_frame frame_status = {0};
>
> Fixes:
>  - http://autobuild.buildroot.org/results/bf3b6f9f6ef39b99842b3c92495b7bf359c68158
>
> Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>

Applied to git.kernel.org/pub/scm/utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe


> ---
>  mmc_cmds.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index fb37189..6b09f26 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -1915,7 +1915,9 @@ static int do_rpmb_op(int fd,
>         u_int16_t rpmb_type;
>         struct mmc_ioc_multi_cmd *mioc;
>         struct mmc_ioc_cmd *ioc;
> -       struct rpmb_frame frame_status = {0};
> +       struct rpmb_frame frame_status;
> +
> +       memset(&frame_status, 0, sizeof(frame_status));
>
>         if (!frame_in || !frame_out || !out_cnt)
>                 return -EINVAL;
> --
> 2.23.0
>
