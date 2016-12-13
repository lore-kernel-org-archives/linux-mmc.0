From: Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 1/5] mmc: dt-bindings: add ZTE ZX296718 MMC bindings
Date: Tue, 13 Dec 2016 22:20:47 +0800
Message-ID: <CABymUCMw2RnysbqgLPZXhWcLDk8XbaK_oB0Lpuub6Y_9+Vc7Jg@mail.gmail.com>
References: <1480904976-7081-1-git-send-email-jun.nie@linaro.org>
 <1480904976-7081-2-git-send-email-jun.nie@linaro.org> <20161209214720.lymj7dfadksleryr@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161209214720.lymj7dfadksleryr@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "xie.baoyou" <xie.baoyou-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jason Liu <jason.liu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, chen.chaokai-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, lai.binz-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

2016-12-10 5:47 GMT+08:00 Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Mon, Dec 05, 2016 at 10:29:32AM +0800, Jun Nie wrote:
>> Document the device-tree binding of ZTE MMC host on
>> ZX296718 SoC.
>>
>> Signed-off-by: Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>>  .../devicetree/bindings/mmc/zx-dw-mshc.txt         | 35 ++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
>> new file mode 100644
>> index 0000000..c175c4b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
>> @@ -0,0 +1,35 @@
>> +* ZTE specific extensions to the Synopsys Designware Mobile Storage
>> +  Host Controller
>> +
>> +The Synopsys designware mobile storage host controller is used to interface
>> +a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
>> +differences between the core Synopsys dw mshc controller properties described
>> +by synopsys-dw-mshc.txt and the properties used by the ZTE specific
>> +extensions to the Synopsys Designware Mobile Storage Host Controller.
>> +
>> +Required Properties:
>> +
>> +* compatible: should be
>> +     - "zte,zx296718-dw-mshc": for ZX SoCs
>> +
>> +Example:
>> +
>> +     mmc1: mmc@1110000 {
>> +             compatible = "zte,zx296718-dw-mshc";
>
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>
> These aren't needed unless you have child nodes with reg property. The
> DW binding says you should have at least one child.

Will remove them in next version.
>
>> +             reg = <0x01110000 0x1000>;
>> +             interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
>> +             fifo-depth = <32>;
>> +             data-addr = <0x200>;
>> +             fifo-watermark-aligned;
>
> Custom properties should have vendor prefix.

These properties are consumed by DW MMC driver, not by ZTE driver. And
they may reused by SoCs from other vendors that integrate DW MMC IP.
The names are OK in this case?

Jun

>
>> +             bus-width = <4>;
>> +             clock-frequency = <50000000>;
>> +             clocks = <&topcrm SD0_AHB>, <&topcrm SD0_WCLK>;
>> +             clock-names = "biu", "ciu";
>> +             num-slots = <1>;
>> +             max-frequency = <50000000>;
>> +             cap-sdio-irq;
>> +             cap-sd-highspeed;
>> +             status = "disabled";
>> +     };
>> --
>> 1.9.1
>>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
