From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 3/7] mmc: mediatek: Add PM support for MMC driver
Date: Tue, 19 May 2015 13:55:29 +0200
Message-ID: <CAPDyKFo=f-8aycE9wPjdWEjdVLLz8Lk=Pt2=JeTL3CSM-2Gj4g@mail.gmail.com>
References: <1432017411-2996-1-git-send-email-chaotian.jing@mediatek.com>
	<1432017411-2996-4-git-send-email-chaotian.jing@mediatek.com>
	<20150519110453.GD26575@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150519110453.GD26575@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Chris Ball <chris@printf.net>, Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>, srv_heupstream <srv_heupstream@mediatek.com>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Hongzhou Yang <hongzhou.yang@mediatek.com>, Catalin Marinas <catalin.marinas@arm.com>, =?UTF-8?B?QmluIFpoYW5nICjnq6Dmlowp?= <bin.zhang@mediatek.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, linux-arm-ker
List-Id: linux-mmc@vger.kernel.org

On 19 May 2015 at 13:04, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Hi Chaotian,
>
> On Tue, May 19, 2015 at 02:36:47PM +0800, Chaotian Jing wrote:
>> Add PM support for Mediatek MMC driver
>> Save/restore registers when PM
>
> Has anyone asked you to add a new driver in two steps? I find it hard to
> review if a driver is introduced and changed right afterwards.
> Presumably you find it hard to maintain the patches like this also.
> Please ignore if this is indeed requested by someone.

I requested it.

Primarily because I want to make sure we deal with runtime/system PM
support properly. I guess I have seen too many cases where
functionality is broken, unless compiled with CONFIG_PM* set.

Kind regards
Uffe
