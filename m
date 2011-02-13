From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Sun, 13 Feb 2011 23:35:54 +0100
Message-ID: <201102132335.54868.arnd@arndb.de>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com> <1297650746-12841-2-git-send-email-shawn.guo@freescale.com> <20110213192609.GA21429@void.printf.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:65534 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab1BMWf7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Feb 2011 17:35:59 -0500
In-Reply-To: <20110213192609.GA21429@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Shawn Guo <shawn.guo@freescale.com>, s.hauer@pengutronix.de, LW@karo-electronics.de, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sunday 13 February 2011, Chris Ball wrote:
> On Mon, Feb 14, 2011 at 10:32:20AM +0800, Shawn Guo wrote:
> > This adds the mmc host driver for Freescale MXS-based SoC i.MX23/28.
> > The driver calls into mxs-dma via generic dmaengine api for both pio
> > and data transfer.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> 
> Please add a Reviewed-by: from Arnd and a Tested-by: from Lothar.
> Could you add a MODULE_AUTHOR() field, too?

In general, these tags should not simply be added by the author without
having the person who did the reviewing or testing specifically provide
them!

In this particular case, I'm happy with the driver in version 2, good job!
Please do add my

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
