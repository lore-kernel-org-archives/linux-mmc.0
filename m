From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH resend] mmc: Added ioctl to let userspace apps send ACMDs
Date: Wed, 23 Mar 2011 08:57:32 +0100
Message-ID: <201103230857.32442.arnd@arndb.de>
References: <203F41F6E33F954E8E8B02559FDC906F7431FC48EA@modex01> <AANLkTikHzG3j8oT_aqZ5VAGFxyBBShyPzQTZxvxwkuff@mail.gmail.com> <alpine.DEB.2.00.1103221741140.30367@peruna>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:50831 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754410Ab1CWH7O (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Mar 2011 03:59:14 -0400
In-Reply-To: <alpine.DEB.2.00.1103221741140.30367@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirqus@gmail.com>, linux-mmc@vger.kernel.org, cjb@laptop.org

On Wednesday 23 March 2011, John Calixto wrote:
>=20
> On Wed, 23 Mar 2011, Micha=C5=82 Miros=C5=82aw wrote:
> > When you grant write access to a device to some user, you should
> > expect that it is all you are granting. There shouldn't be any hidd=
en
> > doors that, for example, if underlying device is SD card then you c=
an
> > destroy it by this ioctl(). Not counting wearing or WORM-like media=
,
> > writes (also erasing, changing encryption keys, etc.) are undoable.
> > Other forms of access should be granted separately (by capabilities=
 or
> > other means).
> >=20
>=20
> Fair enough.  I'm not aware enough of the other ACMDs that might
> actually destroy the card (nothing I'm using will destroy the card), =
so
> I'll be sure to hook it with CAP_SYS_ADMIN (or whatever capability is
> most appropriate).

The standard defines some commands as vendor-specific. A typical use
case for these would be a way to update the firmware on the embedded
microcontroller of the card.

Overwriting that firmware with garbage would be an obvious way to
brick the card.

	Arnd
