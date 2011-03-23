From: John Calixto <john.calixto@modsystems.com>
Subject: Re: [PATCH resend] mmc: Added ioctl to let userspace apps send
 ACMDs
Date: Tue, 22 Mar 2011 17:44:29 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1103221741140.30367@peruna>
References: <203F41F6E33F954E8E8B02559FDC906F7431FC48EA@modex01> <alpine.DEB.2.00.1103180927390.5267@peruna> <AANLkTimjssCz_U4xbSf+ecoM7RsjC3eGQBo2vabfyy=T@mail.gmail.com> <201103182026.48939.arnd@arndb.de> <AANLkTinKon=D445PEHP2CzeL7OUpf_4y8j0-GA2nmZPt@mail.gmail.com>
 <alpine.DEB.2.00.1103211129130.23727@peruna> <AANLkTimwnS74Ybo6XTLOVUs7pRZBv4+hDgS7i2bfj+HV@mail.gmail.com> <alpine.DEB.2.00.1103221508420.30367@peruna> <AANLkTikHzG3j8oT_aqZ5VAGFxyBBShyPzQTZxvxwkuff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811328-142209471-1300841085=:30367"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-banded.atl.sa.earthlink.net ([209.86.89.70]:33283 "EHLO
	elasmtp-banded.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751677Ab1CWAor (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Mar 2011 20:44:47 -0400
In-Reply-To: <AANLkTikHzG3j8oT_aqZ5VAGFxyBBShyPzQTZxvxwkuff@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, cjb@laptop.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811328-142209471-1300841085=:30367
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 23 Mar 2011, Micha=B3 Miros=B3aw wrote:
> When you grant write access to a device to some user, you should
> expect that it is all you are granting. There shouldn't be any hidden
> doors that, for example, if underlying device is SD card then you can
> destroy it by this ioctl(). Not counting wearing or WORM-like media,
> writes (also erasing, changing encryption keys, etc.) are undoable.
> Other forms of access should be granted separately (by capabilities or
> other means).
>=20

Fair enough.  I'm not aware enough of the other ACMDs that might
actually destroy the card (nothing I'm using will destroy the card), so
I'll be sure to hook it with CAP_SYS_ADMIN (or whatever capability is
most appropriate).

John
---1463811328-142209471-1300841085=:30367--
