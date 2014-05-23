From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v13 3/7] mmc: omap_hsmmc: Extend debugfs by SDIO IRQ
 handling, runtime state
Date: Fri, 23 May 2014 08:14:24 -0700
Message-ID: <20140523151424.GG2321@atomide.com>
References: <1400833834-15893-1-git-send-email-afenkart@gmail.com>
 <1400833834-15893-4-git-send-email-afenkart@gmail.com>
 <537F3E6E.7060000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <537F3E6E.7060000@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: Andreas Fenkart <afenkart@gmail.com>, Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Andreas Mueller <schnitzeltony@googlemail.com>, Sebastian Reichel <sre@kernel.org>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

* Balaji T K <balajitk@ti.com> [140523 05:27]:
> On Friday 23 May 2014 02:00 PM, Andreas Fenkart wrote:
> >Add SDIO IRQ entries to debugfs entry. Note that PSTATE shows current
> >state of data lines, incl. SDIO IRQ pending
> >
> >Acked-by: Balaji T K <balajitk@ti.com>
> >Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
> >
> >diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> >index 0125eea..cfd2bfb 100644
> >--- a/drivers/mmc/host/omap_hsmmc.c
> >+++ b/drivers/mmc/host/omap_hsmmc.c
> >@@ -56,6 +56,7 @@
> >  #define OMAP_HSMMC_RSP54	0x0118
> >  #define OMAP_HSMMC_RSP76	0x011C
> >  #define OMAP_HSMMC_DATA		0x0120
> >+#define OMAP_HSMMC_PSTATE	0x0124
> >  #define OMAP_HSMMC_HCTL		0x0128
> >  #define OMAP_HSMMC_SYSCTL	0x012C
> >  #define OMAP_HSMMC_STAT		0x0130
> >@@ -1816,10 +1817,23 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
> >  {
> >  	struct mmc_host *mmc = s->private;
> >  	struct omap_hsmmc_host *host = mmc_priv(mmc);
> >+#ifdef CONFIG_PM
> >+	bool suspended;
> >+#endif
> >
> >  	seq_printf(s, "mmc%d:\n", mmc->index);
> >+	seq_printf(s, "sdio irq mode\t%s\n",
> >+		   (mmc->caps & MMC_CAP_SDIO_IRQ) ? "interrupt" : "polling");
> >+
> >+	if (mmc->caps & MMC_CAP_SDIO_IRQ) {
> >+		seq_printf(s, "sdio irq \t%s\n",
> >+			   (host->flags & HSMMC_SDIO_IRQ_ENABLED) ?  "enabled"
> >+			   : "disabled");
> >+	}
> >
> >  #ifdef CONFIG_PM
> 
> shouldn't this be CONFIG_PM_RUNTIME ?
> 
> >+	suspended = host->dev->power.runtime_status != RPM_ACTIVE;
> >+	seq_printf(s, "runtime state\t%s\n", (suspended ? "idle" : "active"));
> 
> The whole check for runtime status (and check for CONFIG_PM..) can be removed,
> since runtime status is available via sysfs
> 
> cat /sys/class/mmc_host/mmc<X>/device/power/runtime_status
> 
> >  	seq_printf(s, "ctx_loss:\t%d\n", host->context_loss);
> >  #endif

Also CONFIG_SYSFS is a bool FYI.

Regards,

Tony
