From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 2/4] mmc: support sdhci-pxav2.c
Date: Tue, 7 Jun 2011 09:17:41 +0200
Message-ID: <201106070917.41691.arnd@arndb.de>
References: <1307094606-8692-1-git-send-email-zhangfei.gao@marvell.com> <1E53FF9F-5C6A-4AA2-B441-DD712C5D6715@marvell.com> <BANLkTik9an1N8914nC5MVL7+nHh+NhDNAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:61886 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885Ab1FGHRo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2011 03:17:44 -0400
In-Reply-To: <BANLkTik9an1N8914nC5MVL7+nHh+NhDNAA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Philip Rakity <prakity@marvell.com>, Zhangfei Gao <zgao6@marvell.com>, Shawn Guo <shawn.guo@linaro.org>, Eric Miao <eric.y.miao@gmail.com>, Nicolas Pitre <nico@fluxnic.net>, Qiming Wu <wuqm@marvell.com>, Jun Nie <njun@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <w.sang@pengutronix.de>, Haojian Zhuang <haojian.zhuang@gmail.com>, Raymond Wu <xywu@marvell.com>, Chris Ball <cjb@laptop.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Tuesday 07 June 2011 08:08:27 zhangfei gao wrote:
> >> +config MMC_SDHCI_PXAV2
> >> +     tristate "Marvell PXAV2 SD Host Controller support"
> >> +     select MMC_SDHCI
> >> +     select MMC_SDHCI_PLTFM
> >> +     help
> >> +       This selects the Marvell(R) PXAV2 SD Host Controller.
> >> +       If you have a PXAV2 platform (such as pxa910) with SD Host Controller
> >> +       and a card slot, say Y or M here.
> >> +
> >> +       If unsure, say N.
> >> +
> >
> > The following might be a better approach.  This way we preserve the existing SDHCI_PXA definition
> > and allow users to see what CPU's are supported.
> >
> > config MMC_SDHCI_PXA
> >>       tristate "Marvell MMP SD Host Controller support"
> >>       depends on ARCH_MMP2
> >>      select MMC_SDHCI_PXAV3
> >
> >
> >> config MMC_SDHCI_PXA168
> >>       tristate "Marvell PXA168 SD Host Controller support"
> >>       depends on ARCH_PXA
> >>      select MMC_SDHCI_PXAV2
> >>
> >> config MMC_SDHCI_PXA9XX
> >>       tristate "Marvell PXA910 SD Host Controller support"
> >>       depends on ARCH_PXA
> >>      select MMC_SDHCI_PXAV3
> >>
> >> config MMC_SDHCI_MMP2
> >>       tristate "Marvell MMP SD Host Controller support"
> >>       depends on ARCH_MMP2
> >>      select MMC_SDHCI_PXAV3
> >
> Still prefer the original method, it is simple and no dependence.
> >

How about changing the title of the option though? A user will
usually not know if he is using the v2 or v3 controller without
reading the help text. If you change it to

config MMC_SDHCI_PXAV2
	tristate "Marvell PXA168 SD Host Controller support (PXAV2)"
	default CPU_PXA168

config MMC_SDHCI_PXAV3
	tristate "Marvell MMP2/PX9XX SD Host Controller support (PXAV3)"
	default CPU_MMP2 || CPU_PXA910

you increase the chances of users getting the configuration right.

	Arnd

BTW, both of you: Please always remove the lines that you don't refer to
when you reply to an email. It's very annoying having to scroll through
dozens of lines of citations to see what you are actually writing.
