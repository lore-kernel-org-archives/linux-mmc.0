From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 1/3] mmc: dt-bindings: update Mediatek MMC bindings
Date: Tue, 24 Jan 2017 09:02:32 +0100
Message-ID: <CAPDyKFqo7fMTp3YPJwgoa4u3iAie2U884VUfTnMQ_js8neMqTQ@mail.gmail.com>
References: <1484988923-1543-1-git-send-email-yong.mao@mediatek.com>
 <1484988923-1543-2-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1484988923-1543-2-git-send-email-yong.mao@mediatek.com>
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
Cc: Rob Herring <robh@kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mediatek@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chunfeng Yun <chunfeng.yun@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

+Rob, devicetree

On 21 January 2017 at 09:55, Yong Mao <yong.mao@mediatek.com> wrote:
> From: yong mao <yong.mao@mediatek.com>
>
> Add description for mediatek,hs200-cmd-int-delay
> Add description for mediatek,hs400-cmd-int-delay
> Add description for mediatek,hs400-cmd-resp-sel-rising
>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>

You need an ack from a DT maintainer for this. I have added Rob and
the devicetree list on cc.

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> index 0120c7f..4182ea3 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> @@ -21,6 +21,15 @@ Optional properties:
>  - assigned-clocks: PLL of the source clock
>  - assigned-clock-parents: parent of source clock, used for HS400 mode to get 400Mhz source clock
>  - hs400-ds-delay: HS400 DS delay setting
> +- mediatek,hs200-cmd-int-delay: HS200 command internal delay setting.
> +                               This field has total 32 stages.
> +                               The value is an integer from 0 to 31.
> +- mediatek,hs400-cmd-int-delay: HS400 command internal delay setting
> +                               This field has total 32 stages.
> +                               The value is an integer from 0 to 31.
> +- mediatek,hs400-cmd-resp-sel-rising:  HS400 command response sample selection
> +                                      If present,HS400 command responses are sampled on rising edges.
> +                                      If not present,HS400 command responses are sampled on falling edges.
>
>  Examples:
>  mmc0: mmc@11230000 {
> @@ -38,4 +47,7 @@ mmc0: mmc@11230000 {
>         assigned-clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>;
>         assigned-clock-parents = <&topckgen CLK_TOP_MSDCPLL_D2>;
>         hs400-ds-delay = <0x14015>;
> +       mediatek,hs200-cmd-int-delay = <26>;
> +       mediatek,hs400-cmd-int-delay = <14>;
> +       mediatek,hs400-cmd-resp-sel-rising;
>  };
> --
> 1.7.9.5
>
