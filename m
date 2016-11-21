From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RFCv2 00/10] mmc: Add HW Command Queuing Support
Date: Mon, 21 Nov 2016 16:52:37 +0100
Message-ID: <CACRpkdbTkAzTGiKFLFgxFTQA0wa8egCAwZf8WzJNTa-nOifqOA@mail.gmail.com>
References: <1467033757-32498-1-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:32785 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754308AbcKUPwj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Nov 2016 10:52:39 -0500
Received: by mail-qk0-f174.google.com with SMTP id x190so355897648qkb.0
        for <linux-mmc@vger.kernel.org>; Mon, 21 Nov 2016 07:52:38 -0800 (PST)
In-Reply-To: <1467033757-32498-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Alex Lemberg <alex.lemberg@sandisk.com>, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Asutosh Das <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sujit Reddy Thumma <sthumma@codeaurora.org>, kdorfman@codeaurora.org, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, venkatg@codeaurora.org, Shawn Lin <shawn.lin@rock-chips.com>

On Mon, Jun 27, 2016 at 3:22 PM, Ritesh Harjani <riteshh@codeaurora.org> wrote:

> This patch series refreshes the older patch series sent a
> while ago by Asutosh Das[1].
>
> Current set of patch series is only introducing the basic CMDQ
> driver to get more review comments. Based on the reviews, will
> add other features as well to the patch list.

kthread is deprecated since the talks of the last kernel
summit. You should prefer to use workqueues.

The queueing mechanism looks like a duplicate copy/paste
solution built on the "old" processing queue.

Overall this is the problem with the whole patch set: instead
of a "deep" integration by improving the existing request
processing, a separate code path is bolted on the side.

What you should do is improve the existing infrastructure to
accomodate for the new mechanism.

For example: a new processing thread is introduced instead
of augmenting the existing one to handle this case, resulting
in a big slew of duplicated code.

For example: this is not at all integrated with the other feature,
packed command, which is *also* speculatively pulling out ever more
stuff from the block layer, albeit in a totally different manner,
actually integrated with the existing queue mechanism.

Needless to say: these two features (packed command and
command queue) should use the *same codepath* just that the
command queuing is more powerful, so that packed command is
merely a subset of the command queueing.

Now: note that I sent a patch do delete packed command. I do
not know if that will be accepted, but something deeply
integrated is for sure needed, we need a elegant and compact
core of code to maintain, not more copies of the already existing
messy code.

Yours,
Linus Walleij
