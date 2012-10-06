From: wwang <wei_wang@realsil.com.cn>
Subject: Re: [PATCH v6 0/3] Add modules to support realtek PCIE card reader
Date: Sat, 6 Oct 2012 15:23:56 +0800
Message-ID: <506FDC8C.3030707@realsil.com.cn>
References: <cover.1347330871.git.wei_wang@realsil.com.cn> <50664814.30407@turmel.org> <20120929110730.GA27797@liondog.tnic> <87d315osjm.fsf@octavius.laptop.org> <20120929152942.GA11412@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rtits2.realtek.com ([60.250.210.242]:50675 "EHLO
	rtits2.realtek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab2JFHYt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 6 Oct 2012 03:24:49 -0400
In-Reply-To: <20120929152942.GA11412@liondog.tnic>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Chris Ball <cjb@laptop.org>, gregkh@linuxfoundation.org, Andrew Morton <akpm@linux-foundation.org>, Phil Turmel <philip@turmel.org>, sameo@linux.intel.com, devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, arnd@arndb.de, oakad@yahoo.com

=E4=BA=8E 2012=E5=B9=B409=E6=9C=8829=E6=97=A5 23:29, Borislav Petkov =E5=
=86=99=E9=81=93:
> On Sat, Sep 29, 2012 at 09:41:17AM -0400, Chris Ball wrote:
>> On Sat, Sep 29 2012, Borislav Petkov wrote:
>>> So, I think that this driver has seen a bunch of testing and review=
ing
>>> and we might start considering upstreaming it. There are a bunch of
>>> laptops integrating those readers and maybe a single three-month-is=
h -rc
>>> period of testing wouldn't hurt before it appears upstream.
>>>
>>> Now, AFAICT, there is another driver in staging which supports the =
same
>>> or a subset of the cardreaders this driver does so I don't know wha=
t
>>> Realsil want to do with that. Wei?
>>>
>>> And since this driver touches multiple drivers/{mfd,mmc,memstick}
>>> subdirs, maybe akpm would like to merge it? At least I haven't seen=
 any
>>> other maintainers complaining about its design or wanting to take i=
t so
>> I think you've missed the mails -- Alex Dubov has acked the memstick
>> portion, Samuel Ortiz has said he'll push the MFD driver for 3.7,
>> and I've pushed the MMC driver into mmc-next for 3.7.  So, I think
>> we should merge it.  I don't think we need akpm, since there are no
>> build-time dependencies involved.
> Great, all is taken care of then.
>
> Only the staging driver remains, I believe the CONFIG_RTS_PSTOR one. =
Wei?
>
> Thanks.
>
Hi all:

Sorry for my late reply. I'm on my vacation these days.

At first I want to explain the relationship between the staging driver=20
"rts_pstor" with this one here.
Initially, we tried to build a SCSI driver for Realtek PCI-E card=20
reader, which has the same architecture and code base with our Windows=20
driver. And I pushed rts_pstor to staging tree last year. But Realtek=20
PCI-E card reader is not a real SCSI device, which doesn't  understand=20
SCSI command at all. So SCSI subsystem won't accept rts_pstor, and I=20
can't find a proper subsystem to push it to.  That's why I create this=20
series of drivers, which are more compatible with the whole Linux=20
architecture.
We are still maintaining the SCSI driver for Realtek card reader, and=20
will release the latest source code in the Github in the future.  But=20
maybe we won't push it to the staging tree any more.

BR,
Wei WANG

