From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v3 11/15] ARM: dts: dra7-evm: Add wilink8 wlan support
Date: Fri, 27 Apr 2018 16:50:28 +0530
Message-ID: <b3e16fc6-e620-29a4-71e7-5abe9a6da4d8@ti.com>
References: <20180425125449.19755-1-kishon@ti.com>
 <20180425125449.19755-12-kishon@ti.com>
 <CAL_JsqKBXbcQxbN7z9j_DKgiaQg4buUa+08fg9zPELv-ucpRZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqKBXbcQxbN7z9j_DKgiaQg4buUa+08fg9zPELv-ucpRZA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Hari Nagalla <hnagalla@ti.com>, Ido Yariv <ido@wizery.com>, Eyal Reizer <eyalr@ti.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-mmc@vger.kernel.org

Hi Rob,

On Wednesday 25 April 2018 08:17 PM, Rob Herring wrote:
> On Wed, Apr 25, 2018 at 7:54 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>> From: Hari Nagalla <hnagalla@ti.com>
>>
>> The wilink module is a combo wireless connectivity sdio
>> card based on Texas Instrument's wl18xx solution. It is a
>> 4-wire, 1.8V, embedded sdio wlan device with an external
>> irq line and is power-controlled by a gpio-based fixed
>> regulator.
>>
>> Add pinmux configuration and IODelay values for MMC4.
>> On dra7-evm, MMC4 is used for connecting to wilink module.
>>
>> IODelay data credits to :  Vishal Mahaveer <vishalm@ti.com>
>> and Sekhar Nori <nsekhar@ti.com>
>>
>> Signed-off-by: Ido Yariv <ido@wizery.com>
>> Signed-off-by: Eyal Reizer <eyalr@ti.com>
>> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  arch/arm/boot/dts/dra7-evm-common.dtsi | 15 +++++++++++++++
>>  arch/arm/boot/dts/dra7-evm.dts         | 25 +++++++++++++++++++++++++
>>  2 files changed, 40 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/dra7-evm-common.dtsi b/arch/arm/boot/dts/dra7-evm-common.dtsi
>> index 05a7b1a01bc3..3590c40fc112 100644
>> --- a/arch/arm/boot/dts/dra7-evm-common.dtsi
>> +++ b/arch/arm/boot/dts/dra7-evm-common.dtsi
>> @@ -260,3 +260,18 @@
>>  &pcie1_rc {
>>         status = "okay";
>>  };
>> +
>> +&mmc4 {
>> +       bus-width = <4>;
>> +       cap-power-off-card;
>> +       keep-power-in-suspend;
>> +       non-removable;
>> +       #address-cells = <1>;
>> +       #size-cells = <0>;
>> +       wlcore: wlcore@2 {
> 
> wifi@2

sure, I'll fix it in the next revision.

Thanks
Kishon
