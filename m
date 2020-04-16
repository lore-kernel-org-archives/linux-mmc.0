Return-Path: <SRS0=WBH1=6A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB4FC2BB55
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 20:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0651A21BE5
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 20:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DiLrCwPu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgDPUQl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727912AbgDPUQk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Apr 2020 16:16:40 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32065C03C1A9
        for <linux-mmc@vger.kernel.org>; Thu, 16 Apr 2020 13:16:40 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id i3so2187142pgk.1
        for <linux-mmc@vger.kernel.org>; Thu, 16 Apr 2020 13:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vUAOCtCt8du7Os+3vw2Znw14Nonp2UoTlR0pT/AkghM=;
        b=DiLrCwPu0nkuET40jCIp+nDwIo+rN/MpIQKmb/JprzCw+bTM3hdnYeXF8G/NzKbHa0
         sNBe++iudA9Zo4z1DzsoSgR52AWXq/kDU32msbyLU+21z2HumOSfWInDq2l3pWXHHktJ
         psWOB/UZ2KSkQWsW9gO2dsvvBW9/BjYOxuwOWqg9zRJoQTh+TFvfcizmUgM3V/WvByRZ
         z5J32EndrIgceSdtNNvs08D2+jvvqMcsoYAtmkd5R2XuDUTe+GZscFLuuQ4Wm2UYEbZo
         EuXvNDTF+4SLM/B5+tHDv7eOriWPd0emj9c13tacfeQcGiinXBUURMeYdoIvbNJwdcf7
         Sdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vUAOCtCt8du7Os+3vw2Znw14Nonp2UoTlR0pT/AkghM=;
        b=ckycRrMFi+FaXlaI82MJ2ktA35CcusF8DrZ6beSBKE6XFCZEPn41TR+zmRjzaVSz5F
         nfV3ydaRg0b5OBEnNsalOJueDUJHCn2dYxI3IDAPUYzxcgIh1/D6nm5Y1fNdD0xPDA6w
         MCk5aPg7Azex+W6Vv1CdA1nsnEtryCF1NbbMSUw5RPrhQ3h2XRatddHH1aoV6JMAUlF1
         ubbDs/TbsndiyCHpHjvBWBaazOU0ZDVsQ07HAr5zZiztNwdvUg4JrKKTpCZ9FOHvjxsb
         3coDTCBSL5JrdNY1dDBBSac0sQtm5xXu6weqwP4aHYN6U32YXjWSKEHsfnon7pMe3jft
         hARg==
X-Gm-Message-State: AGi0PuYAIm2DMVjtxJkZ2MX5niuuE0mXkxGD5kv+kDoj6wl/n9Ug/DmM
        q7NKw/OKKPnNAatAjSjTPJ35F9lOGL/aPdL6G+DTQg==
X-Google-Smtp-Source: APiQypIyUzh78zWnsuEDX4jhiKakNZ8iouIlNXWcbtqennK3yV9EzmmHfcPXezDACiq0jgMRkO0JT+njkryOVukiahU=
X-Received: by 2002:aa7:919a:: with SMTP id x26mr34178999pfa.39.1587068199267;
 Thu, 16 Apr 2020 13:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200416182402.16858-1-natechancellor@gmail.com>
In-Reply-To: <20200416182402.16858-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 16 Apr 2020 13:16:27 -0700
Message-ID: <CAKwvOdkCMsDUGK88xGqfsA5Nc1eNmR+PbLBoHE0dv65aimcJyQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Remove uninitialized ret variables
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        linux-mmc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "kernelci . org bot" <bot@kernelci.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Apr 16, 2020 at 11:24 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/mmc/host/sdhci-of-arasan.c:784:9: warning: variable 'ret' is
> uninitialized when used here [-Wuninitialized]
>         return ret;
>                ^~~
> drivers/mmc/host/sdhci-of-arasan.c:738:9: note: initialize the variable
> 'ret' to silence this warning
>         int ret;
>                ^
>                 = 0
> drivers/mmc/host/sdhci-of-arasan.c:860:9: warning: variable 'ret' is
> uninitialized when used here [-Wuninitialized]
>         return ret;
>                ^~~
> drivers/mmc/host/sdhci-of-arasan.c:810:9: note: initialize the variable
> 'ret' to silence this warning
>         int ret;
>                ^
>                 = 0
> 2 warnings generated.
>
> This looks like a copy paste error. Neither function has handling that
> needs ret so just remove it and return 0 directly.

Forgive me for not taking the time to look into this more carefully,
but just a thought:

Having functions always return a single integer literal as opposed to
having a `void` return type in their function signature is a code
smell.  Did you consider the call sites of these functions to see if
they do anything with the return value?  I understand it may not be
worthwhile/possible if these functions fulfil an interface that
requires the int return type function signature.  (It's also probably
faster for me to just look rather than type this all out, but I saw no
mention of this consideration in the commit message or patch, so
wanted to check that it had been performed).

>
> Fixes: f73e66a36772 ("sdhci: arasan: Add support for Versal Tap Delays")
> Link: https://github.com/ClangBuiltLinux/linux/issues/996
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 16e26c217a77..18bf0e76b1eb 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -735,7 +735,6 @@ static int sdhci_versal_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
>                 container_of(clk_data, struct sdhci_arasan_data, clk_data);
>         struct sdhci_host *host = sdhci_arasan->host;
>         u8 tap_delay, tap_max = 0;
> -       int ret;
>
>         /*
>          * This is applicable for SDHCI_SPEC_300 and above
> @@ -781,7 +780,7 @@ static int sdhci_versal_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
>                 sdhci_writel(host, regval, SDHCI_ARASAN_OTAPDLY_REGISTER);
>         }
>
> -       return ret;
> +       return 0;
>  }
>
>  static const struct clk_ops versal_sdcardclk_ops = {
> @@ -807,7 +806,6 @@ static int sdhci_versal_sampleclk_set_phase(struct clk_hw *hw, int degrees)
>                 container_of(clk_data, struct sdhci_arasan_data, clk_data);
>         struct sdhci_host *host = sdhci_arasan->host;
>         u8 tap_delay, tap_max = 0;
> -       int ret;
>
>         /*
>          * This is applicable for SDHCI_SPEC_300 and above
> @@ -857,7 +855,7 @@ static int sdhci_versal_sampleclk_set_phase(struct clk_hw *hw, int degrees)
>                 sdhci_writel(host, regval, SDHCI_ARASAN_ITAPDLY_REGISTER);
>         }
>
> -       return ret;
> +       return 0;
>  }
>
>  static const struct clk_ops versal_sampleclk_ops = {
>
> base-commit: a3ca59b9af21e68069555ffff1ad89bd2a7c40fc
> --
> 2.26.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200416182402.16858-1-natechancellor%40gmail.com.



-- 
Thanks,
~Nick Desaulniers
