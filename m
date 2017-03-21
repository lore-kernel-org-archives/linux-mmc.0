From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RESEND 2/2] mmc-utils: Check for ext_csd_rev only once
Date: Wed, 22 Mar 2017 07:27:02 +0900
Message-ID: <ab557510-e716-386c-654b-a1383587bb9d@samsung.com>
References: <20170320134301.2909-1-alexander.stein@systec-electronic.com>
 <CGME20170320135235epcas4p2f08da19465f1d7445bde4f3f901a6b4e@epcas4p2.samsung.com>
 <20170320134301.2909-2-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:37999 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755793AbdCUWiH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Mar 2017 18:38:07 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0ON60288YRP3LR80@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 22 Mar 2017 07:27:03 +0900 (KST)
In-reply-to: <20170320134301.2909-2-alexander.stein@systec-electronic.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>, Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org

On 03/20/2017 10:43 PM, Alexander Stein wrote:
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

> ---
>  mmc_cmds.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 728ad77..d7215bb 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -1736,19 +1736,10 @@ int do_read_extcsd(int nargs, char **argv)
>  	if (ext_csd_rev >= 7) {
>  		printf("eMMC Firmware Version: %s\n",
>  			(char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION]);
> -	}
> -
> -	if (ext_csd_rev >= 7) {
>  		printf("eMMC Life Time Estimation A [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]: 0x%02x\n",
>  			ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]);
> -	}
> -
> -	if (ext_csd_rev >= 7) {
>  		printf("eMMC Life Time Estimation B [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B]: 0x%02x\n",
>  			ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B]);
> -	}
> -
> -	if (ext_csd_rev >= 7) {
>  		printf("eMMC Pre EOL information [EXT_CSD_PRE_EOL_INFO]: 0x%02x\n",
>  			ext_csd[EXT_CSD_PRE_EOL_INFO]);
>  	}
> 

