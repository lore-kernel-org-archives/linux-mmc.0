From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/5] mmc: sdhci: a few fixes on timeout and max_discard_to
Date: Mon, 13 Jan 2014 14:01:56 +0100
Message-ID: <CAPDyKFo1qe5tbCRvXtAV=nc9Bg6=ajWosnQudXvixw5134wscw@mail.gmail.com>
References: <1387268191-19859-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:50164 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbaAMNB5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jan 2014 08:01:57 -0500
Received: by mail-qa0-f53.google.com with SMTP id cm18so5726799qab.40
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jan 2014 05:01:56 -0800 (PST)
In-Reply-To: <1387268191-19859-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, Adrian Hunter <adrian.hunter@intel.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, ed.sutter@alcatel-lucent.com

On 17 December 2013 09:16, Dong Aisheng <b29396@freescale.com> wrote:
> Patch 1~4 mainly fixes the issue that the max timeout counter for uSDHC is
> 1 << 28 rather than 1 << 27. 1~2 fix getting the max timeout counter
> while 3~4 fix setting the max timeout.
> Thus it introduces two new platform hook: get_max_timeout_count and set_timeout
> for those platform which have different timeout setting.
>
> This issue is firstly reported here by Ed Sutter:
> http://www.spinics.net/lists/linux-mmc/msg23375.html
> The root cause is the max_discard_to got from uSDHC is too small, only 677ms,
> which cause the max_discard_bytes for eMMC is only 512, then the discard operation
> of mkfs.ext3 for an eMMC card is too slow, just like dead.
> With above patches, the issue can be fixed.
>
> Patch 5 adds the capability to calcalute the max_discard_to dynamically
> for SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK.
>
> Originally the max_discard_to for a high speed sdhc card may be:
> mmc1: new high speed SDHC card at address aaaa
> mmc1: calculated max. discard sectors 49152 for timeout 1355 ms
> After fix:
> mmc1: new high speed SDHC card at address aaaa
> mmc1: calculated max. discard sectors 712704 for timeout 5422 ms
>
> It also improves the card discard performance a lot due to max_discard_sectors
> increase a lot.
>
> There's also discussion about remove max_discard_to limit here:
> http://www.spinics.net/lists/linux-mmc/msg23395.html
> But it does not help for uSDHC since we can observe data timeout
> on a Toshiba SD3.0 cards if we do not disable data timeout interrupt.

Just some more input to this discussion.

As you probably know, I am working on a solution which in principle
means we will fall back to use R1 responses instead of R1B.
Particularly in those cases were the host driver supports
MMC_CAP_WAIT_WHILE_BUSY and when it can't support the requested busy
detection timeout. In other words, we will fall back to use poll with
CMD13 instead, which is what happens already for those not supporting
MMC_CAP_WAIT_WHILE_BUSY.

Kind regards
Ulf Hansson

>
> ChangeLog:
> v1->v2:
>  1. change .get_max_timeout to .get_max_timeout_count to reuse some code
>  2. some other minor changes based on Shawn's comment.
>  3. patch 6 in v1 is dropped since not need anymore after change 1
>
>
>
> Dong Aisheng (5):
>   mmc: sdhci: add platfrom get_max_timeout_count hook
>   mmc: sdhci-esdhc-imx: fix incorrect max_discard_to for uSDHC
>   mmc: sdhci: add platform set_timeout hook
>   mmc: sdhci-esdhc-imx: set the correct max timeout value for uSDHC
>   mmc: sdhci: calculate max_discard_to dynamically for
>     SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK
>
>  drivers/mmc/host/sdhci-esdhc-imx.c |   20 +++++++++++
>  drivers/mmc/host/sdhci.c           |   66 +++++++++++++++++++++++------------
>  drivers/mmc/host/sdhci.h           |    3 ++
>  3 files changed, 66 insertions(+), 23 deletions(-)
>
> --
> 1.7.2.rc3
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
