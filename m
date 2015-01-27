From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] mmc: print message if a card supports secure erase/trim
Date: Tue, 27 Jan 2015 10:56:41 -0800
Message-ID: <1422385001.18650.10.camel@perches.com>
References: <1422359304-30321-1-git-send-email-holler@ahsoftware.de>
	 <CAFLxGvyuE8odPdNSD1PTccyBXFm=JO=ooikUOJfz41aFpsUAJg@mail.gmail.com>
	 <54C77E69.7050600@ahsoftware.de> <54C77F5D.30302@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54C77F5D.30302@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: Alexander Holler <holler@ahsoftware.de>, linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 2015-01-27 at 13:06 +0100, Richard Weinberger wrote:
> Am 27.01.2015 um 13:02 schrieb Alexander Holler:
> > Am 27.01.2015 um 12:55 schrieb Richard Weinberger:
> >> On Tue, Jan 27, 2015 at 12:48 PM, Alexander Holler <holler@ahsoftware.de> wrote:
> >>> It's an interesting detail, so inform the user about it.
[]
> >>> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
[]
> >>> @@ -347,6 +347,10 @@ int mmc_add_card(struct mmc_card *card)
> >>>                          uhs_bus_speed_mode, type, card->rca);
> >>>          }
> >>>
> >>> +       if (mmc_can_secure_erase_trim(card))
> >>> +               pr_info("%s: card supports secure erase/trim\n",
> >>> +                       mmc_hostname(card->host));
> >>> +
> >>
> >> Please make this a sysfs attribute.
> >> Exposing such properties as log messages is horrible.
> > 
> > Look at the source at the message which is printed just before and decide which one you find more informational / useful.
> 
> -ENOPARSE

Because you didn't look at the code?

Alexander, while I kind of agree with Richard about various
properties being rightfully exposed in sysfs, it might have
made more short-term sense to extend the original line instead
of printing another new one.

Something like:
---
 drivers/mmc/core/bus.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index c5ef100..e282780 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -259,6 +259,7 @@ int mmc_add_card(struct mmc_card *card)
 	int ret;
 	const char *type;
 	const char *uhs_bus_speed_mode = "";
+	const char *secure_trim_erase = "";
 	static const char *const uhs_speeds[] = {
 		[UHS_SDR12_BUS_SPEED] = "SDR12 ",
 		[UHS_SDR25_BUS_SPEED] = "SDR25 ",
@@ -300,21 +301,26 @@ int mmc_add_card(struct mmc_card *card)
 		(card->sd_bus_speed < ARRAY_SIZE(uhs_speeds)))
 		uhs_bus_speed_mode = uhs_speeds[card->sd_bus_speed];
 
+	if (mmc_can_secure_erase_trim(card))
+		secure_trim_erase = " (secure erase/trim)";
+
 	if (mmc_host_is_spi(card->host)) {
-		pr_info("%s: new %s%s%s card on SPI\n",
+		pr_info("%s: new %s%s%s%s card on SPI\n",
 			mmc_hostname(card->host),
 			mmc_card_hs(card) ? "high speed " : "",
 			mmc_card_ddr52(card) ? "DDR " : "",
-			type);
+			type,
+			secure_trim_erase);
 	} else {
-		pr_info("%s: new %s%s%s%s%s card at address %04x\n",
+		pr_info("%s: new %s%s%s%s%s%s card at address %04x\n",
 			mmc_hostname(card->host),
 			mmc_card_uhs(card) ? "ultra high speed " :
 			(mmc_card_hs(card) ? "high speed " : ""),
 			mmc_card_hs400(card) ? "HS400 " :
 			(mmc_card_hs200(card) ? "HS200 " : ""),
 			mmc_card_ddr52(card) ? "DDR " : "",
-			uhs_bus_speed_mode, type, card->rca);
+			uhs_bus_speed_mode, type, secure_trim_erase,
+			card->rca);
 	}
 
 #ifdef CONFIG_DEBUG_FS
