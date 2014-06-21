From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 5/5] ARM: dts: imx51-babbage: Fix esdhc setup
Date: Sat, 21 Jun 2014 15:56:20 +0800
Message-ID: <20140621075619.GA16239@dragon>
References: <1400848384-3226-1-git-send-email-s.hauer@pengutronix.de>
 <1400848384-3226-6-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2lp0209.outbound.protection.outlook.com ([207.46.163.209]:6137
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758051AbaFUH4r (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 21 Jun 2014 03:56:47 -0400
Content-Disposition: inline
In-Reply-To: <1400848384-3226-6-git-send-email-s.hauer@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org

On Fri, May 23, 2014 at 02:33:04PM +0200, Sascha Hauer wrote:
> - Move cd/wp pinctrl from the hog group to the esdhc groups
> - use gpio for card detection / write protection on esdhc2 since
>   the controller based detection does not work
> - Fix cd gpio polarity for esdhc1. This is wrong and currently
>   only works because the imx esdhc driver ignores the polarity.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Applied it after fixing up the commit log and pad value.

Shawn
