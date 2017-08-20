From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V5 08/13] mmc: mmc: Enable CQE's
Date: Sun, 20 Aug 2017 13:41:15 +0200
Message-ID: <CACRpkdbt8cQjYhb2c8p2R9QiBwe3ZtP2qX5hKGsCxXkFqx+VAA@mail.gmail.com>
References: <1502366898-23691-1-git-send-email-adrian.hunter@intel.com> <1502366898-23691-9-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:33549 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752721AbdHTLlQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Aug 2017 07:41:16 -0400
Received: by mail-oi0-f50.google.com with SMTP id f11so132101148oic.0
        for <linux-mmc@vger.kernel.org>; Sun, 20 Aug 2017 04:41:15 -0700 (PDT)
In-Reply-To: <1502366898-23691-9-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>

On Thu, Aug 10, 2017 at 2:08 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Enable or disable CQE when a card is added or removed respectively.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

pr_info("%s: Command Queue Engine enabled\n",

Kudos for making this pr_info() as we're introducing it to everyone
so that users can see what is going on. Good!

Yours,
Linus Walleij
