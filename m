From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 09/11 v2] mmc: sh_mobile_sdhi: do not manage PM clocks manually
 on ARM
Date: Tue, 10 Jan 2012 18:44:39 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1201101839140.530@axis700.grange>
References: <1325686636-23905-1-git-send-email-g.liakhovetski@gmx.de>
 <1325686636-23905-10-git-send-email-g.liakhovetski@gmx.de>
 <CANqRtoRqSFMmC4VySM-Aczd7AFxZrC8nzjPwaffa+=3VtWZK0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CANqRtoRqSFMmC4VySM-Aczd7AFxZrC8nzjPwaffa+=3VtWZK0g@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

On sh-mobile platforms the MMC clock frequency for the TMIO MMC unit is
obtained from the same clock, as the one, that runtime power-manages the
controller. The SDHI glue code has to access that clock directly,
bypassing the runtime PM framework, to get its frequency, but it
shouldn't enable or disable it.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Hi Magnus

On Fri, 6 Jan 2012, Magnus Damm wrote:

> >From my point of view there is very little difference between SH and
> SH-Mobile ARM, so I don't understand the special treatment. Also, is
> this change really needed for SH with your recent Runtime PM patches?

I tested on ecovec, using polled hotplug and debug prints from the PM 
clock enable / disable routines - seems to also work properly with this 
patch. So, looks like you were right, cannot say anything about other 
platforms, obviously.

 drivers/mmc/host/sh_mobile_sdhi.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index a8d353e..95a2405 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -117,8 +117,6 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 		goto eclkget;
 	}
 
-	clk_enable(priv->clk);
-
 	mmc_data->hclk = clk_get_rate(priv->clk);
 	mmc_data->set_pwr = sh_mobile_sdhi_set_pwr;
 	mmc_data->get_cd = sh_mobile_sdhi_get_cd;
@@ -235,7 +233,6 @@ eirq_sdio:
 eirq_card_detect:
 	tmio_mmc_host_remove(host);
 eprobe:
-	clk_disable(priv->clk);
 	clk_put(priv->clk);
 eclkget:
 	kfree(priv);
@@ -261,7 +258,6 @@ static int sh_mobile_sdhi_remove(struct platform_device *pdev)
 		free_irq(irq, host);
 	}
 
-	clk_disable(priv->clk);
 	clk_put(priv->clk);
 	kfree(priv);
 
-- 
1.7.2.5

