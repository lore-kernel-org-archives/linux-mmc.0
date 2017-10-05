From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH V9 13/15] mmc: block: Add CQE and blk-mq support
Date: Thu, 05 Oct 2017 12:55:49 +0200
Message-ID: <2081590.uFvUN0fvNT@amdc3058>
References: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com>
        <2384661.GfpEZ6rEzz@amdc3058>
        <CAPDyKFrVK2hK9LEPKRfTTMOvP6WD5ug+VTwOt9tDaiMKKUBsNA@mail.gmail.com>
        <CGME20171005105552epcas1p45c58d8d356f029a0089271b903af3e48@epcas1p4.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAPDyKFrVK2hK9LEPKRfTTMOvP6WD5ug+VTwOt9tDaiMKKUBsNA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>, Christoph Hellwig <hch@lst.de>
List-Id: linux-mmc@vger.kernel.org

On Wednesday, October 04, 2017 11:48:27 AM Ulf Hansson wrote:
> [...]
> 
> >> MQ code that doesn't perform and therefore we cannot switch seamlessly
> >> to MQ.
> >
> > I think that switching seamlessly to blk-mq in short/medium-term
> > is not possible (SCSI tried and failed to do so). The changes to
> > the old path are very complex and besides affecting performance
> > they also affect error recovery handling (which needs to be tested
> > properly before the switch).
> 
> Agreed, and that's why I have queued up the new Kconfig option for
> enabling the blkmq path from MMC.

This seems premature - the new Kconfig option change for "mmc-mq" should
belong to the patch adding "mmc-mq" support (otherwise it may just confuse
users who enable it).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
