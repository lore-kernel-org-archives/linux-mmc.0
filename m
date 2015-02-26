From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RT PATCH] mmc: sdhci: don't provide hard irq handler
Date: Thu, 26 Feb 2015 12:29:26 +0100
Message-ID: <20150226112925.GC12992@linutronix.de>
References: <54EC487F.8020109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48481 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbbBZL32 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Feb 2015 06:29:28 -0500
Content-Disposition: inline
In-Reply-To: <54EC487F.8020109@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michal =?utf-8?B?xaBtdWNy?= <msmucr@gmail.com>
Cc: linux-rt-users@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>

the sdhci code provides both irq handlers: the primary and the thread
handler. Initially it was meant for the primary handler to be very
short.
The result is not that on -RT we have the primrary handler grabing lock=
s
and this isn't really working. As a hack for now I just push both
handler into the threaded mode.

Reported-By: Michal =C5=A0mucr <msmucr@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
The "same thing" was reported against the iwlwifi driver
(request_threaded_irq(=E2=80=A6, iwl_pcie_isr, iwl_pcie_irq_handler, =E2=
=80=A6) and they
managed to rework it and not do anything that would break -RT in their
primary handler. Besides sdhci there are a few others drivers in the
same tree doing similar things.
I'm not sure what to do here in general. Motivating upstream maintainer
to rework their code or introducing IRQF_RT_SAFE and for others doing
the conversation like in the patch below.

Michal: This is untested but should fix the issue, reported.

 drivers/mmc/host/sdhci.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 023c2010cd75..bcde53774bc9 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2565,6 +2565,31 @@ static irqreturn_t sdhci_thread_irq(int irq, voi=
d *dev_id)
 	return isr ? IRQ_HANDLED : IRQ_NONE;
 }
=20
+#ifdef CONFIG_PREEMPT_RT_BASE
+static irqreturn_t sdhci_rt_irq(int irq, void *dev_id)
+{
+	irqreturn_t ret;
+
+	local_bh_disable();
+	ret =3D sdhci_irq(irq, dev_id);
+	local_bh_enable();
+	if (ret =3D=3D IRQ_WAKE_THREAD)
+		ret =3D sdhci_thread_irq(irq, dev_id);
+	return ret;
+}
+#endif
+
+static int sdhci_req_irq(struct sdhci_host *host)
+{
+#ifdef CONFIG_PREEMPT_RT_BASE
+	return request_threaded_irq(host->irq, NULL, sdhci_rt_irq,
+				    IRQF_SHARED, mmc_hostname(host->mmc), host);
+#else
+	return request_threaded_irq(host->irq, sdhci_irq, sdhci_thread_irq,
+				    IRQF_SHARED, mmc_hostname(host->mmc), host);
+#endif
+}
+
 /*********************************************************************=
********\
  *                                                                    =
       *
  * Suspend/resume                                                     =
       *
@@ -2632,9 +2657,7 @@ int sdhci_resume_host(struct sdhci_host *host)
 	}
=20
 	if (!device_may_wakeup(mmc_dev(host->mmc))) {
-		ret =3D request_threaded_irq(host->irq, sdhci_irq,
-					   sdhci_thread_irq, IRQF_SHARED,
-					   mmc_hostname(host->mmc), host);
+		ret =3D sdhci_req_irq(host);
 		if (ret)
 			return ret;
 	} else {
@@ -3253,8 +3276,7 @@ int sdhci_add_host(struct sdhci_host *host)
=20
 	sdhci_init(host, 0);
=20
-	ret =3D request_threaded_irq(host->irq, sdhci_irq, sdhci_thread_irq,
-				   IRQF_SHARED,	mmc_hostname(mmc), host);
+	ret =3D sdhci_req_irq(host);
 	if (ret) {
 		pr_err("%s: Failed to request IRQ %d: %d\n",
 		       mmc_hostname(mmc), host->irq, ret);
--=20
2.1.4

