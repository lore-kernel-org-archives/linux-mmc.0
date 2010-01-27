From: John Rigby <jcrigby@gmail.com>
Subject: Re: sdio irq hack for omap_hsmmc.c (was: Re: [PATCH] OMAP35xx:SDIO
	IRQ Support for OMAP35xx)
Date: Wed, 27 Jan 2010 16:56:28 -0700
Message-ID: <4b73d43f1001271556m5945d358v2ca5bea5862b0080@mail.gmail.com>
References: <4b73d43f1001260904m212d2c53gde6328ad9b9bb14e@mail.gmail.com>
	 <008001ca9fa6$87dc26e0$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <008001ca9fa6$87dc26e0$544ff780@am.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: Mike Rapoport <mike@compulab.co.il>, Dirk Behme <dirk.behme@googlemail.com>, Phaneendra Kumar Alapati <phani@embwise.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>, "Paasikivi Teemu.3 (EXT-Ixonos/Tampere)" <ext-teemu.3.paasikivi@nokia.com>
List-Id: linux-mmc@vger.kernel.org

Just to be clear, my post was in response to the reported problems
with enabling sdio irqs with this patch:
http://patchwork.kernel.org/patch/69122/

The patch originator reported good results but others reported
complete failure.  My hack fixed the problem for me.  I believe this
much more modest patch will also fix the problem but it is untested
because I don't have a board running right now.  Beware, I'm sending
this from gmail so it may get line wrapped but it is a trivial patch
so I think it is understandable.

John

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index fa94580..7af970e 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1727,10 +1727,16 @@ static int __init omap_hsmmc_probe

 	omap_hsmmc_context_save(host);

+#if 0
 	mmc->caps |= MMC_CAP_DISABLE;
 	mmc_set_disable_delay(mmc, OMAP_MMC_DISABLED_TIMEOUT);
 	/* we start off in DISABLED state */
 	host->dpm_state = DISABLED;
+#else
+	/* we start off in ENABLED state */
+	host->dpm_state = ENABLED;
+	clk_enable(host->fclk);
+#endif

 	if (mmc_host_enable(host->mmc) != 0) {
 		clk_put(host->iclk);


On Wed, Jan 27, 2010 at 4:14 PM, Madhusudhan <madhu.cr@ti.com> wrote:
> It is hard to comment on what is happening here without a patch. Is it a
> performance issue or that SDIO functionality failure with PM enabled?
>
> The MMC controller supports wakeup capability on the dat1 line using a GPIO
> for a SDIO interrupt. I guess that should help.
>
> Regards,
> Madhu
>
