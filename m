From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RFC 01/39] mmc: block: Use local var for mqrq_cur
Date: Wed, 15 Feb 2017 13:29:51 +0100
Message-ID: <CACRpkdbMDUNqVSZYaAcu3rFSxd_cj7Fub4xMRHRLHKbOcudZ_g@mail.gmail.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com> <1486731352-8018-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:38234 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751666AbdBOM3x (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 07:29:53 -0500
Received: by mail-it0-f49.google.com with SMTP id c7so61915586itd.1
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2017 04:29:53 -0800 (PST)
In-Reply-To: <1486731352-8018-2-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On Fri, Feb 10, 2017 at 1:55 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> A subsequent patch will remove 'mq->mqrq_cur'. Prepare for that by
> assigning it to a local variable.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

My patch series also totally kill off mq->mqrq_cur and prev instead using
a pool (with queue depth items) of pre-allocated struct mmc_queue_req, see
"mmc: queue: get/put struct mmc_queue_req"

So I guess we agree that getting rid of the prev/cur thing is something we
can agree to do as a first step?

Yours,
Linus Walleij
