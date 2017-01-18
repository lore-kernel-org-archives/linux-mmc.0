From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] mmc: dt-bindings: update Mediatek MMC bindings
Date: Wed, 18 Jan 2017 15:34:02 -0600
Message-ID: <20170118213402.rbduvubbsdpvfgad@rob-hp-laptop>
References: <1484215490-7494-1-git-send-email-yong.mao@mediatek.com>
 <1484215490-7494-3-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1484215490-7494-3-git-send-email-yong.mao@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Yong Mao <yong.mao@mediatek.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com, Javier Martinez Canillas <javier@osg.samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, Chunfeng Yun <chunfeng.yun@mediatek.com>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Philipp Zabel <p.zabel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-mmc@vger.kernel.org, Eddie Huang <eddie.huang@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jan 12, 2017 at 06:04:50PM +0800, Yong Mao wrote:
> From: yong mao <yong.mao@mediatek.com>
> 
> Add description for hs200-cmd-int-delay
> Add description for hs400-cmd-int-delay
> Add description for cmd-resp-sel
> 
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> index 0120c7f..2dbb3b0 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> @@ -21,6 +21,9 @@ Optional properties:
>  - assigned-clocks: PLL of the source clock
>  - assigned-clock-parents: parent of source clock, used for HS400 mode to get 400Mhz source clock
>  - hs400-ds-delay: HS400 DS delay setting
> +- hs200-cmd-int-delay: HS200 command internal delay setting
> +- hs400-cmd-int-delay: HS400 command internal delay setting

What are the units and range of values? These need vendor prefix as 
well.

> +- cmd-resp-sel: command response sample selection

Looks like a boolean. State that and make the default the more common 
case.

>  
>  Examples:
>  mmc0: mmc@11230000 {
> @@ -38,4 +41,7 @@ mmc0: mmc@11230000 {
>  	assigned-clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>;
>  	assigned-clock-parents = <&topckgen CLK_TOP_MSDCPLL_D2>;
>  	hs400-ds-delay = <0x14015>;
> +	hs200-cmd-int-delay = <26>;
> +	hs400-cmd-int-delay = <14>;
> +	cmd-resp-sel = <0>; /* 0: rising, 1: falling */
>  };
> -- 
> 1.7.9.5
> 
