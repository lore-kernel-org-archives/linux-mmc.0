From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC 4/7] mmc: tmio: Add UHS-I mode support
Date: Tue, 22 Mar 2016 18:21:04 +0100
Message-ID: <20160322172101.GA23563@katana>
References: <1455913003-6140-1-git-send-email-wsa@the-dreams.de>
 <1455913003-6140-5-git-send-email-wsa@the-dreams.de>
 <CAPDyKFpxE3XU8ocRLTyMvBo-FPOECY7zeJAr7O1oLwKXEZ20zQ@mail.gmail.com>
 <20160309161735.GB9443@katana>
 <CAPDyKFp_d=GKxKvNt7nyGoWLFSUYTycbS6jb-khPC1cBvJENog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFp_d=GKxKvNt7nyGoWLFSUYTycbS6jb-khPC1cBvJENog@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-renesas-soc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Dirk Behme <dirk.behme@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

> Okay, let me elaborate a bit more on what I really meant.
> 
> In tmio_mmc_of_parse(), the mmc->ops gets assigned to the
> &tmio_mmc_ops. Before doing that, you can conditionally assign
> ->start_signal_voltage_switch() callback within the &tmio_mmc_ops,
> right!?

So, lets talk with code. Do you mean something like this on top of my
series? (Compile tested only to see if I got you right):

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 5d2a852f17eebd..89e0c5e9fcc668 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -210,9 +210,10 @@ static void sh_mobile_sdhi_clk_disable(struct tmio_mmc_host *host)
 	clk_disable_unprepare(priv->clk);
 }
 
-static int sh_mobile_sdhi_start_signal_voltage_switch(struct tmio_mmc_host *host,
+static int sh_mobile_sdhi_start_signal_voltage_switch(struct mmc_host *mmc,
 						      struct mmc_ios *ios)
 {
+	struct tmio_mmc_host *host = mmc_priv(mmc);
 	struct sh_mobile_sdhi *priv = host_to_priv(host);
 	struct pinctrl_state *pin_state;
 	int ret;
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 759bf015d09b84..b1819c74965b47 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -101,7 +101,7 @@ struct tmio_mmc_host {
 	void (*clk_disable)(struct tmio_mmc_host *host);
 	int (*multi_io_quirk)(struct mmc_card *card,
 			      unsigned int direction, int blk_size);
-	int (*start_signal_voltage_switch)(struct tmio_mmc_host *host,
+	int (*start_signal_voltage_switch)(struct mmc_host *mmc,
 					   struct mmc_ios *ios);
 };
 
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 8dee637638c31e..8e2fef7c5e481c 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -1014,16 +1014,6 @@ static int tmio_multi_io_quirk(struct mmc_card *card,
 	return blk_size;
 }
 
-static int tmio_mmc_start_signal_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
-{
-	struct tmio_mmc_host *host = mmc_priv(mmc);
-
-	if (!host->start_signal_voltage_switch)
-		return 0;
-
-	return host->start_signal_voltage_switch(host, ios);
-}
-
 static int tmio_mmc_card_busy(struct mmc_host *mmc)
 {
 	struct tmio_mmc_host *host = mmc_priv(mmc);
@@ -1031,14 +1021,12 @@ static int tmio_mmc_card_busy(struct mmc_host *mmc)
 	return !(sd_ctrl_read32(host, CTL_STATUS2) & TMIO_STATUS2_DAT0);
 }
 
-static const struct mmc_host_ops tmio_mmc_ops = {
+static struct mmc_host_ops tmio_mmc_ops = {
 	.request	= tmio_mmc_request,
 	.set_ios	= tmio_mmc_set_ios,
 	.get_ro         = tmio_mmc_get_ro,
 	.get_cd		= mmc_gpio_get_cd,
 	.enable_sdio_irq = tmio_mmc_enable_sdio_irq,
-	.start_signal_voltage_switch
-			= tmio_mmc_start_signal_voltage_switch,
 	.card_busy	= tmio_mmc_card_busy,
 	.multi_io_quirk	= tmio_multi_io_quirk,
 };
@@ -1138,7 +1126,9 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 		goto host_free;
 	}
 
+	tmio_mmc_ops.start_signal_voltage_switch = _host->start_signal_voltage_switch;
 	mmc->ops = &tmio_mmc_ops;
+
 	mmc->caps |= MMC_CAP_4_BIT_DATA | pdata->capabilities;
 	mmc->caps2 |= pdata->capabilities2;
 	mmc->max_segs = 32;


> Why am I suggesting this? I want to avoid us evolving the code in the
> wrong direction, similar what has happened to SDHCI. *One* way to
> address this, is to minimize unnecessary variant specific callbacks.

Well, I can't test the original tmio_mmc implementation, only the sdhi
variant. So, we need a variant specific start_signal_voltage_switch().
As I see it, the above patch reduces one layer of abstraction. This is
nice, but the variant specific callback is still there. or?

Or i still got you wrong, then sorry!

Thanks,

   Wolfram
