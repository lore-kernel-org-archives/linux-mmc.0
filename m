From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 00/12] mmc: remove the MMC_DATA_STREAM flag
Date: Fri, 29 Jan 2016 13:28:51 +0900
Message-ID: <56AAEA83.60109@samsung.com>
References: <1454040371-31625-1-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:38051 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbcA2E2x (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jan 2016 23:28:53 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O1P01T805S31K10@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 29 Jan 2016 13:28:51 +0900 (KST)
In-reply-to: <1454040371-31625-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, sonic.zhang@analog.com, robert.jarzmik@free.fr

Hi, All.

Sorry! I sent wrong patchset..There is other patch.. :(

I will resend the correct patchset.
Discard this patchset...Sorry!

Best Regards,
Jaehoon Chung

On 01/29/2016 01:05 PM, Jaehoon Chung wrote:
> This patchset is related to remove the MMC_DATA_STREAM.
> It's not set to MMC_DATS_STREAM anywhere.
> This flag had been used with CDM11 and CMD20.
> But CMD11/CMD20 have become obsolete.
> To reduce the confusion, removed the unnecessary flag.
> 
> Jaehoon Chung (12):
>   mmc: core: use the defined function to check whether card is removable
>   mmc: atmel-mci: remove the MMC_DATA_STREAM flag
>   mmc: bfin_sdh: remove the MMC_DATA_STREAM flag
>   mmc: davinci_mmc: remove the MMC_DATA_STREAM flag
>   mmc: dw_mmc: remove the MMC_DATA_STREAM flag
>   mmc: jz4740_mmc: remove the MMC_DATA_STREAM flag
>   mmc: mxcmmc: remove the MMC_DATA_STREAM flag
>   mmc: pxamci: remove the MMC_DATA_STREAM flag
>   mmc: s3cmci: remove the MMC_DATA_STREAM flag
>   mmc: sunxi-mmc: remove the MMC_DATA_STREAM flag
>   mmc: core: remove the MMC_DATA_STREAM flag
>   mmc: block: don't use the OR operation for flag of data
> 
>  drivers/mmc/card/block.c       |  6 +++---
>  drivers/mmc/core/core.c        |  9 ++++-----
>  drivers/mmc/host/atmel-mci.c   |  9 ++-------
>  drivers/mmc/host/bfin_sdh.c    |  3 ---
>  drivers/mmc/host/davinci_mmc.c | 15 +++------------
>  drivers/mmc/host/dw_mmc.c      |  2 --
>  drivers/mmc/host/jz4740_mmc.c  |  2 --
>  drivers/mmc/host/mxcmmc.c      |  3 ---
>  drivers/mmc/host/pxamci.c      |  6 ------
>  drivers/mmc/host/s3cmci.c      |  3 +--
>  drivers/mmc/host/sunxi-mmc.c   |  5 -----
>  include/linux/mmc/core.h       |  1 -
>  12 files changed, 13 insertions(+), 51 deletions(-)
> 

