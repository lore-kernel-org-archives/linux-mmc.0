From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v3 4/7] arm64: dts: mediatek: Add MT8173 MMC dts
Date: Wed, 29 Apr 2015 08:37:26 +0200
Message-ID: <20150429063726.GQ6325@pengutronix.de>
References: <1430214525-19198-1-git-send-email-chaotian.jing@mediatek.com>
 <1430214525-19198-5-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430214525-19198-5-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>, srv_heupstream@mediatek.com, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, Hongzhou Yang <hongzhou.yang@mediatek.com>, Catalin Marinas <catalin.marinas@arm.com>, bin.zhang@mediatek.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Apr 28, 2015 at 05:48:42PM +0800, Chaotian Jing wrote:
> From: Eddie Huang <eddie.huang@mediatek.com>
> 
> Add node mmc0 and mmc1

While at it you could add mmc2 and mmc3 to the dtsi aswell. No need to patch that
again later.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
