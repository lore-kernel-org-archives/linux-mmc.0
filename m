From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH V2 0/2] sdhci: Dual Data Rate Support
Date: Thu, 20 Jan 2011 20:27:05 -0800
Message-ID: <F4765FB0-0EBF-42C5-8D69-8E91D6700EBA@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:55528 "HELO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751827Ab1AUE1J convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 20 Jan 2011 23:27:09 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Zhangfei Gao <zhangfei.gao@gmail.com>, Mark Brown <markb@marvell.com>

[PATCH 1/3] sdhci: register defs for sd 3.0 HOST CONTROL 2
adds the definitions needed for HOST_CONTROL_2 Register

[PATCH 2/3] mmc and sdhci:

sdhci set_ddr does not change signaling voltage when core/
layer indicates this is not needed.  eMMC cards working at 3.3V
do not need to have their i/o signaling level changed since
they are obviously working and 3.3v or lower vccq is supported.

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

[PATCH 3/3] sdhci:
add support sdhci-pxa for testing.  The callback is
needed since the Marvell controller requires V18_EN
to be set for DDR.  The controller does not change
the i/o signaling voltage (vccq).

