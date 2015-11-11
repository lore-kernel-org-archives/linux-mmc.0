From: Alim Akhtar <alim.akhtar@gmail.com>
Subject: Re: [PATCH] mmc: change to use kmalloc
Date: Wed, 11 Nov 2015 22:32:23 +0530
Message-ID: <CAGOxZ53m0Fiudgt-gUBH2QhOW291tVmx1pFyeX5qmO_3kHQvSQ@mail.gmail.com>
References: <1447215791-19429-1-git-send-email-yalin.wang2010@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34747 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbbKKRDE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Nov 2015 12:03:04 -0500
In-Reply-To: <1447215791-19429-1-git-send-email-yalin.wang2010@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: yalin wang <yalin.wang2010@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, ben@decadent.org.uk, Jaehoon Chung <jh80.chung@samsung.com>, asaf.vertz@tandemg.com, tklauser@distanz.ch, jonathanh@nvidia.com, "James E.J. Bottomley" <JBottomley@odin.com>, Grant Grundler <grundler@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Yalin,

On Wed, Nov 11, 2015 at 9:53 AM, yalin wang <yalin.wang2010@gmail.com> wrote:
> Use kmalloc instead of kzalloc, zero the memory is not needed.
>
why you want to do this? what problem you faces, and how this resolves the same?

> Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
> ---
>  drivers/mmc/card/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 23b6c8e..975cd3e 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
Alim
