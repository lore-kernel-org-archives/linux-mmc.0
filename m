From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V9 11/15] mmc: core: Export mmc_start_request()
Date: Wed, 27 Sep 2017 01:47:37 +0200
Message-ID: <CACRpkdbbbgOJ6RmCNa8EV9WzbY1RsurJgnrT0MqYTZ+ZkprhhQ@mail.gmail.com>
References: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com> <1506083824-4024-12-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:47067 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968440AbdIZXri (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Sep 2017 19:47:38 -0400
Received: by mail-io0-f169.google.com with SMTP id d16so14242343ioj.3
        for <linux-mmc@vger.kernel.org>; Tue, 26 Sep 2017 16:47:38 -0700 (PDT)
In-Reply-To: <1506083824-4024-12-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>, Christoph Hellwig <hch@lst.de>

On Fri, Sep 22, 2017 at 2:37 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Export mmc_start_request() so that the block driver can use it.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
