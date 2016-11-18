From: Jun Nie <jun.nie@linaro.org>
Subject: Re: [PATCH v5 0/5] Add intial support to DW MMC host on ZTE SoC
Date: Fri, 18 Nov 2016 14:34:34 +0800
Message-ID: <CABymUCM9nENzQ4cA+7oxQc6AHeMoqLsY4-rum76xnbNL4=zAaw@mail.gmail.com>
References: <CGME20161108012533epcas5p19f44057ff5477f35ebf057527fea9788@epcas5p1.samsung.com>
 <1478568298-18380-1-git-send-email-jun.nie@linaro.org> <20eca791-015f-1d9f-d24b-213276db08db@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34621 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751139AbcKRGeg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2016 01:34:36 -0500
Received: by mail-qk0-f173.google.com with SMTP id q130so251738241qke.1
        for <linux-mmc@vger.kernel.org>; Thu, 17 Nov 2016 22:34:35 -0800 (PST)
In-Reply-To: <20eca791-015f-1d9f-d24b-213276db08db@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, "xie.baoyou" <xie.baoyou@zte.com.cn>, Ulf Hansson <ulf.hansson@linaro.org>, Jason Liu <jason.liu@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>

2016-11-18 10:16 GMT+08:00 Jaehoon Chung <jh80.chung@samsung.com>:
> Hi Jun,
>
> On 11/08/2016 10:24 AM, Jun Nie wrote:
>> Add intial support to DW MMC host on ZTE SoC. It include platform
>> specific wrapper driver and workarounds for fifo quirk.
>
> If you send the patch after modifying Shawn's comment, I will apply these patchset on my repository.
> I don't know but i guess you want to apply these patches on v4.10.
>
> Best Regards,
> Jaehoon Chung
>
Thanks for you guys' review. Could you please help add your review tag
to V6 patches as I already send out and do not want to send twice to
confuse everyone. Thank you!

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

Jun

>>
>> Patches are prepared based on latest dw mmc runtime change:
>>    https://github.com/jh80chung/dw-mmc.git for-ulf
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
>> Jun Nie (5):
>>   mmc: dt-bindings: add ZTE ZX296718 MMC bindings
>>   mmc: zx: Initial support for ZX mmc controller
>>   Documentation: synopsys-dw-mshc: add binding for fifo quirks
>>   mmc: dw: Add fifo address property
>>   mmc: dw: Add fifo watermark alignment property
>>
>>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  13 ++
>>  .../devicetree/bindings/mmc/zx-dw-mshc.txt         |  34 +++
>>  drivers/mmc/host/Kconfig                           |   9 +
>>  drivers/mmc/host/Makefile                          |   1 +
>>  drivers/mmc/host/dw_mmc-zx.c                       | 242 +++++++++++++++++++++
>>  drivers/mmc/host/dw_mmc-zx.h                       |  31 +++
>>  drivers/mmc/host/dw_mmc.c                          |  17 +-
>>  include/linux/mmc/dw_mmc.h                         |   5 +
>>  8 files changed, 349 insertions(+), 3 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
>>  create mode 100644 drivers/mmc/host/dw_mmc-zx.c
>>  create mode 100644 drivers/mmc/host/dw_mmc-zx.h
>>
>
