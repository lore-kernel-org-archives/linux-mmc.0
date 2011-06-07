From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 0/3] provide sdhci driver for mmp2 and pxa910
Date: Tue, 7 Jun 2011 09:00:27 +0200
Message-ID: <201106070900.27637.arnd@arndb.de>
References: <BANLkTikP72ybaqa8zDgNjBQg8Q6SH5fMdw@mail.gmail.com> <FDBC7F85-3643-4C3C-9E4B-2006D56F24C9@marvell.com> <BANLkTimkk3JfuVmhuBAw4Op93oDtjKdoXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:60215 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab1FGHAe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2011 03:00:34 -0400
In-Reply-To: <BANLkTimkk3JfuVmhuBAw4Op93oDtjKdoXw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Philip Rakity <prakity@marvell.com>, Nicolas Pitre <nico@fluxnic.net>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Qiming Wu <wuqm@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Tuesday 07 June 2011 07:44:42 zhangfei gao wrote:
> On Sat, Jun 4, 2011 at 5:08 AM, Philip Rakity <prakity@marvell.com> wrote:
> >
> > Please update mmp2 and pxa defconfigs.
> 
> The trend is replacing defconfig with device tree, it may not
> acceptable to update defconfig.

Actually, the defconfigs are not going away, at least not directly.

The device tree will replace the need for individual board files,
but not for defconfig files. As a side-effect, the number of
defconfig files can get reduced, but we should still maintain
them.

	Arnd
