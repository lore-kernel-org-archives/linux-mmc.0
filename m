From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2 00/22] mmc: Add Command Queue support
Date: Sat, 8 Apr 2017 19:37:05 +0200
Message-ID: <CACRpkdbF5emW7bT222A_+VkSN7NX6PCTWOZ9=hO+JtSt7pWCeg@mail.gmail.com>
References: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:36464 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751914AbdDHRhG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Apr 2017 13:37:06 -0400
Received: by mail-io0-f180.google.com with SMTP id l7so64825273ioe.3
        for <linux-mmc@vger.kernel.org>; Sat, 08 Apr 2017 10:37:06 -0700 (PDT)
In-Reply-To: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>

On Mon, Mar 13, 2017 at 1:36 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Here are the hardware command queue patches without the software command
> queue patches or sdhci patches.

I think we have to merge at least a bunch of these patches, there is evidently a
bunch of stuff in the beginning of the series at least that I have
nothing against.

They will royally screw up my patch stack for MQ but that is not a technical
argument, just work.

I will try to to go in and provide Reviewed-by tags for all stuff I consider
merge material.

Yours,
Linus Walleij
