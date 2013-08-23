From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: mmc bus test data timeout setting
Date: Fri, 23 Aug 2013 13:14:06 +0200
Message-ID: <CAPDyKFruF1kJoB=qrn6P+Px5neZijKFLEwQA382uSYR6=aiLHw@mail.gmail.com>
References: <59606D77376AA44BB2E289FE5BA55046751F63AE@NTXXIAMBX01.xacn.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f47.google.com ([209.85.212.47]:52424 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754675Ab3HWLOI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Aug 2013 07:14:08 -0400
Received: by mail-vb0-f47.google.com with SMTP id h10so320305vbh.6
        for <linux-mmc@vger.kernel.org>; Fri, 23 Aug 2013 04:14:06 -0700 (PDT)
In-Reply-To: <59606D77376AA44BB2E289FE5BA55046751F63AE@NTXXIAMBX01.xacn.micron.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Minjian Wu (minjianwu)" <minjianwu@micron.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 26 July 2013 07:06, Minjian Wu (minjianwu) <minjianwu@micron.com> wrote:
> Add data timeout setting for mmc bus test command(CMD14 and CMD19).
>
> Signed-off-by: Minjian Wu <minjianwu@micron.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/mmc/core/mmc_ops.c                     |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -562,6 +562,7 @@ mmc_send_bus_test(struct mmc_card *card, struct mmc_host *host, u8 opcode,
>
>         data.sg = &sg;
>         data.sg_len = 1;
> +       mmc_set_data_timeout(&data,card);
>         sg_init_one(&sg, data_buf, len);
>         mmc_wait_for_req(host, &mrq);
>         err = 0;
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
