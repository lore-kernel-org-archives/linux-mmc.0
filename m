From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/7] pinctrl: mediatek: emulate GPIO interrupt on both-edges
Date: Tue, 10 Feb 2015 16:24:56 +0800
Message-ID: <CACRpkdbhuouBuXv0X4M5VHikvWV_rLFd+LjU=PndgTVm4+retg@mail.gmail.com>
References: <1422339332-27498-1-git-send-email-chaotian.jing@mediatek.com>
	<1422339332-27498-2-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1422339332-27498-2-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Eddie Huang <eddie.huang@mediatek.com>, Hongzhou Yang <hongzhou.yang@mediatek.com>, James Liao <jamesjj.liao@mediatek.com>, "Joe.C" <yingjoe.chen@mediatek.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, bin.zhang@mediatek.com
List-Id: linux-mmc@vger.kernel.org

On Tue, Jan 27, 2015 at 2:15 PM, Chaotian Jing
<chaotian.jing@mediatek.com> wrote:

> From: Yingjoe Chen <yingjoe.chen@mediatek.com>
>
> MTK EINT does not support generating interrupt on both edges.
> Emulate this by changing edge polarity while enable irq,
> set types and interrupt handling. This follows an example of
> drivers/gpio/gpio-mxc.c.
>
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>

Patch applied on top of the rest of the mtk pinctrl support.
Adding Hongzhou's ACK on top.

Yours,
Linus Walleij
