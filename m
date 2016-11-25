From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V7 06/25] mmc: queue: Introduce queue depth
Date: Fri, 25 Nov 2016 15:43:58 +0100
Message-ID: <CACRpkdaQL3UM5DK9nwiQEcR_R19qWqRwt+KpOJNFR1HKEQ5bkA@mail.gmail.com>
References: <1480068442-5169-1-git-send-email-adrian.hunter@intel.com> <1480068442-5169-7-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:33113 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752653AbcKYOpR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Nov 2016 09:45:17 -0500
Received: by mail-qt0-f170.google.com with SMTP id p16so67394315qta.0
        for <linux-mmc@vger.kernel.org>; Fri, 25 Nov 2016 06:43:59 -0800 (PST)
In-Reply-To: <1480068442-5169-7-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On Fri, Nov 25, 2016 at 11:07 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Add a mmc_queue member to record the size of the queue, which currently
> supports 2 requests on-the-go at a time.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
(...)
> +       /* Queue depth is only ever 2 with packed commands */

That's a weird comment.
It doesn't have anything with packed commands to do does it?
In that case it was just deleted.

Are you referring to the asynchronous issuing pipeline thing
(cur & next)?

Yours,
Linus Walleij
