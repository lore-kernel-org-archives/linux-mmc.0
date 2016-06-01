From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: k3: add MMC_CAP_CMD23
Date: Wed, 01 Jun 2016 21:46:27 +0900
Message-ID: <574ED923.6060700@samsung.com>
References: <CGME20160601124153epcas1p277b5dd6a7b72de21e4dc71d456960170@epcas1p2.samsung.com>
 <1464784798-15828-1-git-send-email-jerome.forissier@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:38316 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbcFAMqa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jun 2016 08:46:30 -0400
In-reply-to: <1464784798-15828-1-git-send-email-jerome.forissier@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jerome Forissier <jerome.forissier@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Jerome,

On 06/01/2016 09:39 PM, Jerome Forissier wrote:
> Enables RPMB support for the on-board eMMC of the HiKey board as well
> as for eMMC modules connected to the microSD slot.

Thanks! I will pick on my repository.
If we needs to use the MMC_CAP_CMD23, i will consider for using by default.

Best Regards,
Jaehoon Chung

> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc-k3.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
> index 63c2e2e..8e9d886 100644
> --- a/drivers/mmc/host/dw_mmc-k3.c
> +++ b/drivers/mmc/host/dw_mmc-k3.c
> @@ -32,6 +32,12 @@ struct k3_priv {
>  	struct regmap	*reg;
>  };
>  
> +static unsigned long dw_mci_hi6220_caps[] = {
> +	MMC_CAP_CMD23,
> +	MMC_CAP_CMD23,
> +	0
> +};
> +
>  static void dw_mci_k3_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>  {
>  	int ret;
> @@ -126,6 +132,7 @@ static void dw_mci_hi6220_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>  }
>  
>  static const struct dw_mci_drv_data hi6220_data = {
> +	.caps			= dw_mci_hi6220_caps,
>  	.switch_voltage		= dw_mci_hi6220_switch_voltage,
>  	.set_ios		= dw_mci_hi6220_set_ios,
>  	.parse_dt		= dw_mci_hi6220_parse_dt,
> 

