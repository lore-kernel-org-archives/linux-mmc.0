From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v6 03/12] arm64: dts: mt8173: remove "mediatek,mt8135-mmc"
 from mmc nodes
Date: Thu, 2 Nov 2017 15:13:47 +0100
Message-ID: <CAPDyKFp5Ez_NXWtSeTt+nsgJtesS3t_tbUpgFco8ZVAPj+PgoA@mail.gmail.com>
References: <1508118399-21828-1-git-send-email-chaotian.jing@mediatek.com>
 <1508118399-21828-4-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFrRVT8YFXvy3Wuf_jga5oourScOdas34U=YkeLRzHoWMg@mail.gmail.com> <b24d12e4-251f-6f79-1ed9-5b52f8f39625@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b24d12e4-251f-6f79-1ed9-5b52f8f39625@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, yong mao <yong.mao@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, Heiner Kallweit <hkallweit1@gmail.com>, Phong LE <ple@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

On 2 November 2017 at 12:50, Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
> On 10/25/2017 11:11 PM, Ulf Hansson wrote:
>> On 16 October 2017 at 03:46, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>>> devicetree bindings has been updated to support multi-platforms,
>>> so that each platform has its owns compatible name.
>>> And, this compatible name may used in driver to distinguish with
>>> other platform.
>>>
>>> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
>>
>> Matthias, do you intend to pick this? Else I can do it with your ack...
>>
>
> If it's not too late, feel free to take it. Otherwise I will queue it for the
> next merge window:
>
> Acked-by: Matthias Brugger <matthias.bgg@gmail.com>

Thanks, I have queued it up for 4.15 and will add your ack.

Kind regards
Uffe
