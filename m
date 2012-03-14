From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH v1 5/5] ARM: mxs: add mxs dma dt support
Date: Wed, 14 Mar 2012 16:43:21 +0800
Message-ID: <4F605A29.6080009@freescale.com>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com> <1331628428-24017-6-git-send-email-b29396@freescale.com> <4F604F9F.1070801@freescale.com> <20120314083046.GD1180@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:42315
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751907Ab2CNIks (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Mar 2012 04:40:48 -0400
In-Reply-To: <20120314083046.GD1180@shlinux2.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <aisheng.dong@freescale.com>
Cc: Dong Aisheng-B29396 <B29396@freescale.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "vinod.koul@linux.intel.com" <vinod.koul@linux.intel.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rdunlap@xenotime.net" <rdunlap@xenotime.net>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "cjb@laptop.org" <cjb@laptop.org>, Guo Shawn-R65073 <r65073@freescale.com>

Hi Aisheng:
> The non-dt way also does not have interrupt resource for dma device.
> It seems the channel interrupt resource is handled in each client device.
> I'm not familiar with gpmi-nand, but I guess you may need to handle
> it in gpmi driver, just like mxs-mmc driver.
>
ok, got it.

thanks
Huang Shijie


