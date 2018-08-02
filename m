From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v3 4/4] arm64: dts: rockchip: add PX30 eavluation board
 devicetree
Date: Thu, 02 Aug 2018 14:42:28 +0200
Message-ID: <2650340.eNOEUyGAWg@phil>
References: <1533113116-8820-1-git-send-email-cl@rock-chips.com>
 <1533113116-8820-5-git-send-email-cl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1533113116-8820-5-git-send-email-cl@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: cl@rock-chips.com
Cc: mark.rutland@arm.com, ulf.hansson@linaro.org, huibin.hong@rock-chips.com, catalin.marinas@arm.com, shawn.lin@rock-chips.com, will.deacon@arm.com, alsa-devel@alsa-project.org, hjc@rock-chips.com, yamada.masahiro@socionext.com, tony.xie@rock-chips.com, klaus.goger@theobroma-systems.com, sugar.zhang@rock-chips.com, linux-rockchip@lists.infradead.org, jacob-chen@iotwrt.com, jagan@amarulasolutions.com, huangtao@rock-chips.com, devicetree@vger.kernel.org, arnd@arndb.de, frank.wang@rock-chips.com, zhangqing@rock-chips.com, kever.yang@rock-chips.com, broonie@kernel.org, djw@t-chip.com.cn, sandy.huang@rock-chips.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, david.wu@rock-chips.com, william.wu@rock-chips.com
List-Id: linux-mmc@vger.kernel.org

Hi,

Am Mittwoch, 1. August 2018, 10:45:16 CEST schrieb cl@rock-chips.com:
> From: Liang Chen <cl@rock-chips.com>
> 
> This patch add px30-evb.dts for PX30 evaluation board.
> Tested on PX30 evb.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Liang Chen <cl@rock-chips.com>

applied with the following changes:
- some reordering
- changed chosen from using bootargs to stdout-path
- split out rk809 node into separate patch to be applied once the
  rk809 changes land
- split out dwc2 into separate patch to be applied once the binding lands
- dropped commented cd-gpios from &sdmmc node


Heiko
