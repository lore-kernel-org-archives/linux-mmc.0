From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: Add support DW SD/MMC driver on SOCFPGA
Date: Wed, 12 Jun 2013 17:31:52 +0200
Message-ID: <201306121731.53120.arnd@arndb.de>
References: <1370996924-23048-1-git-send-email-dinguyen@altera.com> <1370996924-23048-3-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:55795 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996Ab3FLPcG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Jun 2013 11:32:06 -0400
In-Reply-To: <1370996924-23048-3-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Pavel Machek <pavel@denx.de>

On Wednesday 12 June 2013, dinguyen@altera.com wrote:
> +static int dw_mci_socfpga_setup_clock(struct dw_mci *host)
> +{
> +       struct dw_mci_socfpga_priv_data *priv = host->priv;
> +
> +       clk_disable_unprepare(host->ciu_clk);
> +       regmap_write(priv->sysreg, SYSMGR_SDMMCGRP_CTRL_OFFSET,
> +               priv->hs_timing);
> +       clk_prepare_enable(host->ciu_clk);
> +
> +       host->bus_hz /= (priv->ciu_div + 1);
> +       return 0;
> +}


Sorry for being so late in the game here, but why do you need a
regmap_write() call in the driver here? Shouldn't you just be able
to use the clk_set_rate() interface from the generic dw_mmc-pltfm
code?

	Arnd
