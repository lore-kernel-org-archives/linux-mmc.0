From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 0/4] mmc: sdhci: Dual Data Rate Support
Date: Sun, 13 Feb 2011 23:15:47 -0800
Message-ID: <A02C531B-EA01-4EF5-915F-850DC1D9F881@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:33739 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751770Ab1BNHUR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 02:20:17 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>


Patch set 9/12

[PATCH 1/4] mmc: rename ddr to uhs in ios structure to indicate usage
uhs mode comprises dual data rate, single data rate options
such as ddr_1_8v as well as sdr50 and sdr104
ddr name changed to indicate its true usage

[PATCH 2/4] sdhci: register defs for sd 3.0 HOST CONTROL 2

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Mark F. Brown <markb@marvell.com>

[PATCH 3/4] mmc: sdhci: Support for SD/MMC Dual Data Rate

** V4 Changes **
sdhci set_ddr does not change signaling voltage when core/
layer indicates this is not needed.  eMMC cards working at 3.3V
do not need to have their i/o signaling level changed since
they are obviously working and 3.3v or lower vccq is supported.
(we do not know if a 3.3V card supports 1.8V vccq).

Similarly eMMC cards working at 1.8V do not need their
signaling voltage changed.

The DDR value on the card only tells us it works at 1.8V or
3.3V or both.

eMMC
Voltage (vcc)  and i/o signaling (vccq) allowed
vcc
3.3V    3.3v vccq  -  1.8v vccq   -   1.2v vccq
1.8V               -  1.8v vccq   -   1.2v vccq
1.2V                              -   1.2v vccq

We have a single voltage eMMC (which is all we support since
dual voltage cards are not supported). We have no idea what
vccq it is operating at.  eMMC cards are usually mounted on the
board.  For a eMMC not operating at 1.2V vccq
we signal the host/ layer to leave
the signaling voltage alone since we are obviously working.
We have no idea if switching the card to 1.8V vccq is
supported by the card.

If the eMMC card indicates it supports 1.2V vccq we
notify the driver since 1.2V core voltage (vcc) is not
supported and a i/o signal voltage change will be needed.
Note:  SD Host Controller (sdhci.c) does not support 1.2V
vcc.

Rules for SD DDR are different.
vccq change occurs after a CMD11.

ddr renamed to uhs.

[PATCH 4/4] sdhci: sdhci-pxa.c: add callback for signaling for DDR
controller needs to have 1.8V signaling voltage bit set
even if not doing 1.8V signaling for DDR to work.

The bit does not change the i/o signaling voltage



