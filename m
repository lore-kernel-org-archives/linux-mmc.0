From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: eMMC boot problem: switch to bus width 8 ddr failed
Date: Fri, 13 Jan 2017 12:23:04 +0100
Message-ID: <CAPDyKFpAYY6grArvLGMr7X577uLEXjnv479ML52CKfkMXxyqUw@mail.gmail.com>
References: <20170106004114.GA22893@archie.localdomain> <1754f0ae-fe6f-00a2-a0d6-9fd55c2b866f@rock-chips.com>
 <20170106155618.GA10105@archie.localdomain> <CAPDyKFoUeYrE7nC2Ds8XHBYXtQpLHkRXKp_hFyD0m6fuuFM==w@mail.gmail.com>
 <103b3045-c17d-ef14-c843-471fcb6e537f@rock-chips.com> <AM4PR0401MB232420E07E9DA5FE18E8B38790780@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM4PR0401MB232420E07E9DA5FE18E8B38790780@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bough Chen <haibo.chen@nxp.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Clemens Gruber <clemens.gruber@pqgruber.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, "A.S. Dong" <aisheng.dong@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Gary Bisson <gary.bisson@boundarydevices.com>, Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>
List-Id: linux-mmc@vger.kernel.org

[...]

> Hi Ulf and Shawn,
>
> Aisheng and I debug this issue these days, and we find the root cause. There are two things
> to describe.
>
> 1) voltage switch issue.  The properity "no-1-8-v" do not work for  MMC_TIMING_MMC_DDR52.
> This is another bug, we need to fix, but has no relation with the current bug.

I am working on a patch which invents MMC_CAP_3_3V_DDR and which has a
corresponding DT binding "mmc-ddr-3_3v".
Give me a day or so, then I will post it.

Likely it should help to resolve your issue, don't you think?

[...]

Kind regards
Uffe
