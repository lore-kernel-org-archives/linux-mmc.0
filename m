From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: block: fix logical error to avoid memory leak
Date: Mon, 18 Dec 2017 14:05:52 +0100
Message-ID: <CAPDyKFojyPB5QULubDVar1kqnHQ0SUeZn7kr=HWKfDiWmujQ6Q@mail.gmail.com>
References: <20171214050305.GA135779@sofia> <f9294d5a-bd24-8b95-3666-fa75d681bec1@intel.com>
 <20171216151545.GA138678@sofia>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:37755 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbdLRNFx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Dec 2017 08:05:53 -0500
Received: by mail-it0-f65.google.com with SMTP id d137so27526496itc.2
        for <linux-mmc@vger.kernel.org>; Mon, 18 Dec 2017 05:05:53 -0800 (PST)
In-Reply-To: <20171216151545.GA138678@sofia>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Liu, Changcheng" <changcheng.liu@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On 16 December 2017 at 16:15, Liu, Changcheng <changcheng.liu@intel.com> wrote:
> If the MMC_DRV_OP_GET_EXT_CSD request completes successfully, then
> ext_csd must be freed, but in one case it was not. Fix that.
>
> Signed-off-by: Liu Changcheng <changcheng.liu@intel.com>

Thanks, applied for next!

Next time, you may please preserve acks from previous versions,
especially if the reviewer (Adrian in this case) says so.

Kind regards
Uffe

>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index ccfa98a..b737a95 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2623,6 +2623,7 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
>
>         if (n != EXT_CSD_STR_LEN) {
>                 err = -EINVAL;
> +               kfree(ext_csd);
>                 goto out_free;
>         }
>
> --
> 2.7.4
