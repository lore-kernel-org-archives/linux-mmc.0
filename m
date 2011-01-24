From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH] mmc: clear all interrupt in suspend before free_irq
Date: Mon, 24 Jan 2011 03:33:16 -0500
Message-ID: <AANLkTikkj=tcCTHgT=fbvS=nOtMP+V3brjtReUNCiHu5@mail.gmail.com>
References: <AANLkTi=M5M=uaGJ-+8K0fLDssDR7bnD=K0Saxz-Gww6y@mail.gmail.com>
	<alpine.LFD.2.00.1101211431050.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60172 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312Ab1AXIdR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Jan 2011 03:33:17 -0500
Received: by fxm20 with SMTP id 20so3744506fxm.19
        for <linux-mmc@vger.kernel.org>; Mon, 24 Jan 2011 00:33:16 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1101211431050.8580@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-mmc@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>, Bing Zhao <bzhao@marvell.com>, Chris Ball <cjb@laptop.org>, Raymond Wu <xywu@marvell.com>

On Fri, Jan 21, 2011 at 2:33 PM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> On Fri, 21 Jan 2011, zhangfei gao wrote:
>
>> >From b7be39e0bbac3950057078ac66900ebc0871f77e Mon Sep 17 00:00:00 2=
001
>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>> Date: Fri, 21 Jan 2011 18:02:47 -0500
>> Subject: [PATCH] mmc: clear all interrupt in suspend before free_irq
>>
>> =A0 =A0 =A0 When debugging wifi host sleep, race condition about
>> SDHCI_INT_CARD_INT happens.
>> =A0 =A0 =A0 Host free_irq in suspend and request_irq when resume bac=
k.
>> =A0 =A0 =A0 However SDHCI_INT_CARD_INT is not cleared, so interrupt =
will
>> immediately happen after request_irq.
>> =A0 =A0 =A0 mmc_signal_sdio_irq will be called and wakeup sdio_irq_t=
hread.
>> =A0 =A0 =A0 As a result irq_handler in sdio driver is called even be=
fore host resume back.
>>
>> =A0 =A0 =A0 The correct case is mmc_sdio_resume calls mmc_signal_sdi=
o_irq to
>> wakeup sdio_irq_thread
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>
> That makes sense, as long as the masking of interrupts doesn't preven=
t
> a SDIO card interrupt from waking up the host system.
>
Hi, Nicolas

Thanks for suggestion, we found some controller will actively call
sdhci_suspend_host, while CPU still keep in active state, so wakeup
source will not workable at such state, and CPU still rely on
interrupt to wake up.
Interrupt may not be freed in future to support this case.
So directly skip mmc_signal_sdio_irq in suspend state, do you think thi=
s is OK.

Subject: [PATCH] mmc: skip mmc_signal_sdio_irq in irq handler when resu=
me back

	When debugging wifi host sleep, race condition about
SDHCI_INT_CARD_INT happens.
	Host free_irq in suspend and request_irq when resume back.
	However SDHCI_INT_CARD_INT is not cleared, so interrupt will
immediately happen after request_irq.
	mmc_signal_sdio_irq will be called and wakeup sdio_irq_thread.
	As a result irq_handler in sdio driver is called even before host resu=
me back.

	So skip mmc_signal_sdio_irq in irq handler when resume back.
	And mmc_sdio_resume calls mmc_signal_sdio_irq to wakeup sdio_irq_threa=
d

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 drivers/mmc/host/sdhci.c  |   10 ++++++++--
 include/linux/mmc/sdhci.h |    1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index aacd78c..a813b8b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1684,8 +1684,12 @@ out:
 	/*
 	 * We have to delay this as it calls back into the driver.
 	 */
-	if (cardint)
-		mmc_signal_sdio_irq(host->mmc);
+	if (cardint) {
+		if(host->suspended)
+			sdhci_enable_sdio_irq(host->mmc, 0);
+		else
+			mmc_signal_sdio_irq(host->mmc);
+	}

 	return result;
 }
@@ -1709,6 +1713,7 @@ int sdhci_suspend_host(struct sdhci_host *host,
pm_message_t state)
 		return ret;

 	free_irq(host->irq, host);
+	host->suspended =3D true;

 	if (host->vmmc)
 		ret =3D regulator_disable(host->vmmc);
@@ -1742,6 +1747,7 @@ int sdhci_resume_host(struct sdhci_host *host)
 	sdhci_init(host, (host->mmc->pm_flags & MMC_PM_KEEP_POWER));
 	mmiowb();

+	host->suspended =3D false;
 	ret =3D mmc_resume_host(host->mmc);
 	sdhci_enable_card_detection(host);

diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 83bd9f7..764666a 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -140,6 +140,7 @@ struct sdhci_host {
 	struct timer_list timer;	/* Timer for timeouts */

 	unsigned int caps;	/* Alternative capabilities */
+	bool suspended;

 	unsigned int            ocr_avail_sdio;	/* OCR bit masks */
 	unsigned int            ocr_avail_sd;
--=20
1.7.0.4
