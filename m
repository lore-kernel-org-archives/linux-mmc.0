From: Stephen Warren <swarren@nvidia.com>
Subject: RE: Resume issue with brcmfmac *not* loaded
Date: Tue, 14 Jun 2011 11:51:44 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04992C03DE@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF04992C026B@HQMAIL01.nvidia.com>
	<BANLkTimJXtFB5Qi9sjVOWhrKVfuE5O1p-uhGMq_WmnJPJcugpg@mail.gmail.com>
 <BANLkTinAXsHYBZ0uSY4ZtTd=f=7LNQM+_9o_FcLLYs1iPfL=YQ@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF04992C034F@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:19726 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308Ab1FNSwk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jun 2011 14:52:40 -0400
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04992C034F@HQMAIL01.nvidia.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>, Grant Grundler <grundler@chromium.org>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "Greg KH (gregkh@suse.de)" <gregkh@suse.de>, "vrao@broadcom.com" <vrao@broadcom.com>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Olof Johansson <olofj@chromium.org>, Sukesh Srikakula <sukeshs@broadcom.com>

Stephen Warren wrote at Tuesday, June 14, 2011 9:58 AM:
> Olof Johansson wrote at Monday, June 13, 2011 7:13 PM:
...
> > >On Mon, Jun 13, 2011 at 2:18 PM, Stephen Warren <swarren@nvidia.com> wrote:
> > >> I'm having resume problems on a system (NVIDIA Tegra Seaboard) that would
> > >> use the brcmfmac staging driver.
...
> > >> When the driver is loaded, suspend and resume (echo mem > /sys/state/power)
> > >> work fine.
> > >>
> > >> However, without the driver loaded, resume works, but 10 seconds later,
> > >> the kernel hangs a little, and spits out the errors quoted at the end of
> > >> this email. The hangs interfere with other devices on the system; e.g.
> > >> audio DMA gets starved and causes audible artifacts.
...
> > Sounds to me like there's another problem going on here. I wonder if
> > the card gets confused if the host goes away and comes back without it
> > having been power cycled as well.
...
> > Sounds like the solution here might instead be:
> >
> > * Specify the power_gpio properly for the slot in question (it does
> > have one wired up if I'm reading the right schematics, it's just not
> > specified in the board file)
> 
> I assume you mean WF_RST_L_PWDN_L?
> 
> > * Add a suspend/resume function to the sdhci-tegra driver currently
> > not in use, that disables power to the slot during suspend if the
> > pm_flags don't have MMC_KEEP_POWER set.
> 
> I'll give that a try and see...

That doesn't seem to make any difference.

(and note if trying to repro: that the problem repros if the brcmfmac driver
has never been loaded, not just if it isn't loaded when entering suspend)

-- 
nvpublic

