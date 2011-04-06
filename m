From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: Check CAP_SYS_ADMIN for destructive ioctl ACMDs
Date: Wed, 6 Apr 2011 12:14:30 +0200
Message-ID: <BANLkTinG2Zty-VqnKD4c=-DYuML9ZxBeNg@mail.gmail.com>
References: <alpine.DEB.2.00.1104051458350.25803@peruna> <BANLkTi=xcPEJxophfymqF5+Nd=aF40H=FQ@mail.gmail.com>
 <alpine.DEB.2.00.1104051613150.25803@peruna> <BANLkTi=wXpqFGhaBPnoRa+sQJ_eysvrTVA@mail.gmail.com>
 <alpine.DEB.2.00.1104051733180.25803@peruna>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:48303 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755285Ab1DFKOv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Apr 2011 06:14:51 -0400
Received: by pxi2 with SMTP id 2so730182pxi.10
        for <linux-mmc@vger.kernel.org>; Wed, 06 Apr 2011 03:14:51 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1104051733180.25803@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: Andrei Warkentin <andreiw@motorola.com>, linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>

2011/4/6 John Calixto <john.calixto@modsystems.com>:
> On Tue, 5 Apr 2011, Andrei Warkentin wrote:
>> Could you check the SD behavior for undefined ACMDs? If I do ACMD25,
>> and ACMD25 is not defined, will it be executed as CMD25? This is the
>> MMC behavior as I have mentioned.
> The SD spec has a similar paragraph about unspecified ACMD opcodes -
> they should be treated as the equivalent CMD opcodes. =C2=A0However, =
all of
> the opcodes that I listed are indeed specified. =C2=A0So, if the card
> identifies itself as an SD card, it must implement those opcodes. =C2=
=A0If
> it identifies itself as an SD card, and it does *not* implement the A=
CMD
> opcodes I listed, then it likely "fell out the back door of the
> manufacturing facility and landed on a store shelf" ;) ... its
> quality/correct performance/reliability is unlikely.

Not all specified ACMDs are mandatory. SD spec 2.00 says that only
6,13,41,42,51 are mandatory for all cards. This is less than the list
you prepared in the patch.

It's better not to make those exceptions and instead prepare an
userspace daemon that opens mmcblkX (non-exclusively) and forwards the
requests from unprivileged users to the device (or even implements
application specific API).

Best Regards,
Micha=C5=82 Miros=C5=82aw
