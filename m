From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [RFC PATCH v3 5/5] ARM: dts: add supports-idmac property
Date: Wed, 5 Aug 2015 17:25:47 +0800
Message-ID: <55C1D69B.4060308@rock-chips.com>
References: <1438762614-22154-1-git-send-email-shawn.lin@rock-chips.com>
 <1438762730-22368-1-git-send-email-shawn.lin@rock-chips.com>
 <1438764734.3504.9.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
        format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1438764734.3504.9.camel@synopsys.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: shawn.lin@rock-chips.com, "dianders@chromium.org" <dianders@chromium.org>, "wangzhou.bry@gmail.com" <wangzhou.bry@gmail.com>, "tomeu.vizoso@collabora.com" <tomeu.vizoso@collabora.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "javier.martinez@collabora.co.uk" <javier.martinez@collabora.co.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "haokexin@gmail.com" <haokexin@gmail.com>, "stefan@agner.ch" <stefan@agner.ch>, "addy.ke@rock-chips.com" <addy.ke@rock-chips.com>, "galak@codeaurora.org" <galak@codeaurora.org>, "olof@lixom.net" <olof@lixom.net>, "long.wanglong@huawei.com" <long.wanglong@huawei.com>, "peter.griffin@linaro.org" <peter.griffin@linaro.org>, mark.rut
List-Id: linux-mmc@vger.kernel.org

=E5=9C=A8 2015/8/5 16:52, Alexey Brodkin =E5=86=99=E9=81=93:
> Hi Shawn,
>
> On Wed, 2015-08-05 at 16:18 +0800, Shawn Lin wrote:
>> DesignWare MMC Controller's transfer mode should be decided
>> at runtime instead of compile-time. Add "supports-idmac" for
>> all platforms that use internal dma mode to enable this feature
>> at runtime.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>> Changes in v3: None
>> Changes in v2: None
>>
>>   arch/arm/boot/dts/exynos3250-monk.dts              | 1 +
>>   arch/arm/boot/dts/exynos3250-rinato.dts            | 1 +
>>   arch/arm/boot/dts/exynos4412-odroid-common.dtsi    | 1 +
>>   arch/arm/boot/dts/exynos4412-origen.dts            | 1 +
>>   arch/arm/boot/dts/exynos4412-trats2.dts            | 1 +
>>   arch/arm/boot/dts/exynos4x12.dtsi                  | 1 +
>>   arch/arm/boot/dts/exynos5250-arndale.dts           | 2 ++
>>   arch/arm/boot/dts/exynos5250-smdk5250.dts          | 2 ++
>>   arch/arm/boot/dts/exynos5250-snow.dts              | 3 +++
>>   arch/arm/boot/dts/exynos5250-spring.dts            | 2 ++
>>   arch/arm/boot/dts/exynos5260-xyref5260.dts         | 2 ++
>>   arch/arm/boot/dts/exynos5410-smdk5410.dts          | 2 ++
>>   arch/arm/boot/dts/exynos5420-arndale-octa.dts      | 2 ++
>>   arch/arm/boot/dts/exynos5420-peach-pit.dts         | 3 +++
>>   arch/arm/boot/dts/exynos5420-smdk5420.dts          | 2 ++
>>   arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 2 ++
>>   arch/arm/boot/dts/exynos5800-peach-pi.dts          | 3 +++
>>   arch/arm/boot/dts/hisi-x5hd2.dtsi                  | 2 ++
>>   arch/arm/boot/dts/rk3288-evb.dtsi                  | 2 ++
>>   arch/arm/boot/dts/rk3288-firefly.dtsi              | 3 +++
>>   arch/arm/boot/dts/rk3288-popmetal.dts              | 2 ++
>>   arch/arm64/boot/dts/exynos/exynos7-espresso.dts    | 2 ++
>>   22 files changed, 42 insertions(+)
> I'm wondering if you're going to care about other platforms
> that use DW MMC?
>
> Just grep for "snps,dw-mshc", "altr,socfpga-dw-mshc",
> "img,pistachio-dw-mshc" and you'll see more dt* files to
> be updated.
   Thanks,  Alexey.
   Yes,  I missed some ARC dt*  files just as Vineet told me. It will b=
e=20
fixed in v4.
   Btw, I cannot find "img,pistachio-dw-mshc" in 4.2.0-rc3. And no more=
=20
"dw-mshc" or "dwmmc"
   is found.

> -Alexey
>
>


--=20
Shawn Lin
