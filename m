From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] sdhci-pxa: add call back interface to share sdhci-pxa
Date: Wed, 18 May 2011 22:38:45 +0200
Message-ID: <201105182238.45614.arnd@arndb.de>
References: <BANLkTimPN=GauwY7Rwh3xUEkV3=q3wfzAQ@mail.gmail.com> <08119C91-F5AA-4E6A-99D4-CFB253B1AE7B@marvell.com> <BANLkTikVM7QbRJ2Lo2Ef3T9oGAmZ4SJzMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:61738 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756378Ab1ESHxe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 May 2011 03:53:34 -0400
In-Reply-To: <BANLkTikVM7QbRJ2Lo2Ef3T9oGAmZ4SJzMQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <mark.brown314@gmail.com>

On Tuesday 17 May 2011, zhangfei gao wrote:
> >> The code handle several register difference are located at
> >> arch/arm/mach-mmp/mmp2.c is for mmp2
> >> arch/arm/mach-mmp/pxa910.c is for pxa910 serious,
> >> arch/arm/mach-mmp/mmp3.c is for mmp3 serious, considering there may
> >> still registers changing.
> >>
> >> The board difference are directly put in board.c
> >> For example ttc_dkb do not use wp pin, so get_ro is provided.
> >
> > embedding the code in these chip files stops code sharing.  For example,
> > mmp3 has same controller as mmp2.
> 
> If register are totally same, they can share.
> If there is minor difference with chip upgrading, they can put in
> different file.

When we talked about similar problems in drivers during the Linaro Developer
Summit, the broad consensus was to move code from arch/arm into individual
device drivers, and I think this should be done for this driver too.

My recommendation here would be to have no callbacks in the platform
data at all, but instead have the code for all variants in the
sdhci-pxa driver itself. You can still have a structure to describe
the differences using function pointers, but it's better if that is
part of the driver itself. In the platform data, provide a way
to identify the variant of the controller (e.g. using an enum)
and point to the base addresses as required.

	Arnd

