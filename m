From: Sean Straw <sstraw@enphaseenergy.com>
Subject: Setting write reliability on eMMC
Date: Tue, 24 Jan 2017 23:21:18 +0000
Message-ID: <50cb93608f8e4dcea790bf702b57d4bf23aafa4a0b9b4adaabedd4a0a5a6c0e6BY2PR0201MB192782C9A6415501890E694EC3750@BY2PR0201MB1927.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-co1nam03on0136.outbound.protection.outlook.com ([104.47.40.136]:18464
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750782AbdAXXVV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 24 Jan 2017 18:21:21 -0500
Content-Language: en-US
Content-ID: <D97D846CA72687438073630629647161@namprd02.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


I'm trying to enable write reliability on the (default) user partition of a=
n eMMC 4.41 device in the hopes that it might help to prevent flash corrupt=
ion during unwanted power cycling.  The device is an ARM system not too dis=
similar from a BeagleBone Black.

I have used the mmc-util package, but I receive an error when setting the r=
egister.  The intended setting can be read in the extcsd subsequent to a po=
wer cycle, but as partitioning is incomplete, I have no confidence that the=
 device is in fact operating  in reliable write mode.  I searched for an ap=
propriate discussion forum for the mmc-util itself, but could find none.  I=
 contacted (days apart) two different contributors who had contributed code=
 relevant to this setting (both write reliability and continue  vs. finaliz=
ing the OTP operation), but have yet to receive any acknowledgement (not ev=
en an RTFM).

I realize that this here is a discussion forum for development of mmc suppo=
rt for linux, and not a support forum for mmc-utils itself, but surely sett=
ing this feature should not be shrouded in the dark arts?  I need to be abl=
e to set it and know it is in  effect so that I can run testing on the devi=
ce.  Since it is an OTP (One Time Programming) operation, every time I atte=
mpt to set the feature the device I'm using is then in a partially programm=
ed state (although I have tried both completion and continuation  flags), a=
nd I cannot expect to set the write reliability again without receiving an =
error, so I've got to abuse yet another device for the next iteration.


mmc write_reliability set -y 0 /dev/mmcblk0


Done setting EXT_CSD_WR_REL_SET to 0x01 on /dev/mmcblk0
setting OTP PARTITION_SETTING_COMPLETED!
Setting OTP PARTITION_SETTING_COMPLETED failed on /dev/mmcblk0
Note that I'm not getting an "device is already partitioned" (which would b=
e expected if I tried to update the setting on a device I'd already tried s=
etting it on, but I don't even get that error after a power cycle), or anyt=
hing about the WR_REL_SET being  read-only.

Once set, I can do nothing to _unset_ it, so it seems reasonable that it's =
been stored in the OTP, but why the error when setting, and also in the ext=
csd:


Partitioning Setting [PARTITION_SETTING_COMPLETED]: 0x00
 Device partition setting NOT complete
General Purpose Partition Size
 [GP_SIZE_MULT_4]: 0x000000
 [GP_SIZE_MULT_3]: 0x000000
 [GP_SIZE_MULT_2]: 0x000000
 [GP_SIZE_MULT_1]: 0x000000


I can post more output if needed.  I would greatly appreciate any insight a=
nyone might offer here.

Apologies in advance for the IT-inserted footer below.
 The information contained in this message may be privileged and confidenti=
al. It is intended to be read only by the individual or entity to whom it i=
s addressed or by their designee. If the reader of this message is not the =
intended recipient, you are on notice  that any distribution of this messag=
e, in any form, is strictly prohibited. If you have received this message i=
n error, please immediately notify the sender and delete or destroy any cop=
y of this message!
The information contained in this message may be privileged and confidentia=
l. It is intended to be read only by the individual or entity to whom it is=
 addressed or by their designee. If the reader of this message is not the i=
ntended recipient, you are on notice that any distribution of this message,=
 in any form, is strictly prohibited. If you have received this message in =
error, please immediately notify the sender and delete or destroy any copy =
of this message!
