From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH] mmc: add dependence in Kconfig for pxav2/pxav3
Date: Mon, 20 Jun 2011 21:23:16 +0800
Message-ID: <BANLkTimMB9T1-s9pEc-zzhQB7m-ZOT1DFg@mail.gmail.com>
References: <1308552287-18752-1-git-send-email-zhangfei.gao@marvell.com>
	<BANLkTinGM3YUxYHgFBs9KMOrjWe1m8Esww@mail.gmail.com>
	<BANLkTi=_qEQT5f_FcAEYz2Y5p6FGJU+P5Q@mail.gmail.com>
	<201106201349.38459.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37913 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891Ab1FTNXR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2011 09:23:17 -0400
Received: by vws1 with SMTP id 1so847260vws.19
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jun 2011 06:23:16 -0700 (PDT)
In-Reply-To: <201106201349.38459.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Zhangfei Gao <zhangfei.gao@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Stephen Rothwell <sfr@canb.auug.org.au>

On Mon, Jun 20, 2011 at 7:49 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 20 June 2011, zhangfei gao wrote:
>> Currently, clk_enable, clk_disable, clk_get_rate realization are
>> located at arch.
>> Driver/clk/clkdev.c only realize clk_get/put.
>>
>> I am afraid it may difficult to build the driver on other arch, like
>> x86, =A0so we may still need "depends on ARCH_MMP" for safety.
>
> I would recommend turning this into "depends on CLKDEV_LOOKUP" instea=
d.
> Always be specific with your dependencies so you enable the option
> on all platforms that are able to build it, but not on any of the
> others.
>
> =A0 =A0 =A0 =A0Arnd
>

Select CLKDEV_LOOKUP is compile driver/clk/clkdev.c, which only
provide clk_get, clk_put.
Is it unsafe to assume all clk_get_rate/clk_enable/clk_disable are
provided by the arch, which CLKDEV_LOOKUP?
Any possibility CLKDEV_LOOKUP is selected but clk_get_rate is not reali=
zed.

Thanks
