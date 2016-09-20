From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3 1/6] mmc: add define for R1 response without CRC
Date: Tue, 20 Sep 2016 18:25:37 +0900
Message-ID: <ee4fe6b6-14bd-a0a5-9d6c-30c314ed83c3@samsung.com>
References: <20160919205750.4766-1-wsa+renesas@sang-engineering.com>
 <CGME20160919205932epcas1p3cec11c9dbe2589f7d50fee5932797933@epcas1p3.samsung.com>
 <20160919205750.4766-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:40888 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753395AbcITJZj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Sep 2016 05:25:39 -0400
In-reply-to: <20160919205750.4766-2-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Dirk Behme <dirk.behme@gmail.com>

Hi Wolfram,

On 09/20/2016 05:57 AM, Wolfram Sang wrote:
> The core uses it for polling. Give drivers a proper define handle this
> case like for other response types.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  include/linux/mmc/core.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index b01e77de1a74de..4caee099b63a28 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -55,6 +55,9 @@ struct mmc_command {
>  #define MMC_RSP_R6	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)
>  #define MMC_RSP_R7	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)
>  
> +/* Can be used by core to poll after switch to MMC HS mode */
> +#define MMC_RSP_R1_NO_CRC	(MMC_RSP_PRESENT|MMC_RSP_OPCODE)

MMC_RSP_RQ_NO_CRC is described at Specification?

Best Regards,
Jaehoon Chung

> +
>  #define mmc_resp_type(cmd)	((cmd)->flags & (MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC|MMC_RSP_BUSY|MMC_RSP_OPCODE))
>  
>  /*
> 

