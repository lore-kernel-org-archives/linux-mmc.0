From: John Calixto <john.calixto@modsystems.com>
Subject: Re: [PATCH v6] mmc: Add mmc CMD+ACMD passthrough ioctl
Date: Wed, 20 Apr 2011 10:38:02 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104201034170.28189@peruna>
References: <alpine.DEB.2.00.1104131713570.15392@peruna> <alpine.DEB.2.00.1104131737280.15392@peruna> <BANLkTim4VUmQmWEVJahhw4yfXiSmXi+K0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811328-1050589184-1303320937=:28189"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-dupuy.atl.sa.earthlink.net ([209.86.89.62]:47941 "EHLO
	elasmtp-dupuy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751630Ab1DTRiK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2011 13:38:10 -0400
In-Reply-To: <BANLkTim4VUmQmWEVJahhw4yfXiSmXi+K0g@mail.gmail.com>
Content-ID: <alpine.DEB.2.00.1104201036550.28189@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Cc: linux-mmc@vger.kernel.org, Andrei Warkentin <andreiw@motorola.com>, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811328-1050589184-1303320937=:28189
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1104201036551.28189@peruna>

Hi Michal,

On Wed, 20 Apr 2011, Micha=B3 Miros=B3aw wrote:
>=20
> So... again... What's the problem with anonymous union of pointer and u64=
?
>=20

As Arnd pointed out, this would not work for big endian machines.

John
---1463811328-1050589184-1303320937=:28189--
