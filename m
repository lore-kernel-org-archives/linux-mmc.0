From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/3] mmc: sd: Remove superfluous error code assignment
Date: Wed, 9 Sep 2015 21:29:16 +0200
Message-ID: <55F0888C.3010502@redhat.com>
References: <1441816398-4330-1-git-send-email-yszhou4tech@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48398 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620AbbIIT3U (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 9 Sep 2015 15:29:20 -0400
In-Reply-To: <1441816398-4330-1-git-send-email-yszhou4tech@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yousong Zhou <yszhou4tech@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org

Hi All,

I requested yousong to send this set to further discuss it,
and hopefully get some fix for this in the kernel.

Yousong, I actually intended you to do a patch to the sunxi-mmc
code, rather then too the core. Ah well. Since we've this set
now lets see if people like it, it may help other cases
too I guess.

Regards,

Hans


On 09-09-15 18:33, Yousong Zhou wrote:
> Signed-off-by: Yousong Zhou <yszhou4tech@gmail.com>
> ---
>   drivers/mmc/core/sd.c |    2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 4e7366a..e28ebf3 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -357,8 +357,6 @@ int mmc_sd_switch_hs(struct mmc_card *card)
>   	if (card->sw_caps.hs_max_dtr == 0)
>   		return 0;
>
> -	err = -EIO;
> -
>   	status = kmalloc(64, GFP_KERNEL);
>   	if (!status) {
>   		pr_err("%s: could not allocate a buffer for "
>
