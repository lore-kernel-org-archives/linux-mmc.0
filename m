From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V5 06/13] mmc: core: Remove unused MMC_CAP2_PACKED_CMD
Date: Sun, 20 Aug 2017 13:33:10 +0200
Message-ID: <CACRpkdaODdFtajW50_SKvOGb=hsqHEp-YsJGv-Qt+uOkn9Vj+w@mail.gmail.com>
References: <1502366898-23691-1-git-send-email-adrian.hunter@intel.com> <1502366898-23691-7-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35323 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752721AbdHTLdL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Aug 2017 07:33:11 -0400
Received: by mail-oi0-f46.google.com with SMTP id e124so132362480oig.2
        for <linux-mmc@vger.kernel.org>; Sun, 20 Aug 2017 04:33:11 -0700 (PDT)
In-Reply-To: <1502366898-23691-7-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>

On Thu, Aug 10, 2017 at 2:08 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Packed commands support was removed but some bits got left behind. Remove
> them.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

I would even apply this as patch #1 in the series (I guess that works).
Sorry for leaving this cruft behind.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
