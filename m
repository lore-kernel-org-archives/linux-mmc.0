From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2 09/22] mmc: block: Change mmc_apply_rel_rw() to get
 block address from the request
Date: Mon, 10 Apr 2017 15:49:47 +0200
Message-ID: <CACRpkdYyj-F=Q4hgH=32TN5MyqDAw40UzMMq4Qu8nTfm+beH2w@mail.gmail.com>
References: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com> <1489408613-26915-10-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:34073 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753248AbdDJNtu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Apr 2017 09:49:50 -0400
Received: by mail-io0-f174.google.com with SMTP id a103so31127646ioj.1
        for <linux-mmc@vger.kernel.org>; Mon, 10 Apr 2017 06:49:49 -0700 (PDT)
In-Reply-To: <1489408613-26915-10-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>

On Mon, Mar 13, 2017 at 1:36 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> mmc_apply_rel_rw() will be used by Software Command Queuing also. In that
> case the command argument is not the block address so change
> mmc_apply_rel_rw() to get block address from the request.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Plus it is a good readability change on its own merits.

Yours,
Linus Walleij
