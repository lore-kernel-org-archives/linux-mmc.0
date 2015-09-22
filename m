From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 1/3] mmc: debugfs: fix memory leak for mmc_ext_csd_open
Date: Tue, 22 Sep 2015 09:37:01 +0800
Message-ID: <5600B0BD.704@rock-chips.com>
References: <1442884713-11193-1-git-send-email-shawn.lin@rock-chips.com>
 <CAK7Sx+gO2=jhQ-DpNqm4o+JUqKv+38a1C9CtZ4sZrUQ5XGJqHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:52689 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757437AbbIVBhN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Sep 2015 21:37:13 -0400
In-Reply-To: <CAK7Sx+gO2=jhQ-DpNqm4o+JUqKv+38a1C9CtZ4sZrUQ5XGJqHQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: trick wong <trickwong@gmail.com>
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 2015/9/22 9:29, trick wong wrote:
> In the correct path,this buf will used later.why freed?
>

right.
sorry for this noise, withdraw this patch[1/3].

> 2015-09-22 9:18 GMT+08:00 Shawn Lin <shawn.lin@rock-chips.com
> <mailto:shawn.lin@rock-chips.com>>:
>
>     buf allocated isn't been freed before return, so we fix it.
>
>     Fixes: 736bb6bb01a ("mmc: Add Extended CSD register to debugfs")
>     Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com
>     <mailto:shawn.lin@rock-chips.com>>
>     ---
>
>       drivers/mmc/core/debugfs.c | 1 +
>       1 file changed, 1 insertion(+)
>
>     diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
>     index e914210..b2ab936 100644
>     --- a/drivers/mmc/core/debugfs.c
>     +++ b/drivers/mmc/core/debugfs.c
>     @@ -304,6 +304,7 @@ static int mmc_ext_csd_open(struct inode *inode,
>     struct file *filp)
>
>              filp->private_data = buf;
>              kfree(ext_csd);
>     +       kfree(buf);
>              return 0;
>
>       out_free:
>     --
>     2.3.7
>
>
>     --
>     To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>     the body of a message to majordomo@vger.kernel.org
>     <mailto:majordomo@vger.kernel.org>
>     More majordomo info at http://vger.kernel.org/majordomo-info.html
>
>


-- 
Best Regards
Shawn Lin

