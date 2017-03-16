From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH v6 08/14] mmc: sdhci-xenon: Add Marvell Xenon SDHC core
 functionality
Date: Thu, 16 Mar 2017 10:24:17 +0800
Message-ID: <20170316102417.0909bccc@xhacker>
References: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
 <cb885ae19e7c467908cdaa1f1cc8d95a7217d663.1487091464.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFpH+RGAZGoVCuCOKJ2iEa+Y=cNNcM-uKhkYaTpmogXCKA@mail.gmail.com>
 <10855817-e693-e007-9499-c4e97936fadb@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <10855817-e693-e007-9499-c4e97936fadb@marvell.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ziji Hu <huziji@marvell.com>
Cc: Jimmy Xu <zmxu@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mike Turquette <mturquette@baylibre.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Doug Jones <dougj@marvell.com>, linux-clk <linux-clk@vger.kernel.org>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Kostya Porotchkin <kostap@marvell.com>, Hanna Hawa <hannah@marvell.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Rob Herring <robh+dt@kernel.org>, Ryan Gao <ygao@marvell.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, linux-arm-kernel@lists.infradead
List-Id: linux-mmc@vger.kernel.org

Hi Ziji

On Wed, 15 Mar 2017 21:58:43 +0800 Ziji Hu wrote:

> Hi Ulf,
> 
> On 2017/3/15 21:11, Ulf Hansson wrote:
> > On 14 February 2017 at 18:01, Gregory CLEMENT
> > <gregory.clement@free-electrons.com> wrote:  
> >> From: Hu Ziji <huziji@marvell.com>  
> <snip>
> >> +config MMC_SDHCI_XENON
> >> +       tristate "Marvell Xenon eMMC/SD/SDIO SDHCI driver"
> >> +       depends on MMC_SDHCI_PLTFM
> >> +       help
> >> +         This selects Marvell Xenon eMMC/SD/SDIO SDHCI.
> >> +         If you have a machine with integrated Marvell Xenon SDHC IP,  
> > 
> > /s/SDHC/SDHCI
> >   
> 
> 	Sorry. I don't get your point.
> 	Could you please give more detailed comments?

Ulf want you to s/SDHC/SDHCI in the line "If you have .....", I.E
change the line to:
If you have a machine with integrated Marvell Xenon SDHCI IP,

Thanks,
Jisheng
