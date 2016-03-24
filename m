From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: Warnings for invalid VDD (sdhci-s3c)
Date: Thu, 24 Mar 2016 15:11:25 +0200
Message-ID: <56F3E77D.7030201@intel.com>
References: <CAJKOXPcGDnPm-Ykh6wHqV1YxfTaov5E8iVqBoBn4OJc7BnhgEQ@mail.gmail.com>
 <20160324155840.50474b98@xhacker> <56F3A0B7.4050509@samsung.com>
 <20160324162449.29c9cf78@xhacker> <56F3A88F.50603@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <56F3A88F.50603@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Jisheng Zhang <jszhang@marvell.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, ludovic.desroches@atmel.com, "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 24/03/16 10:42, Krzysztof Kozlowski wrote:
> On 24.03.2016 17:24, Jisheng Zhang wrote:
>> Hi,
>>
>> On Thu, 24 Mar 2016 17:09:27 +0900 Jaehoon Chung wrote:
>>
>>> Hi,
>>>
>>> On 03/24/2016 04:58 PM, Jisheng Zhang wrote:
>>>> Hi,
>>>>
>>>> On Thu, 24 Mar 2016 16:28:56 +0900 Krzysztof Kozlowski wrote:
>>>>   
>>>>> Hi,
>>>>>
>>>>> After 918f4cbd4340 ("mmc: sdhci: restore behavior when setting VDD via
>>>>> external regulator") On Trats2 board I see warnings for invalid VDD
>>>>> value (2.8V):
>>>>>
>>>>> [    3.119656] ------------[ cut here ]------------
>>>>> [    3.119666] WARNING: CPU: 3 PID: 90 at
>>>>> ../drivers/mmc/host/sdhci.c:1234 sdhci_do_set_ios+0x4cc/0x5e0
>>>>> [    3.119669] mmc0: Invalid vdd 0x10  
>>>>
>>>> Per my understanding, the wrong vdd indicates a wrong ocr, what's the voltage of
>>>> this host's vmmc regulator?  
>>>
>>> As i know, it's fixed-voltage with gpio on trats2. It's 2.8V.
>>> I didn't check this entirely..need to check ocr value.
>>>
>>
>> I may know the reason. the vmmc is 2.8v, then mmc_regulator_get_supply() convert
>> the value to a ocr as 0x10. The key here is that the 2.8v is invalid in SDHCI
>> case and isn't accepted by current sdhci driver.
> 
> Yeah, I already wrote that. It is the part of the warning and my email.
> Our regulator is fixed at 2.8 which is 0x10. :)
> 
>> I dunno the elegant solution to handle this case, let's wait for sdhci maintainers
>> idea.
> 
> Hmm...

I haven't tested it, but what about this:

From: Adrian Hunter <adrian.hunter@intel.com>
Date: Thu, 24 Mar 2016 14:29:24 +0200
Subject: [PATCH] mmc: sdhci: Fix regression setting power on Trats2 board

Several commits relating to setting power have been introducing
problems by putting driver-specific rules into generic SDHCI code.

Fix by adding a 'set_power' callback and restoring the default
behaviour prior to commit 918f4cbd4340.  The desired behaviour
of commit 918f4cbd4340 is gotten by having sdhci-pxav3 provide
its own set_power callback.

Reported-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Fixes: 918f4cbd4340 ("mmc: sdhci: restore behavior when setting VDD...)
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # v4.5+
---
 drivers/mmc/host/sdhci-pxav3.c | 17 +++++++++++++++++
 drivers/mmc/host/sdhci.c       | 36 +++++++++++++++++++++++++++++-------
 drivers/mmc/host/sdhci.h       |  4 ++++
 3 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index f5edf9d3a18a..673d1e8446a5 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -307,8 +307,25 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 		__func__, uhs, ctrl_2);
 }
 
+static void pxav3_set_power(struct sdhci_host *host, unsigned char mode,
+			    unsigned short vdd)
+{
+	struct mmc_host *mmc = host->mmc;
+	u8 pwr = host->pwr;
+
+	sdhci_set_power(host, mode, vdd);
+
+	if (host->pwr == pwr)
+		return;
+
+	spin_unlock_irq(&host->lock);
+	mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
+	spin_lock_irq(&host->lock);
+}
+
 static const struct sdhci_ops pxav3_sdhci_ops = {
 	.set_clock = sdhci_set_clock,
+	.set_power = pxav3_set_power,
 	.platform_send_init_74_clocks = pxav3_gen_init_74_clocks,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.set_bus_width = sdhci_set_bus_width,
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index add9fdfd1d8f..3c5dc2f73d5e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1269,10 +1269,24 @@ clock_set:
 }
 EXPORT_SYMBOL_GPL(sdhci_set_clock);
 
-static void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
+static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
 			    unsigned short vdd)
 {
 	struct mmc_host *mmc = host->mmc;
+
+	spin_unlock_irq(&host->lock);
+	mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
+	spin_lock_irq(&host->lock);
+
+	if (mode != MMC_POWER_OFF)
+		sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL);
+	else
+		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+}
+
+void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
+		     unsigned short vdd)
+{
 	u8 pwr = 0;
 
 	if (mode != MMC_POWER_OFF) {
@@ -1335,12 +1349,20 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 		if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
 			mdelay(10);
 	}
+}
+EXPORT_SYMBOL_GPL(sdhci_set_power);
 
-	if (!IS_ERR(mmc->supply.vmmc)) {
-		spin_unlock_irq(&host->lock);
-		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
-		spin_lock_irq(&host->lock);
-	}
+static void __sdhci_set_power(struct sdhci_host *host, unsigned char mode,
+			      unsigned short vdd)
+{
+	struct mmc_host *mmc = host->mmc;
+
+	if (host->ops->set_power)
+		host->ops->set_power(host, mode, vdd);
+	else if (!IS_ERR(mmc->supply.vmmc))
+		sdhci_set_power_reg(host, mode, vdd);
+	else
+		sdhci_set_power(host, mode, vdd);
 }
 
 /*****************************************************************************\
@@ -1490,7 +1512,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		}
 	}
 
-	sdhci_set_power(host, ios->power_mode, ios->vdd);
+	__sdhci_set_power(host, ios->power_mode, ios->vdd);
 
 	if (host->ops->platform_send_init_74_clocks)
 		host->ops->platform_send_init_74_clocks(host, ios->power_mode);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0115e9907bf8..033d72b5bbd5 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -529,6 +529,8 @@ struct sdhci_ops {
 #endif
 
 	void	(*set_clock)(struct sdhci_host *host, unsigned int clock);
+	void	(*set_power)(struct sdhci_host *host, unsigned char mode,
+			     unsigned short vdd);
 
 	int		(*enable_dma)(struct sdhci_host *host);
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
@@ -660,6 +662,8 @@ static inline bool sdhci_sdio_irq_enabled(struct sdhci_host *host)
 }
 
 void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
+void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
+		     unsigned short vdd);
 void sdhci_set_bus_width(struct sdhci_host *host, int width);
 void sdhci_reset(struct sdhci_host *host, u8 mask);
 void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
-- 
1.9.1
