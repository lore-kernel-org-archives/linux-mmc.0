From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [RFC PATCH v3 5/5] ARM: dts: add supports-idmac property
Date: Wed, 5 Aug 2015 08:52:15 +0000
Message-ID: <1438764734.3504.9.camel@synopsys.com>
References: <1438762614-22154-1-git-send-email-shawn.lin@rock-chips.com>
         <1438762730-22368-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1438762730-22368-1-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
Content-ID: <389F2642BBCCE444BE27E61447882A61@internal.synopsys.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
Cc: "dianders@chromium.org" <dianders@chromium.org>, "wangzhou.bry@gmail.com" <wangzhou.bry@gmail.com>, "tomeu.vizoso@collabora.com" <tomeu.vizoso@collabora.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "javier.martinez@collabora.co.uk" <javier.martinez@collabora.co.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "haokexin@gmail.com" <haokexin@gmail.com>, "stefan@agner.ch" <stefan@agner.ch>, "addy.ke@rock-chips.com" <addy.ke@rock-chips.com>, "galak@codeaurora.org" <galak@codeaurora.org>, "olof@lixom.net" <olof@lixom.net>, "long.wanglong@huawei.com" <long.wanglong@huawei.com>, "peter.griffin@linaro.org" <peter.griffin@linaro.org>, "mark.rutland@arm.com" <mark.rutland@arm.co>
List-Id: linux-mmc@vger.kernel.org

Hi Shawn,

On Wed, 2015-08-05 at 16:18 +-0800, Shawn Lin wrote:
+AD4- DesignWare MMC Controller's transfer mode should be decided
+AD4- at runtime instead of compile-time. Add +ACI-supports-idmac+ACI- for
+AD4- all platforms that use internal dma mode to enable this feature
+AD4- at runtime.
+AD4- 
+AD4- Signed-off-by: Shawn Lin +ADw-shawn.lin+AEA-rock-chips.com+AD4-
+AD4- ---
+AD4- 
+AD4- Changes in v3: None
+AD4- Changes in v2: None
+AD4- 
+AD4-  arch/arm/boot/dts/exynos3250-monk.dts              +AHw- 1 +-
+AD4-  arch/arm/boot/dts/exynos3250-rinato.dts            +AHw- 1 +-
+AD4-  arch/arm/boot/dts/exynos4412-odroid-common.dtsi    +AHw- 1 +-
+AD4-  arch/arm/boot/dts/exynos4412-origen.dts            +AHw- 1 +-
+AD4-  arch/arm/boot/dts/exynos4412-trats2.dts            +AHw- 1 +-
+AD4-  arch/arm/boot/dts/exynos4x12.dtsi                  +AHw- 1 +-
+AD4-  arch/arm/boot/dts/exynos5250-arndale.dts           +AHw- 2 +-+-
+AD4-  arch/arm/boot/dts/exynos5250-smdk5250.dts          +AHw- 2 +-+-
+AD4-  arch/arm/boot/dts/exynos5250-snow.dts              +AHw- 3 +-+-+-
+AD4-  arch/arm/boot/dts/exynos5250-spring.dts            +AHw- 2 +-+-
+AD4-  arch/arm/boot/dts/exynos5260-xyref5260.dts         +AHw- 2 +-+-
+AD4-  arch/arm/boot/dts/exynos5410-smdk5410.dts          +AHw- 2 +-+-
+AD4-  arch/arm/boot/dts/exynos5420-arndale-octa.dts      +AHw- 2 +-+-
+AD4-  arch/arm/boot/dts/exynos5420-peach-pit.dts         +AHw- 3 +-+-+-
+AD4-  arch/arm/boot/dts/exynos5420-smdk5420.dts          +AHw- 2 +-+-
+AD4-  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi +AHw- 2 +-+-
+AD4-  arch/arm/boot/dts/exynos5800-peach-pi.dts          +AHw- 3 +-+-+-
+AD4-  arch/arm/boot/dts/hisi-x5hd2.dtsi                  +AHw- 2 +-+-
+AD4-  arch/arm/boot/dts/rk3288-evb.dtsi                  +AHw- 2 +-+-
+AD4-  arch/arm/boot/dts/rk3288-firefly.dtsi              +AHw- 3 +-+-+-
+AD4-  arch/arm/boot/dts/rk3288-popmetal.dts              +AHw- 2 +-+-
+AD4-  arch/arm64/boot/dts/exynos/exynos7-espresso.dts    +AHw- 2 +-+-
+AD4-  22 files changed, 42 insertions(+-)

I'm wondering if you're going to care about other platforms
that use DW MMC?

Just grep for +ACI-snps,dw-mshc+ACI-, +ACI-altr,socfpga-dw-mshc+ACI-,
+ACI-img,pistachio-dw-mshc+ACI- and you'll see more dt+ACo- files to
be updated.

-Alexey
