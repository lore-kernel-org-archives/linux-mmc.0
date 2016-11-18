From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v6 0/5] Add intial support to DW MMC host on ZTE SoC
Date: Fri, 18 Nov 2016 15:52:51 +0900
Message-ID: <2205472e-963f-319b-6523-76a4f486cafe@samsung.com>
References: <CGME20161118062929epcas2p35fff280ed75b50d35c3194514c7e0d8d@epcas2p3.samsung.com>
 <1479450555-19047-1-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:36053 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbcKRGwx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2016 01:52:53 -0500
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OGT0320DSG3Y230@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 18 Nov 2016 15:52:51 +0900 (KST)
In-reply-to: <1479450555-19047-1-git-send-email-jun.nie@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jun Nie <jun.nie@linaro.org>, shawn.guo@linaro.org, xie.baoyou@zte.com.cn
Cc: ulf.hansson@linaro.org, jason.liu@linaro.org, chen.chaokai@zte.com.cn, lai.binz@zte.com.cn, linux-mmc@vger.kernel.org

Hi Jun,

On 11/18/2016 03:29 PM, Jun Nie wrote:
> Add intial support to DW MMC host on ZTE SoC. It include platform
> specific wrapper driver and workarounds for fifo quirk.
> 
> Patches are prepared based on latest dw mmc runtime change:
>    https://github.com/jh80chung/dw-mmc.git for-ulf

Applied on my dwmmc repository.
I have applied your patches, after modifying some conflict and subject prefix as "dw_mmc*".
And added Shawn's reviewed-by tags. Thanks!

Best Regards,
Jaehoon Chung

> 
> Changes vs version 5:
>   - Add clock delay lock status check to save CPU cycle in timing tuning CMD.
> 
> Changes vs version 4:
>   - Fix missing empty dts compatible element in the end of compatible array.
> 
> Changes vs version 3:
>   - Fix brace error in document.
> 
> Changes vs version 2:
>   - Change dt property fifo-addr to data-addr and fifo-watermark-quirk to
>     fifo-watermark-aligned.
>   - Polish ZX MMC driver on minor coding style issues.
> 
> Changes vs version 1:
>   - Change fifo-addr-override to fifo-addr and remove its workaround tag in comments.
>   - Remove ZX DW MMC driver reset cap in driver, which can be added in dt nodes.
> 
> Jun Nie (5):
>   mmc: dt-bindings: add ZTE ZX296718 MMC bindings
>   mmc: zx: Initial support for ZX mmc controller
>   Documentation: synopsys-dw-mshc: add binding for fifo quirks
>   mmc: dw: Add fifo address property
>   mmc: dw: Add fifo watermark alignment property
> 
>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  13 ++
>  .../devicetree/bindings/mmc/zx-dw-mshc.txt         |  34 +++
>  drivers/mmc/host/Kconfig                           |   9 +
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/dw_mmc-zx.c                       | 242 +++++++++++++++++++++
>  drivers/mmc/host/dw_mmc-zx.h                       |  31 +++
>  drivers/mmc/host/dw_mmc.c                          |  17 +-
>  include/linux/mmc/dw_mmc.h                         |   5 +
>  8 files changed, 349 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
>  create mode 100644 drivers/mmc/host/dw_mmc-zx.c
>  create mode 100644 drivers/mmc/host/dw_mmc-zx.h
> 

