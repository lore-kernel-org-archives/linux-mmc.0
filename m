From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RFC 11/39] mmc: block: Factor out data preparation
Date: Wed, 15 Feb 2017 14:11:38 +0100
Message-ID: <CACRpkdYef7+BLdD40VQS4b=bQwVK=h+6sB0hjDpFC376-ty89g@mail.gmail.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com> <1486731352-8018-12-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:33217 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750791AbdBONLk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 08:11:40 -0500
Received: by mail-io0-f170.google.com with SMTP id g18so10818499ioe.0
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2017 05:11:39 -0800 (PST)
In-Reply-To: <1486731352-8018-12-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On Fri, Feb 10, 2017 at 1:55 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Factor out data preparation into a separate function mmc_blk_data_prep()
> which can be re-used for command queuing.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

This patch is a good and valid refactoring as it stands, alone.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
