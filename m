From: Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 3/5] Documentation: synopsys-dw-mshc: add binding for
 fifo quirks
Date: Thu, 1 Dec 2016 09:35:43 +0800
Message-ID: <CABymUCP6_pHs55Jx53Qt9-jTNO+Bw3xMp7NCnu49=ASEemXgyw@mail.gmail.com>
References: <1479450555-19047-1-git-send-email-jun.nie@linaro.org>
 <1479450555-19047-4-git-send-email-jun.nie@linaro.org> <CABymUCN_+kJC2NZaPuqOg1C_Q2ASmiGwbwWCtfiLjGwSqPjgkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CABymUCN_+kJC2NZaPuqOg1C_Q2ASmiGwbwWCtfiLjGwSqPjgkQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "xie.baoyou" <xie.baoyou-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jason Liu <jason.liu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, chen.chaokai-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, lai.binz-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

2016-11-24 10:19 GMT+08:00 Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>:
> 2016-11-18 14:29 GMT+08:00 Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>:
>> Add fifo-addr property and fifo-watermark-quirk property to
>> synopsys-dw-mshc bindings. It is intended to provide more
>> dt interface to support SoCs specific configuration.
>>
>> Signed-off-by: Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>> index 4e00e85..8bf2e41 100644
>> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>> @@ -76,6 +76,17 @@ Optional properties:
>>
>>  * broken-cd: as documented in mmc core bindings.
>>
>> +* data-addr: Override fifo address with value provided by DT. The default FIFO reg
>> +  offset is assumed as 0x100 (version < 0x240A) and 0x200(version >= 0x240A) by
>> +  driver. If the controller does not follow this rule, please use this property
>> +  to set fifo address in device tree.
>> +
>> +* fifo-watermark-aligned: Data done irq is expected if data length is less than
>> +  watermark in PIO mode. But fifo watermark is requested to be aligned with data
>> +  length in some SoC so that TX/RX irq can be generated with data done irq. Add this
>> +  watermark quirk to mark this requirement and force fifo watermark setting
>> +  accordingly.
>> +
>>  * vmmc-supply: The phandle to the regulator to use for vmmc.  If this is
>>    specified we'll defer probe until we can find this regulator.
>>
>> @@ -103,6 +114,8 @@ board specific portions as listed below.
>>                 interrupts = <0 75 0>;
>>                 #address-cells = <1>;
>>                 #size-cells = <0>;
>> +               data-addr = <0x200>;
>> +               fifo-watermark-aligned;
>>         };
>>
>>  [board specific internal DMA resources]
>> --
>> 1.9.1
>>
> Hi Rob & Mark,
>
> Could you help review and act this patch if you think it is OK? Thank you!
>
> Jun


Hi Rob & Mark,

Could you help comment or act on this patch in revsion 6? Thank you!

Jun
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
