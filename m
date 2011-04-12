From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4] mmc: Add ioctl to let userspace apps send ACMDs
Date: Wed, 13 Apr 2011 01:00:39 +0200
Message-ID: <201104130100.39810.arnd@arndb.de>
References: <alpine.DEB.2.00.1104111424140.32082@peruna> <alpine.DEB.2.00.1104111450340.32082@peruna> <BANLkTimn3vB1JaBfboOL0ayG2FpXsUMe7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:54294 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755572Ab1DLXAy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2011 19:00:54 -0400
In-Reply-To: <BANLkTimn3vB1JaBfboOL0ayG2FpXsUMe7w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?iso-8859-2?q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Cc: John Calixto <john.calixto@modsystems.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Andrei Warkentin <andreiw@motorola.com>

On Tuesday 12 April 2011, Micha=B3 Miros=B3aw wrote:
> > +       unsigned int cmd_timeout_ms;
> > +       __u64 data_ptr;  /* DAT buffer */
>=20
> This will be more natural if you have an anonymous union here:
> union {
>   __u64 data_ptr_
>  void *data_ptr;
> };

No, that really does not work. It's important for all members of the io=
ctl data
structure to have a fixed size, independent of the size of long or poin=
ter.

If you do a union, the pointer ends up in the first 32 bits of the 64 b=
it member,
which does not work on big-endian architectures. It also doesn't work o=
n 31
bit architectures, although that is a minor worry here.

	Arnd
