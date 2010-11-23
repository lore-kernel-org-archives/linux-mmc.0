From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH] sdhci: sdhci-pxa only supports mmp2 at this time. Change Kconfig
Date: Tue, 23 Nov 2010 12:59:52 +0800
Message-ID: <AANLkTinZdya+yELS2+Qi3UFjXg0LRveXEf=+nUYJsoHa@mail.gmail.com>
References: <3E707E23-91F2-4BA1-A74B-C8EE2E8EAF31@marvell.com>
	<AANLkTimMFsxHt3AEfHDgZsia3c+rYVx2P5Diw=Robrbe@mail.gmail.com>
	<20101123025548.GA29770@void.printf.net>
	<AANLkTi=aPtSsDk5UYgXz5REw0K7m_xzNDSHgs31Rbcx+@mail.gmail.com>
	<F2601D24-BA24-4E4C-8C2D-C6B5C55416EB@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39423 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913Ab0KWE7x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Nov 2010 23:59:53 -0500
Received: by gyb11 with SMTP id 11so1834851gyb.19
        for <linux-mmc@vger.kernel.org>; Mon, 22 Nov 2010 20:59:52 -0800 (PST)
In-Reply-To: <F2601D24-BA24-4E4C-8C2D-C6B5C55416EB@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, Chris Ball <cjb@laptop.org>, "Mark F. Brown" <mark.brown314@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>, Eric Miao <eric.y.miao@gmail.com>

On Tue, Nov 23, 2010 at 11:22 AM, Philip Rakity <prakity@marvell.com> w=
rote:
>
> I implemented the first sdhci-pxa.c controller for the pxa168 over a =
year ago. =A0Also fixed issues on Tavor.
>
> This approach is not sufficient to make Aspen nor Tavor work.
>
> There are a number of silicon issues that need to be addressed.
>
>
>
>
But we're formating patches for these silicons. I prefer to push
patches for Aspen/Tavor rather than restricting on CPU_MMP2 now.

This driver is used to share among Aspen/Tavor/MMP2.

Thanks
Haojian
