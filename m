From: Philip Rakity <prakity@marvell.com>
Subject: [RFC 0/1] sdhcic Do not disable global interrupts while waiting in
 set_ios
Date: Sun, 13 Feb 2011 23:06:51 -0800
Message-ID: <7741D61D-ED87-42A0-82AA-4777643A0060@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:52835 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751811Ab1BNHKi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 02:10:38 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>


Patch set 5/12

[RFC] sdhci: sdhci.c: Do not disable global interrupts while waiting
in set_ios

holding the spin_lock with all interrupts disabled
is not good form when doing mdelay.
set_ios calls routines that need to delay for power to
stabalize or for chip issues when quirks are defined.

disable only our interupt and spin_lock on the chip
instead of spin_lock with all interrupts disabled.

use mmc_delay (if possible) rather then mdelay
to avoid active waits. sdhci_reset not changed.
still uses mdelay as we do not know if interrupts
have been disabled so we play "safe"

