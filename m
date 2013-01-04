From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v3 3/8] MFD:rtsx: Declare that the DMA address
 limitationis32bit explicitly
Date: Fri, 4 Jan 2013 08:50:31 +0300
Message-ID: <20130104055031.GQ7247@mwanda>
References: <cover.1356662293.git.wei_wang@realsil.com.cn>
 <cd92be49bee917165009311d62e10a5f60a85a48.1356662293.git.wei_wang@realsil.com.cn>
 <20130103122559.GF7247@mwanda>
 <50E6427E.1050809@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:31992 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab3ADFvH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Jan 2013 00:51:07 -0500
Content-Disposition: inline
In-Reply-To: <50E6427E.1050809@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: wwang <wei_wang@realsil.com.cn>
Cc: "sameo@linux.intel.com" <sameo@linux.intel.com>, "oakad@yahoo.com" <oakad@yahoo.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "bp@alien8.de" <bp@alien8.de>, "cjb@laptop.org" <cjb@laptop.org>

On Fri, Jan 04, 2013 at 10:46:22AM +0800, wwang wrote:
> =E4=BA=8E 2013=E5=B9=B401=E6=9C=8803=E6=97=A5 20:25, Dan Carpenter =E5=
=86=99=E9=81=93:
> > On Fri, Dec 28, 2012 at 10:41:28AM +0800, wei_wang@realsil.com.cn w=
rote:
> >> From: Wei WANG <wei_wang@realsil.com.cn>
> >>
> >> Realtek PCIe card reader only supports 32bit DMA
> >>
> > Is this a bugfix?  If so what does the bug look like?
> >
> > regards,
> > dan carpenter
> >
> Hi Dan:
>=20
> No, this is not a bugfix. In default, the kernel will allocate 32bit
> address for DMA. This declaration can improve the readability.
>=20

Ah ok.  Really none of the things I mentioned were stuff that
prevented the patch from being merged or couldn't be fixed in follow
on patches.

The thing is that the commit message should always say why a patch
is needed.

regards,
dan carpenter

