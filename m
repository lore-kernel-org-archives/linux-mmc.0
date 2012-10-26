From: wwang <wei_wang@realsil.com.cn>
Subject: Re: [PATCH v6 0/3] Add modules to support realtek PCIE card reader
Date: Fri, 26 Oct 2012 09:10:45 +0800
Message-ID: <5089E315.1010708@realsil.com.cn>
References: <cover.1347330871.git.wei_wang@realsil.com.cn> <50664814.30407@turmel.org> <20120929110730.GA27797@liondog.tnic> <87d315osjm.fsf@octavius.laptop.org> <20120929152942.GA11412@liondog.tnic> <506FDC8C.3030707@realsil.com.cn> <20121020034615.GT5685@mwanda> <20121025185041.GB22114@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rtits2.realtek.com ([60.250.210.242]:60024 "EHLO
	rtits2.realtek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347Ab2JZBL5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Oct 2012 21:11:57 -0400
In-Reply-To: <20121025185041.GB22114@kroah.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Phil Turmel <philip@turmel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "arnd@arndb.de" <arnd@arndb.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Andrew Morton <akpm@linux-foundation.org>, Chris Ball <cjb@laptop.org>, "oakad@yahoo.com" <oakad@yahoo.com>

=D3=DA 2012=C4=EA10=D4=C226=C8=D5 02:50, Greg KH =D0=B4=B5=C0:
> On Sat, Oct 20, 2012 at 06:46:15AM +0300, Dan Carpenter wrote:
>> On Sat, Oct 06, 2012 at 03:23:56PM +0800, wwang wrote:
>>> We are still maintaining the SCSI driver for Realtek card reader,
>>> and will release the latest source code in the Github in the future=
=2E
>>> But maybe we won't push it to the staging tree any more.
>> Maybe we should just remove the staging code if it won't be fixed.
>> That's sort of the point of staging.
> I agree.  wwang, want me to delet the staging driver now?  I don't wa=
nt
> "dead" code in the tree, especially as you don't want to maintain it
> anymore.
>
> thanks,
>
> greg k-h
Hi Greg:

OK. You can delete it now, please.
And I will push my new driver to MFD and MMC subsystem.

Best Regards,
wwang
