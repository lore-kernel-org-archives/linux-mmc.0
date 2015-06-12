From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Do not set MMC_CAP_1_8V_DDR in the
 'no-1-8-v' case
Date: Fri, 12 Jun 2015 13:00:03 -0300
Message-ID: <CAOMZO5CU56Ty7XC5WPVtqc43W2MLEPnc-j6v9_jtsXVYHzDgng@mail.gmail.com>
References: <1434060503-10260-1-git-send-email-festevam@gmail.com>
	<20150612032223.GC16730@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36732 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbbFLQAF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Jun 2015 12:00:05 -0400
In-Reply-To: <20150612032223.GC16730@shlinux1.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Aisheng Dong <aisheng.dong@freescale.com>, kevin.lemoi@savant.com, Otavio Salvador <otavio@ossystems.com.br>, Sascha Hauer <kernel@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>, stable <stable@vger.kernel.org>

On Fri, Jun 12, 2015 at 12:22 AM, Dong Aisheng <b29396@freescale.com> wrote:

> I think this patch will break the eMMC DDR 3.3v mode support.

I think you are right.

On a imx6q-sabresd which has 'no-1-8-v' in the emmc node we have originally:

mmc2: new DDR MMC card at address 0001

After applying this patch I get:

mmc2: new high speed MMC card at address 0001

I will try to come up with a different solution.

Thanks
