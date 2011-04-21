From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6] mmc: Add mmc CMD+ACMD passthrough ioctl
Date: Thu, 21 Apr 2011 13:15:51 +0200
Message-ID: <201104211315.51984.arnd@arndb.de>
References: <alpine.DEB.2.00.1104131713570.15392@peruna> <201104210711.15457.arnd@arndb.de> <BANLkTinuzNRUOKOVY+SOqJ3fjjfKFUhNdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:58352 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114Ab1DULPz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 07:15:55 -0400
In-Reply-To: <BANLkTinuzNRUOKOVY+SOqJ3fjjfKFUhNdA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?iso-8859-2?q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Cc: John Calixto <john.calixto@modsystems.com>, linux-mmc@vger.kernel.org, Andrei Warkentin <andreiw@motorola.com>, Chris Ball <cjb@laptop.org>

On Thursday 21 April 2011, Micha=B3 Miros=B3aw wrote:
> Subject: Re: [PATCH v4] mmc: Add ioctl to let userspace apps send ACM=
Ds
> Date: Wed, 13 Apr 2011 01:00:39 +0200
> Message-Id: <201104130100.39810.arnd@arndb.de>
>=20
> Then I already provided an example of implementation that's
> independent of endianness and avoids casts on userspace.
>=20

Yes, v4 got that aspect right, as far as I can tell, aside
from an incorrect cast (u8* instead of u8 __user *).

	Arnd
