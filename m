From: Ziji Hu <huziji@marvell.com>
Subject: Re: [PATCH 2/10] mmc: sdhci: Export
 sdhci_start_signal_voltage_switch() in sdhci.c
Date: Sat, 8 Oct 2016 14:26:37 +0800
Message-ID: <0de88699-7cbb-a057-fd8a-83de37445623@marvell.com>
References: <cover.990e3503c30c18ecf50dd48bce3d52811f03ca22.1475853198.git-series.gregory.clement@free-electrons.com>
 <9a660a813af58ad7c108fd06289513302426c9fb.1475853198.git-series.gregory.clement@free-electrons.com>
 <9bfe6e9a-c06e-481a-b5ea-af58820093bf@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9bfe6e9a-c06e-481a-b5ea-af58820093bf@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, "Jack(SH) Zhu" <jmzhu@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Shiwu Zhang <zhangshw@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, Xueping Liu <xpliu@marvell.com>, Hilbert Zhang <zzhang@marvell.com>, Liuliu Zhao <zhaoliul@marvell.com>, Peng Zhu <zhupeng@marvell.com>, Yu Cao <yuca>
List-Id: linux-mmc@vger.kernel.org

Hi Shawn,

On 2016/10/8 10:40, Shawn Lin wrote:
> Hi,
> 
> ÔÚ 2016/10/7 23:22, Gregory CLEMENT Ð´µÀ:
>> From: Ziji Hu <huziji@marvell.com>
>>
>> Export sdhci_start_signal_voltage_switch() from sdhci.c.
>> Thus vendor sdhci driver can implement its own signal voltage
>> switch routine.
>>
> 
> You can overwtite this callback within your driver itself.
> That is what other sdhci variant drivers did, so patch 1-3 are
> unnecessary.

    Thanks a lot for your reply.

    Our SDHC driver just requests some pre- and post- operations besides common standard SDHC functions.
    Overwriting those common functions costs too much.

    Thank you.

Best regards,
Hu Ziji

> 
>> Signed-off-by: Hu Ziji <huziji@marvell.com>
>> Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  drivers/mmc/host/sdhci.c | 5 +++--
>>  drivers/mmc/host/sdhci.h | 2 ++
>>  2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index d4bb818c52d5..2250ea22231f 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1828,8 +1828,8 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
>>      spin_unlock_irqrestore(&host->lock, flags);
>>  }
>>
>> -static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>> -                         struct mmc_ios *ios)
>> +int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>> +                      struct mmc_ios *ios)
>>  {
>>      struct sdhci_host *host = mmc_priv(mmc);
>>      u16 ctrl;
>> @@ -1921,6 +1921,7 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>>          return 0;
>>      }
>>  }
>> +EXPORT_SYMBOL_GPL(sdhci_start_signal_voltage_switch);
>>
>>  static int sdhci_card_busy(struct mmc_host *mmc)
>>  {
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 21dc80b8ae3d..c38ab65b9a97 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -687,6 +687,8 @@ void sdhci_set_bus_width(struct sdhci_host *host, int width);
>>  void sdhci_reset(struct sdhci_host *host, u8 mask);
>>  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
>>  void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
>> +int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>> +                      struct mmc_ios *ios);
>>
>>  #ifdef CONFIG_PM
>>  extern int sdhci_suspend_host(struct sdhci_host *host);
>>
> 
> 
