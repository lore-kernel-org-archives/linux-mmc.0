From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [PATCH 0/2] share sdhci-pxa among mmp2, pxa910, pxa168 and pxa955
Date: Fri, 3 Dec 2010 01:26:54 -0500
Message-ID: <AANLkTim_P3z0dQ1JtNMk1AcE3mhHsy_xOMMmD0rkBC0Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54509 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689Ab0LCG04 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Dec 2010 01:26:56 -0500
Received: by fxm20 with SMTP id 20so1900253fxm.19
        for <linux-mmc@vger.kernel.org>; Thu, 02 Dec 2010 22:26:54 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, niej0001@gmail.com, Philip Rakity <prakity@marvell.com>, Mark Brown <markb@marvell.com>, xywu@marvell.com, njun@marvell.com

These two patches introduce several call backs, in order to share sdhci-pxa.

patch 1: move sdhci_priv and sdhci_ops definition to
include/linux/mmc/sdhci.h from drivers/mmc/host/sdhci.h
1. platfrom could directly overwrite sdhci_ops with soc specific ops,
this case occurs at different controller share the same driver, while
different ops they may use, so move sdhci_ops definition to include
2. platform code will use sdhci_priv to access host->private

Patch 2: Introduce several call backs.
pxa955 may require external gpio to detect card insert and remove.
soc_set_ops is used to overwrite host ops directly from platfrom ops.

example in board.c
static unsigned int mmc0_get_ro(struct sdhci_host *host)
{
        return 0;
}

static void mmc0_generate_init_clocks_mmp2(struct sdhci_host *host, u8
power_mode)
{
        struct sdhci_pxa *pxa = sdhci_priv(host);
i	/* do something */
}

static void mmc0_set_ops(struct sdhci_pxa *pxa)
{
        pxa->ops->get_ro = mmc0_get_ro;
        pxa->ops->platform_send_init_74_clocks = mmp2_send_init_74_clocks;
}

static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc0 = {
        .soc_set_ops    = mmc0_set_ops,
        .clk_delay_cycles       = 0xf,
        .soc_set_timing = mmp2_init_sdh,
};
