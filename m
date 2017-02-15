From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RFC 17/39] mmc: core: Add members to mmc_request and
 mmc_data for CQE's
Date: Wed, 15 Feb 2017 14:42:02 +0100
Message-ID: <CACRpkdbxV6MmgmM8=s17tor8hQzxEjNAPwLi-zfaaY77xc1qXQ@mail.gmail.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com> <1486731352-8018-18-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:36527 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750781AbdBONmE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 08:42:04 -0500
Received: by mail-it0-f41.google.com with SMTP id c7so64541428itd.1
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2017 05:42:03 -0800 (PST)
In-Reply-To: <1486731352-8018-18-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On Fri, Feb 10, 2017 at 1:55 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Most of the information needed to issue requests to a CQE is already in
> struct mmc_request and struct mmc_data. Add data block address, some flags,
> and the task id (tag).
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I can't claim to know exactly why tag has to be here as opposed to being
only internal to out mmc_blk_req, but I assume there is a good reason for
that.

Yours,
Linus Walleij
