From: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v9 0/5] Add intial support to DW MMC host on ZTE SoC
Date: Wed, 11 Jan 2017 15:51:28 +0900
Message-ID: <fdba7d5b-163b-7b52-3f7e-d98affff64e1@samsung.com>
References: <CGME20170106042538epcas4p1a06bd50f6335ae882f0f891b6a2f0f29@epcas4p1.samsung.com>
 <1483676686-17011-1-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1483676686-17011-1-git-send-email-jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, xie.baoyou-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jason.liu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, chen.chaokai-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, lai.binz-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, CPGS <cpgs-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Jun,

On 01/06/2017 01:24 PM, Jun Nie wrote:
> Add intial support to DW MMC host on ZTE SoC. It include platform
> specific wrapper driver and workarounds for fifo quirk.

Thanks for resending patches.
But There are conflicts because of Ulf's latest patch.

commit 0c4697dcb4f2c8b2e1ee4ddfc2a1498d6e9888ae
Refs: v4.10-rc3-23-g0c4697d
Author:     Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
AuthorDate: Fri Dec 30 13:47:20 2016 +0100
Commit:     Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
CommitDate: Tue Jan 10 16:25:33 2017 +0100

    mmc: dw_mmc: Remove the public dw_mmc header file

So i modified your patches with latest mmc repository before applying.
I had the building test.

Best Regards,
Jaehoon Chung

> 
> Changes vs version 8:
>   - Fix bug of uninitialized variable len in zx mmc driver.
> 
> Changes vs version 7:
>   - Re-order patches sequence so that new dts property is introduced before usage.
>   - Remove unecessary property in zx mmc dts.
> 
> Changes vs version 6:
>   - Resolve confilict when rebase to latest dw-mmc.git for-ulf branch.
>   - Add Shawn Lin's review tag.
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
>   Documentation: synopsys-dw-mshc: add binding for fifo quirks
>   mmc: dw: Add fifo address property
>   mmc: dw: Add fifo watermark alignment property
>   mmc: dt-bindings: add ZTE ZX296718 MMC bindings
>   mmc: zx: Initial support for ZX mmc controller
> 
>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  13 ++
>  .../devicetree/bindings/mmc/zx-dw-mshc.txt         |  33 +++
>  drivers/mmc/host/Kconfig                           |   9 +
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/dw_mmc-zx.c                       | 242 +++++++++++++++++++++
>  drivers/mmc/host/dw_mmc-zx.h                       |  31 +++
>  drivers/mmc/host/dw_mmc.c                          |  17 +-
>  include/linux/mmc/dw_mmc.h                         |   5 +
>  8 files changed, 348 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
>  create mode 100644 drivers/mmc/host/dw_mmc-zx.c
>  create mode 100644 drivers/mmc/host/dw_mmc-zx.h
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
