From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3 2/6] mmc: rtsx_pci: use new macro for R1 without CRC
Date: Tue, 20 Sep 2016 18:29:58 +0900
Message-ID: <38358765-9f93-6b4a-176a-2c8a87490936@samsung.com>
References: <20160919205750.4766-1-wsa+renesas@sang-engineering.com>
 <CGME20160919205936epcas1p405299736aa8bedf4bee71e7f2cf8af89@epcas1p4.samsung.com>
 <20160919205750.4766-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:34203 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754045AbcITJaA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Sep 2016 05:30:00 -0400
In-reply-to: <20160919205750.4766-3-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Dirk Behme <dirk.behme@gmail.com>

Hi Wolfram,

Add the commit message.

On 09/20/2016 05:57 AM, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index 396c9b7e4121b0..3ccaa1415f33b2 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -126,7 +126,7 @@ static int sd_response_type(struct mmc_command *cmd)
>  		return SD_RSP_TYPE_R0;
>  	case MMC_RSP_R1:
>  		return SD_RSP_TYPE_R1;
> -	case MMC_RSP_R1 & ~MMC_RSP_CRC:
> +	case MMC_RSP_R1_NO_CRC:
>  		return SD_RSP_TYPE_R1 | SD_NO_CHECK_CRC7;
>  	case MMC_RSP_R1B:
>  		return SD_RSP_TYPE_R1b;
> 

