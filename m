Return-Path: <SRS0=v+1n=B7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83FAC433E1
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 13:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4DAE207BB
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 13:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MsAQRhu3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgHUNEV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgHUNEF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Aug 2020 09:04:05 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5106C061388
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2020 06:04:04 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id x142so396677vke.0
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2020 06:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Of8B1JdNddjVmiolpjV5fIdtTFXK4mNZ1WJPME585rI=;
        b=MsAQRhu3Yz/2CxCDMuK8lKA+6IRovanKanJ+xkv2q+6NkbAawmZpclkCicAmFD/GCn
         LptyFlY1QNEZQQsXN+H9dDLRT4LBFDnWDJrOnwxLywkRMDS+y19GE8mt8p6MDEyHomi3
         PFnKlUCyzg0eXSq7GzvqfoZXMFdHwEaMcn6/BoqVc/tZEQWIZMIrQZYAZpNpAoNWL5aY
         uEMNLITtGGWZqH/4462D4EtFgtvMyRCanOIp3j+6P1azskPtkwwEgAeEiYnQyRUjuOro
         zJOhRTVrnIiLVm7oWrK0GeYEDIzSDLV5oSxTEb1GfnRw/o4yqzjwpZJ2MntLh2eC175o
         4rTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Of8B1JdNddjVmiolpjV5fIdtTFXK4mNZ1WJPME585rI=;
        b=VZgLNKYw6WoAvJAQ4Nb84n8LJzAI8wJsCF9wVqvnjorJE4k3o7aK9tsrfU4bg469Tr
         Pw2Wgp0Z/tRV+tHx4rW9HZID9uxXCgjuDwBejssLRuk+oMxK3ZzFyS3uMN3OjMypdZCf
         sKJh5nh+x/15SwbUe5Bk/xivpfoDLxuJMu2V/N0qhgllM9hjCO6+KZiyeLIRaaRZ7UJP
         GPmspbDT0EotexEDqc4TOpJbcgZWg+LL+oWHW311+VP8yV5YTVbIJeY+CQNbu7/qRAfJ
         0NfPzB8W/QGQF3hzXHKwUgPnHw1K3aCffr4uT7sL2b3sJz5db+bKJkCJWy6COrWQjE9a
         4xeg==
X-Gm-Message-State: AOAM533WI3BTfomRmHDdSBtJojTvyulau5qhZZaeIv0HnY5ybxevtPCO
        sl7xL9/Ml0cp/D89Lt2Gmxk9tHRBB5XMOs0HtSCEKQ==
X-Google-Smtp-Source: ABdhPJxexRNpnHIAvgnOO637NaC3Fo+35Ifzsik1b/A6iDZxGrmVTZ55K47fA64XUTB0JSJ5J9MQb/JS1o/wJWEBAJI=
X-Received: by 2002:ac5:ccdb:: with SMTP id j27mr1509317vkn.43.1598015043981;
 Fri, 21 Aug 2020 06:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <1596887102-9743-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1596887102-9743-1-git-send-email-guoren@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Aug 2020 15:03:27 +0200
Message-ID: <CAPDyKFoAonef5daQy0rZFdQeUhKwryYDM0k-aiWXKZG8XBxQxw@mail.gmail.com>
Subject: Re: [PATCH] mmc: Kconfig: Add RISCV and CSKY for MMC_DW
To:     guoren@kernel.org
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 8 Aug 2020 at 13:45, <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Synopsys DesignWare MMC controller could be used in RISC-V and
> C-SKY architectures.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 3b706af..119adab 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -777,7 +777,7 @@ config MMC_CAVIUM_THUNDERX
>
>  config MMC_DW
>         tristate "Synopsys DesignWare Memory Card Interface"
> -       depends on ARC || ARM || ARM64 || MIPS || COMPILE_TEST
> +       depends on ARC || ARM || ARM64 || MIPS || RISCV || CSKY || COMPILE_TEST
>         help
>           This selects support for the Synopsys DesignWare Mobile Storage IP
>           block, this provides host support for SD and MMC interfaces, in both
> --
> 2.7.4
>
