From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V13 06/10] mmc: sdhci-pci: Add CQHCI support for Intel GLK
Date: Wed, 8 Nov 2017 10:24:53 +0100
Message-ID: <CACRpkdaf8nt1P32M+uYD3xSTTHMO8YMnP=Y56H179XiB9mvakQ@mail.gmail.com>
References: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com> <1509715220-31885-7-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1509715220-31885-7-git-send-email-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>, Christoph Hellwig <hch@lst.de>
List-Id: linux-mmc@vger.kernel.org

On Fri, Nov 3, 2017 at 2:20 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Add CQHCI initialization and implement CQHCI operations for Intel GLK.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

This patch seems OK in context, but it merely illustrates the
weirdness of .[runtime]_suspend/resume calling into CQE-specific
APIs rather than using generic host callbacks.

Yours,
Linus Walleij
