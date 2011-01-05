From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: [PATCH 4/4] mmc: add MMC_QUIRK_NONSTD_FUNC_IF
Date: Wed, 5 Jan 2011 13:28:02 +0100
Message-ID: <AANLkTinmhoY+TqmF_scKnzG-Kjjof=YDf2kzfJfr1gjy@mail.gmail.com>
References: <1294175416-12358-1-git-send-email-ohad@wizery.com>
	<1294175416-12358-4-git-send-email-ohad@wizery.com>
	<AANLkTimg7DU=1bYv-k2-WwiSurHmsrjN_+zb_=irZv9n@mail.gmail.com>
	<AANLkTi=HyXUAMALQD4MMZrw=Por8bTkJ6HxSC10UrDt4@mail.gmail.com>
	<AANLkTikwaSmwy2b6if-=BhU9c5Ea_9xyOdKDC0VhpBox@mail.gmail.com>
	<AANLkTik8FNxAhGz8Dzj=h4S1hyDGUYw4HSAhzwHWfWpG@mail.gmail.com>
	<AANLkTinrz+qonuPSo-HOJ2zmjwmyn0YJkMTg+MwKXN2s@mail.gmail.com>
	<AANLkTik7yr6bXcGpNt09zoXU_P03RE=vo2HepDa2fhuW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44141 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569Ab1AEM2E (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Jan 2011 07:28:04 -0500
Received: by qwa26 with SMTP id 26so15590355qwa.19
        for <linux-mmc@vger.kernel.org>; Wed, 05 Jan 2011 04:28:02 -0800 (PST)
In-Reply-To: <AANLkTik7yr6bXcGpNt09zoXU_P03RE=vo2HepDa2fhuW@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, "DE CESCO, Jonathan" <jonathanc@ti.com>

On Wed, Jan 5, 2011 at 10:40 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Wed, Jan 5, 2011 at 11:10 AM, Pierre Tardy <tardyp@gmail.com> wrote:
>> Well, we dont do it like this in intel_mid. Every platform quirk has
>> to come somehow from the firmware (SFI), and there is no such
>> descriptor to my knowledge. Lets see what John is proposing...
>
> I think that John shared it with you this morning. I haven't looked
> into your platform too much, but if it's using upstream code, let's
> take the discussion to the list (by rebasing John's solution and
> posting it here).
>
>> Yes, that's why I thought of a table, we might want to make this more
>> generic, and, as you are proposing more than one quirk those few days
>> for cards, we could add those quirks in struct sdio_device_id, like
>> they do for PCI...
>
> Interesting. Care to send a patch for review ?
Well... TI is selling quirky hw, would make sense that you handle this. :-)

Here is a first attempt anyway...

From: Pierre Tardy <pierre.tardy@intel.com>
Date: Wed, 5 Jan 2011 13:21:02 +0100
Subject: [PATCH] mmc: add per device quirk placeholder

Some cards have quirks valid for every platforms
using current platform quirk hooks leads to a lot
of code and debug duplication.

So we inspire a bit from what exists in PCI subsystem
and do out own per vendorid/deviceid quirk
We still drop the complexity of the pci quirk system
(with special section tables, and so on)
That can be added later if needed.


Signed-off-by: Pierre Tardy <pierre.tardy@intel.com>
---
 drivers/mmc/core/Makefile |    3 ++-
 drivers/mmc/core/core.h   |    2 ++
 drivers/mmc/core/quirks.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/sdio.c   |    1 +
 include/linux/mmc/card.h  |    2 ++
 5 files changed, 50 insertions(+), 1 deletions(-)
 create mode 100644 drivers/mmc/core/quirks.c

diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
index 86b4791..6395019 100644
--- a/drivers/mmc/core/Makefile
+++ b/drivers/mmc/core/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_MMC)		+= mmc_core.o
 mmc_core-y			:= core.o bus.o host.o \
 				   mmc.o mmc_ops.o sd.o sd_ops.o \
 				   sdio.o sdio_ops.o sdio_bus.o \
-				   sdio_cis.o sdio_io.o sdio_irq.o
+				   sdio_cis.o sdio_io.o sdio_irq.o \
+				   quirks.o

 mmc_core-$(CONFIG_DEBUG_FS)	+= debugfs.o
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 026c975..36d9a25 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -61,6 +61,8 @@ int mmc_attach_mmc(struct mmc_host *host, u32 ocr);
 int mmc_attach_sd(struct mmc_host *host, u32 ocr);
 int mmc_attach_sdio(struct mmc_host *host, u32 ocr);

+void mmc_fixup_device(struct mmc_card *card);
+
 /* Module parameters */
 extern int use_spi_crc;

diff --git a/drivers/mmc/core/quirks.c b/drivers/mmc/core/quirks.c
new file mode 100644
index 0000000..d75e68c
--- /dev/null
+++ b/drivers/mmc/core/quirks.c
@@ -0,0 +1,43 @@
+/*
+ *  This file contains work-arounds for many known sdio hardware
+ *  bugs.
+ *
+ *  Copyright (c) 2011 Pierre Tardy <tardyp@gmail.com>
+ *  Inspired from pci fixup code:
+ *  Copyright (c) 1999 Martin Mares <mj@ucw.cz>
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/mmc/card.h>
+#include <linux/mod_devicetable.h>
+
+/*
+ *  The world is not perfect and supplies us with broken mmc/sdio devices.
+ *  For at least a part of these bugs we need a work-around
+ */
+
+struct mmc_fixup {
+	u16 vendor, device;	/* You can use SDIO_ANY_ID here of course */
+	void (*hook)(struct mmc_card *card);
+};
+
+static const struct mmc_fixup mmc_fixup_methods[] = {
+	{ 0 }
+};
+
+void mmc_fixup_device(struct mmc_card *card)
+{
+	const struct mmc_fixup *f;
+
+	for (f = mmc_fixup_methods; f->hook; f++) {
+		if ((f->vendor == card->cis.vendor || f->vendor == (u16) SDIO_ANY_ID) &&
+		    (f->device == card->cis.device || f->device == (u16) SDIO_ANY_ID)) {
+			dev_dbg(&card->dev, "calling %pF\n", f->hook);
+			f->hook(card);
+		}
+	}
+}
+EXPORT_SYMBOL(mmc_fixup_device);
+
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index db18ef5..d290a1c 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -386,6 +386,7 @@ static int mmc_sdio_init_card(struct mmc_host
*host, u32 ocr,
 	 */
 	if (host->ops->init_card)
 		host->ops->init_card(host, card);
+	mmc_fixup_device(card);

 	/*
 	 * For native busses:  set card RCA and quit open drain mode.
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 5071eb1..3fe9db0 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -149,6 +149,8 @@ struct mmc_card {
 	struct dentry		*debugfs_root;
 };

+void mmc_fixup_device(struct mmc_card *dev);
+
 #define mmc_card_mmc(c)		((c)->type == MMC_TYPE_MMC)
 #define mmc_card_sd(c)		((c)->type == MMC_TYPE_SD)
 #define mmc_card_sdio(c)	((c)->type == MMC_TYPE_SDIO)
-- 
1.7.0.4
