From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/2] mmc: rtsx: add support for sdio card
Date: Thu, 4 Dec 2014 14:52:32 +0100
Message-ID: <CAPDyKFr-Ov0UEGFJOa+kewzKYf+aAFQkuSuxJiyRNx7ETS9eEg@mail.gmail.com>
References: <cover.1417484016.git.micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:53213 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932101AbaLDNwc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Dec 2014 08:52:32 -0500
Received: by mail-qa0-f49.google.com with SMTP id s7so11853911qap.36
        for <linux-mmc@vger.kernel.org>; Thu, 04 Dec 2014 05:52:32 -0800 (PST)
In-Reply-To: <cover.1417484016.git.micky_ching@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: micky <micky_ching@realsil.com.cn>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Chris Ball <chris@printf.net>, "driverdev-devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@oracle.com>, Roger <rogerable@realtek.com>, Wei WANG <wei_wang@realsil.com.cn>

On 2 December 2014 at 02:36,  <micky_ching@realsil.com.cn> wrote:
> From: Micky Ching <micky_ching@realsil.com.cn>
>
> v3:
>   rtsx_pci_sdmmc.c:
>     - dump_reg_range
>       - remove unused pointer check
>       - fix start index

I can't find v3.

Kind regards
Uffe

> v2:
>   rtsx_pci.h:
>     - remove unused rtsx_pci_write_le32
>     - add SD_CMD_START
>   rtsx_pci_sdmmc.c:
>     - dump_reg_range
>       - alloc data on stack
>     - remove forward declaration
>     - use SD_CMD_START replace magic number 0x40
>     - move initialize assignment to error handling
>
> This patch is used to change transfer mode for sdio card support
> by SD interface.
>
>
> Micky Ching (2):
>   mfd: rtsx: add func to split u32 into register
>   mmc: rtsx: add support for sdio card
>
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 522 +++++++++++++++++++++-----------------
>  include/linux/mfd/rtsx_pci.h      |   9 +
>  2 files changed, 296 insertions(+), 235 deletions(-)
>
> --
> 1.9.1
>
