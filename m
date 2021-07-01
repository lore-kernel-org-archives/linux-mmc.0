Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7894C11F64
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Jul 2021 09:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A99E461480
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Jul 2021 09:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbhGAJJY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Jul 2021 05:09:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235088AbhGAJJY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 1 Jul 2021 05:09:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BFF761490;
        Thu,  1 Jul 2021 09:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625130414;
        bh=MaCv3p2s4Y+m8WXNbkHrFUHk0ZhDpOb3qUE9ihRrl/0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c+DfL8Vb3ANnCufs6Txm4ecndVtsg8++y0S7FGi7KkWB5l2EUJkUob9Up0bmRuPhM
         QyRTy/wrRHTbO1HL0HNnsURaje6Zw8y/7J//yhF5pw2whv3X2zQ57Ww2xgIV7uB1do
         bxspIRK6k+mQPR1Q5usAF9QvvZbA2ftu9qSVdQd4Ss6S1ylpDrLJZ1t3Nizpi+L/yr
         yxtwpS+Pje33g5WFkopaHRBNMyWxUfsYKe5aloF6TLfFPCFL8bEaSIKwYnwHymvaR9
         a2O7PryIvlYHbQ7vi/pxsK+33XKq9jjdjAuPkU7R0fgC/LgSvZSJtXEI6sbjFFr+Hh
         k8cyRAYhFPjkw==
Received: by mail-wr1-f43.google.com with SMTP id v5so7230861wrt.3;
        Thu, 01 Jul 2021 02:06:53 -0700 (PDT)
X-Gm-Message-State: AOAM532MBHqWZg7hvjJuCzX+RblOv9vFShJoh7l8nvlVfiNMqchwYapv
        QGiuf+HIRG+3ZGzyDJZYmtT0Uh5IA8Y2a4xOeI8=
X-Google-Smtp-Source: ABdhPJzAp2tTQfel9pBkdL6/k6elC9IBeuDeoYONmfsIcpyu4gDUEhBeE60t9Q/GBsjKzyMCavAkvXtHN60gwVXUnk0=
X-Received: by 2002:adf:ee10:: with SMTP id y16mr7025006wrn.99.1625130412697;
 Thu, 01 Jul 2021 02:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210630122057.2795882-1-arnd@kernel.org> <202107010615.MzO98NWl-lkp@intel.com>
In-Reply-To: <202107010615.MzO98NWl-lkp@intel.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 1 Jul 2021 11:06:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1XQKG-bEqbPnasDTKeymZYEkrFAi1XccTH9EK8OjuVaA@mail.gmail.com>
Message-ID: <CAK8P3a1XQKG-bEqbPnasDTKeymZYEkrFAi1XccTH9EK8OjuVaA@mail.gmail.com>
Subject: Re: [PATCH] mmc: warn for invalid SDIO data buffers
To:     kernel test robot <lkp@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, kbuild-all@lists.01.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jul 1, 2021 at 1:02 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Arnd,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on soc/for-next]
> [also build test ERROR on linus/master v5.13 next-20210630]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Arnd-Bergmann/mmc-warn-for-invalid-SDIO-data-buffers/20210630-202237
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
> config: i386-randconfig-c001-20210630 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/0day-ci/linux/commit/256b826ee105fe46723b99c3f128ea01aa3e7adf
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Arnd-Bergmann/mmc-warn-for-invalid-SDIO-data-buffers/20210630-202237
>         git checkout 256b826ee105fe46723b99c3f128ea01aa3e7adf
>         # save the attached .config to linux build tree
>         make W=1 ARCH=i386
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
> >> ERROR: modpost: "is_vmalloc_or_module_addr" [drivers/mmc/core/mmc_core.ko] undefined!

Ah, I see that is_vmalloc_addr() is exported, but is_vmalloc_or_module_addr()
is not. I assume it's ok to add a corresponding EXPORT_SYMBOL_GPL() for
it as well. I'll wait for other comments before resending with that change.

      Arnd
