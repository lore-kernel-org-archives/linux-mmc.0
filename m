From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RFC 13/39] mmc: mmc: Enable Software Command Queuing
Date: Wed, 15 Feb 2017 14:35:44 +0100
Message-ID: <CACRpkdbbm4PhQd4QHsm4eRGTpifv8J_w9JcHpe20bJvKNJPDXA@mail.gmail.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com> <1486731352-8018-14-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:34192 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbdBONfq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 08:35:46 -0500
Received: by mail-it0-f49.google.com with SMTP id k200so25152841itb.1
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2017 05:35:46 -0800 (PST)
In-Reply-To: <1486731352-8018-14-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On Fri, Feb 10, 2017 at 1:55 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Enable the Command Queue if the host controller supports Software Command
> Queuing. It is not compatible with Packed Commands, so do not enable that
> at the same time.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

This looks right
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
