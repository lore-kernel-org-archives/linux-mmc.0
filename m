From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: Add a restriction to mmc debugfs clock setting.
Date: Wed, 27 Jan 2016 15:16:21 +0100
Message-ID: <CAPDyKFpjVOBDhU250zjTS1F8ngASdaJJaDX_kA8Sidf9H2LF3w@mail.gmail.com>
References: <1453381071-47571-1-git-send-email-pawelx.wodkowski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:36019 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932797AbcA0OQW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jan 2016 09:16:22 -0500
Received: by mail-yk0-f179.google.com with SMTP id v14so241635855ykd.3
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jan 2016 06:16:22 -0800 (PST)
In-Reply-To: <1453381071-47571-1-git-send-email-pawelx.wodkowski@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pawel Wodkowski <pawelx.wodkowski@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chuanxiao Dong <chuanxiao.dong@intel.com>, Yuan Juntao <juntaox.yuan@intel.com>

On 21 January 2016 at 13:57, Pawel Wodkowski <pawelx.wodkowski@intel.com> wrote:
> From: Chuanxiao Dong <chuanxiao.dong@intel.com>
>
> Clock frequency values written to an mmc host should not be less than
> the minimum clock frequency which the mmc host supports.
>
> Signed-off-by: Yuan Juntao <juntaox.yuan@intel.com>
> Signed-off-by: Pawel Wodkowski <pawelx.wodkowski@intel.com>

Thanks, applied for next!

Kind regards
Uffe

>
> ---
>
> Changes in v2:
> - Allow setting zero frequency.
>
>  drivers/mmc/core/debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index 154aced0b91b..705586dcd9fa 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -220,7 +220,7 @@ static int mmc_clock_opt_set(void *data, u64 val)
>         struct mmc_host *host = data;
>
>         /* We need this check due to input value is u64 */
> -       if (val > host->f_max)
> +       if (val != 0 && (val > host->f_max || val < host->f_min))
>                 return -EINVAL;
>
>         mmc_claim_host(host);
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
