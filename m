From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RFC 14/39] mmc: core: Factor out debug prints from mmc_start_request()
Date: Wed, 15 Feb 2017 14:38:28 +0100
Message-ID: <CACRpkdakuECqLyzqW5eBVgaj9NMSPGEMtZt_UNNAzu08xZVoZw@mail.gmail.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com> <1486731352-8018-15-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:33683 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750781AbdBONi3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 08:38:29 -0500
Received: by mail-io0-f176.google.com with SMTP id g18so11274337ioe.0
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2017 05:38:29 -0800 (PST)
In-Reply-To: <1486731352-8018-15-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On Fri, Feb 10, 2017 at 1:55 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> In preparation to reuse the code for CQE support.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
