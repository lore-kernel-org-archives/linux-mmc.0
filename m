From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: FW: [PATCH v2] mmc: host: sdhci: Fix parameter of sdhci_do_start_signal_voltage_switch()
Date: Mon, 18 Feb 2013 12:50:00 -0300
Message-ID: <51224DA8.7020907@freescale.com>
References: <25B60CDC2F704E4E9D88FFD52780CB4C0BDE525A28@SC-VEXCH1.marvell.com> <CADz5_gLDcVNdG+hisNDinKXmjJsNn=bnqdL47C_t4BpDfDDZsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:54781
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753849Ab3BRPcr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Feb 2013 10:32:47 -0500
In-Reply-To: <CADz5_gLDcVNdG+hisNDinKXmjJsNn=bnqdL47C_t4BpDfDDZsg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Fabio Estevam <festevam@gmail.com>

Kevin Liu wrote:

> Thanks a lot for finding this and quick fix!
> My original purpose is to change the argument type from ios to
> signal_voltage. But the code change for mmc core was not integrated
> into Johan's final patchset ([PATCH v6 5/5] mmc: core: Fixup signal
> voltage switch).
> So I still prefer your first version. I submit below patch for this just now:

Chris has already applied my patch, so if you need to make further changes, just send incremental patches on top of it.

