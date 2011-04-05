From: John Calixto <john.calixto@modsystems.com>
Subject: Re: [PATCH v2 2/2] mmc: Check CAP_SYS_ADMIN for destructive ioctl
 ACMDs
Date: Tue, 5 Apr 2011 16:46:54 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104051644150.25803@peruna>
References: <alpine.DEB.2.00.1104051458350.25803@peruna> <BANLkTi=xcPEJxophfymqF5+Nd=aF40H=FQ@mail.gmail.com> <BANLkTi=z=_kCgqPk3mRxXBwHibH_O61Jdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811328-18428946-1302047221=:25803"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-junco.atl.sa.earthlink.net ([209.86.89.63]:45878 "EHLO
	elasmtp-junco.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751996Ab1DEXrE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2011 19:47:04 -0400
In-Reply-To: <BANLkTi=z=_kCgqPk3mRxXBwHibH_O61Jdw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811328-18428946-1302047221=:25803
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 5 Apr 2011, Andrei Warkentin wrote:
> Let me clarify, this is what the MMC spec says:
>=20
>=20
>       The only effect of the APP_CMD is that if the command index of
> the, immediately, following command
>       has an ACMD overloading, the non standard version will used. If,
> as an example, a card has a definition
>       for ACMD13 but not for ACMD7 then, if received immediately after
> APP_CMD command, Command 13
>       will be interpreted as the non standard ACMD13 but, command 7 as
> the standard CMD7.
>       In order to use one of the manufacturer specific ACMD=92s the host =
will:
>       * Send APP_CMD. The response will have the APP_CMD bit (new
> status bit) set signaling
> ...
> ...
> ...
>       If a non valid command is sent (neither ACMD nor CMD) then it
> will be handled as a standard
>       MultiMediaCard illegal command error.
>=20
> This means, since an MMC card doesn't support ACMD25 or ACMD38, these
> will be executed as CMD25 or CMD38. I.e. - it's an attack vector.
>=20

Ah I see.  OK, that makes sense.  I'll check to make sure to check that
the allowed ACMDs are just for SD cards.

Thanks for catching that!

John
---1463811328-18428946-1302047221=:25803--
