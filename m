From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2 07/22] mmc: mmc_test: Disable Command Queue while
 mmc_test is used
Date: Sat, 8 Apr 2017 19:43:54 +0200
Message-ID: <CACRpkda__yFV9Ft8ympAO75tR914qxMYaEvj+58aSn3cJ340Tg@mail.gmail.com>
References: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com> <1489408613-26915-8-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:37076 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751955AbdDHRn4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Apr 2017 13:43:56 -0400
Received: by mail-it0-f48.google.com with SMTP id a140so8189872ita.0
        for <linux-mmc@vger.kernel.org>; Sat, 08 Apr 2017 10:43:55 -0700 (PDT)
In-Reply-To: <1489408613-26915-8-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>

On Mon, Mar 13, 2017 at 1:36 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Normal read and write commands may not be used while the command queue is
> enabled. Disable the Command Queue when mmc_test is probed and re-enable it
> when it is removed.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Harjani Ritesh <riteshh@codeaurora.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thugh if I get it right, there is no test for the command queue
functionality then, really. The tests just test common stuff. So
we would maybe want to add tests for CMDQ.

Yours,
Linus Walleij
