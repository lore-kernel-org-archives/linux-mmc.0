From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: add missing mmc_blk_put in power_ro_lock_show
Date: Tue, 21 Jul 2015 14:19:08 +0200
Message-ID: <CAPDyKFr8m+-gO7s18cP5aDYB5B8AMnSfrb3uSuMwhY=-DcuzWg@mail.gmail.com>
References: <1437054645-31056-1-git-send-email-tomas.winkler@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1437054645-31056-1-git-send-email-tomas.winkler@intel.com>
Sender: stable-owner@vger.kernel.org
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "# 3.10+" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 16 July 2015 at 15:50, Tomas Winkler <tomas.winkler@intel.com> wrote:
> Enclosing mmc_blk_put is missing in power_ro_lock_show
> sysfs handler
>
> Cc: stable@vger.kernel.org # 3.10+
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Thanks, applied for fixes!

I took the liberty to update the change-log and and add a fixes tag.
Fixes: add710eaa886 ("mmc: boot partition ro lock support")

Kind regards
Uffe

> ---
>  drivers/mmc/card/block.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index c9c3d20b784b..a1b820fcb2a6 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -208,6 +208,8 @@ static ssize_t power_ro_lock_show(struct device *dev,
>
>         ret = snprintf(buf, PAGE_SIZE, "%d\n", locked);
>
> +       mmc_blk_put(md);
> +
>         return ret;
>  }
>
> --
> 2.4.3
>
