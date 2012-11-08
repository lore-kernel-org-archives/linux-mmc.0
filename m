From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v7 0/3] Add modules to support realtek PCIE card reade
Date: Thu, 8 Nov 2012 12:34:43 +0000
Message-ID: <201211081234.43449.arnd@arndb.de>
References: <cover.1351481260.git.wei_wang@realsil.com.cn> <1352347282.60054.YahooMailNeo@web121002.mail.ne1.yahoo.com> <509B4363.7080905@realsil.com.cn>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:60292 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118Ab2KHMfD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Nov 2012 07:35:03 -0500
In-Reply-To: <509B4363.7080905@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: wwang <wei_wang@realsil.com.cn>
Cc: Alex Dubov <oakad@yahoo.com>, Chris Ball <cjb@laptop.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "bp@alien8.de" <bp@alien8.de>

On Thursday 08 November 2012, wwang wrote:
>=20
> =E4=BA=8E 2012=E5=B9=B411=E6=9C=8808=E6=97=A5 12:01, Alex Dubov =E5=86=
=99=E9=81=93:
> > Hi,
> >> Do you have any comment on the MEMSTICK part in this v7 patchset? =
Can
> >> you help to merge the patch to the kernel tree?
> >
> > I'm afraid that presently I don't have much time to look at the mem=
stick related stuff any further. Hopefully, somebody else can step in a=
nd take a look at your submission.
> >
> > Sorry for that.
> >
> Hi Greg & Arnd:
>=20
> Can you help to review the MEMSTICK part in my patch and merge it to =
the=20
> kernel tree? Alex is a little busy now and I can't find any other=20
> maintainer who can take care of MEMSTICK subsystem.
>=20

I don't know anything about memstick specific questions, but I looked
at the code and it seems entirely reasonable and well-written.

Acked-by: Arnd Bergmann <arnd@arndb.de>
