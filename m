From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH -next 0/2] Two issue fixes of Xenon SDHCI
Date: Fri, 28 Apr 2017 12:36:56 +0200
Message-ID: <CAPDyKFq_niVea0Nf1YB1eAV3Ei3N82VKnfHrVNdJaezhRdYkZw@mail.gmail.com>
References: <cover.1493275841.git.huziji@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:36772 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2992703AbdD1Kg6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Apr 2017 06:36:58 -0400
Received: by mail-qt0-f181.google.com with SMTP id g60so46736199qtd.3
        for <linux-mmc@vger.kernel.org>; Fri, 28 Apr 2017 03:36:57 -0700 (PDT)
In-Reply-To: <cover.1493275841.git.huziji@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hu Ziji <huziji@marvell.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jimmy Xu <zmxu@marvell.com>, Doug Jones <dougj@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, Kostya Porotchkin <kostap@marvell.com>, Hanna Hawa <hannah@marvell.com>, hongd@marvell.com, zjwu@marvell.com

On 28 April 2017 at 04:34, Hu Ziji <huziji@marvell.com> wrote:
> Hi Ulf,
>
>    Could you please help review the two fixes of Xenon SDHCI?
>    Patch 1 fixes the remove flow of Xenon SDHCI.
>    Patch 2 fixes a default value in PHY register.
>
>    Thank you.
>
> Best regards,
> Hu Ziji
>
> Hu Ziji (2):
>   mmc: sdhci-xenon: Fix the work flow in xenon_remove().
>   mmc: sdhci-xenon: Fix the default value of LOGIC_TIMING_ADJUST
>     register in eMMC 5.0 PHY
>
>  drivers/mmc/host/sdhci-xenon-phy.c | 7 ++++++-
>  drivers/mmc/host/sdhci-xenon.c     | 4 ++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> --
> 2.7.4
>

Thanks, applied for next!

Kind regards
Uffe
