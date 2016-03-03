From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 0/4] Add enhanced strobe support for emmc version 5.1 or later
Date: Thu,  3 Mar 2016 10:35:57 +0800
Message-ID: <1456972557-7994-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:60413 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755392AbcCCCnv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Mar 2016 21:43:51 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>


Hello Ulf and Adrian,

This RFC patch is going to support enhanced strobe function
for emmc version 5.1+ introduced by JEDEC recently.

=46irstly=EF=BC=8Cfrom the former discussion of sdhci, I write these co=
de
inspired by Adrian's patch[0] for variant drivers to overwrite the
callback in order not to add new callback into sdhci. And enchanced
strobe is a optional function, so we add a new cap* for drivers to
decide whether to use it.

1. History
   When introduing hs400 mode, JEDEC asks controllers to use data strob=
e line
to latch the data from emmc devives. But for cmd-reponse, not mentioned=
 yet.
Since emmc version 5.1 published, JEDEC adds enhanced strobe function t=
o deal
with cmd-response the same way as dara-read. This feature is optional.

2. Current situation
   I can't find a upstreamed controller claimed to support it, as well =
as the
mmc stack. But my "arasan,sdhci-5.1" actially supports this function. S=
o I decide
to work for this part.

3. About the code
   1)This patchset is taken from Yi Sun's patch[1], but after reviewing=
 the details
and applying to test, I find some problems. We ask devices to switch to=
 enhanced
strobe mode, but we don't notify drivers to enable enhanced strobe mode=
=2E And we can't
force controller to use enhanced strobe even if devices claims to suppo=
rt it. So I
rework most of the code and take over the ownership from Yi Sun(If any =
objections
here, please let know).
   2)By looking into the SDHCI spec, I find there isn't any registers t=
o enable the
enhanced strobe function. But from my "arasan,sdhci-5.1" databook, it d=
escribes a
register called VENDOR_REGISTER(0x78) to trigger this mode. So I guess =
other sdhci
variant drivers may also need s vendor specific register to deal with i=
t.

4. Howto
   If we are sure that our controller supports enhanced strobe mode, ju=
st add
cap-enhanced-strobe in DT. Once emmc devices claims to support this mod=
e,
we enable it automatically. Of course, other sdhci*/non-sdhci drivers s=
hould
implement/overwrite the prepare_enhanced_strobe by themselves. I believ=
e all of the
platforms which need to support this mode should do some basic preparat=
ion for their
controllers.

Reference:
[0]: https://patchwork.kernel.org/patch/8262231/
[1]: https://patchwork.kernel.org/patch/6545421/



Shawn Lin (4):
  mmc: core: add cap-enhanced-strobe support
  mmc: core: implement enhanced strobe support
  mmc: sdhci: implement enhanced strobe callback
  mmc: sdhci-of-arasan: overwrite enhanced strobe callback

 Documentation/devicetree/bindings/mmc/mmc.txt |  1 +
 drivers/mmc/core/host.c                       |  2 +
 drivers/mmc/core/mmc.c                        | 54 +++++++++++++++++++=
+++++++-
 drivers/mmc/host/sdhci-of-arasan.c            | 20 ++++++++++
 drivers/mmc/host/sdhci.c                      | 11 ++++++
 include/linux/mmc/card.h                      |  1 +
 include/linux/mmc/host.h                      |  8 ++++
 include/linux/mmc/mmc.h                       |  2 +
 8 files changed, 98 insertions(+), 1 deletion(-)

--=20
2.3.7


