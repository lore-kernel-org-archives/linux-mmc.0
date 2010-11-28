From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 2/3] mmc: sdio: don't reinitialize nonremovable
 powered-resumed cards
Date: Sun, 28 Nov 2010 10:46:15 +0200
Message-ID: <AANLkTimq7pFOniQECotBL_zSA+RGHGfT3q2JHi+Q61qx@mail.gmail.com>
References: <1290921690-6133-1-git-send-email-ohad@wizery.com>
 <1290921690-6133-3-git-send-email-ohad@wizery.com> <AANLkTiko9brvK33=GjzJgzGdmoufyNn=_mCNfUFAP-dT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62413 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750Ab0K1Iqg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 28 Nov 2010 03:46:36 -0500
Received: by iwn5 with SMTP id 5so642239iwn.19
        for <linux-mmc@vger.kernel.org>; Sun, 28 Nov 2010 00:46:35 -0800 (PST)
In-Reply-To: <AANLkTiko9brvK33=GjzJgzGdmoufyNn=_mCNfUFAP-dT@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

2010/11/28 Micha=C5=82 Miros=C5=82aw <mirqus@gmail.com>:

<snip>

>> +
>> + =C2=A0 =C2=A0 =C2=A0 /* No need to reinitialize powered-resumed no=
nremovable cards */
>> + =C2=A0 =C2=A0 =C2=A0 if (mmc_card_is_removable(host) || !mmc_card_=
is_powered_resumed(host))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D mmc_sdio_=
init_card(host, host->ocr, host->card,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (host->pm_flags & MMC_PM_KEE=
P_POWER));
>
> You can use mmc_card_is_powered_resumed() here, too.

Yeah. there are additional incarnations, too. that's why I noted that:

>> I have not switched all existing code to mmc_card_is_powered_resumed=
(),
>> I can do that as a subsequent clean up patch.
