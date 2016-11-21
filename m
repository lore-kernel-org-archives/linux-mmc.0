From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFCv2 00/10] mmc: Add HW Command Queuing Support
Date: Mon, 21 Nov 2016 17:05:15 +0100
Message-ID: <10880752.H1JikWMFDK@wuerfel>
References: <1467033757-32498-1-git-send-email-riteshh@codeaurora.org> <CACRpkdbTkAzTGiKFLFgxFTQA0wa8egCAwZf8WzJNTa-nOifqOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:61136 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752889AbcKUQFo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Nov 2016 11:05:44 -0500
In-Reply-To: <CACRpkdbTkAzTGiKFLFgxFTQA0wa8egCAwZf8WzJNTa-nOifqOA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ritesh Harjani <riteshh@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Alex Lemberg <alex.lemberg@sandisk.com>, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Asutosh Das <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sujit Reddy Thumma <sthumma@codeaurora.org>, kdorfman@codeaurora.org, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, venkatg@codeaurora.org, Shawn Lin <shawn.lin@rock-chips.com>

On Monday, November 21, 2016 4:52:37 PM CET Linus Walleij wrote:
> On Mon, Jun 27, 2016 at 3:22 PM, Ritesh Harjani <riteshh@codeaurora.org> wrote:
> 
> > This patch series refreshes the older patch series sent a
> > while ago by Asutosh Das[1].
> >
> > Current set of patch series is only introducing the basic CMDQ
> > driver to get more review comments. Based on the reviews, will
> > add other features as well to the patch list.
> 
> kthread is deprecated since the talks of the last kernel
> summit. You should prefer to use workqueues.

It's the kthread freezer that is deprecated, not kthreads. It with
blk_mq, we probably won't want to have this kthread, but that's
a differennt issue, and using workqueues instead won't help.

	Arnd
