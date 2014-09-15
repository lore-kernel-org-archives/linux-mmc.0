From: =?UTF-8?B?R3LDqWdvcnkgU291dGFkw6k=?= <gsoutade@neotion.com>
Subject: [PATCH v6 0000/0003] mmc: EXT_CSD_PARTITION_SETTING_COMPLETED bit
 not checked
Date: Mon, 15 Sep 2014 17:47:03 +0200
Message-ID: <541709F7.1040502@neotion.com>
References: <53C7E45E.2060102@neotion.com>	<CAPDyKFoRpQBHGGCMPvEKdeVGjTO-rnyYVostLZGCV3dudD1rmA@mail.gmail.com>	<53EB2DC3.2080002@neotion.com>	<CAPDyKFpjYqVUZ8GHB76gD8pOx_eMg9ecvbWrMEfbhEd5ffk7mw@mail.gmail.com>	<53ECB95F.2030207@neotion.com> <CAPDyKFp2ekmucHVzMWxeKfyTmuFKTXAYwUEpL5QxvEh8AjFopg@mail.gmail.com> <53F1FBA3.6060108@neotion.com> <5411435C.3080905@neotion.com> <541303B2.7050802@neotion.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.neotion.com ([5.39.84.84]:58444 "EHLO mail.neotion.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752769AbaIOPuN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 15 Sep 2014 11:50:13 -0400
In-Reply-To: <541303B2.7050802@neotion.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

JEDEC standard requires that EXT_CSD_PARTITION_SETTING_COMPLETED bit
must be set in order to take in account enhanced area and general purpo=
se
partitions (gp) values.

Current code doesn't checks this bit and blindly trust enhanced area an=
d
gp values. Moreover, "enhanced_area_en" attribute was set according to =
gp values
but not necessary enhanced area one. It's then used to switch
EXT_CSD_ERASE_GROUP_DEF bit which requires EXT_CSD_PARTITION_SETTING_CO=
MPLETED.
This attribute has been replaced by "partition_setting_completed" that
match the expected behavior.

User is now warned in case of misconfiguration.

Plus, some code has been moved into functions for two reasons :
* Functional reason (one behavior per function)
* Deep indentation result

Gr=C3=A9gory Soutad=C3=A9 (3):
  mmc: Move code that manages user area and gp partitions into function=
s
  mmc: Replace "enhanced_area_en" attribute by "partition_setting_compl=
eted"
  mmc: Checks EXT_CSD_PARTITION_SETTING_COMPLETED before partitions com=
putation

 drivers/mmc/core/mmc.c   |  172 ++++++++++++++++++++++++++------------=
--------
 include/linux/mmc/card.h |    2 +-
 include/linux/mmc/mmc.h  |    2 +
 3 files changed, 102 insertions(+), 74 deletions(-)

=46rom commit 7ec62d421bdf29cb31101ae2689f7f3a9906289a in master linux =
tree.

Changelog v5:
	Remove some useless braces
Changelog v4:
	Second patch in v3 doesn't compile
Changelog v3:
	Move code BEFORE fixing bugs.
Changelog v2:
	Move code for user area and general purpose partitions
	into functions.
--=20
1.7.9.5
