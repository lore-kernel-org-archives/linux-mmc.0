From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [v5 4/5] MMC: Block CMD23 support for UHS104/SDXC cards.
Date: Fri, 20 May 2011 13:09:30 -0500
Message-ID: <BANLkTikGU_ttmmnku1YdvTchuJ0q3hpMfA@mail.gmail.com>
References: <1303870235-29041-1-git-send-email-andreiw@motorola.com>
	<1305841590-26963-5-git-send-email-andreiw@motorola.com>
	<6C03668EAF45B747AF947A1603D1B300011BEA692F@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og108.obsmtp.com ([64.18.0.186]:60099 "EHLO
	exprod5og108.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934312Ab1ETSJc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 May 2011 14:09:32 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.167])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p4KI7Aq2026792
	for <linux-mmc@vger.kernel.org>; Fri, 20 May 2011 14:07:10 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p4KI5hhE026185
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Fri, 20 May 2011 14:07:10 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so3554449wyb.15
        for <linux-mmc@vger.kernel.org>; Fri, 20 May 2011 11:09:30 -0700 (PDT)
In-Reply-To: <6C03668EAF45B747AF947A1603D1B300011BEA692F@SAUSEXMBP01.amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Nath, Arindam" <Arindam.Nath@amd.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "arnd@arndb.de" <arnd@arndb.de>, "malchev@google.com" <malchev@google.com>

On Fri, May 20, 2011 at 5:38 AM, Nath, Arindam <Arindam.Nath@amd.com> w=
rote:
> Hi Andrei,
>
>
> [...]
>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>> index 596d0b9..efff41d 100644
>> --- a/drivers/mmc/core/sd.c
>> +++ b/drivers/mmc/core/sd.c
>> @@ -203,6 +203,13 @@ static int mmc_decode_scr(struct mmc_card *card=
)
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->erased_byte =3D 0x0;
>>
>> + =A0 =A0 if (scr->sda_vsn =3D=3D SCR_SPEC_VER_2) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Check if Physical Layer Spec v3.0X is s=
upported. */
>> + =A0 =A0 =A0 =A0 =A0 =A0 scr->sda_spec3 =3D UNSTUFF_BITS(resp, 47, =
1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (scr->sda_spec3)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scr->cmds =3D UNSTUFF_BITS=
(resp, 32, 2);
>> + =A0 =A0 }
>
> There is already this condition checking (=3D=3D SCR_SPEC_VER_2) in m=
mc_decode_scr(). So can you please make your changes appropriately?

Ok, will clean it up.

A
