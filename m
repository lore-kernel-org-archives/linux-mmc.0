From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: Print proper voltage on error
Date: Wed, 13 Jul 2016 10:35:48 +0900
Message-ID: <57859AF4.1020204@samsung.com>
References: <1468332502-28016-1-git-send-email-k.kozlowski@samsung.com>
 <CGME20160712140926epcas1p48680eebdc43dc79797d75a04f77d4816@epcas1p4.samsung.com>
 <1468332502-28016-2-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:50031 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbcGMBf5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2016 21:35:57 -0400
In-reply-to: <1468332502-28016-2-git-send-email-k.kozlowski@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi Krzysztof,

On 07/12/2016 11:08 PM, Krzysztof Kozlowski wrote:
> The commit 97f659a2e972 ("mmc: dw_mmc: prevent to set the wrong
> value") reordered the code so the 'uhs' variable used in
> mmc_regulator_set_vqmmc() error message is always 0 at that time thus
> always printing 3.3 voltage.  Instead use value obtained from ios in
> printed error message.

The commit 97f659a2e972 was dropped because some board didn't work fine.
Some boards didn't use the vqmmc suppy and not defined into device-tree.

It's short time to fix. I will re-send the patch on next.
At that time, i will check this patch.

Best Regards,
Jaehoon Chung

> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index c2a128628b31..7de561065003 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1416,8 +1416,8 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
>  	ret = mmc_regulator_set_vqmmc(mmc, ios);
>  	if (ret) {
>  		dev_err(&mmc->class_dev,
> -				 "Regulator set error %d - %s V\n",
> -				 ret, uhs & v18 ? "1.8" : "3.3");
> +				 "Regulator set error %d - %s\n",
> +				 ret, mmc_voltage_to_str(ios));
>  		return ret;
>  	}
>  
> 

