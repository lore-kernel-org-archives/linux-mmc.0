From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: r8a77995: draak: enable SDHI2
Date: Mon, 20 Nov 2017 21:07:02 +0100
Message-ID: <ae0e2924-7e5d-7760-ed82-b0622765b1f8@gmail.com>
References: <1510759549-30404-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1510759549-30404-4-git-send-email-ulrich.hecht+renesas@gmail.com>
 <CAMuHMdXFMsvjMcbmBLCBL9+Ow1=cqQeosEd3hUygjhT_Z=L49w@mail.gmail.com>
 <20171117143507.yovg64u2znjwj4wh@verge.net.au>
 <ee3b50ce-3da7-eff1-6bb6-9eb5d61faf42@gmail.com>
 <20171120094327.pnrvraysv2tm6jhm@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171120094327.pnrvraysv2tm6jhm@verge.net.au>
Content-Language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Linux MMC List <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 11/20/2017 10:43 AM, Simon Horman wrote:
> On Fri, Nov 17, 2017 at 08:08:27PM +0100, Marek Vasut wrote:
>> On 11/17/2017 03:35 PM, Simon Horman wrote:
>>> On Thu, Nov 16, 2017 at 10:43:35AM +0100, Geert Uytterhoeven wrote:
>>>> Hi Uli,
>>>>
>>>> On Wed, Nov 15, 2017 at 4:25 PM, Ulrich Hecht
>>>> <ulrich.hecht+renesas@gmail.com> wrote:
>>>>> The single SDHI controller is connected to eMMC.
>>>>>
>>>>> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
>>>>
>>>> Thanks for your patch!
>>>>
>>>>> --- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
>>>>> +++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
>>>>> @@ -32,6 +32,24 @@
>>>>>                 /* first 128MB is reserved for secure area. */
>>>>>                 reg = <0x0 0x48000000 0x0 0x18000000>;
>>>>>         };
>>>>> +
>>>>> +       reg_1p8v: regulator0 {
>>>>> +               compatible = "regulator-fixed";
>>>>> +               regulator-name = "fixed-1.8V";
>>>>> +               regulator-min-microvolt = <1800000>;
>>>>> +               regulator-max-microvolt = <1800000>;
>>>>> +               regulator-boot-on;
>>>>> +               regulator-always-on;
>>>>> +       };
>>>>> +
>>>>> +       reg_3p3v: regulator1 {
>>>>> +               compatible = "regulator-fixed";
>>>>> +               regulator-name = "fixed-3.3V";
>>>>> +               regulator-min-microvolt = <3300000>;
>>>>> +               regulator-max-microvolt = <3300000>;
>>>>> +               regulator-boot-on;
>>>>> +               regulator-always-on;
>>>>> +       };
>>>>
>>>> As the eMMC is 1.8V only, I'll defer the review to the people looking
>>>> into the need
>>>> to specify the 3.3V pinctrl on other R-Car Gen3 boards.
>>>
>>> I don't see any harm in describing the hardware present in DT.
>>>
>> The hardware present has 1V8 only bus interface. The 3V3 rail connected
>> to the eMMC is used for the flash array only, not for the bus interface.
>> The bus interface has a separate power rail, 1V8 one.
> 
> Ok, so a better description of the hardware would be one that
> does not include the reg_3p3v node?

Nope.

The VCC is used to supply the memory array and that needs 3V3 (because
otherwise the charge pump which is used to erase blocks cannot operate).

The VCCQ is used to supply IO and that is 1V8 or 3V3 or a few other
options inbetween, but in this case it's 1V8 only according to the DT.

So what you want to fix is sdhi2_pins power-source node and make it 1800
(mV) .

-- 
Best regards,
Marek Vasut
