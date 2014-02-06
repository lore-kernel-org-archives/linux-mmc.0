From: Martin Fuzzey <mfuzzey@parkeon.com>
Subject: [Regression: mmc: sdhci-esdhc-imx: add runtime pm support]
Date: Thu, 06 Feb 2014 15:55:35 +0100
Message-ID: <52F3A267.8030302@parkeon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:42137 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571AbaBFOzj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Feb 2014 09:55:39 -0500
Received: by mail-wi0-f175.google.com with SMTP id hm4so1687852wib.14
        for <linux-mmc@vger.kernel.org>; Thu, 06 Feb 2014 06:55:38 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

Hello all,

since

commit 89d7e5c131228a8f0d8b0cb48b459c62152bf620
Author: Dong Aisheng <b29396@freescale.com>
Date:   Mon Nov 4 16:38:29 2013 +0800

     mmc: sdhci-esdhc-imx: add runtime pm support


My SDIO wifi module (WiiBear n modue based on Marvel 8787 chipset) using 
mainline mwifiex driver is no longer working:

[   33.465577] mwifiex_sdio mmc2:0001:1: mwifiex_cmd_timeout_func: 
Timeout cmd id (7242618.212205) = 0xa9, act = 0x0
[   33.475944] mwifiex_sdio mmc2:0001:1: num_data_h2c_failure = 0
[   33.481793] mwifiex_sdio mmc2:0001:1: num_cmd_h2c_failure = 0
[   33.487599] mwifiex_sdio mmc2:0001:1: num_cmd_timeout = 1
[   33.493010] mwifiex_sdio mmc2:0001:1: num_tx_timeout = 0
[   33.498371] mwifiex_sdio mmc2:0001:1: last_cmd_index = 1
[   33.503693] mwifiex_sdio mmc2:0001:1: last_cmd_id: 00 00 a9 00 00 00 
00 00 00 00
[   33.511137] mwifiex_sdio mmc2:0001:1: last_cmd_act: 00 00 00 00 00 00 
00 00 00 00
[   33.518660] mwifiex_sdio mmc2:0001:1: last_cmd_resp_index = 0
[   33.524417] mwifiex_sdio mmc2:0001:1: last_cmd_resp_id: 00 00 00 00 
00 00 00 00 00 00
[   33.532301] mwifiex_sdio mmc2:0001:1: last_event_index = 0
[   33.537825] mwifiex_sdio mmc2:0001:1: last_event: 00 00 00 00 00 00 
00 00 00 00
[   33.545164] mwifiex_sdio mmc2:0001:1: data_sent=1 cmd_sent=1
[   33.550863] mwifiex_sdio mmc2:0001:1: ps_mode=0 ps_state=0
[   33.556425] mwifiex_sdio mmc2:0001:1: cmd timeout
[   33.572375] mwifiex_sdio: Resetting card...
[   33.728913] mmc2: card 0001 removed


Increasing the autosuspend delay from 50ms to 500ms fixes the problem.

This is using an i.MX53 SOC

This is on 3.13 cherrypicking from mainline this patch and these two 
supporting patches:

commit d433dc63182825538b85de6a85e2ea3fad7f2917
Author: Dong Aisheng <b29396@freescale.com>
Date:   Mon Nov 4 16:38:25 2013 +0800

     mmc: sdhci-pltfm: export pltfm suspend/resume api


commit ce090a4eb9626272bfd2529520f2f16351029640
Author: Dong Aisheng <b29396@freescale.com>
Date:   Mon Nov 4 16:38:28 2013 +0800

     mmc: sdhci-esdhc-imx: fix runtime pm unbalance issue


Cheers,

Martin


