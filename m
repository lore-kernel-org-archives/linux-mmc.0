From: Holger Schurig <holgerschurig@gmail.com>
Subject: Re: SDHCI: mdelay() in hot path in esdhc_pltfm_set_clock looses CAN
 (!) frames
Date: Wed, 8 Jul 2015 08:22:57 +0200
Message-ID: <CAOpc7mGgD1c4BW1DXEEZQ06njQO6tgUKi0ssAGyL4SJXajDRGw@mail.gmail.com>
References: <CAOpc7mG7-RyZ2LSX8n1kh_KWaVf6N=Lo0LGt4ckLJWzp541FZg@mail.gmail.com>
	<CAOMZO5D02tarn9QrOuS3i1ekn=1Jupngo6RBOfyVm9QASPA23A@mail.gmail.com>
	<20150707205243.GK7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:34578 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754051AbbGHGW6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jul 2015 02:22:58 -0400
In-Reply-To: <20150707205243.GK7557@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Fabio Estevam <festevam@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, open list <linux-kernel@vger.kernel.org>, Dong Aisheng <b29396@freescale.com>, Sascha Hauer <kernel@pengutronix.de>

Wow, at last some reaction. And I thought nobody cares ...

BTW, removing CONFIG_MMC_CLKGATE helped a bit, because the pointless
clock-off-clock-on while the device is booting (or accessing multiple
sectors within a short time) isn't going to happen anymore.

But really, a mdelay(1) in a driver ...
