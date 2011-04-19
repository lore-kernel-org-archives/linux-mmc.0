From: Barry Song <21cnbao@gmail.com>
Subject: MMC Quirks Clarification and Shared Data Pins SDHCI Host Controller Driver
Date: Tue, 19 Apr 2011 10:02:55 +0800
Message-ID: <BANLkTimgVe_CBiEPfxo7R=YMbKb848TCSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46135 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010Ab1DSCDP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Apr 2011 22:03:15 -0400
Received: by pwi15 with SMTP id 15so2519444pwi.19
        for <linux-mmc@vger.kernel.org>; Mon, 18 Apr 2011 19:03:15 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: bin.shi@csr.com

Barry Song <21cnbao@gmail.com> on behalf of Shi bin <bin.shi@csr.com>

>
>

Hi, list,

I=E2=80=99m new to here for investigating sd/mmc driver in our Cortex-A=
9
Single core platform board. Our sd/mmc host controller is fully
compatible with standard SD specification 2.0 but one specific
feature: slot 0 and slot 2 shared 8 bits data pins, which means at one
time, only one slot could be accessed through 8 bits data pins with a
switch defined in controller register.

I have researched in SDHCI driver in Linux kernel and don=E2=80=99t fin=
d any
codes dealing with the feature I mentioned, right? What I consider
about is, high layer send r/w request to mmc core, and sdhci_request
in lower driver be fired, I just add logic about switch 8 bits data
pins here. Other defined functions or callbacks seems could not
handler this thing, eg platform_8bit_width() and
platform_send_init_74_clocks(). Our sd/mmc host controller driver is a
wrapper on standard SDHCI driver.

So, all in all, I apply additional new quirks(occupy last bit 31) and
sdhci_ops callback shared_data_bus as below.

Index: include/linux/mmc/sdhci.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/linux/mmc/sdhci.h   (revision 4482)
+++ include/linux/mmc/sdhci.h                (working copy)
@@ -85,8 +85,6 @@
 #define SDHCI_QUIRK_NO_HISPD_BIT
          (1<<29)
 /* Controller treats ADMA descriptors with length 0000h incorrectly */
 #define SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC                          =
  (1<<30)
+/* Controller share 8 bits data pins */
+#define SDHCI_QUIRK_SHARE_DATA_PINS
   (1<<31)

                int irq;                   /* Device IRQ */
                void __iomem *ioaddr; /* Mapped address */
Index: drivers/mmc/host/sdhci.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/mmc/host/sdhci.h     (revision 4481)
+++ drivers/mmc/host/sdhci.h  (working copy)
@@ -222,8 +222,6 @@
                void (*platform_send_init_74_clocks)(struct sdhci_host =
*host,

              u8 power_mode);
                unsigned int    (*get_ro)(struct sdhci_host *host);
+             void                       (*shared_data_bus)(struct
sdhci_host *host,
+
              int acquire);
 };

 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
Index: drivers/mmc/host/sdhci.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/mmc/host/sdhci.c     (revision 4485)
+++ drivers/mmc/host/sdhci.c  (working copy)
@@ -1124,9 +1124,6 @@

                host =3D mmc_priv(mmc);

+             if (host->quirks & SDHCI_QUIRK_SHARE_DATA_PINS)
+                             host->ops->shared_data_bus(host, 1);
+
                spin_lock_irqsave(&host->lock, flags);

                WARN_ON(host->mrq !=3D NULL);
@@ -1381,9 +1378,6 @@
                spin_unlock_irqrestore(&host->lock, flags);

                mmc_request_done(host->mmc, mrq);
+
+             if (host->quirks & SDHCI_QUIRK_SHARE_DATA_PINS)
+                             host->ops->shared_data_bus(host, 0);
 }

 static void sdhci_timeout_timer(unsigned long data)


My questions is
1)	What=E2=80=99s purpose of quirks? For lots of sd/mmc host controller
different feature and IC bugs?
2)	My patch has modified kernel mmc core codes to achieve my
purpose(shared 8 data pins on runtime), is it acceptable?

Any suggestion and comment will be welcome!



Best Regards,
Shi Bin
