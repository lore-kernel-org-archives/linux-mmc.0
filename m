From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] mmc: block: delete packed command support
Date: Thu, 24 Nov 2016 10:53:55 +0100
Message-ID: <CACRpkdYaCs4f-aaCmGu-RPQJe4HMKbhE10vcekxNpKHVm=6YYg@mail.gmail.com>
References: <1479916086-26641-1-git-send-email-linus.walleij@linaro.org> <201611241455.f15P3Xee%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34634 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936459AbcKXJx7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Nov 2016 04:53:59 -0500
Received: by mail-qk0-f171.google.com with SMTP id q130so43973422qke.1
        for <linux-mmc@vger.kernel.org>; Thu, 24 Nov 2016 01:53:57 -0800 (PST)
In-Reply-To: <201611241455.f15P3Xee%fengguang.wu@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: "kbuild-all@01.org" <kbuild-all@01.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Namjae Jeon <namjae.jeon@samsung.com>, Maya Erez <qca_merez@qca.qualcomm.com>

On Thu, Nov 24, 2016 at 7:35 AM, kbuild test robot <lkp@intel.com> wrote:

> Hi Linus,
>
> [auto build test WARNING on ulf.hansson-mmc/next]
> [cannot apply to linus/master linux/master v4.9-rc6 next-20161123]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

This is indeed a false build error.

Patches sent to linux-mmc@vger.kernel.org is probably better tested agains
the "next" branch on Ulf's MMC tree at:
https://git.kernel.org/cgit/linux/kernel/git/ulfh/mmc.git/

Yours,
Linus Walleij
