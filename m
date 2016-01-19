From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: Add a restriction to mmc debugfs clock setting.
Date: Tue, 19 Jan 2016 14:35:29 +0800
Message-ID: <569DD931.6050001@rock-chips.com>
References: <1453183995-46099-1-git-send-email-pawelx.wodkowski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:45716 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbcASGf4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jan 2016 01:35:56 -0500
In-Reply-To: <1453183995-46099-1-git-send-email-pawelx.wodkowski@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pawel Wodkowski <pawelx.wodkowski@intel.com>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, Chuanxiao Dong <chuanxiao.dong@intel.com>, Yuan Juntao <juntaox.yuan@intel.com>

On 2016/1/19 14:13, Pawel Wodkowski wrote:
> From: Chuanxiao Dong <chuanxiao.dong@intel.com>
>
> Clock frequency values written to an mmc host should not be less than
> the minimum clock frequency which the mmc host supports.
>
> Signed-off-by: Yuan Juntao <juntaox.yuan@intel.com>
> Signed-off-by: Pawel Wodkowski <pawelx.wodkowski@intel.com>
> ---
>   drivers/mmc/core/debugfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index 154aced0b91b..bdfce774d848 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -220,7 +220,7 @@ static int mmc_clock_opt_set(void *data, u64 val)
>   	struct mmc_host *host = data;
>
>   	/* We need this check due to input value is u64 */
> -	if (val > host->f_max)
> +	if (val > host->f_max || val < host->f_min)

Hmm... how about if I want to disable clk from sysfs and pass ZERO to 
mmc_clock_opt_set, doesn't that case make sense? :)

>   		return -EINVAL;
>
>   	mmc_claim_host(host);
>


-- 
Best Regards
Shawn Lin

