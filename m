From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH 0/6] mmc: sdhci: fixes and enhancements
Date: Wed, 19 Sep 2012 15:52:45 +0800
Message-ID: <CADz5_g+GT7WC77NoKNuqcnVDumWR+NX2X63O=YDMDDYLXpzR8A@mail.gmail.com>
References: <1348020762-12932-1-git-send-email-keyuan.liu@gmail.com>
	<m31uhylo3o.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:61782 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330Ab2ISHwr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Sep 2012 03:52:47 -0400
Received: by weyx8 with SMTP id x8so420968wey.19
        for <linux-mmc@vger.kernel.org>; Wed, 19 Sep 2012 00:52:46 -0700 (PDT)
In-Reply-To: <m31uhylo3o.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, pierre@ossman.eu, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

2012/9/19 Chris Ball <cjb@laptop.org>:
> Hi,
>
> On Tue, Sep 18 2012, Kevin Liu wrote:
>> This patchset does as follows:
>> [PATCH 1/6] mmc: sdhci-pxav3: fix build error
>> [PATCH 2/6] mmc: sdhci: fix transfer mode setting bug for cmds w/o data transfer
>> [PATCH 3/6] mmc: sdhci: set regulator min/max voltage according to spec
>> [PATCH 4/6] mmc: sdhci: refine code for sd clock disable/enable in set ios
>> [PATCH 5/6] mmc: sdhci: keep the saved clock var up to date
>> [PATCH 6/6] mmc: sdhci: fix null return check of regulator_get
>
> I'm worried that 2-5 might cause regressions for unexpected reasons, so
> I'll plan on merging these for 3.8 instead of 3.7 (assuming that no-one
> objects to them); hope that's okay.
>

Thanks
Kevin
