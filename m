From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [GIT PULL] DWMMC controller fixes
Date: Mon, 07 Nov 2016 09:33:03 +0900
Message-ID: <c5600c7c-8cea-cc8a-7878-56b0211a6c2c@samsung.com>
References: <CGME20161103052622epcas1p23ba69cc20d0a6ad576580e39086d2003@epcas1p2.samsung.com>
 <587f4226-0c21-899b-b16d-3f33d092e382@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:47356 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751167AbcKGAdJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Nov 2016 19:33:09 -0500
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OG80133NXJ6A8A0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 07 Nov 2016 09:33:06 +0900 (KST)
In-reply-to: <587f4226-0c21-899b-b16d-3f33d092e382@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

Hi Ulf,

On 11/03/2016 02:25 PM, Jaehoon Chung wrote:
> Dear Ulf,
> 
> Could you pull these patches on your fixes branch?

For Reminding..If there is a problem, let me know. 

Best Regards,
Jaehoon Chung

> 
> The following changes since commit d1f63f0c81c22ba705fcd149a1fcec37b734d818:
> 
>   mmc: sdhci-msm: Fix error return code in sdhci_msm_probe() (2016-10-27 09:43:01 +0200)
> 
> are available in the git repository at:
> 
>   https://github.com/jh80chung/dw-mmc.git fixes
> 
> for you to fetch changes up to 5c3d7c7ed1e676d7fa1c9222d9a46c5d09b9fe97:
> 
>   mmc: dw_mmc: add the "reset" as name of reset controller (2016-11-03 14:11:59 +0900)
> 
> ----------------------------------------------------------------
> DWMMC core:
> - Add the "reset" as "#reset-names" property for preventing wrong operation.
> 
> ----------------------------------------------------------------
> Jaehoon Chung (2):
>       Documentation: synopsys-dw-mshc: add binding for reset-names
>       mmc: dw_mmc: add the "reset" as name of reset controller
> 
>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 5 +++++
>  drivers/mmc/host/dw_mmc.c                                  | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> 
> Best Regards,
> Jaehoon Chung
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

