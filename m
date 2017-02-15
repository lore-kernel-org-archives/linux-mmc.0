From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RFC 10/39] mmc: block: Change mmc_apply_rel_rw() to get
 block address from the request
Date: Wed, 15 Feb 2017 14:09:43 +0100
Message-ID: <CACRpkdY7ebc+=Rx6UK8P5eFux9OaCqRJuJDzHm+NArbQJrmEfw@mail.gmail.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com> <1486731352-8018-11-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:34953 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751238AbdBONJp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 08:09:45 -0500
Received: by mail-it0-f47.google.com with SMTP id 203so64200451ith.0
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2017 05:09:45 -0800 (PST)
In-Reply-To: <1486731352-8018-11-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On Fri, Feb 10, 2017 at 1:55 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> mmc_apply_rel_rw() will be used by Software Command Queuing also. In that
> case the command argument is not the block address so change
> mmc_apply_rel_rw() to get block address from the request.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

This looks right. Isn't this something we can just apply right off?
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
