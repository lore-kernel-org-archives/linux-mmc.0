From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RFC 20/39] mmc: core: Add support for handling CQE requests
Date: Wed, 15 Feb 2017 14:44:49 +0100
Message-ID: <CACRpkdb-q7iorHQ8GrANFC49NrMWcP=wpv904OdXe8Npb8Az=w@mail.gmail.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com> <1486731352-8018-21-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:37435 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750719AbdBONov (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 08:44:51 -0500
Received: by mail-it0-f42.google.com with SMTP id x75so63187453itb.0
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2017 05:44:50 -0800 (PST)
In-Reply-To: <1486731352-8018-21-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On Fri, Feb 10, 2017 at 1:55 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Add core support for handling CQE requests, including starting, completing
> and recovering.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

So this adds a new command path for the cqe. I guess it's unavoidable, and
looks good to me.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
