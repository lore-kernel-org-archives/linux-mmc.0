From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 00/30] mmc: mmc: Add Software Command Queuing
Date: Mon, 12 Sep 2016 14:36:21 +0200
Message-ID: <CAPDyKFqFF2NYzRvO3XTy0m2MiX6ft2bU1jp_U1RR_XU1JLWziw@mail.gmail.com>
References: <1471344280-16663-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36788 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757879AbcILMgY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Sep 2016 08:36:24 -0400
Received: by mail-wm0-f43.google.com with SMTP id b187so133584360wme.1
        for <linux-mmc@vger.kernel.org>; Mon, 12 Sep 2016 05:36:24 -0700 (PDT)
In-Reply-To: <1471344280-16663-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On 16 August 2016 at 12:44, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Hi
>
> Here is an updated version of the Software Command Queuing patches,
> re-based on next + v4.8-rc2 + "block: Fix secure erase" patch, otherwise no
> changes since V3.
>
> Ulf, as before, if you accept the "Command during Transfer" API introduced
> in patch 1, then you could take patches 1-5 in advance of the rest.

Adrian,

I have had a busy period, apologize for taking such long time to review this!

Patch 1->5 looks good to me, so I have applied these for next. I will
continue with the review during the week.

[...]

Kind regards
Uffe
