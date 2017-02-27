From: Ziji Hu <huziji@marvell.com>
Subject: Re: [PATCH v6 00/14] mmc: Add support to Marvell Xenon SD Host
 Controller
Date: Mon, 27 Feb 2017 17:41:56 +0800
Message-ID: <d1f1d71f-d0d4-d83e-04f6-5688dcbe01b9@marvell.com>
References: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
 <87y3x0ajdv.fsf@free-electrons.com>
 <CAPDyKFqXQmuxWFZwcnTgQcKU_t5MKCtBj6s+tv5gzVWS11x0qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqXQmuxWFZwcnTgQcKU_t5MKCtBj6s+tv5gzVWS11x0qA@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk <linux-clk@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

On 2017/2/21 3:32, Ulf Hansson wrote:
> On 20 February 2017 at 17:59, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
>> Hi Ulf,
>>
>>  On mar., févr. 14 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
>>
>>> Hello,
>>>
>>> This the sixth version of the series adding support for the SDHCI
>>> Xenon controller. It can be currently found on the Armada 37xx and the
>>> Armada 7K/8K but will be also used in more Marvell SoC (and not only
>>> the mvebu ones actually).
>>>
>>> Most of the following changes had been discussed on the mailing list,
>>> except the new compatible string.
>>>
>>
>> I think that with this version we addressed all the concerns expressed
>> about the previous version. Do you think that you will be able to apply
>> this series for 4.11 or do you still see any issues?
>>
>> Thanks,
>>
>> Gregory
> 
> We are in the merge window for v4.11, so new material is out of the
> question. I am preparing the PR to Linus as this very moment.
> 
> Anyway, I will look into the series as soon as I can.

	Could you please take a look at our patch set?
	Very sorry for pushing you, but your comment is very important to us.

	Thank you.

Best regards,
Hu Ziji

> 
> Kind regards
> Uffe
> 
