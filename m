From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 10/11] phy: rockchip-emmc: Minor code cleanup in rockchip_emmc_phy_power_off()
Date: Mon, 13 Jun 2016 16:05:27 -0700
Message-ID: <CAD=FV=U0XuOEBXsuf7cdp-mhe8=XJer9EoRJ99-2Mx_0=CFt-g@mail.gmail.com>
References: <1465339484-969-1-git-send-email-dianders@chromium.org>
 <1465339484-969-11-git-send-email-dianders@chromium.org> <f80ba471-95dd-5cda-00a2-9006cfe15167@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f80ba471-95dd-5cda-00a2-9006cfe15167@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, Brian Norris <briannorris@chromium.org>, Adrian Hunter <adrian.hunter@intel.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, Jun 13, 2016 at 1:56 AM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> On 2016/6/8 6:44, Douglas Anderson wrote:
>>
>> There's no reason to store the return value of rockchip_emmc_phy_power()
>> in a variable nor to check it.  Just return it.
>>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> ---
>>  drivers/phy/phy-rockchip-emmc.c | 8 +-------
>>  1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/drivers/phy/phy-rockchip-emmc.c
>> b/drivers/phy/phy-rockchip-emmc.c
>> index 0fce7359d468..188e4c387ba8 100644
>> --- a/drivers/phy/phy-rockchip-emmc.c
>> +++ b/drivers/phy/phy-rockchip-emmc.c
>> @@ -227,8 +227,6 @@ static int rockchip_emmc_phy_power_off(struct phy
>> *phy)
>>  static int rockchip_emmc_phy_power_on(struct phy *phy)
>>  {
>
>
> I saw the cleanup for power_off is done on [patch 9/11]
>
> shouldn't be in this patch? :)

Yeah, I tried to, but then I realized that I couldn't split that out
too easily because the previous patch touched the same code.

...but actually, reordering things solves all the problems so I've done that.


-Doug
