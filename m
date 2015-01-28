From: Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: Re: [PATCH 1/7] pinctrl: mediatek: emulate GPIO interrupt on
 both-edges
Date: Wed, 28 Jan 2015 17:24:18 +0800
Message-ID: <1422437058.32212.38.camel@mtksdaap41>
References: <1422339332-27498-1-git-send-email-chaotian.jing@mediatek.com>
 <1422339332-27498-2-git-send-email-chaotian.jing@mediatek.com>
 <CACRpkdbncsDJ3pP0dETpho5+j+OVuaYr=YTsH8pAs7vuT_9OLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdbncsDJ3pP0dETpho5+j+OVuaYr=YTsH8pAs7vuT_9OLw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>, Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, srv_heupstream@mediatek.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Hongzhou Yang <hongzhou.yang@mediatek.com>, Catalin Marinas <catalin.marinas@arm.com>, bin.zhang@mediatek.com, Will Deacon <will.deacon@arm.com>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Eddie Huang <eddie.huang@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, 2015-01-27 at 15:21 +0100, Linus Walleij wrote:
> On Tue, Jan 27, 2015 at 7:15 AM, Chaotian Jing
> <chaotian.jing@mediatek.com> wrote:
> 
> > From: Yingjoe Chen <yingjoe.chen@mediatek.com>
> >
> > MTK EINT does not support generating interrupt on both edges.
> > Emulate this by changing edge polarity while enable irq,
> > set types and interrupt handling. This follows an example of
> > drivers/gpio/gpio-mxc.c.
> >
> > Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> 
> Hongzhu, if you're fine with this patch can you ACK it as maintainer
> of the pinctrl driver so I can merge it immediately on top of your
> drivern whenever we consider it finished (and if it applies still...)

Hi Linus,

Thanks for reviewing.
Please note this patch depends on mt8173 pinctrl driver patch[1], and
modify files introduced in that patch. So this patch should be merged
after that series.

Joe.C

[1]
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/320066.html
