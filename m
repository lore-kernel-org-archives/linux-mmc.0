From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V14 05/24] mmc: block: No need to export mmc_cleanup_queue()
Date: Thu, 23 Nov 2017 14:23:09 +0100
Message-ID: <CACRpkdaJps0QfYUUU-kYqjraiiE6kAgRTbwj7Kn4uM5iRL9E_A@mail.gmail.com>
References: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com> <1511271770-3444-6-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:34166 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752436AbdKWNXK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Nov 2017 08:23:10 -0500
Received: by mail-it0-f44.google.com with SMTP id m11so12387437iti.1
        for <linux-mmc@vger.kernel.org>; Thu, 23 Nov 2017 05:23:09 -0800 (PST)
In-Reply-To: <1511271770-3444-6-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Christoph Hellwig <hch@lst.de>

On Tue, Nov 21, 2017 at 2:42 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> mmc_cleanup_queue() is not used by a different module. Do not export it.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
