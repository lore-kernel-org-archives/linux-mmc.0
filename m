From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2 08/22] mmc: block: Disable Command Queue while RPMB is used
Date: Sat, 8 Apr 2017 19:44:51 +0200
Message-ID: <CACRpkdbKUdLgB1YDFc+bnNTzLKxTbtpZjwcLg2OWHpSazh_gFw@mail.gmail.com>
References: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com> <1489408613-26915-9-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:38631 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751955AbdDHRox (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Apr 2017 13:44:53 -0400
Received: by mail-it0-f53.google.com with SMTP id y18so8171711itc.1
        for <linux-mmc@vger.kernel.org>; Sat, 08 Apr 2017 10:44:53 -0700 (PDT)
In-Reply-To: <1489408613-26915-9-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>

On Mon, Mar 13, 2017 at 1:36 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> RPMB does not allow Command Queue commands. Disable and re-enable the
> Command Queue when switching.
>
> Note that the driver only switches partitions when the queue is empty.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Harjani Ritesh <riteshh@codeaurora.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
