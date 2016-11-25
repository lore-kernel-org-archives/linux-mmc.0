From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V7 18/25] mmc: block: Pass mqrq to mmc_blk_prep_packed_list()
Date: Fri, 25 Nov 2016 15:53:49 +0100
Message-ID: <CACRpkdYAsAbhzDeyXt+YykzZG9fsrCD5MwYz-MkW-ivRDAV6kA@mail.gmail.com>
References: <1480068442-5169-1-git-send-email-adrian.hunter@intel.com> <1480068442-5169-19-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34416 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754213AbcKYOxv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Nov 2016 09:53:51 -0500
Received: by mail-qk0-f172.google.com with SMTP id q130so80337731qke.1
        for <linux-mmc@vger.kernel.org>; Fri, 25 Nov 2016 06:53:50 -0800 (PST)
In-Reply-To: <1480068442-5169-19-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On Fri, Nov 25, 2016 at 11:07 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> A subsequent patch will remove 'mq->mqrq_cur'. Prepare for that by
> passing mqrq to mmc_blk_prep_packed_list().
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

This code path is deleted upstream.

Yours,
Linus Walleij
