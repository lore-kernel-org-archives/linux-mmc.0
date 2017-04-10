From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2 11/22] mmc: core: Factor out debug prints from mmc_start_request()
Date: Mon, 10 Apr 2017 15:53:27 +0200
Message-ID: <CACRpkdZmziX6_w4fCM_bzY8GAm784HfsCdjVgBXSHZ6AZrOKgg@mail.gmail.com>
References: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com> <1489408613-26915-12-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:34339 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753379AbdDJNxb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Apr 2017 09:53:31 -0400
Received: by mail-io0-f175.google.com with SMTP id a103so31277615ioj.1
        for <linux-mmc@vger.kernel.org>; Mon, 10 Apr 2017 06:53:30 -0700 (PDT)
In-Reply-To: <1489408613-26915-12-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>

On Mon, Mar 13, 2017 at 1:36 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> In preparation to reuse the code for CQE support.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
