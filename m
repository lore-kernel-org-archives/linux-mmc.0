Return-Path: <SRS0=WBH1=6A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D436EC2BA2B
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 20:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0455206A2
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 20:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z17pqRn6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgDPUck (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728696AbgDPUcj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Apr 2020 16:32:39 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B92C061A0C;
        Thu, 16 Apr 2020 13:32:39 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id i27so4215163ota.7;
        Thu, 16 Apr 2020 13:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3KT3Lk+L86Pg6kG/Kio9iVjTavDlMZk/zeLFXx3fyr0=;
        b=Z17pqRn6xv7LY+zwTUW3Relp+eGpiRdHw0EvAg6ebTJvDwmK+ofO7eUVBCcBvzuJfU
         ck9w3vDTV9F1tQ/gn6ZFZg96f3X/nNhYbpUfG5TVxYv2l69PFT8aRNNpYJlFOVDn7gGG
         KWJD4aQaD4fuPach6ICowOqjZDKGi7cg1JB5JYVbpAplf3UzacoHhQAoOCku721176bY
         DvVl9Pwb8Z4U4++dLCQeZn9BOk2H17mFrFnrEGG3/sLoweXTUo/BmFxO6NZqIszENJEB
         HHypR6LEHxsqKU65r6otZChnFj3Mgr1/w0f53VAoQNE9fAq9GtEbkVt0kcvhnNnD6w4r
         ztVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3KT3Lk+L86Pg6kG/Kio9iVjTavDlMZk/zeLFXx3fyr0=;
        b=RD6gkYCIZDxAfMM5766uho84ETLM7mJqyfLRMOyAUC9pfaKEobBjggXC9RrL0VMysX
         7u6Ov7teH2kGoBGO6yYbVdeIpqNmsd+EhVLUuR/447UQG1eV+ERl0Hnkyk6BJCP6H5jA
         KXRcpNPXKiMLKRc4z6+SJgTZp6NpPRbjflQQqYVNypHH2vEcuOCl5TLNjAZCkyzOa5oy
         GMDsVMvilflGLr28RMHtnTv+ZjkVchfzfHR9QPmV53OXC0OtzkcoFwgmpS4F+Umt9Hrd
         95h/lpMY+Zmpvh8gUPue4vhGxKE+ZYYCqUCjRiz+trQ8eswlxCaeu7wsCk+HB8DjPkcw
         EtLA==
X-Gm-Message-State: AGi0PuadJIlw16UrsrVZLvZRTprkq8KDRYp5RZ2nlFb5dLkUI2mXtcQ9
        9s9IveWarvbwLIsHXFOld2otqmvm
X-Google-Smtp-Source: APiQypK4uMOTrP9aJlJSPOasMk4kiHyD0QruPHFS0YD8KUeyYrXq4lRuQi15zKhlYSKgAFrXy+QFiA==
X-Received: by 2002:a4a:3006:: with SMTP id q6mr18966698oof.70.1587068657829;
        Thu, 16 Apr 2020 13:24:17 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id i2sm8092125oon.0.2020.04.16.13.24.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Apr 2020 13:24:17 -0700 (PDT)
Date:   Thu, 16 Apr 2020 13:24:15 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        linux-mmc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "kernelci . org bot" <bot@kernelci.org>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Remove uninitialized ret variables
Message-ID: <20200416202415.GA30964@ubuntu-s3-xlarge-x86>
References: <20200416182402.16858-1-natechancellor@gmail.com>
 <CAKwvOdkCMsDUGK88xGqfsA5Nc1eNmR+PbLBoHE0dv65aimcJyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkCMsDUGK88xGqfsA5Nc1eNmR+PbLBoHE0dv65aimcJyQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Apr 16, 2020 at 01:16:27PM -0700, Nick Desaulniers wrote:
> On Thu, Apr 16, 2020 at 11:24 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns:
> >
> > drivers/mmc/host/sdhci-of-arasan.c:784:9: warning: variable 'ret' is
> > uninitialized when used here [-Wuninitialized]
> >         return ret;
> >                ^~~
> > drivers/mmc/host/sdhci-of-arasan.c:738:9: note: initialize the variable
> > 'ret' to silence this warning
> >         int ret;
> >                ^
> >                 = 0
> > drivers/mmc/host/sdhci-of-arasan.c:860:9: warning: variable 'ret' is
> > uninitialized when used here [-Wuninitialized]
> >         return ret;
> >                ^~~
> > drivers/mmc/host/sdhci-of-arasan.c:810:9: note: initialize the variable
> > 'ret' to silence this warning
> >         int ret;
> >                ^
> >                 = 0
> > 2 warnings generated.
> >
> > This looks like a copy paste error. Neither function has handling that
> > needs ret so just remove it and return 0 directly.
> 
> Forgive me for not taking the time to look into this more carefully,
> but just a thought:
> 
> Having functions always return a single integer literal as opposed to
> having a `void` return type in their function signature is a code
> smell.  Did you consider the call sites of these functions to see if
> they do anything with the return value?  I understand it may not be
> worthwhile/possible if these functions fulfil an interface that
> requires the int return type function signature.  (It's also probably

Which is the case. These functions are passed to 'struct clk_ops', which
defines the set_phase member as

int     (*set_phase)(struct clk_hw *hw, int degrees);

so we cannot just change the return to void since there are other
set_phase functions that do set a return value other than zero.

> faster for me to just look rather than type this all out, but I saw no
> mention of this consideration in the commit message or patch, so
> wanted to check that it had been performed).

Yeah, I should have probably mentioned that. I can do so if the
maintainers feel it worthwhile.

Cheers,
Nathan
