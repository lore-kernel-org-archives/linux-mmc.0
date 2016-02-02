From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 00/11] mmc: remove the MMC_DATA_STREAM flag
Date: Tue, 2 Feb 2016 14:11:29 +0100
Message-ID: <CAPDyKFqQtt4BHGZ9bK3Fm+M4zh_T+2eLxW62wfqds_4zNVtObA@mail.gmail.com>
References: <1454328456-22918-1-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:35288 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755080AbcBBNLa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Feb 2016 08:11:30 -0500
Received: by mail-yk0-f171.google.com with SMTP id r207so137100820ykd.2
        for <linux-mmc@vger.kernel.org>; Tue, 02 Feb 2016 05:11:30 -0800 (PST)
In-Reply-To: <1454328456-22918-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Sonic Zhang <sonic.zhang@analog.com>, Robert Jarzmik <robert.jarzmik@free.fr>, andi.shyti@samsung.com

On 1 February 2016 at 13:07, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> This patchset is related to remove the MMC_DATA_STREAM.
> It's not set to MMC_DATS_STREAM anywhere.
> This flag had been used with CDM11 and CMD20.
> But CMD11/CMD20 have become obsolete.
> To reduce the confusion, removed the unnecessary flag.
>
> Changelog V2:
>         - Fixed commit message.
>         - Added Robert's Acked-by for pxamci host controller.
>
> Jaehoon Chung (11):
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
>  11 files changed, 9 insertions(+), 46 deletions(-)
>
> --
> 1.9.1
>

Thanks, applied for next!

Kind regards
Uffe
