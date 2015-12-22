From: Stefan Wahren <info@lategoodbye.de>
Subject: Re: [PATCHv2 4/5] mmc: shdci-bcm2835: add verify for 32-bit
 back-to-back workaround
Date: Tue, 22 Dec 2015 16:55:22 +0100
Message-ID: <5679726A.1070300@lategoodbye.de>
References: <Scott Branden <sbranden@broadcom.com>
 <1414651017-3545-1-git-send-email-sbranden@broadcom.com>
 <1414651017-3545-5-git-send-email-sbranden@broadcom.com>
 <5459AECF.8000402@wwwdotorg.org> <5459CB17.3020303@broadcom.com>
 <545B00B9.5090108@wwwdotorg.org> <545D1006.5040705@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.augenpunkt.de ([213.239.207.9]:38967 "EHLO
	www.augenpunkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933098AbbLVPz5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Dec 2015 10:55:57 -0500
In-Reply-To: <545D1006.5040705@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Branden <sbranden@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Ulf Hansson <ulf.hansson@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Peter Griffin <peter.griffin@linaro.org>, Chris Ball <chris@printf.net>, Piotr Krol <pietrushnic@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, Joe Perches <joe@perches.com>

Hi Scott,

Am 07.11.2014 um 19:31 schrieb Scott Branden:
> On 14-11-05 09:01 PM, Stephen Warren wrote:
>> On 11/05/2014 12:00 AM, Scott Branden wrote:
>>> On 14-11-04 08:59 PM, Stephen Warren wrote:
>>>> On 10/30/2014 12:36 AM, Scott Branden wrote:
>>>>> Add a verify option to driver to print out an error message if a
>>>>> potential back to back write could cause a clock domain issue.
>>>>
>>>>> index f8c450a..11af27f 100644
>>>>
>>>>> +#ifdef CONFIG_MMC_SDHCI_BCM2835_VERIFY_WORKAROUND
>>>>> +    struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>>> +    struct bcm2835_sdhci_host *bcm2835_host = pltfm_host->priv;
>>>>> +
>>>>> +    if (bcm2835_host->previous_reg == reg) {
>>>>> +        if ((reg != SDHCI_HOST_CONTROL)
>>>>> +            && (reg != SDHCI_CLOCK_CONTROL)) {
>>>>
>>>> The comment in patch 3 says the problem doesn't apply to the data
>>>> register. Why does this check for these two registers rather than data?
>>> This Verify workaround patch still a work in progress.  I'm still
>>> getting more info from the silicon designers on the back-to-back
>>> register writes that are affect.  The spew of 0x20 or 0x28 or 0x2c
>>> register writes are all ok locations that don't need to be worked
>>> around.  This patch needs to be corrected with the proper register rules
>>> still.
> Thanks for testing.  Yes, I have work to do on the verify patch above
> still.

do you still have plans to submit a V3 of this patch series?

I attached an improved version of this patch which avoids a possible
endless loop caused by the dev_err call. So only the first occurence
of a specific register will be logged.

Regards
Stefan


-------------------8<-------------------------------------------

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 1526b8a..7b0990f 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -306,6 +306,15 @@ config MMC_SDHCI_BCM2835

 	  If unsure, say N.

+config MMC_SDHCI_BCM2835_VERIFY_WORKAROUND
+	bool "Verify BCM2835 workaround does not do back to back writes"
+	depends on MMC_SDHCI_BCM2835
+	default y
+	help
+	  This enables code that verifies the bcm2835 workaround.
+	  The verification code checks that back to back writes to the same
+	  register do not occur.
+
 config MMC_SDHCI_F_SDH30
 	tristate "SDHCI support for Fujitsu Semiconductor F_SDH30"
 	depends on MMC_SDHCI_PLTFM
diff --git a/drivers/mmc/host/sdhci-bcm2835.c
b/drivers/mmc/host/sdhci-bcm2835.c
index 01ce193d..c1c70df 100644
--- a/drivers/mmc/host/sdhci-bcm2835.c
+++ b/drivers/mmc/host/sdhci-bcm2835.c
@@ -20,15 +20,27 @@
  */

 #include <linux/delay.h>
+#include <linux/hashtable.h>
 #include <linux/module.h>
 #include <linux/mmc/host.h>
+#include <linux/slab.h>
 #include "sdhci-pltfm.h"

 struct bcm2835_sdhci_host {
 	u32 shadow_cmd;
 	u32 shadow_blk;
+	int previous_reg;
 };

+struct reg_hash {
+	struct hlist_node node;
+	int reg;
+};
+
+#define BCM2835_REG_HT_BITS 4
+
+static DEFINE_HASHTABLE(bcm2835_used_regs, BCM2835_REG_HT_BITS);
+
 #define REG_OFFSET_IN_BITS(reg) ((reg) << 3 & 0x18)

 static inline u32 bcm2835_sdhci_readl(struct sdhci_host *host, int reg)
@@ -56,8 +68,37 @@ static u8 bcm2835_sdhci_readb(struct sdhci_host
*host, int reg)
 }

 static inline void bcm2835_sdhci_writel(struct sdhci_host *host,
+					u32 val, int reg)
+{
+	writel(val, host->ioaddr + reg);
+}
+
+static inline void bcm2835_sdhci_writel_verify(struct sdhci_host *host,
 						u32 val, int reg)
 {
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct bcm2835_sdhci_host *bcm2835_host = pltfm_host->priv;
+	struct reg_hash *rh;
+	struct hlist_head *head;
+
+	head = &bcm2835_used_regs[hash_min(reg, BCM2835_REG_HT_BITS)];
+
+	if (bcm2835_host->previous_reg == reg) {
+		if ((reg != SDHCI_HOST_CONTROL) &&
+		    (reg != SDHCI_CLOCK_CONTROL) &&
+		    (hlist_empty(head))) {
+			rh = kzalloc(sizeof(*rh), GFP_KERNEL);
+			if (WARN_ON(!rh))
+				return;
+
+			rh->reg = reg;
+			hash_add(bcm2835_used_regs, &rh->node, rh->reg);
+			dev_err(mmc_dev(host->mmc), "back-to-back write to 0x%x\n",
+				reg);
+		}
+	}
+	bcm2835_host->previous_reg = reg;
+
 	writel(val, host->ioaddr + reg);
 }

@@ -131,7 +172,11 @@ static const struct sdhci_ops bcm2835_sdhci_ops = {
 	.read_l = bcm2835_sdhci_readl,
 	.read_w = bcm2835_sdhci_readw,
 	.read_b = bcm2835_sdhci_readb,
+#ifdef CONFIG_MMC_SDHCI_BCM2835_VERIFY_WORKAROUND
+	.write_l = bcm2835_sdhci_writel_verify,
+#else
 	.write_l = bcm2835_sdhci_writel,
+#endif
 	.write_w = bcm2835_sdhci_writew,
 	.write_b = bcm2835_sdhci_writeb,
 	.set_clock = sdhci_set_clock,



