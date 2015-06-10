From: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH v7 1/2] arm64: dts: Add the arasan mmc nodes in apm-storm.dtsi
Date: Wed, 10 Jun 2015 23:56:20 +0530
Message-ID: <CAOHikRBAU=P56A2JhRJiB5gWANMfrZPp+fXR-BGUGyDGYAusKA@mail.gmail.com>
References: <1431517912-10322-1-git-send-email-stripathi@apm.com>
	<1431517912-10322-2-git-send-email-stripathi@apm.com>
	<CAOHikRAV4i_R8LhmJgRRePSbJ+YG_eb6c94idQZWHS+fh6SAVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og118.obsmtp.com ([64.18.0.160]:47820 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752467AbbFJS0W (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Jun 2015 14:26:22 -0400
Received: by wgv5 with SMTP id 5so42060464wgv.1
        for <linux-mmc@vger.kernel.org>; Wed, 10 Jun 2015 11:26:20 -0700 (PDT)
In-Reply-To: <CAOHikRAV4i_R8LhmJgRRePSbJ+YG_eb6c94idQZWHS+fh6SAVQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Anton Vorontsov <anton@enomsg.org>, Arnd Bergmann <arnd@arndb.de>, Michal Simek <michal.simek@xilinx.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Don Dutile <ddutile@redhat.com>, Jon Masters <jcm@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, patches <patches@apm.com>, Suman Tripathi <stripathi@apm.com>

Hi Arnd and all

On Mon, May 18, 2015 at 12:34 PM, Suman Tripathi <stripathi@apm.com> wrote:
> Hi Arnd,
>
> On Wed, May 13, 2015 at 5:21 PM, Suman Tripathi <stripathi@apm.com> wrote:
>> This patch adds the arasan mmc nodes to reuse the of-arasan
>> driver for APM X-Gene SoC.
>>
>> Signed-off-by: Suman Tripathi <stripathi@apm.com>
>> ---
>> ---
>>  arch/arm64/boot/dts/apm/apm-mustang.dts |  4 +++
>>  arch/arm64/boot/dts/apm/apm-storm.dtsi  | 43 +++++++++++++++++++++++++++++++++
>>  2 files changed, 47 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/apm/apm-mustang.dts b/arch/arm64/boot/dts/apm/apm-mustang.dts
>> index 83578e7..7a3ea72 100644
>> --- a/arch/arm64/boot/dts/apm/apm-mustang.dts
>> +++ b/arch/arm64/boot/dts/apm/apm-mustang.dts
>> @@ -52,3 +52,7 @@
>>  &xgenet {
>>         status = "ok";
>>  };
>> +
>> +&mmc0 {
>> +       status = "ok";
>> +};
>> diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
>> index c8d3e0e..8e03ecd 100644
>> --- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
>> +++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
>> @@ -145,6 +145,40 @@
>>                                 clock-output-names = "socplldiv2";
>>                         };
>>
>> +                       ahbclk: ahbclk@1f2ac000 {
>> +                               compatible = "apm,xgene-device-clock";
>> +                               #clock-cells = <1>;
>> +                               clocks = <&socplldiv2 0>;
>> +                               reg = <0x0 0x1f2ac000 0x0 0x1000
>> +                                       0x0 0x17000000 0x0 0x2000>;
>> +                               reg-names = "csr-reg", "div-reg";
>> +                               csr-offset = <0x0>;
>> +                               csr-mask = <0x1>;
>> +                               enable-offset = <0x8>;
>> +                               enable-mask = <0x1>;
>> +                               divider-offset = <0x164>;
>> +                               divider-width = <0x5>;
>> +                               divider-shift = <0x0>;
>> +                               clock-output-names = "ahbclk";
>> +                       };
>> +
>> +                       sdioclk: sdioclk@1f2ac000 {
>> +                               compatible = "apm,xgene-device-clock";
>> +                               #clock-cells = <1>;
>> +                               clocks = <&socplldiv2 0>;
>> +                               reg = <0x0 0x1f2ac000 0x0 0x1000
>> +                                       0x0 0x17000000 0x0 0x2000>;
>> +                               reg-names = "csr-reg", "div-reg";
>> +                               csr-offset = <0x0>;
>> +                               csr-mask = <0x2>;
>> +                               enable-offset = <0x8>;
>> +                               enable-mask = <0x2>;
>> +                               divider-offset = <0x178>;
>> +                               divider-width = <0x8>;
>> +                               divider-shift = <0x0>;
>> +                               clock-output-names = "sdioclk";
>> +                       };
>> +
>>                         qmlclk: qmlclk {
>>                                 compatible = "apm,xgene-device-clock";
>>                                 #clock-cells = <1>;
>> @@ -533,6 +567,15 @@
>>                         interrupts = <0x0 0x4f 0x4>;
>>                 };
>>
>> +               mmc0: mmc@1c000000 {
>> +                       compatible = "arasan,sdhci-4.9a";
>> +                       reg = <0x0 0x1c000000 0x0 0x100>;
>> +                       interrupts = <0x0 0x49 0x4>;
>> +                       dma-coherent;
>> +                       clock-names = "clk_xin", "clk_ahb";
>> +                       clocks = <&sdioclk 0>, <&ahbclk 0>;
>> +               };
>> +
>>                 phy1: phy@1f21a000 {
>>                         compatible = "apm,xgene-phy";
>>                         reg = <0x0 0x1f21a000 0x0 0x100>;
>> --
>> 1.8.2.1
>>
>
> Can you review this ?

Sorry to bother on this again . Can you review it ?

>
>
> --
> Thanks,
> with regards,
> Suman Tripathi



-- 
Thanks,
with regards,
Suman Tripathi
