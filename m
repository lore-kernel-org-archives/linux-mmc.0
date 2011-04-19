From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [patchv3 2/5] MMC: Use CMD23 for multiblock transfers when we can.
Date: Mon, 18 Apr 2011 22:44:40 -0500
Message-ID: <BANLkTimErvCyAOVW=DgHvRqDZg9EF9QKeg@mail.gmail.com>
References: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
	<1302950458-1969-3-git-send-email-andreiw@motorola.com>
	<201104171923.31039.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og111.obsmtp.com ([64.18.0.22]:50417 "EHLO
	exprod5og111.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282Ab1DSDoo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Apr 2011 23:44:44 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3J3gnkx022188
	for <linux-mmc@vger.kernel.org>; Mon, 18 Apr 2011 23:42:49 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3J3gl1Z022176
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 18 Apr 2011 23:42:48 -0400 (EDT)
Received: by wwb28 with SMTP id 28so6055266wwb.3
        for <linux-mmc@vger.kernel.org>; Mon, 18 Apr 2011 20:44:40 -0700 (PDT)
In-Reply-To: <201104171923.31039.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org, arindam.nath@amd.com, cjb@laptop.org

On Sun, Apr 17, 2011 at 12:23 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 16 April 2011, Andrei Warkentin wrote:
>> @@ -982,6 +1016,26 @@ static const struct mmc_fixup blk_fixups[] =3D
>> =A0 =A0 =A0 =A0 MMC_FIXUP("SEM08G", 0x2, 0x100, add_quirk, MMC_QUIRK=
_INAND_CMD38),
>> =A0 =A0 =A0 =A0 MMC_FIXUP("SEM16G", 0x2, 0x100, add_quirk, MMC_QUIRK=
_INAND_CMD38),
>> =A0 =A0 =A0 =A0 MMC_FIXUP("SEM32G", 0x2, 0x100, add_quirk, MMC_QUIRK=
_INAND_CMD38),
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Some MMC cards experience performance degradation=
 with CMD23
>> + =A0 =A0 =A0 =A0* instead of CMD12-bounded multiblock transfers. Fo=
r now we'll
>> + =A0 =A0 =A0 =A0* white list what's good:
>> + =A0 =A0 =A0 =A0* 1) Certain SanDisk eMMCs with the old MMCA manfid=
=2E
>> + =A0 =A0 =A0 =A0* 2) All new SanDisk products.
>> + =A0 =A0 =A0 =A0*
>> + =A0 =A0 =A0 =A0* N.B. This doesn't affect SD cards.
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 MMC_FIXUP(CID_NAME_ANY, CID_MANFID_ANY, CID_OEMID_ANY,=
 add_quirk_mmc,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_QUIRK_BLK_NO_CMD23),
>> + =A0 =A0 =A0 MMC_FIXUP("SEM04G", 0x2, 0x100, remove_quirk_mmc, MMC_=
QUIRK_BLK_NO_CMD23),
>> + =A0 =A0 =A0 MMC_FIXUP("SEM08G", 0x2, 0x100, remove_quirk_mmc, MMC_=
QUIRK_BLK_NO_CMD23),
>> + =A0 =A0 =A0 MMC_FIXUP("SEM16G", 0x2, 0x100, remove_quirk_mmc, MMC_=
QUIRK_BLK_NO_CMD23),
>> + =A0 =A0 =A0 MMC_FIXUP("SEM32G", 0x2, 0x100, remove_quirk_mmc, MMC_=
QUIRK_BLK_NO_CMD23),
>> + =A0 =A0 =A0 MMC_FIXUP("SEM02G", 0x2, 0x100, remove_quirk_mmc, MMC_=
QUIRK_BLK_NO_CMD23),
>> + =A0 =A0 =A0 MMC_FIXUP(CID_NAME_ANY, 0x45, CID_OEMID_ANY,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 remove_quirk_mmc, MMC_QUIRK_BLK_NO=
_CMD23),
>> +
>> =A0 =A0 =A0 =A0 END_FIXUP
>> =A0};
>
> Shouldn't this better be a blacklist for known bad cards?
>
> As far as I can tell, we should always use CMD23 where possible.
>

I thought about this some more. In this space (eMMCs), it's still
going to be up to the system integrator to evaluate the system and
enable/disable certain properties (such as CMD23 use) as they make
sense. What you would want to avoid, ideally, is someone compiling a
kernel for their pre-2.6.40 embedded system, not knowing anything
amount eMMCs and CMD23, and winding up with an I/O performance
regression.

So maybe this should be a blacklist for known bad cards. And the
entire support should be a "default-N" compile option for MMCs (not
SDs). That way someone who just does an "make oldconfig" will see
"CONFIG_MMC_BLK_CMD23 - I/O performance improvement for newer eMMC
cards, may cause degradation on older cards". What do you think?

A
