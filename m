From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v5 0/5] Add intial support to DW MMC host on ZTE SoC
Date: Mon, 14 Nov 2016 12:39:54 +0900
Message-ID: <da871ea6-cc1a-b615-27ed-b5edfef022cb@samsung.com>
References: <1478568298-18380-1-git-send-email-jun.nie@linaro.org>
 <CGME20161114032234epcas2p10bffe1f18aca57fd136770246a8e5af8@epcas2p1.samsung.com>
 <CABymUCMfZwzvkZvOFCCsic46A1t-SD8uFqBBRyqnTgmFbTikzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:60993 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753190AbcKNDj5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Nov 2016 22:39:57 -0500
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OGM00JW54UH54E0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 14 Nov 2016 12:39:54 +0900 (KST)
In-reply-to: <CABymUCMfZwzvkZvOFCCsic46A1t-SD8uFqBBRyqnTgmFbTikzQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, "xie.baoyou" <xie.baoyou@zte.com.cn>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jason Liu <jason.liu@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>

Hi Jun,

On 11/14/2016 12:21 PM, Jun Nie wrote:
> 2016-11-08 9:24 GMT+08:00 Jun Nie <jun.nie@linaro.org>:
>> Add intial support to DW MMC host on ZTE SoC. It include platform
>> specific wrapper driver and workarounds for fifo quirk.
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
>> --
>> 1.9.1
>>
> 
> Jaehoon Chung,
> 
> I assume you do not have more comments on this serial patches, neither
> from community. If so, could you help merge them to your trees so that
> it can go to mainline later?

Sorry for late..because I had holidays until yesterday. :)
Now, I'm checking sequentially. ASAP, i will reply. 
Thanks! 

Best Regards,
Jaehoon Chung

> 
> Thank you!
> Jun
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

