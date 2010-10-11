From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/6] SD/MMC driver for MX25/35/51
Date: Mon, 11 Oct 2010 17:32:55 +0100
Message-ID: <20101011163255.GA21335@void.printf.net>
References: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:42250 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754712Ab0JKQc5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Oct 2010 12:32:57 -0400
Content-Disposition: inline
In-Reply-To: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zhu Richard-R65037 <r65037@freescale.com>

Hi Wolfram,

On Mon, Oct 11, 2010 at 04:21:00PM +0200, Wolfram Sang wrote:
> Wolfram Sang (6):
>   mmc: sdhci-pltfm: Add structure for host-specific data
>   mmc: sdhci-pltfm: move .h-file into apropriate subdir
>   mmc: sdhci: introduce private get_ro
>   mmc: sdhci_pltfm: pass more data on custom init-call
>   mmc: sdhci-of-esdhc: factor out common stuff
>   mmc: sdhci-pltfm: add pltfm-driver for imx35/51

Mind fixing up the >80 char lines in the last two patches?  It's just:

WARNING: line over 80 characters
#79: FILE: drivers/mmc/host/sdhci-esdhc.h:54:
+	temp &= ~(ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN | ESDHC_CLOCK_MASK);

WARNING: line over 80 characters
#99: FILE: drivers/mmc/host/sdhci-esdhc.h:74:
+		  (div << ESDHC_DIVIDER_SHIFT) | (pre_div << ESDHC_PREDIV_SHIFT));


WARNING: line over 80 characters
#86: FILE: drivers/mmc/host/sdhci-esdhc-imx.c:24:
+static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, int reg)

WARNING: line over 80 characters
#164: FILE: drivers/mmc/host/sdhci-esdhc-imx.c:102:
+static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pdata)

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
