From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [Regression: mmc: sdhci-esdhc-imx: add runtime pm support]
Date: Fri, 7 Feb 2014 15:56:16 +0800
Message-ID: <CAA+hA=Qvnm4S1tEQbfopegTeE4uHDdu9nY=fnYAYqdzPrUP8CQ@mail.gmail.com>
References: <52F3A267.8030302@parkeon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:54773 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbaBGH4S (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Feb 2014 02:56:18 -0500
Received: by mail-qc0-f179.google.com with SMTP id e16so5331374qcx.10
        for <linux-mmc@vger.kernel.org>; Thu, 06 Feb 2014 23:56:17 -0800 (PST)
In-Reply-To: <52F3A267.8030302@parkeon.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Martin Fuzzey <mfuzzey@parkeon.com>
Cc: Dong Aisheng <b29396@freescale.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Martin,

On Thu, Feb 6, 2014 at 10:55 PM, Martin Fuzzey <mfuzzey@parkeon.com> wrote:
> Hello all,
>
> since
>
> commit 89d7e5c131228a8f0d8b0cb48b459c62152bf620
> Author: Dong Aisheng <b29396@freescale.com>
> Date:   Mon Nov 4 16:38:29 2013 +0800
>
>     mmc: sdhci-esdhc-imx: add runtime pm support
>
>
> My SDIO wifi module (WiiBear n modue based on Marvel 8787 chipset) using
> mainline mwifiex driver is no longer working:
>

Some SDIO cards may not be able to work well without clock.

Can you try the following patch to see if it works?

commit d9d062627407f714ba326fa8dd6e8aa20199fdbe
Author: Dong Aisheng <b29396@freescale.com>
Date:   Fri Nov 15 17:54:36 2013 +0800

    mmc: sdhci: get runtime pm when sdio irq is enabled

    SDIO cards may need clock to send the card interrupt to host.
    Thus, we get runtime pm when sdio irq is enabled to prevent the clock
    resource is released and put it when sdio irq is disabled.

    Signed-off-by: Dong Aisheng <b29396@freescale.com>

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9ddef47..f892757 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1734,9 +1734,15 @@ static void sdhci_enable_sdio_irq(struct
mmc_host *mmc, int enable)
        struct sdhci_host *host = mmc_priv(mmc);
        unsigned long flags;

+       if (enable)
+               sdhci_runtime_pm_get(host);
+
        spin_lock_irqsave(&host->lock, flags);
        sdhci_enable_sdio_irq_nolock(host, enable);
        spin_unlock_irqrestore(&host->lock, flags);
+
+       if (!enable)
+               sdhci_runtime_pm_put(host);
 }

 static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,


Regards
Dong Aisheng

> [   33.465577] mwifiex_sdio mmc2:0001:1: mwifiex_cmd_timeout_func: Timeout
> cmd id (7242618.212205) = 0xa9, act = 0x0
> [   33.475944] mwifiex_sdio mmc2:0001:1: num_data_h2c_failure = 0
> [   33.481793] mwifiex_sdio mmc2:0001:1: num_cmd_h2c_failure = 0
> [   33.487599] mwifiex_sdio mmc2:0001:1: num_cmd_timeout = 1
> [   33.493010] mwifiex_sdio mmc2:0001:1: num_tx_timeout = 0
> [   33.498371] mwifiex_sdio mmc2:0001:1: last_cmd_index = 1
> [   33.503693] mwifiex_sdio mmc2:0001:1: last_cmd_id: 00 00 a9 00 00 00 00
> 00 00 00
> [   33.511137] mwifiex_sdio mmc2:0001:1: last_cmd_act: 00 00 00 00 00 00 00
> 00 00 00
> [   33.518660] mwifiex_sdio mmc2:0001:1: last_cmd_resp_index = 0
> [   33.524417] mwifiex_sdio mmc2:0001:1: last_cmd_resp_id: 00 00 00 00 00 00
> 00 00 00 00
> [   33.532301] mwifiex_sdio mmc2:0001:1: last_event_index = 0
> [   33.537825] mwifiex_sdio mmc2:0001:1: last_event: 00 00 00 00 00 00 00 00
> 00 00
> [   33.545164] mwifiex_sdio mmc2:0001:1: data_sent=1 cmd_sent=1
> [   33.550863] mwifiex_sdio mmc2:0001:1: ps_mode=0 ps_state=0
> [   33.556425] mwifiex_sdio mmc2:0001:1: cmd timeout
> [   33.572375] mwifiex_sdio: Resetting card...
> [   33.728913] mmc2: card 0001 removed
>
>
> Increasing the autosuspend delay from 50ms to 500ms fixes the problem.
>
> This is using an i.MX53 SOC
>
> This is on 3.13 cherrypicking from mainline this patch and these two
> supporting patches:
>
> commit d433dc63182825538b85de6a85e2ea3fad7f2917
> Author: Dong Aisheng <b29396@freescale.com>
> Date:   Mon Nov 4 16:38:25 2013 +0800
>
>     mmc: sdhci-pltfm: export pltfm suspend/resume api
>
>
> commit ce090a4eb9626272bfd2529520f2f16351029640
> Author: Dong Aisheng <b29396@freescale.com>
> Date:   Mon Nov 4 16:38:28 2013 +0800
>
>     mmc: sdhci-esdhc-imx: fix runtime pm unbalance issue
>
>
> Cheers,
>
> Martin
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
