From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH] mmc: core: Fix voltage select in DDR mode
Date: Thu, 15 Dec 2011 22:36:30 +0530
Message-ID: <000001ccbb4b$e65ce250$b316a6f0$@org>
References: <1323950262-2160-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:13852 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756323Ab1LORGf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Dec 2011 12:06:35 -0500
In-Reply-To: <1323950262-2160-1-git-send-email-girish.shivananjappa@linaro.org>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Girish K S' <girish.shivananjappa@linaro.org>, linux-mmc@vger.kernel.org
Cc: patches@linaro.org, linux-samsung-soc@vger.kernel.org, 'Philip Rakity' <prakity@marvell.com>, 'Arindam Nath' <arindam.nath@amd.com>, 'Chris Ball' <cjb@laptop.org>



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Girish K S
> Sent: Thursday, December 15, 2011 5:28 PM
> To: linux-mmc@vger.kernel.org
> Cc: patches@linaro.org; linux-samsung-soc@vger.kernel.org; Girish K S;
> Philip Rakity; Arindam Nath; Chris Ball
> Subject: [PATCH] mmc: core: Fix voltage select in DDR mode
> 
> This patch fixes the wrong comparison before setting the interface
> voltage in DDR mode.
> 
> The assignment to the variable ddr before comaprison is either
> ddr = MMC_1_2V_DDR_MODE; or ddr == MMC_1_8V_DDR_MODE. But the
> comparison
> is done wth the extended csd value if (ddr ==
> EXT_CSD_CARD_TYPE_DDR_1_2V)
> 
> cc: Philip Rakity <prakity@marvell.com>
> cc: Arindam Nath <arindam.nath@amd.com>
> cc: Chris Ball <cjb@laptop.org>
> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> ---
>  drivers/mmc/core/mmc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 006e932..f0a9f1f 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1058,7 +1058,7 @@ static int mmc_init_card(struct mmc_host *host,
> u32 ocr,
>  			 *
>  			 * WARNING: eMMC rules are NOT the same as SD DDR
>  			 */
> -			if (ddr == EXT_CSD_CARD_TYPE_DDR_1_2V) {
> +			if (ddr == MMC_1_2V_DDR_MODE) {

Looks fine. 
Acked-by: Subhash Jadavani <subhashj@codeaurora.org>

>  				err = mmc_set_signal_voltage(host,
>  					MMC_SIGNAL_VOLTAGE_120, 0);
>  				if (err)
> --
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

