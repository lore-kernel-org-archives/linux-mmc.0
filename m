From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2 03/22] mmc: block: Use local var for mqrq_cur
Date: Sat, 8 Apr 2017 19:37:55 +0200
Message-ID: <CACRpkdbictC_69-1C3G=UZFL2jDbD4gRwTqvKN-zbmKQ8SxOxw@mail.gmail.com>
References: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com> <1489408613-26915-4-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:32920 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752181AbdDHRh5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Apr 2017 13:37:57 -0400
Received: by mail-io0-f169.google.com with SMTP id t68so31354734iof.0
        for <linux-mmc@vger.kernel.org>; Sat, 08 Apr 2017 10:37:56 -0700 (PDT)
In-Reply-To: <1489408613-26915-4-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>

On Mon, Mar 13, 2017 at 1:36 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> A subsequent patch will remove 'mq->mqrq_cur'. Prepare for that by
> assigning it to a local variable.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
