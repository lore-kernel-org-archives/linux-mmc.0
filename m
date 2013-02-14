From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: [PATCH v2] mmc: host: sdhci: Fix parameter of sdhci_do_start_signal_voltage_switch()
Date: Thu, 14 Feb 2013 13:56:53 +0100
Message-ID: <CA+20K0A4tWsmxrLJ+Enba3GPa8W0-E_tPvzaSL4izCF1x=K8uQ@mail.gmail.com>
References: <1360845303-21620-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qe0-f48.google.com ([209.85.128.48]:57003 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759704Ab3BNM46 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Feb 2013 07:56:58 -0500
Received: by mail-qe0-f48.google.com with SMTP id 3so1035582qea.35
        for <linux-mmc@vger.kernel.org>; Thu, 14 Feb 2013 04:56:54 -0800 (PST)
In-Reply-To: <1360845303-21620-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: cjb@laptop.org, kliu5@marvell.com, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org

Hi,

2013/2/14 Fabio Estevam <fabio.estevam@freescale.com>:
> Commit 3714f4315354 (mmc: sdhci: update signal voltage switch code) changed the
> type of the second parameter of sdhci_do_start_signal_voltage_switch(), from
> "struct mmc_ios *ios" to "int signal_voltage" which causes the following build
> warning:
>
> drivers/mmc/host/sdhci.c:2044:2: warning: initialization from incompatible pointer type [enabled by default]
> drivers/mmc/host/sdhci.c:2044:2: warning: (near initialization for 'sdhci_ops.start_signal_voltage_switch') [enabled by default]
>
> Use the previous type so that it matches the start_signal_voltage_switch()
> definition from host.h.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Reviewed-by: Johan Rudholm <johan.rudholm@stericsson.com>

Kind regards, Johan
