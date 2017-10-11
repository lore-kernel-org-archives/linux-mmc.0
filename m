From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] ANDROID: mmc: core: export emmc revision
Date: Wed, 11 Oct 2017 22:18:38 +0200
Message-ID: <20171011201838.GA4479@kroah.com>
References: <20171011192320.160580-1-jinqian@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171011192320.160580-1-jinqian@android.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jin Qian <jinqian@android.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Uri Yanai <uri.yanai@sandisk.com>, Chanho Min <chanho.min@lge.com>, Jungseung Lee <js07.lee@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Jin Qian <jinqian@google.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Oct 11, 2017 at 12:23:18PM -0700, Jin Qian wrote:
> From: Jin Qian <jinqian@google.com>
> 
> Expose emmc revision as part of device attributes.
> 
> Signed-off-by: Jin Qian <jinqian@android.com>
> ---
>  drivers/mmc/core/mmc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 36217ad5e9b1..4aa4cfb2c9e1 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -780,6 +780,7 @@ MMC_DEV_ATTR(manfid, "0x%06x\n", card->cid.manfid);
>  MMC_DEV_ATTR(name, "%s\n", card->cid.prod_name);
>  MMC_DEV_ATTR(oemid, "0x%04x\n", card->cid.oemid);
>  MMC_DEV_ATTR(prv, "0x%x\n", card->cid.prv);
> +MMC_DEV_ATTR(rev, "0x%x\n", card->ext_csd.rev);


Is there a Documentation/ABI/ update as well to describe exactly what
this sysfs attribute contains?

thanks,

greg k-h
