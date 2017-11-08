From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V13 08/10] mmc: block: blk-mq: Separate card polling from recovery
Date: Wed, 8 Nov 2017 10:30:55 +0100
Message-ID: <CACRpkdb2_D3WZZp2f2o+f+zc7R-jU=wfs7Ec1rppim0mTd-sDw@mail.gmail.com>
References: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com> <1509715220-31885-9-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <1509715220-31885-9-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>, Christoph Hellwig <hch@lst.de>
List-Id: linux-mmc@vger.kernel.org

On Fri, Nov 3, 2017 at 2:20 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Recovery is simpler to understand if it is only used for errors. Create a
> separate function for card polling.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

This looks good but I can't see why it's not folded into
patch 3 already. This error handling is introduced there.

Yours,
Linus Walleij
