From: Philip Rakity <prakity@marvell.com>
Subject: Re: Patch: eMMC boot partition needs to be deactivated for linux to
 find user partitions
Date: Fri, 19 Mar 2010 22:12:22 -0700
Message-ID: <3A9599CE-49EE-4A18-89E0-22B17090CA43@marvell.com>
References: <43E4817426ED174AA81263BCECB4351D131745CF98@sc-vexch3.marvell.com>
 <53E1B390-48DD-4E33-B51F-1B039AFD13A2@marvell.com>
 <4B9DEAE2.3030707@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_3A9599CE49EE4A1889E022B17090CA43marvellcom_"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia2.marvell.com ([65.219.4.35]:56819 "EHLO
	dakia2.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab0CTFMZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 20 Mar 2010 01:12:25 -0400
In-Reply-To: <4B9DEAE2.3030707@nokia.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Nicolas Pitre <nico@marvell.com>, Lennert Buijtenhek <buytenh@marvell.com>, Andrew Morton <akpm@linux-foundation.org>

--_002_3A9599CE49EE4A1889E022B17090CA43marvellcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Adrian,

Thank you for the feedback.  I have amended the patch.  I tested the patch =
against mmc4.3 or earlier cards and it works.
Your comment about the switch boot config not being supported by earlier ca=
rds is handled by NOT checking for any errors.=20

The reason the patch is needed is because when our  boot loader gets loaded=
 from the private boot area, it sets the partition to the private boot area=
 and then hands control to a secondary loader.  Normally our boot loader wo=
uld disable access to the partition once boot code was loaded in before pas=
sing control to linux but if the process is stopped or the kernel is loaded=
 from another device the partition number is not reset. =20

We can fix this but it seems good practice for linux to reset the flash to =
a normal state.

The other concerns I believe were addressed earlier.  The trace showing wha=
t was happening with and without the patch.

regards,
Philip

signed-off-by: Philip Rakity <prakity@marvell.com>
diff -ru linux-2.6.32.8/drivers/mmc/core/mmc.c linux-2.6.32.8 copy/drivers/=
mmc/core/mmc.c
--- linux-2.6.32.8/drivers/mmc/core/mmc.c	2010-02-09 04:57:19.000000000 -08=
00
+++ linux-2.6.32.8 copy/drivers/mmc/core/mmc.c	2010-03-12 20:56:16.00000000=
0 -0800
@@ -430,6 +432,13 @@
 	}
=20
 	/*
+	* ensure eMMC private booting PARTITION is not enabled
+	*/
+	mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+		EXT_CSD_BOOT_CONFIG, 0x0);
+
+	/*
 	 * Compute bus speed.
 	 */
 	max_dtr =3D (unsigned int)-1;
diff -ru linux-2.6.32.8/include/linux/mmc/mmc.h linux-2.6.32.8 copy/include=
/linux/mmc/mmc.h
--- linux-2.6.32.8/include/linux/mmc/mmc.h	2010-02-09 04:57:19.000000000 -0=
800
+++ linux-2.6.32.8 copy/include/linux/mmc/mmc.h	2010-03-12 20:53:48.0000000=
00 -0800
@@ -251,6 +252,7 @@
  * EXT_CSD fields
  */
=20
+#define EXT_CSD_BOOT_CONFIG	179 /* R/W */
 #define EXT_CSD_BUS_WIDTH	183	/* R/W */
 #define EXT_CSD_HS_TIMING	185	/* R/W */
 #define EXT_CSD_CARD_TYPE	196	/* RO */



On Mar 15, 2010, at 1:08 AM, Adrian Hunter wrote:

> Philip Rakity wrote:
>> Some eMMC chips have a boot partition that is meant to be used to load i=
n low level boot code.
>> This partition is available when the chip is powered up.  Normally the b=
oot loader would disable
>> access to the partition once boot code was loaded in before passing cont=
rol to linux. =20
>>=20
>> if booting occurs from another device (not the eMMC chip) the partition =
will not be disabled by
>> the boot loader and control will be passed to linux.  This will cause li=
nux to not recognize user
>> partitions on the chip unless access to the boot partition is deactivate=
d.
>>=20
>> See JEDEC Standard 84-A44 (eMMC 4.4 spec) -- Page 139
>=20
> Page 139 doesn't say anything about why you need that switch command.
> Please provide a more useful reference or delete this.
>=20
> Boot mode is terminated by CMD1, so that switch command should not
> be needed.  Please explain why it is needed in more detail.
>=20
> That switch command should not be used for devices that do not
> support it e.g. eMMC 4.3 and before.
>=20
>=20
>>=20
>> signed off by:  Philip Rakity <prakity@marvell.com>
>> diff -ru linux-2.6.32.8/drivers/mmc/core/mmc.c linux-2.6.32.8 copy/drive=
rs/mmc/core/mmc.c
>> --- linux-2.6.32.8/drivers/mmc/core/mmc.c	2010-02-09 04:57:19.000000000 =
-0800
>> +++ linux-2.6.32.8 copy/drivers/mmc/core/mmc.c	2010-03-12 20:56:16.00000=
0000 -0800
>> @@ -430,6 +432,13 @@
>> 	}
>>=20
>> 	/*
>> +	* ensure eMMC private booting PARTITION is not enabled
>> +	* see JEDEC Standard No. 84-A44 - Page 139=20
>> +	*/
>> +	mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> +		EXT_CSD_BOOT_CONFIG, 0x0);
>> +
>> +	/*
>> 	 * Compute bus speed.
>> 	 */
>> 	max_dtr =3D (unsigned int)-1;
>> diff -ru linux-2.6.32.8/include/linux/mmc/mmc.h linux-2.6.32.8 copy/incl=
ude/linux/mmc/mmc.h
>> --- linux-2.6.32.8/include/linux/mmc/mmc.h	2010-02-09 04:57:19.000000000=
 -0800
