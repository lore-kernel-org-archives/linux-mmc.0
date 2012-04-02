From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH 0/8][git pull] mmc: omap: Assorted fixes for 3.4 merge window
Date: Mon, 2 Apr 2012 13:22:44 +0530
Message-ID: <CANfBPZ8o_Hdd7sUJ-DS-j9JOkQ=SRJcLChCfd7nCCPbaVVBkLA@mail.gmail.com>
References: <1331905144-31655-1-git-send-email-svenkatr@ti.com> <87hax4kqsy.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:41748 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751040Ab2DBHxH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 2 Apr 2012 03:53:07 -0400
Received: by bkuw11 with SMTP id w11so2645584bku.37
        for <linux-mmc@vger.kernel.org>; Mon, 02 Apr 2012 00:53:04 -0700 (PDT)
In-Reply-To: <87hax4kqsy.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, balajitk@ti.com, balbi@ti.com

On Sun, Apr 1, 2012 at 10:10 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Fri, Mar 16 2012, Venkatraman S wrote:
>> Chris,
>> =A0 =A0Here are a group of fixes posted by Felipe and Balaji for the
>> OMAP hsmmc driver in the past few days.
>> =A0 =A0I've rebased them to the lastest mmc-next and posted them
>> here again. These have also been tested on OMAP4 development platfor=
m.
>>
>> Please feel to apply directly or pull if that's convenient.
>>
>> Changes since yesterday (v1):-
>> =A0 =A0 =A0 Fixed formatting issues as suggested by Felipe
>> =A0 =A0 =A0 Marked some patches for stable.
>>
>> The following changes since commit 5f0390f10c0e9c9c504cdbf4af8022526=
28a2490:
>>
>> =A0 mmc: omap_hsmmc: Avoid a regulator voltage change with dt (2012-=
03-14 11:33:20 -0400)
>>
>> are available in the git repository at:
>>
>> =A0 git://github.com/svenkatr/linux.git omap-mmc-pending-for-3.4
>>
>> for you to fetch changes up to 8d54766b608915035b47616ea564e4e9b4dda=
29c:
>>
>> =A0 mmc: omap4: hsmmc: fix module re-insertion (2012-03-16 11:38:41 =
+0530)
>
> I've just rebased mmc-next on top of 3.4-rc1, and now there are many
> conflicts against your tree -- please could you resend patches 3-8
> against that base? =A0I'll take them for 3.4, and will take patches 1=
-2
> for 3.5.
>
I've rebased patches 3-8 into a new branch (See below).
I'll send you 1-2 on top of 3.4-rc2 once it's out. Is it Ok ?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The following changes since commit a4dfa827bb5b9a984d4000ffb80134b9495e=
4d8a:

  mmc: sdio: Use empty system suspend/resume callbacks at the bus
level (2012-04-01 00:35:06 -0400)

are available in the git repository at:

  git://github.com/svenkatr/linux.git omap-mmc-fixes-3.4

for you to fetch changes up to 80f833a2f77b8d6464209c0bb00a39ad835356a0=
:

  mmc: omap4: hsmmc: fix module re-insertion (2012-04-02 12:26:47 +0530=
)

----------------------------------------------------------------
Balaji T K (3):
      mmc: omap: use runtime put sync in probe error patch
      mmc: omap: context save after enabling runtime pm
      mmc: omap4: hsmmc: fix module re-insertion

=46elipe Balbi (3):
      mmc: host: omap_hsmmc: trivial cleanups
      mmc: host: omap_hsmmc: make it behave well as a module
      mmc: host: omap_hsmmc: convert to module_platform_driver

 drivers/mmc/host/omap_hsmmc.c |  181
+++++++++++++++++++++--------------------------
 1 file changed, 79 insertions(+), 102 deletions(-)

Regards,
Venkat.
