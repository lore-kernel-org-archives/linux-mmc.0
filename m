From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/1] mmc: sdhci: fix low memory corruption
Date: Mon, 15 Jun 2015 11:55:40 +0200
Message-ID: <CAPDyKFoxNTq+Wnx4Mere8HkJrGUxKby4AqhdYu0Sk69vPWXp9g@mail.gmail.com>
References: <557A9C71.6090700@suse.cz>
	<1434102302-11189-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1434102302-11189-1-git-send-email-jslaby@suse.cz>
Sender: stable-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, konrad.wilk@oracle.com, linux-mmc <linux-mmc@vger.kernel.org>, "# 4.0+" <stable@vger.kernel.org>, Haibo Chen <haibo.chen@freescale.com>
List-Id: linux-mmc@vger.kernel.org

On 12 June 2015 at 11:45, Jiri Slaby <jslaby@suse.cz> wrote:
> When dma mapping (dma_map_sg) fails in sdhci_pre_dma_transfer, -EINVAL
> is returned. There are 3 callers of sdhci_pre_dma_transfer:
> * sdhci_pre_req and sdhci_adma_table_pre: handle negative return
> * sdhci_prepare_data: handles 0 (error) and "else" (good) only
>
> sdhci_prepare_data is therefore broken. When it receives -EINVAL from
> sdhci_pre_dma_transfer, it assumes 1 sg mapping was mapped. Later,
> this non-existant mapping with address 0 is kmap'ped and written to:
> Corrupted low memory at ffff880000001000 (1000 phys) = 22b7d67df2f6d1cf
> Corrupted low memory at ffff880000001008 (1008 phys) = 63848a5216b7dd95
> Corrupted low memory at ffff880000001010 (1010 phys) = 330eb7ddef39e427
> Corrupted low memory at ffff880000001018 (1018 phys) = 8017ac7295039bda
> Corrupted low memory at ffff880000001020 (1020 phys) = 8ce039eac119074f
> ...
>
> So teach sdhci_prepare_data to understand negative return values from
> sdhci_pre_dma_transfer and disable DMA in that case, as well as for
> zero.
>
> It was introduced in 348487cb28e66b032bae1b38424d81bf5b444408 (mmc:
> sdhci: use pipeline mmc requests to improve performance). The commit
> seems to be suspicious also by assigning host->sg_count both in
> sdhci_pre_dma_transfer and sdhci_adma_table_pre.
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: stable@vger.kernel.org # 4.0+
> Fixes: 348487cb28e6
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Haibo Chen <haibo.chen@freescale.com>

Thanks, applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 1b4861ddfb38..55e7f9a9858a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -834,7 +834,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>                         int sg_cnt;
>
>                         sg_cnt = sdhci_pre_dma_transfer(host, data, NULL);
> -                       if (sg_cnt == 0) {
> +                       if (sg_cnt <= 0) {
>                                 /*
>                                  * This only happens when someone fed
>                                  * us an invalid request.
> --
> 2.4.2
>
