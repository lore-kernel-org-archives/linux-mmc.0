From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 4/5 v3] mmc: add a function to get a regulator, supplying card's Vdd
Date: Mon, 11 Jun 2012 09:41:00 -0400
Message-ID: <871ulm7yqb.fsf@octavius.laptop.org>
References: <Pine.LNX.4.64.1205251045490.13353@axis700.grange>
	<Pine.LNX.4.64.1205251208440.13353@axis700.grange>
	<Pine.LNX.4.64.1205251230540.13353@axis700.grange>
	<20120528144502.GG4032@opensource.wolfsonmicro.com>
	<Pine.LNX.4.64.1206111259190.29799@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1206111259190.29799@axis700.grange> (Guennadi
	Liakhovetski's message of "Mon, 11 Jun 2012 13:03:26 +0200 (CEST)")
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, Jun 11 2012, Guennadi Liakhovetski wrote:
> Yes, but existing mmc-regulator functions use EXPORT_SYMBOL(), e.g.,
>
> EXPORT_SYMBOL(mmc_regulator_get_ocrmask);
>
> which indeed seem to do the "old evil binary-only module trick": re-export 
> functions, dropping the "_GPL" suffix. Looks like they should be fixed...

Yuck, thanks for noticing that.  Happy to fix it:


Subject: [PATCH] mmc: core: Export regulator_* functions as GPL

The regulator API functions we're wrapping are exported as GPL, so our
wrappers for the same functions should be too.

Reported-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/core/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 0b6141d..c689877 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -941,7 +941,7 @@ int mmc_regulator_get_ocrmask(struct regulator *supply)
 
 	return result;
 }
-EXPORT_SYMBOL(mmc_regulator_get_ocrmask);
+EXPORT_SYMBOL_GPL(mmc_regulator_get_ocrmask);
 
 /**
  * mmc_regulator_set_ocr - set regulator to match host->ios voltage
@@ -1011,7 +1011,7 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
 			"could not set regulator OCR (%d)\n", result);
 	return result;
 }
-EXPORT_SYMBOL(mmc_regulator_set_ocr);
+EXPORT_SYMBOL_GPL(mmc_regulator_set_ocr);
 
 #endif /* CONFIG_REGULATOR */
 
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
