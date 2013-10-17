From: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RESEND PATCH v2 2/6] ARM: dts: Specify clocks for UARTs on bcm11351
Date: Thu, 17 Oct 2013 08:14:56 +0200
Message-ID: <525F8060.4040900@gmail.com>
References: <1381960030-1640-1-git-send-email-tim.kryger@linaro.org> <1381960030-1640-3-git-send-email-tim.kryger@linaro.org> <CAEPRUYrzAow1yr58jOp5ead7BkQx-K7yaLLzSHPwqYVu=aZFEQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAEPRUYrzAow1yr58jOp5ead7BkQx-K7yaLLzSHPwqYVu=aZFEQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>
Cc: Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linaro Patches <patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 10/17/2013 07:41 AM, Christian Daudt wrote:
> On Wed, Oct 16, 2013 at 2:47 PM, Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> Rather than declaring the frequency of the external clock, specify the
>> label of the clock such that the driver may determine the frequency on
>> its own.
>>
>> Signed-off-by: Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Reviewed-by: Markus Mayer <markus.mayer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Reviewed-by: Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>>   arch/arm/boot/dts/bcm11351.dtsi | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
>> index c6464fb..ce65367 100644
>> --- a/arch/arm/boot/dts/bcm11351.dtsi
>> +++ b/arch/arm/boot/dts/bcm11351.dtsi
>> @@ -43,7 +43,7 @@
>>                  compatible = "brcm,bcm11351-dw-apb-uart", "snps,dw-apb-uart";
>>                  status = "disabled";
>>                  reg = <0x3e000000 0x1000>;
>> -               clock-frequency = <13000000>;
>> +               clocks = <&uartb_clk>;
>>                  interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
>>                  reg-shift = <2>;
>>                  reg-io-width = <4>;
>
> Hi Sebastian,
>   this patch series (and a subsequent one from Tim) both rely on your
> "ARM: provide common arch init for DT clocks" patchset in order to
> work. Will that patchset be in 3.13 ? I don't want to pull the dt mods
> unless they are as they break the boot without them.

Christian,

here is the pull request [1], pull [2], and stable commitment for the
branch [3]. You can merge that branch too and name the dependency when
you send your PR, arm-soc maintainers will sort it out.

Besides a small section mismatch fixup for nomadik that Olof requested,
I guess it is in.

Sebastian

[1] http://www.spinics.net/lists/arm-kernel/msg276175.html
[2] http://www.spinics.net/lists/arm-kernel/msg277816.html
[3] http://www.spinics.net/lists/arm-kernel/msg279736.html

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
