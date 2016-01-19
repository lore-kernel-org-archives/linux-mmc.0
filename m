From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: debugfs: correct wrong voltage value
Date: Tue, 19 Jan 2016 10:44:08 +0100
Message-ID: <CAPDyKFqxiSxSeXqsYJoDSh5jQsjTMqs0EuNPOJJHrSX31mdo_w@mail.gmail.com>
References: <1453109719-53079-1-git-send-email-pawelx.wodkowski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:34656 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757889AbcASJoJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jan 2016 04:44:09 -0500
Received: by mail-yk0-f170.google.com with SMTP id a85so563551298ykb.1
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jan 2016 01:44:09 -0800 (PST)
In-Reply-To: <1453109719-53079-1-git-send-email-pawelx.wodkowski@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pawel Wodkowski <pawelx.wodkowski@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chuanxiao Dong <chuanxiao.dong@intel.com>

On 18 January 2016 at 10:35, Pawel Wodkowski <pawelx.wodkowski@intel.com> wrote:
> From: Chuanxiao Dong <chuanxiao.dong@intel.com>
>
> Correct the wrong voltage value shown in debugfs for mmc/sd/sdio.
>
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> Signed-off-by: Pawel Wodkowski <pawelx.wodkowski@intel.com>

Thanks, applied for fixes and by adding the fixes tag below.

Fixes: 42cd95a0603e ("mmc: core: debugfs: Add signal_voltage to ios dump")

Kind regards
Uffe

> ---
>  drivers/mmc/core/debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index bdfce774d848..6239ec3220a8 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -170,7 +170,7 @@ static int mmc_ios_show(struct seq_file *s, void *data)
>                 str = "invalid";
>                 break;
>         }
> -       seq_printf(s, "signal voltage:\t%u (%s)\n", ios->chip_select, str);
> +       seq_printf(s, "signal voltage:\t%u (%s)\n", ios->signal_voltage, str);
>
>         switch (ios->drv_type) {
>         case MMC_SET_DRIVER_TYPE_A:
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
