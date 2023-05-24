Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1077C7EE23
	for <linux-mmc@archiver.kernel.org>; Wed, 24 May 2023 13:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbjEXNMA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 May 2023 09:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbjEXNLo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 May 2023 09:11:44 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2029A1A6
        for <linux-mmc@vger.kernel.org>; Wed, 24 May 2023 06:11:32 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-563b1e5f701so8959807b3.3
        for <linux-mmc@vger.kernel.org>; Wed, 24 May 2023 06:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684933891; x=1687525891;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=34o3DtpNIVdQeZC8bU8U/uc6p6qXV/32Q4BzT8svKd8=;
        b=Icsnqu6He3fGmq05OHwLcujobeOkfyG2G8nArOAkoITJ9U+sYoEYGHw+aalG2x5sOr
         xmVbmSoE4gJG4LQMKSgN5Qh4JH8WgAYwUI2fyRrgjF7YIrqyMcephGatFjooQL/1tEnU
         x6ounFs0nzgCSWNK3jGIWA5+SFdWFiuAvudqSD000ESEnlaEFe1RR2WyM2tK04Q1DZ16
         9VMRb1Z/EeEC5AZagf/LZhSbrPIsjlB0ox2A9E4ITgFZfscyob8PJFW90nijA9ZVVcqB
         gEfjjQdUPigV/jMYKAY9Hqr3Pg/8rsm0koZ5ltjuGngeIXXJGFla71o5mOGDodWu/V0f
         L42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684933891; x=1687525891;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34o3DtpNIVdQeZC8bU8U/uc6p6qXV/32Q4BzT8svKd8=;
        b=ieHBBFkSqtqIrQaBOfKlvZEwjF+f48BIIy7GpDKUs5vk4GjE0LQLgXYof22pvbfNRD
         OQrHDiYoLHeU0Ybs5mPEt4RfYhyKVo1pP0ONBaytHEaCSUojvaYvUe0Uq4qoryohcEAJ
         vmIO/57dKDE7wJeKrGvAiwax54KWL0c3PNV/fSjP7NJbS/4KA+av/TnoBdPGBCQdiY+o
         aewkFf3uL+rG6KnxdSVPsFkaqdPqWls+3dT9HT02Oauw4Lz2ooYCpFwAyNcM8XwjJDkm
         q2uTZ18Iw98Ql05hoPvpaGnu0hdwGbJOr0sR0WZ7BDhbxSOq2Q3Xm0Wh7QK/xNznQcvC
         yThg==
X-Gm-Message-State: AC+VfDyAHQBtXHxin6F+3Q7sX/+rG0MinV8pgvlhiqcnO7mYYxmOUMET
        yhjrd7PAsPKPstJ/uDsAFSv6iE9RoZWfjzkiZEyaxw==
X-Google-Smtp-Source: ACHHUZ5bzgKh7DOR8WmbaQ2iomRob//GbkoT3mmQrwObvRTuAj0uRzwOKYxF68C9ARu6kyv/PRO2sblahtJQlbDA7fk=
X-Received: by 2002:a25:7313:0:b0:ba7:2531:28af with SMTP id
 o19-20020a257313000000b00ba7253128afmr18473418ybc.11.1684933891295; Wed, 24
 May 2023 06:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230516202714.560929-1-arnd@kernel.org>
In-Reply-To: <20230516202714.560929-1-arnd@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 May 2023 15:10:55 +0200
Message-ID: <CAPDyKFp0=a+cuZRDLkh-4Z7R0=zrJ4C6h7LL++KKZ6TDBeKzCA@mail.gmail.com>
Subject: Re: [PATCH] memstick r592: make memstick_debug_get_tpc_name() static
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Zheng Wang <zyytlz.wz@163.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 16 May 2023 at 22:27, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> There are no other files referencing this function, apparently
> it was left global to avoid an 'unused function' warning when
> the only caller is left out. With a 'W=1' build, it causes
> a 'missing prototype' warning though:
>
> drivers/memstick/host/r592.c:47:13: error: no previous prototype for 'memstick_debug_get_tpc_name' [-Werror=missing-prototypes]
>
> Annotate the function as 'static __maybe_unused' to avoid both
> problems.
>
> Fixes: 926341250102 ("memstick: add driver for Ricoh R5C592 card reader")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/host/r592.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
> index 42bfc46842b8..461f5ffd02bc 100644
> --- a/drivers/memstick/host/r592.c
> +++ b/drivers/memstick/host/r592.c
> @@ -44,12 +44,10 @@ static const char *tpc_names[] = {
>   * memstick_debug_get_tpc_name - debug helper that returns string for
>   * a TPC number
>   */
> -const char *memstick_debug_get_tpc_name(int tpc)
> +static __maybe_unused const char *memstick_debug_get_tpc_name(int tpc)
>  {
>         return tpc_names[tpc-1];
>  }
> -EXPORT_SYMBOL(memstick_debug_get_tpc_name);
> -
>
>  /* Read a register*/
>  static inline u32 r592_read_reg(struct r592_device *dev, int address)
> --
> 2.39.2
>
