From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/7] mmc: sh_mmcif: use to_delayed_work
Date: Wed, 27 Jan 2016 15:15:12 +0100
Message-ID: <CAPDyKFq97KHVdrmwZeASvn1AsjOXfmTbPhXBU9KBV+sJXk0NOA@mail.gmail.com>
References: <643e31066f3378b9521dd9cd8c569ccfcf185d61.1451659910.git.geliangtang@163.com>
	<580d73236305b902cbd6fe7b7880d3e6a6d3a382.1451659910.git.geliangtang@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:35067 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932783AbcA0OPN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jan 2016 09:15:13 -0500
Received: by mail-yk0-f175.google.com with SMTP id y137so18713677yka.2
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jan 2016 06:15:13 -0800 (PST)
In-Reply-To: <580d73236305b902cbd6fe7b7880d3e6a6d3a382.1451659910.git.geliangtang@163.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Geliang Tang <geliangtang@163.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 1 January 2016 at 15:59, Geliang Tang <geliangtang@163.com> wrote:
> Use to_delayed_work() instead of open-coding it.
>
> Signed-off-by: Geliang Tang <geliangtang@163.com>

Thanks, applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sh_mmcif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 1ca8a13..e0c076a 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1395,7 +1395,7 @@ static irqreturn_t sh_mmcif_intr(int irq, void *dev_id)
>
>  static void sh_mmcif_timeout_work(struct work_struct *work)
>  {
> -       struct delayed_work *d = container_of(work, struct delayed_work, work);
> +       struct delayed_work *d = to_delayed_work(work);
>         struct sh_mmcif_host *host = container_of(d, struct sh_mmcif_host, timeout_work);
>         struct mmc_request *mrq = host->mrq;
>         struct device *dev = sh_mmcif_host_to_dev(host);
> --
> 2.5.0
>
>
