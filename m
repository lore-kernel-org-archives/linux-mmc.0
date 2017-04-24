From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2 00/22] mmc: Add Command Queue support
Date: Mon, 24 Apr 2017 10:12:32 +0200
Message-ID: <CACRpkdYBB1ZMnvCKet706bm12B3DWnie=0uDri835R_f81gMUw@mail.gmail.com>
References: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFp=rrQbSAGMx=UF2abcLmzWjO4syq7eLAmChT_EQNvDgg@mail.gmail.com> <faa2a3d8-e045-8bd1-06c9-e5cf64713035@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:38625 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1166572AbdDXIOj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Apr 2017 04:14:39 -0400
Received: by mail-it0-f49.google.com with SMTP id e132so45369476ite.1
        for <linux-mmc@vger.kernel.org>; Mon, 24 Apr 2017 01:14:39 -0700 (PDT)
In-Reply-To: <faa2a3d8-e045-8bd1-06c9-e5cf64713035@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>

On Sat, Apr 22, 2017 at 9:45 AM, Adrian Hunter <adrian.hunter@intel.com> wr=
ote:

> Ulf and Linus have been doing a great job of keeping this moving, but it
> would be nice to see some others taking more interest.  The first command
> queue patches were posted in February 2014, over 3 years ago!

I agree.

I think both me & Ulf would also be doing more work if we had easily
accessible hardware with upstream host controller support for native
command queueing. (Hm, was just reading in libata about NCQ ...
d=C3=A9ja vu ... https://en.wikipedia.org/wiki/Native_Command_Queuing)

Do we have some hardware with host-backed command queueing
out there that is easily obtained and has upstream support for the
basic system?

Yours,
Linus Walleij
