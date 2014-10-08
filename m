From: Philippe De Muyter <phdm@macq.eu>
Subject: Re: [PATCH 2/2] mmc: Allow setting slot index via devicetree alias
Date: Wed, 8 Oct 2014 12:53:35 +0200
Message-ID: <20141008105335.GA22323@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp2.macqel.be ([109.135.2.61]:57728 "EHLO smtp2.macqel.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755369AbaJHLCa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 8 Oct 2014 07:02:30 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Dong Aisheng <b29396@freescale.com>

Hi Sascha and Dong,

On 2014-05-22 15:30:23, Sascha Hauer wrote:

> If the aliases-node is not found, the driver will act as before.

and the commit (5f9447e5d97060207c4742d5a06e5548de45972d, by Dong Aisheng)
in imx_3.10.31_1.1.0_beta adds :

    The original patch is from here:
    https://www.mail-archive.com/linux-mmc@vger.kernel.org/msg26472.html

    The patch requires additional alias_id fix or it won't work.
    Because according to function definition the max_idx parameter of idx_alloc
    is exclusive, so need add 1 or it will be unable to find the proper idx
    within an invalid range.

I have just upgraded my imx kernel from imx_3.10.17_1.0.0_beta
to imx_3.10.31_1.1.0_beta, but now my new kernel refuses to boot because
it does not find its root fs, because the numbering of the mmc devices
has changed, although I did not add alias id's in my dts file.

Here is what I get :

  Kernel command line: console=ttymxc0,115200 root=/dev/mmcblk0p2 rootwait rw
  ...
  with old method, idx would have been 0
  with new method, idx is 1
  mmcblk1: mmc1:1234 SA04G 3.63 GiB
   mmcblk1: p1 p2
  mmc3: BKOPS_EN bit is not set
  mmc3: new high speed DDR MMC card at address 0001
  with old method, idx would have been 1
  with new method, idx is 3
  mmcblk3: mmc3:0001 MMC04G 3.57 GiB
  mmcblk3boot0: mmc3:0001 MMC04G partition 1 2.00 MiB
  mmcblk3boot1: mmc3:0001 MMC04G partition 2 2.00 MiB
  mmcblk3rpmb: mmc3:0001 MMC04G partition 3 128 KiB
   mmcblk3: unknown partition table
   mmcblk3boot1: unknown partition table
   mmcblk3boot0: unknown partition table
  ...
  Waiting for root device /dev/mmcblk0p2...

Additional debug is mine.

Is there a fix available to preserve the old numbering if no alias has been
defined ?

TIA

Philippe
