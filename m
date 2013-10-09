From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: eMMC 4.51
Date: Wed, 9 Oct 2013 11:49:49 +0800
Message-ID: <20131009034944.GA8861@S2101-09.ap.freescale.net>
References: <CACUGKYPDQJPvtXj3NBm8=eYCioWmq=pRVSORNYNZjD13N5ceeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:23164
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751805Ab3JIDtd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Oct 2013 23:49:33 -0400
Content-Disposition: inline
In-Reply-To: <CACUGKYPDQJPvtXj3NBm8=eYCioWmq=pRVSORNYNZjD13N5ceeg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Tobias <john.tobias.ph@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b29396@freescale.com

On Tue, Oct 08, 2013 at 07:00:58PM -0700, John Tobias wrote:
> Hello,
> 
> I am using git://gitorious.org/thierryreding/linux-next.git to boot my
> custom board based on iMX6 sololite. My board has SanDisk iNAND 4.51
> I/F and wifi module (Marvel SD8797). The latest update of
> sdhci-esdhc-imx.c supports DDR50/SDR50/SDR104 and I would like to use
> it for my device.

The latest update on sdhci-esdhc-imx.c only enables the support of UHS SD card in
SDR104 mode.  Neither DDR50 nor eMMC is supported so far.

Shawn

