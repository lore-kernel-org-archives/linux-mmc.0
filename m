From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCHv3 0/9] mmc: dw_mmc: clean the codes for dwmmc controller
Date: Fri, 18 Nov 2016 20:17:23 +0900
Message-ID: <3a5028b0-fbf2-f2d8-0141-51826a10a6ed@samsung.com>
References: <CGME20161117074336epcas3p3e02ba42edba96bba201f26d05e80601c@epcas3p3.samsung.com>
 <20161117074041.8641-1-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:37442 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752497AbcKRLRZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2016 06:17:25 -0500
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OGU02P5X4OZIL80@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 18 Nov 2016 20:17:23 +0900 (KST)
In-reply-to: <20161117074041.8641-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, adrian.hunter@intel.com

Hi,

On 11/17/2016 04:40 PM, Jaehoon Chung wrote:
> This patchset is modified the some minor fixing and cleaning codes.
> 
> * Major changes
> - Remove the unnecessary codes and use_stop_abort() by default.
> - Remove the obsoleted property "supports-highspeed"
> - Deprecated the "clock-freq-min-max" property. Instead, use "max-frequency"
> - Minimum clock value is set to 100K by default.

I have applied this patchset on my dwmmc repository.
If there are some issues, let me know, plz.

Best Regards,
Jaehoon Chung

> 
> Change in v3:
> - Use the dwmmc private cookie enum.
> - Add the reviewed-by and acked-by tags.
> 
> Change in v2:
> - Applied patches relevant to dt files
> - Use "deprecated" instead of removing about "clock-freq-min-max"
> - Added Heiko's Tested-by tag
> 
> Jaehoon Chung (9):
>   mmc: dw_mmc: display the real register value on debugfs
>   mmc: dw_mmc: fix the debug message for checking card's present
>   mmc: dw_mmc: change the DW_MCI_FREQ_MIN from 400K to 100K
>   mmc: dw_mmc: use the hold register when send stop command
>   mmc: dw_mmc: call the dw_mci_prep_stop_abort() by default
>   mmc: dw_mmc: use the cookie's enum values for post/pre_req()
>   mmc: dw_mmc: remove the unnecessary mmc_data structure
>   mmc: dw_mmc: The "clock-freq-min-max" property was deprecated
>   Documentation: synopsys-dw-mshc: remove the unused properties
> 
>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  8 +-
>  drivers/mmc/host/dw_mmc.c                          | 88 +++++++++++-----------
>  include/linux/mmc/dw_mmc.h                         |  6 ++
>  3 files changed, 50 insertions(+), 52 deletions(-)
> 

