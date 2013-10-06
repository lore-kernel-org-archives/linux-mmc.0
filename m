From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: Add hardware lock error (HLE) to the CMD
 error flag
Date: Sun, 06 Oct 2013 17:28:41 +0900
Message-ID: <52511F39.8000207@samsung.com>
References: <1380791881-31484-1-git-send-email-alim.akhtar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:16721 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843Ab3JFI2i (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Oct 2013 04:28:38 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MU800105NJPIJ40@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Sun, 06 Oct 2013 17:28:37 +0900 (KST)
In-reply-to: <1380791881-31484-1-git-send-email-alim.akhtar@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: alim akhtar <alim.akhtar@samsung.com>
Cc: linux-mmc@vger.kernel.org, tgih.jun@samsung.com, cjb@laptop.org, dianders@chromium.org

Hi Alim,

On 10/03/2013 06:18 PM, alim akhtar wrote:
> From: Alim Akhtar <alim.akhtar@samsung.com>
> 
> Hardware locked error set when the dw_mmc controller cannot load a
> command issued by software. When software sets the start_cmd bit in the
> CMD register, the controller tries to load the command. If the command
> buffer is already filled with a command, this error is raised. Currently
> driver does not handle HLE interrupt, which results in a system hang.
When SDMMC_INT_HLE is set into CMD_ERROR_FLAGS,
then could driver handle the HLE interrupt?

Best Regards,
Jaehoon Chung
> 
> HLE can be simulated by quickly inserting and removing sd card in card
> slot (30 ~ 40 times in say 20 secs)
> 
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 0a6a512..24b4a52 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -44,7 +44,7 @@
>  				 SDMMC_INT_HTO | SDMMC_INT_SBE  | \
>  				 SDMMC_INT_EBE)
>  #define DW_MCI_CMD_ERROR_FLAGS	(SDMMC_INT_RTO | SDMMC_INT_RCRC | \
> -				 SDMMC_INT_RESP_ERR)
> +				 SDMMC_INT_RESP_ERR | SDMMC_INT_HLE)
>  #define DW_MCI_ERROR_FLAGS	(DW_MCI_DATA_ERROR_FLAGS | \
>  				 DW_MCI_CMD_ERROR_FLAGS  | SDMMC_INT_HLE)
>  #define DW_MCI_SEND_STATUS	1
> 

