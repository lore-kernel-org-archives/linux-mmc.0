From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 08/11] Documentation: phy: Let the rockchip eMMC PHY get
 an exported card clock
Date: Mon, 13 Jun 2016 16:05:40 -0700
Message-ID: <CAD=FV=VL0zbx_zbegCqHCa=Q6fDtVG9s3epMc2oGUYB-L2efTw@mail.gmail.com>
References: <1465339484-969-1-git-send-email-dianders@chromium.org>
 <1465339484-969-9-git-send-email-dianders@chromium.org> <20160610133631.GA10634@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160610133631.GA10634@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Heiko Stuebner <heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>, Ziyuan Xu <xzy.xu@rock-chips.com>, Brian Norris <briannorris@chromium.org>, Adrian Hunter <adrian.hunter@intel.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Rob,

On Fri, Jun 10, 2016 at 6:36 AM, Rob Herring <robh@kernel.org> wrote:
> On Tue, Jun 07, 2016 at 03:44:41PM -0700, Douglas Anderson wrote:
>> As of an earlier change in this series ("Documentation: mmc:
>> sdhci-of-arasan: Add ability to export card clock") the SDHCI driver
>> used on Rockchip SoCs can now expose its clock.  Let's now specify that
>> the PHY can use it.
>>
>> Letting the PHY get access to this clock means it can adjust
>> phyctrl_frqsel field appropriately.  Although the Rockchip PHY appears
>> slightly different than the reference Arasan one, you can see that the
>> Arasan datasheet [1] had it defined as:
>>   Select the frequency range of DLL operation:
>>   3b'000 => 200MHz to 170 MHz
>>   3b'001 => 170MHz to 140 MHz
>>   3b'010 => 140MHz to 110 MHz
>>   3b'011 => 110MHz to 80MHz
>>   3b'100 => 80MHz to 50 MHz
>>   3b'101 => 275Mhz to 250MHz
>>   3b'110 => 250MHz to 225MHz
>>   3b'111 => 225MHz to 200MHz
>>
>> On the Rockchip version of the PHY we have less granularity but the idea
>> is the same.
>>
>> [1]: https://arasan.com/wp-content/media/eMMC-5-1-Total-Solution_Rev-1-3.pdf
>>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> ---
>>  Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
>> index 555cb0f40690..fd118b071e5e 100644
>> --- a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
>> +++ b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
>> @@ -7,6 +7,11 @@ Required properties:
>>   - reg: PHY register address offset and length in "general
>>     register files"
>>
>> +Optional clocks (see ../clock/clock-bindings.txt), specified by name:
>> + - emmcclk: The card clock exported by the SDHCI driver.  Although this is
>
> This reads like emmcclk is the property. You need to list out clocks and
> clock-names.

Thanks for the feedback.  Done.

-Doug
