From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH v3 2/4] mmc: support sdhci-pxav2.c
Date: Tue, 7 Jun 2011 15:31:48 +0800
Message-ID: <BANLkTinsk0AzBYd+fO9Oz1RO9smNzJTsTA@mail.gmail.com>
References: <1307094606-8692-1-git-send-email-zhangfei.gao@marvell.com>
 <1E53FF9F-5C6A-4AA2-B441-DD712C5D6715@marvell.com> <BANLkTik9an1N8914nC5MVL7+nHh+NhDNAA@mail.gmail.com>
 <201106070917.41691.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38669 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab1FGHcJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2011 03:32:09 -0400
Received: by vws1 with SMTP id 1so3351531vws.19
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jun 2011 00:32:08 -0700 (PDT)
In-Reply-To: <201106070917.41691.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, Philip Rakity <prakity@marvell.com>, Zhangfei Gao <zgao6@marvell.com>, Shawn Guo <shawn.guo@linaro.org>, Nicolas Pitre <nico@fluxnic.net>, Qiming Wu <wuqm@marvell.com>, Jun Nie <njun@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <w.sang@pengutronix.de>, Haojian Zhuang <haojian.zhuang@gmail.com>, Raymond Wu <xywu@marvell.com>, Chris Ball <cjb@laptop.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

> How about changing the title of the option though? A user will
> usually not know if he is using the v2 or v3 controller without
> reading the help text. If you change it to
>
> config MMC_SDHCI_PXAV2
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate "Marvell PXA168 SD Host Controlle=
r support (PXAV2)"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0default CPU_PXA168
>
> config MMC_SDHCI_PXAV3
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate "Marvell MMP2/PX9XX SD Host Contr=
oller support (PXAV3)"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0default CPU_MMP2 || CPU_PXA910
>

Yeah, the above is much cleaner/simpler.

> you increase the chances of users getting the configuration right.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Arnd
>
> BTW, both of you: Please always remove the lines that you don't refer=
 to
> when you reply to an email. It's very annoying having to scroll throu=
gh
> dozens of lines of citations to see what you are actually writing.
>
