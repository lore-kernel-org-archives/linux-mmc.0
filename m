From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH v1 5/5] ARM: mxs: add mxs dma dt support
Date: Wed, 14 Mar 2012 15:58:23 +0800
Message-ID: <4F604F9F.1070801@freescale.com>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com> <1331628428-24017-6-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe004.messaging.microsoft.com ([213.199.154.207]:53352
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754131Ab2CNHz5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Mar 2012 03:55:57 -0400
In-Reply-To: <1331628428-24017-6-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, vinod.koul@linux.intel.com, s.hauer@pengutronix.de, rob.herring@calxeda.com, grant.likely@secretlab.ca, rdunlap@xenotime.net, kernel@pengutronix.de, cjb@laptop.org, shawn.guo@freescale.com

Hi,
> +			dma-apbh@80004000 {
> +				compatible = "fsl,mxs-dma-apbh";
> +				reg =<0x80004000 2000>;
> +			};
> +
Why you do not add the `interrupt` for the it?
the gpmi-nand needs to parse the interrupt out.

BR
Huang Shijie


