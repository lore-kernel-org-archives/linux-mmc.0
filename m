From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V14 02/24] mmc: block: Check return value of blk_get_request()
Date: Thu, 23 Nov 2017 10:56:19 +0100
Message-ID: <CACRpkdaVVfVY1WAKbY_pM-r8Hvd_OUUchuuNC5+W4BQQvrSfuQ@mail.gmail.com>
References: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com> <1511271770-3444-3-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <1511271770-3444-3-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Christoph Hellwig <hch@lst.de>
List-Id: linux-mmc@vger.kernel.org

On Tue, Nov 21, 2017 at 2:42 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> blk_get_request() can fail, always check the return value.
>
> Fixes: 0493f6fe5bde ("mmc: block: Move boot partition locking into a driver op")
> Fixes: 3ecd8cf23f88 ("mmc: block: move multi-ioctl() to use block layer")
> Fixes: 614f0388f580 ("mmc: block: move single ioctl() commands to block requests")
> Fixes: 627c3ccfb46a ("mmc: debugfs: Move block debugfs into block module")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
This should also go into fixes I think.

I guess this particular sloppiness was due to modeling the code on
drivers/ide/* which doesn't check the return value either.

I should go and fix that :/

Yours,
Linus Walleij
