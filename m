From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2] mmc: change to use kmalloc
Date: Thu, 19 Nov 2015 12:31:06 +0100
Message-ID: <CAPDyKFppbyDHFMiYfaG_Eo9KLjg2tyA-ZV0d511a9ZV3u=OM9g@mail.gmail.com>
References: <1447327631-26947-1-git-send-email-yalin.wang2010@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:35476 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933030AbbKSLbH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Nov 2015 06:31:07 -0500
Received: by ykba77 with SMTP id a77so103797807ykb.2
        for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2015 03:31:06 -0800 (PST)
In-Reply-To: <1447327631-26947-1-git-send-email-yalin.wang2010@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: yalin wang <yalin.wang2010@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Tobias Klauser <tklauser@distanz.ch>, "JBottomley@Odin.com" <JBottomley@odin.com>, Ben Hutchings <ben@decadent.org.uk>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, =?UTF-8?B?SnVzdGluIFdhbmcgKOeOi+S4gSk=?= <justin.wang@spreadtrum.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 12 November 2015 at 12:27, yalin wang <yalin.wang2010@gmail.com> wrote:
> Use kmalloc instead of kzalloc, zero the memory is not needed.
>
> Signed-off-by: yalin wang <yalin.wang2010@gmail.com>

Thanks, applied for next! I took liberty to update the change log and
the commit message header to make it more descriptive.

Kind regards
Uffe


> ---
>  drivers/mmc/card/block.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index c742cfd..c3fd4c8 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -345,7 +345,7 @@ static struct mmc_blk_ioc_data *mmc_blk_ioctl_copy_from_user(
>         struct mmc_blk_ioc_data *idata;
>         int err;
>
> -       idata = kzalloc(sizeof(*idata), GFP_KERNEL);
> +       idata = kmalloc(sizeof(*idata), GFP_KERNEL);
>         if (!idata) {
>                 err = -ENOMEM;
>                 goto out;
> @@ -365,7 +365,7 @@ static struct mmc_blk_ioc_data *mmc_blk_ioctl_copy_from_user(
>         if (!idata->buf_bytes)
>                 return idata;
>
> -       idata->buf = kzalloc(idata->buf_bytes, GFP_KERNEL);
> +       idata->buf = kmalloc(idata->buf_bytes, GFP_KERNEL);
>         if (!idata->buf) {
>                 err = -ENOMEM;
>                 goto idata_err;
> --
> 1.9.1
>
