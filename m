From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 03/11] Documentation: mmc: sdhci-of-arasan: Add
 soc-ctl-syscon for corecfg regs
Date: Mon, 13 Jun 2016 16:07:02 -0700
Message-ID: <CAD=FV=U48jiDHAxw6045UEptGoruUTdGVD_h7QtH2xqXPhY+5g@mail.gmail.com>
References: <1465339484-969-1-git-send-email-dianders@chromium.org>
 <1465339484-969-4-git-send-email-dianders@chromium.org> <45a7e8c7-5bd4-8c40-004a-b8906eff881a@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <45a7e8c7-5bd4-8c40-004a-b8906eff881a@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, Brian Norris <briannorris@chromium.org>, Adrian Hunter <adrian.hunter@intel.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, Jun 13, 2016 at 1:18 AM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> On 2016/6/8 6:44, Douglas Anderson wrote:
>>
>> As can be seen in Arasan's datasheet [1] there are several "corecfg"
>> settings in their SDHCI IP Block that are supposed to be controlled by
>> software.  Although the datasheet referenced is a bit vague about how to
>> access corecfg, in Figure 5 you can see that for Arasan's PHY (a
>> separate component than their SDHCI component) they describe the
>> "phyctrl" registers as being "FROM SOC CTL REG", implying that it's up
>> to the licensee of the Arasan IP block to implement these registers.  It
>> seems sane to assume that the "corecfg" registers in their SDHCI IP
>> block works in a similar way for all licensees of the IP Block.
>>
>> Device tree has a model that allows a device to get a reference to
>> random registers located elsewhere in the SoC: sysctl.  Let's leverage
>> this model and allow adding a sysctl reference to access the control
>> registers for the Arasan SDHCI PHYs.
>>
>> Having a reference to the control registers doesn't do much for us on
>> its own since the Arasan spec doesn't specify how these corecfg values
>> are laid out in memory.  In the SDHCI driver we'll need a map detailing
>> where each corecfg can be found in each implementation.  This map can be
>> found using the primary compatible string of the SDHCI device.  In that
>> spirit, document that existing rk3399 device trees already have a
>> specific compatible string, though up to now they've always been relying
>> on the driver supporting the generic.
>>
>> Note that since existing devices seem to work fairly well as-is, we'll
>> list the syscon reference as "optional", but it's likely that we'll run
>> into much fewer problems if we can actually set the proper values in the
>> syscon, so it is strongly suggested that any SoCs where we have a map to
>> set the corecfg also include a reference to the syscon.
>
>
> yes, the interaction of phy and controller should be more explicitly
> now. Why not make it mandatory for arasan,sdhci-5.1.
>
>>
>> [1]:
>> https://arasan.com/wp-content/media/eMMC-5-1-Total-Solution_Rev-1-3.pdf
>>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> ---
>>  .../devicetree/bindings/mmc/arasan,sdhci.txt       | 27
>> ++++++++++++++++++++--
>>  1 file changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> index 31b35c3a5e47..b67e623ca1ff 100644
>> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> @@ -9,8 +9,12 @@ Device Tree Bindings for the Arasan SDHCI Controller
>>    [4] Documentation/devicetree/bindings/phy/phy-bindings.txt
>>
>>  Required Properties:
>> -  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' or
>> -                'arasan,sdhci-4.9a' or 'arasan,sdhci-5.1'
>> +  - compatible: Compatibility string.  One of:
>> +    - "arasan,sdhci-8.9a"
>> +    - "arasan,sdhci-4.9a"
>> +    - "arasan,sdhci-5.1"
>> +    - "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1": The PHY in rk3399.
>
>
> The PHY in rk3399?

I presume that you found the above confusing?  I changed it to:

  - compatible: Compatibility string.  One of:
    - "arasan,sdhci-8.9a": generic Arasan SDHCI 8.9a PHY
    - "arasan,sdhci-4.9a": generic Arasan SDHCI 4.9a PHY
    - "arasan,sdhci-5.1": generic Arasan SDHCI 5.1 PHY
    - "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1": rk3399 eMMC PHY
      For this device it is strongly suggested to include arasan,soc-ctl-syscon.

I kept Rob's Ack since those changes didn't seem too major.  I will
remove it if requested.

-Doug
