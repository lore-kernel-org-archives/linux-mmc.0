From: Ziji Hu <huziji@marvell.com>
Subject: Re: [PATCH v6 08/14] mmc: sdhci-xenon: Add Marvell Xenon SDHC core
 functionality
Date: Wed, 15 Mar 2017 21:58:43 +0800
Message-ID: <10855817-e693-e007-9499-c4e97936fadb@marvell.com>
References: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
 <cb885ae19e7c467908cdaa1f1cc8d95a7217d663.1487091464.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFpH+RGAZGoVCuCOKJ2iEa+Y=cNNcM-uKhkYaTpmogXCKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFpH+RGAZGoVCuCOKJ2iEa+Y=cNNcM-uKhkYaTpmogXCKA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Jimmy Xu <zmxu@marvell.com>, Andrew Lunn <andrew@lunn.ch>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mike Turquette <mturquette@baylibre.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Doug Jones <dougj@marvell.com>, linux-clk <linux-clk@vger.kernel.org>, Jisheng Zhang <jszhang@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Kostya Porotchkin <kostap@marvell.com>, Hanna Hawa <hannah@marvell.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Rob Herring <robh+dt@kernel.org>, Ryan Gao <ygao@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

On 2017/3/15 21:11, Ulf Hansson wrote:
> On 14 February 2017 at 18:01, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
>> From: Hu Ziji <huziji@marvell.com>
<snip>
>> +config MMC_SDHCI_XENON
>> +       tristate "Marvell Xenon eMMC/SD/SDIO SDHCI driver"
>> +       depends on MMC_SDHCI_PLTFM
>> +       help
>> +         This selects Marvell Xenon eMMC/SD/SDIO SDHCI.
>> +         If you have a machine with integrated Marvell Xenon SDHC IP,
> 
> /s/SDHC/SDHCI
> 

	Sorry. I don't get your point.
	Could you please give more detailed comments?

>> +         say Y or M here.
>> +         If unsure, say N.
>> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
>> index ccc9c4cba154..b0a2ab4b256e 100644
>> --- a/drivers/mmc/host/Makefile
>> +++ b/drivers/mmc/host/Makefile
>> @@ -82,3 +82,6 @@ obj-$(CONFIG_MMC_SDHCI_BRCMSTB)               += sdhci-brcmstb.o
>>  ifeq ($(CONFIG_CB710_DEBUG),y)
>>         CFLAGS-cb710-mmc        += -DDEBUG
>>  endif
>> +
>> +obj-$(CONFIG_MMC_SDHCI_XENON)  += sdhci-xenon-driver.o
>> +sdhci-xenon-driver-y           += sdhci-xenon.o
> 
> Why not only this:
> obj-$(CONFIG_MMC_SDHCI_XENON) += sdhci-xenon.o
> 

	Yes. Will try.

>> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
>> new file mode 100644
<snip>
> 
> ff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
>> new file mode 100644
>> index 000000000000..69de711db9eb
>> --- /dev/null
>> +++ b/drivers/mmc/host/sdhci-xenon.h
> 
> You should probably put all this in the c-file instead. That is how
> most other sdhci variants does it.
> 

	Unfortunately, we have some registers like XENON_SLOT_EMMC_CTRL
	which are accessed by both sdhci-xenon.c and sdhci-xenon-phy.c

> [...]
> 
> Overall this looks good to me, however I think Adrian needs to have a
> quick look as well.
> 
> One additional very minor nitpick. Perhaps you can align on the
> function names prefix, as those currently varies between "whatever",
> "xenon_" and "sdhci_xenon_".
> 
	Sure. Will fix them as you request.

	Thank you.

Best regards,
Hu Ziji

> Kind regards
> Uffe
> 
