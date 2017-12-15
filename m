From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mm/block: logical error fix to avoid memory leak
Date: Fri, 15 Dec 2017 16:34:30 +0200
Message-ID: <f9294d5a-bd24-8b95-3666-fa75d681bec1@intel.com>
References: <20171214050305.GA135779@sofia>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:41190 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755322AbdLOOe4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 15 Dec 2017 09:34:56 -0500
In-Reply-To: <20171214050305.GA135779@sofia>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Liu, Changcheng" <changcheng.liu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, akpm@linux-foundation.org

On 14/12/17 07:03, Liu, Changcheng wrote:
> function:  mmc_ext_csd_open
> {
> +-- 33 lines: struct mmc_card *card = inode->i_private;--
>     if (n != EXT_CSD_STR_LEN) {
>         err = -EINVAL;
>         goto out_free;  //==>should free ext_csd firstly.
>     }
> +--  2 lines: filp->private_data = buf;------------------
>     kfree(ext_csd);
>     return 0;
> 
> out_free:
>     kfree(buf);
>     return err;
> }
> 
> Signed-off-by: Liu Changcheng <changcheng.liu@intel.com>

Well I don't really follow the commit message, but the patch is OK.
How about this:


mmc: block: fix logical error to avoid memory leak

If the MMC_DRV_OP_GET_EXT_CSD request completes successfully, then
ext_csd must be freed, but in one case it was not. Fix that.


Otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index ccfa98a..b737a95 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2623,6 +2623,7 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
>  
>  	if (n != EXT_CSD_STR_LEN) {
>  		err = -EINVAL;
> +		kfree(ext_csd);
>  		goto out_free;
>  	}
>  
> 

