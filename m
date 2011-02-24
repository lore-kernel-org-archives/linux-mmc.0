From: Eric Benard <eric@eukrea.com>
Subject: Re: [PATCH V3 0/5] sdhci-esdhc-imx: use gpio for write protection
	and	card detection
Date: Thu, 24 Feb 2011 20:00:52 +0100
Message-ID: <4D66AAE4.4000308@eukrea.com>
References: <1298469118-25282-1-git-send-email-w.sang@pengutronix.de>
	<87k4gp3bl1.fsf@lebrac.rtp-net.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060703080803020106070607"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87k4gp3bl1.fsf@lebrac.rtp-net.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

This is a multi-part message in MIME format.
--------------060703080803020106070607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Arnaud,

On 24/02/2011 12:40, Arnaud Patard (Rtp) wrote:
> Wolfram Sang<w.sang@pengutronix.de>  writes:
>
> Hi,
>
>> Take #3, changes:
>>
>> * also intercept calls to SDHCI_SIGNAL_ENABLE (needed on mx25)
>> * remove unconditional BROKEN_CARD_DETECTION (leftover)
>> * improved kernel-doc about unused GPIO
>> * added tags from Eric
>>
>> Tested now by me and Marc on mx35, Eric on mx25/35/51. Arnaud, did you have a
>> chance to retest on mx51? What about the FSL guys? :)
>
> I'm getting a hard freeze on my efika sb and mx once I remove the
> unconditional BROKEN_CARD_DETECTION flag. I'm still investigating the
> issue. I'll keep you informed if I find something.
>
may you please test the attached patch. It may give someone with a better 
knowledge of sdhci than me an idea of what is wrong.

Here are the workaround this patch add :
- we can't let enable or disable irq enabled when the card is present/not 
present, else the irq triger again which explains why you get the freeze -> so 
we must rely on the card presence bit to enable the right interrupt,
- we can't turn the clock off if we want the card detect to work when the card 
is removed -> as a quick workaround this patch prevents sdhci_set_clock from 
turning off the clocks when the SDHCI_INT_CARD_INSERT interrupt is enabled.

Also, I had to change the MX51_PAD_GPIO1_0__SD1_CD pad setting as follows to 
enable the internal pull up :
	_MX51_PAD_GPIO1_0__SD1_CD | MUX_PAD_CTRL(PAD_CTL_PUS_22K_UP |
			PAD_CTL_PKE | PAD_CTL_SRE_FAST |
			PAD_CTL_DSE_HIGH | PAD_CTL_PUE | PAD_CTL_HYS),

Eric

--------------060703080803020106070607
Content-Type: text/x-patch;
 name="mx51_sdhci_cd_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mx51_sdhci_cd_fix.patch"

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 8ac039a..be11151 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -217,6 +217,8 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
 		/* Now we have a working card_detect again */
 		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 	}
+	if (cpu_is_mx51())
+		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 
 	return 0;
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9e15f41..11ef076 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -127,10 +127,14 @@ static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
 	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
 		return;
 
-	if (enable)
+	sdhci_mask_irqs(host, irqs);
+	if (enable) {
+		if (!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT))
+			irqs = SDHCI_INT_CARD_INSERT;
+		else
+			irqs = SDHCI_INT_CARD_REMOVE;
 		sdhci_unmask_irqs(host, irqs);
-	else
-		sdhci_mask_irqs(host, irqs);
+	}
 }
 
 static void sdhci_enable_card_detection(struct sdhci_host *host)
@@ -992,6 +996,9 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	u16 clk;
 	unsigned long timeout;
 
+	if ((clock == 0) && (SDHCI_INT_CARD_INSERT & sdhci_readl(host, SDHCI_INT_ENABLE)))
+		goto out;
+
 	if (clock == host->clock)
 		return;
 
@@ -1001,6 +1008,7 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 			return;
 	}
 
+
 	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
 
 	if (clock == 0)
@@ -1583,9 +1591,18 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 	DBG("*** %s got interrupt: 0x%08x\n",
 		mmc_hostname(host->mmc), intmask);
 
-	if (intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
-		sdhci_writel(host, intmask & (SDHCI_INT_CARD_INSERT |
-			SDHCI_INT_CARD_REMOVE), SDHCI_INT_STATUS);
+	if (intmask & SDHCI_INT_CARD_INSERT) {
+		sdhci_unmask_irqs(host, SDHCI_INT_CARD_REMOVE);
+		sdhci_mask_irqs(host, SDHCI_INT_CARD_INSERT);
+		sdhci_writel(host, intmask & SDHCI_INT_CARD_INSERT,
+			SDHCI_INT_STATUS);
+		tasklet_schedule(&host->card_tasklet);
+	}
+	if (intmask & SDHCI_INT_CARD_REMOVE) {
+		sdhci_unmask_irqs(host, SDHCI_INT_CARD_INSERT);
+		sdhci_mask_irqs(host, SDHCI_INT_CARD_REMOVE);
+		sdhci_writel(host, intmask & SDHCI_INT_CARD_REMOVE,
+			SDHCI_INT_STATUS);
 		tasklet_schedule(&host->card_tasklet);
 	}
 

--------------060703080803020106070607
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--------------060703080803020106070607--
