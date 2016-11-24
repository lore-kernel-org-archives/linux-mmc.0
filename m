From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/10] mmc: sdhci-xenon: Add support to PHYs of Marvell
 Xenon SDHC
Date: Thu, 24 Nov 2016 12:09:41 +0100
Message-ID: <23084629.DpfWxNEgoY@wuerfel>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
 <2204525.IWIYQVjIXl@wuerfel>
 <f7334e41-39dd-f868-ff10-199afaebe926@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <f7334e41-39dd-f868-ff10-199afaebe926@marvell.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Hilbert Zhang <zzhang@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Romain Perier <romain.perier@free-electrons.com>, Liuliu Zhao <zhaoliul@marvell.com>, Peng Zhu <zhupeng@marvell.com>, Adrian Hunter <adrian.hunter@intel.com>, Nadav Haklai <nadavh@marvell.com>, "Jack(SH) Zhu" <jmzhu@marvell.com>, Victor Gu <xigu@marvell.com>, Doug Jones <dougj@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Xueping Liu <xpliu@marvell.com>, Shiwu Zhang <zhangshw@marvell.com>, Yu Cao <yucao@marvell.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Keji Zhang <keji@marvell.com>, Kostya Porotchkin <kostap@marvell.com>, Rob Herring <robh+dt@kernel.org>, Ryan Gao <ygao@marvell.com>
List-Id: linux-mmc@vger.kernel.org

On Thursday, November 24, 2016 6:57:18 PM CET Ziji Hu wrote:
> > 
> > Please explain in the changelog why this is not a generic
> > phy driver (or three of them).
> > 
>         Actually we tried to put the PHY code into Linux PHY framework.
>         But it cannot fit in Linux common PHY framework.
> 
>         Our Xenon SDHC PHY register is a part of Xenon SDHC register set.
>         Besides, during MMC initialization, MMC sequence has to call several PHY functions to complete timing setting.
>         In those PHY setting functions, they have to access SDHC register and know current MMC setting, such as bus width, clock frequency and speed mode.
>         As a result, we have to implement PHY under MMC directory.
> 

Ok, that makes sense, just put the same text in the changelog comment.

	Arnd
