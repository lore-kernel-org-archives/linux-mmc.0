From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V14 03/24] mmc: core: Do not leave the block driver in a
 suspended state
Date: Thu, 23 Nov 2017 19:12:58 +0100
Message-ID: <CAPDyKFp1p4zwGvJV1SePHNcnR+_CL6F0=o4ge_ZAXmOSz2HEOQ@mail.gmail.com>
References: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com> <1511271770-3444-4-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511271770-3444-4-git-send-email-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Christoph Hellwig <hch@lst.de>
List-Id: linux-mmc@vger.kernel.org

On 21 November 2017 at 14:42, Adrian Hunter <adrian.hunter@intel.com> wrote:
> The block driver must be resumed if the mmc bus fails to suspend the card.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for fixes and added a stable tag (I think v3.19+ is
the first one we can pick, else some other manual back porting is
needed).

Kind regards
Uffe

> ---
>  drivers/mmc/core/bus.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index a4b49e25fe96..7586ff2ad1f1 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -157,6 +157,9 @@ static int mmc_bus_suspend(struct device *dev)
>                 return ret;
>
>         ret = host->bus_ops->suspend(host);
> +       if (ret)
> +               pm_generic_resume(dev);
> +
>         return ret;
>  }
>
> --
> 1.9.1
>
