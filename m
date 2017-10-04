From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V9 13/15] mmc: block: Add CQE and blk-mq support
Date: Wed, 4 Oct 2017 11:48:27 +0200
Message-ID: <CAPDyKFrVK2hK9LEPKRfTTMOvP6WD5ug+VTwOt9tDaiMKKUBsNA@mail.gmail.com>
References: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com>
 <1506083824-4024-14-git-send-email-adrian.hunter@intel.com>
 <CGME20171004093941epcas1p1d5277f64b4cc5a78bf185bf9d5b1abfb@epcas1p1.samsung.com>
 <CACRpkdYZFW6zdt5ig3wNDxQAaVV6OYnrG5zPfcvzixwh8VbXig@mail.gmail.com> <2384661.GfpEZ6rEzz@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <2384661.GfpEZ6rEzz@amdc3058>
Sender: linux-block-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>, Christoph Hellwig <hch@lst.de>
List-Id: linux-mmc@vger.kernel.org

[...]

>> MQ code that doesn't perform and therefore we cannot switch seamlessly
>> to MQ.
>
> I think that switching seamlessly to blk-mq in short/medium-term
> is not possible (SCSI tried and failed to do so). The changes to
> the old path are very complex and besides affecting performance
> they also affect error recovery handling (which needs to be tested
> properly before the switch).

Agreed, and that's why I have queued up the new Kconfig option for
enabling the blkmq path from MMC.

Kind regards
Uffe
