From: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v8 0/5] Add intial support to DW MMC host on ZTE SoC
Date: Thu, 05 Jan 2017 10:09:33 +0900
Message-ID: <6b530119-bb2e-a492-e7c8-403d7440457a@samsung.com>
References: <CGME20161222045752epcas5p3ed15c57243cee4c65c0c2e784baf9e02@epcas5p3.samsung.com>
 <1482382657-16681-1-git-send-email-jun.nie@linaro.org>
 <a7014d59-7071-917e-27d8-a1dffc373737@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <a7014d59-7071-917e-27d8-a1dffc373737-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, xie.baoyou-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jason.liu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, chen.chaokai-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, lai.binz-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, CPGS <cpgs-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi, 

On 01/04/2017 05:25 PM, Jaehoon Chung wrote:
> Hi Jun,
> 
> On 12/22/2016 01:57 PM, Jun Nie wrote:
>> Add intial support to DW MMC host on ZTE SoC. It include platform
>> specific wrapper driver and workarounds for fifo quirk.
>>
>> Changes vs version 7:
>>   - Re-order patches sequence so that new dts property is introduced before usage.
>>   - Remove unecessary property in zx mmc dts.
>>
>> Changes vs version 6:
>>   - Resolve confilict when rebase to latest dw-mmc.git for-ulf branch.
>>   - Add Shawn Lin's review tag.
>>
>> Changes vs version 5:
>>   - Add clock delay lock status check to save CPU cycle in timing tuning CMD.
>>
>> Changes vs version 4:
>>   - Fix missing empty dts compatible element in the end of compatible array.
>>
>> Changes vs version 3:
>>   - Fix brace error in document.
>>
>> Changes vs version 2:
>>   - Change dt property fifo-addr to data-addr and fifo-watermark-quirk to
>>     fifo-watermark-aligned.
>>   - Polish ZX MMC driver on minor coding style issues.
>>
>> Changes vs version 1:
>>   - Change fifo-addr-override to fifo-addr and remove its workaround tag in comments.
>>   - Remove ZX DW MMC driver reset cap in driver, which can be added in dt nodes.
>>
>>
>> Jun Nie (5):
>>   Documentation: synopsys-dw-mshc: add binding for fifo quirks
>>   mmc: dw: Add fifo address property
>>   mmc: dw: Add fifo watermark alignment property
>>   mmc: dt-bindings: add ZTE ZX296718 MMC bindings
>>   mmc: zx: Initial support for ZX mmc controller
>>
>>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  13 ++
>>  .../devicetree/bindings/mmc/zx-dw-mshc.txt         |  33 +++
>>  drivers/mmc/host/Kconfig                           |   9 +
>>  drivers/mmc/host/Makefile                          |   1 +
>>  drivers/mmc/host/dw_mmc-zx.c                       | 242 +++++++++++++++++++++
>>  drivers/mmc/host/dw_mmc-zx.h                       |  31 +++
>>  drivers/mmc/host/dw_mmc.c                          |  17 +-
>>  include/linux/mmc/dw_mmc.h                         |   5 +
>>  8 files changed, 348 insertions(+), 3 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
>>  create mode 100644 drivers/mmc/host/dw_mmc-zx.c
>>  create mode 100644 drivers/mmc/host/dw_mmc-zx.h
> 
> I will pick your patches after modifying the subject some prefix.
> Sorry for late. Thanks!

Applied on my git repository.
Thanks!

> 
> Best Regards,
> Jaehoon Chung
> 
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
