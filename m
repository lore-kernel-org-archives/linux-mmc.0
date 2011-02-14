From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 0/2] sdhci: sdhci.[ch] support setting f_max clock via call
 back
Date: Sun, 13 Feb 2011 23:10:05 -0800
Message-ID: <AC6F0A56-F4E6-4CE8-AF0C-9D9EAF368A06@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:53693 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751861Ab1BNHLJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 02:11:09 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>


Patch Set 7/12

[PATCH 1/2] sdhci: sdhci.[ch] support setting f_max clock via call back
need ability to set f_max independent of max_clk.

We cannot use the quirk SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN
since the clock is not broken and on mmp2 is fixed at 200MHz.
On some pxa platforms and changing this value
a) does not work
b) causes bad clock dividers
c) mmc errors

On other platforms defining
SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN is the right thing to do
(pxa168 and pxa910) since the clock is configured via system
registers and not known via the CAPABILITY Register.

[PATCH 2/2] sdhci: sdhci-pxa.c add host->ops to configure f_max

sdhci-pxa.c sets f_max after sdhci_add_host was called.

Rather then do this after the call, define a callback to allow
f_max to be obtained from platform specific code if the callback is
defined.

We cannot use the quirk SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN
since the clock is not broken and on mmp2 is fixed at 200MHz.
On some pxa platforms and changing this value
a) does not work
b) causes bad clock dividers
c) mmc errors

On other platforms defining
SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN is the right thing to do
(pxa168 and pxa910) since the clock is configured via system
registers and not known via the CAPABILITY Register.


