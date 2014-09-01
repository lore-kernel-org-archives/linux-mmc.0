From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 2/7] mmc: omap_hsmmc: use blk_size_workaround
Date: Mon, 01 Sep 2014 14:05:49 +0400
Message-ID: <540444FD.4040800@cogentembedded.com>
References: <87r3zvzohj.wl%kuninori.morimoto.gx@gmail.com> <87oauzzofe.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:35424 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbaIAKFt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Sep 2014 06:05:49 -0400
Received: by mail-lb0-f175.google.com with SMTP id u10so5564781lbd.6
        for <linux-mmc@vger.kernel.org>; Mon, 01 Sep 2014 03:05:48 -0700 (PDT)
In-Reply-To: <87oauzzofe.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

Hello.

On 9/1/2014 1:21 PM, Kuninori Morimoto wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

> Now, omap_hsmmc can use blk_size_workaround instead of
> MMC_CAP2_NO_MULTI_READ. let's use it.

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   drivers/mmc/host/omap_hsmmc.c |   17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)

> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index ece1634..6d2696b 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
[...]
> @@ -1840,6 +1854,7 @@ static const struct mmc_host_ops omap_hsmmc_ops = {
>   	.get_ro = omap_hsmmc_get_ro,
>   	.init_card = omap_hsmmc_init_card,
>   	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
> +	.blk_workaround = omap_hsmmc_blk_size_workaround,

    Not '.blk_size_workaround'?

[...]

WBR, Sergei

