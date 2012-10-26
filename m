From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 0/3] Add modules to support realtek PCIE card reader
Date: Fri, 26 Oct 2012 09:04:59 -0700
Message-ID: <20121026160459.GA16813@kroah.com>
References: <50664814.30407@turmel.org>
 <20120929110730.GA27797@liondog.tnic>
 <87d315osjm.fsf@octavius.laptop.org>
 <20120929152942.GA11412@liondog.tnic>
 <506FDC8C.3030707@realsil.com.cn>
 <20121020034615.GT5685@mwanda>
 <20121025185041.GB22114@kroah.com>
 <5089E315.1010708@realsil.com.cn>
 <20121026024556.GA9545@kroah.com>
 <5089FAAB.500@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:63163 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933948Ab2JZQES (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Oct 2012 12:04:18 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2022081pad.19
        for <linux-mmc@vger.kernel.org>; Fri, 26 Oct 2012 09:04:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5089FAAB.500@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: wwang <wei_wang@realsil.com.cn>
Cc: Phil Turmel <philip@turmel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "arnd@arndb.de" <arnd@arndb.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Andrew Morton <akpm@linux-foundation.org>, Chris Ball <cjb@laptop.org>, "oakad@yahoo.com" <oakad@yahoo.com>, Dan Carpenter <dan.carpenter@oracle.com>

On Fri, Oct 26, 2012 at 10:51:23AM +0800, wwang wrote:
> =E4=BA=8E 2012=E5=B9=B410=E6=9C=8826=E6=97=A5 10:45, Greg KH =E5=86=99=
=E9=81=93:
> >On Fri, Oct 26, 2012 at 09:10:45AM +0800, wwang wrote:
> >>=E4=BA=8E 2012=E5=B9=B410=E6=9C=8826=E6=97=A5 02:50, Greg KH =E5=86=
=99=E9=81=93:
> >>>On Sat, Oct 20, 2012 at 06:46:15AM +0300, Dan Carpenter wrote:
> >>>>On Sat, Oct 06, 2012 at 03:23:56PM +0800, wwang wrote:
> >>>>>We are still maintaining the SCSI driver for Realtek card reader=
,
> >>>>>and will release the latest source code in the Github in the fut=
ure.
> >>>>>But maybe we won't push it to the staging tree any more.
> >>>>Maybe we should just remove the staging code if it won't be fixed=
=2E
> >>>>That's sort of the point of staging.
> >>>I agree.  wwang, want me to delet the staging driver now?  I don't=
 want
> >>>"dead" code in the tree, especially as you don't want to maintain =
it
> >>>anymore.
> >>>
> >>>thanks,
> >>>
> >>>greg k-h
> >>Hi Greg:
> >>
> >>OK. You can delete it now, please.
> >>And I will push my new driver to MFD and MMC subsystem.
> >Ok, just to confirm, you want me to delete the
> >drivers/staging/rts_pstor/* code, right?
> >
> >thanks,
> >
> >greg k-h
> Hi Greg:
>=20
> Yes, you can delete drivers/staging/rts_pstor

Thanks, now done.

greg k-h
