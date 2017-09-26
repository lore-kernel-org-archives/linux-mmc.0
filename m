From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V9 08/15] mmc: block: Factor out mmc_setup_queue()
Date: Tue, 26 Sep 2017 17:38:14 +0200
Message-ID: <CACRpkdYj9=PHXfb3ngz2UnDdDxS_XkK7yO2bXRamUL-BYAcYUQ@mail.gmail.com>
References: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com> <1506083824-4024-9-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:44878 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937341AbdIZPiP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Sep 2017 11:38:15 -0400
Received: by mail-it0-f54.google.com with SMTP id d192so8750391itd.1
        for <linux-mmc@vger.kernel.org>; Tue, 26 Sep 2017 08:38:15 -0700 (PDT)
In-Reply-To: <1506083824-4024-9-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>, Christoph Hellwig <hch@lst.de>

On Fri, Sep 22, 2017 at 2:36 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Factor out some common code that will also be used with blk-mq.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