>> +++ linux-2.6.32.8 copy/include/linux/mmc/mmc.h	2010-03-12 20:53:48.0000=
00000 -0800
>> @@ -251,6 +252,7 @@
>>  * EXT_CSD fields
>>  */
>>=20
>> +#define EXT_CSD_BOOT_CONFIG	179 /* R/W */
>> #define EXT_CSD_BUS_WIDTH	183	/* R/W */
>> #define EXT_CSD_HS_TIMING	185	/* R/W */
>> #define EXT_CSD_CARD_TYPE	196	/* RO */
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>=20
>=20

--_002_3A9599CE49EE4A1889E022B17090CA43marvellcom_
Content-Type: text/plain; name="eMMCPartitionPatch.txt"
Content-Description: eMMCPartitionPatch.txt
Content-Disposition: attachment; filename="eMMCPartitionPatch.txt"; size=1030;
	creation-date="Fri, 19 Mar 2010 22:12:23 GMT";
	modification-date="Fri, 19 Mar 2010 22:12:23 GMT"
Content-Transfer-Encoding: base64

c2lnbmVkLW9mZi1ieTogUGhpbGlwIFJha2l0eSA8cHJha2l0eUBtYXJ2ZWxsLmNvbT4NCmRpZmYg
LXJ1IGxpbnV4LTIuNi4zMi44L2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMgbGludXgtMi42LjMyLjgg
Y29weS9kcml2ZXJzL21tYy9jb3JlL21tYy5jDQotLS0gbGludXgtMi42LjMyLjgvZHJpdmVycy9t
bWMvY29yZS9tbWMuYwkyMDEwLTAyLTA5IDA0OjU3OjE5LjAwMDAwMDAwMCAtMDgwMA0KKysrIGxp
bnV4LTIuNi4zMi44IGNvcHkvZHJpdmVycy9tbWMvY29yZS9tbWMuYwkyMDEwLTAzLTEyIDIwOjU2
OjE2LjAwMDAwMDAwMCAtMDgwMA0KQEAgLTQzMCw2ICs0MzIsMTMgQEANCiAJfQ0KIA0KIAkvKg0K
KwkqIGVuc3VyZSBlTU1DIHByaXZhdGUgYm9vdGluZyBQQVJUSVRJT04gaXMgbm90IGVuYWJsZWQN
CisJKi8NCisJbW1jX3N3aXRjaChjYXJkLCBFWFRfQ1NEX0NNRF9TRVRfTk9STUFMLA0KKwkJRVhU
X0NTRF9CT09UX0NPTkZJRywgMHgwKTsNCisNCisJLyoNCiAJICogQ29tcHV0ZSBidXMgc3BlZWQu
DQogCSAqLw0KIAltYXhfZHRyID0gKHVuc2lnbmVkIGludCktMTsNCmRpZmYgLXJ1IGxpbnV4LTIu
Ni4zMi44L2luY2x1ZGUvbGludXgvbW1jL21tYy5oIGxpbnV4LTIuNi4zMi44IGNvcHkvaW5jbHVk
ZS9saW51eC9tbWMvbW1jLmgNCi0tLSBsaW51eC0yLjYuMzIuOC9pbmNsdWRlL2xpbnV4L21tYy9t
bWMuaAkyMDEwLTAyLTA5IDA0OjU3OjE5LjAwMDAwMDAwMCAtMDgwMA0KKysrIGxpbnV4LTIuNi4z
Mi44IGNvcHkvaW5jbHVkZS9saW51eC9tbWMvbW1jLmgJMjAxMC0wMy0xMiAyMDo1Mzo0OC4wMDAw
MDAwMDAgLTA4MDANCkBAIC0yNTEsNiArMjUyLDcgQEANCiAgKiBFWFRfQ1NEIGZpZWxkcw0KICAq
Lw0KIA0KKyNkZWZpbmUgRVhUX0NTRF9CT09UX0NPTkZJRwkxNzkgLyogUi9XICovDQogI2RlZmlu
ZSBFWFRfQ1NEX0JVU19XSURUSAkxODMJLyogUi9XICovDQogI2RlZmluZSBFWFRfQ1NEX0hTX1RJ
TUlORwkxODUJLyogUi9XICovDQogI2RlZmluZSBFWFRfQ1NEX0NBUkRfVFlQRQkxOTYJLyogUk8g
Ki8NCg==

--_002_3A9599CE49EE4A1889E022B17090CA43marvellcom_--
