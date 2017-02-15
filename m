From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RFC 05/39] mmc: mmc: Add functions to enable / disable the
 Command Queue
Date: Wed, 15 Feb 2017 13:52:02 +0100
Message-ID: <CACRpkdbW4nDA=e6zM3095N9y_hy2Rsktzmuf8g8=xOaJCeLbGA@mail.gmail.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com> <1486731352-8018-6-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:36842 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbdBOMwE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 07:52:04 -0500
Received: by mail-io0-f181.google.com with SMTP id j13so88410434iod.3
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2017 04:52:03 -0800 (PST)
In-Reply-To: <1486731352-8018-6-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On Fri, Feb 10, 2017 at 1:55 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Add helper functions to enable or disable the Command Queue.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

I think I asked this before but why?

If the card has this feature, certainly we should just exploit it?

If some card has a problem with it, I guess it is broken and should
simply have this operation blacklisted.

Yours,
Linus Walleij
