From: Michael Hunold <hunold@linuxtv.org>
Subject: iMX53 and MMC_CAP_SDIO_IRQ
Date: Mon, 12 Mar 2012 09:45:07 +0100
Message-ID: <4F5DB793.3080904@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bar.sig21.net ([80.81.252.164]:48482 "EHLO bar.sig21.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571Ab2CLIpT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 12 Mar 2012 04:45:19 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Hi,

I am using a Freescale iMX53 Quick Start Board. The uSD card that comes
with the device contains a Linux kernel labeled "Linux version
2.6.35.3-01129-g691c08a-dirty".

After some digging I found out that this corresponds to the
"imx_2.6.35_11.09.01" tag in the Freescale Linux kernel that can be
found at http://opensource.freescale.com/pub/scm/imx/linux-2.6-imx.git

I am experimenting with an SDIO card and that one works fine using that
kernel. So far, so good.

Now I have tried to use a vanilla Git Linux kernel (3.3.0-rc6+) with
mixed results.

The card is recognised correctly and mostly initialised, up to the point
where an apparently an interrupt from the card is expected to happen.
Because the SDHCI driver supports "real" interrupts (via
MMC_CAP_SDIO_IRQ) the SDIO IRQ thread goes to sleep, but is never woken
up in my case.

After about 2.5 seconds, I receive an error -110 (timeout) and the
initialisation is aborted.

So my question is: is anybody using an iMX53 (or any other hardware
using the SDHCI driver) together with "real" interrupts (via
MMC_CAP_SDIO_IRQ), not polled interrupts?

The main problem is that the ancient Freescale 2.6.35 kernel is using
the "mx_sdhci" driver, while in 3.3.0-rc6+ the generic "sdhci" driver is
used, so it's not possible to simply compare the changes between the two
versions. :-(

Does anybody know the difference between the "mx_sdhci" from Freescale
2.6.35 kernel and the the "sdhci" driver in 3.3.0-rc6+?

Probably this is a question for the Freescale people: why was the
"mx_sdhci" necessary at all and why is it not necessary any more?

Any help, hints and historical informations are highly appreciated,
before I start to look deeper into this problem.

CU
Michael.
