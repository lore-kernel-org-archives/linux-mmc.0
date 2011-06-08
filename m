From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v3 2/4] mmc: support sdhci-pxav2.c
Date: Wed, 8 Jun 2011 11:03:22 +0800
Message-ID: <BANLkTin4nHnaZyA1-Gh5TV+v9BqbRwJSSg@mail.gmail.com>
References: <1307094606-8692-1-git-send-email-zhangfei.gao@marvell.com>
	<1E53FF9F-5C6A-4AA2-B441-DD712C5D6715@marvell.com>
	<BANLkTik9an1N8914nC5MVL7+nHh+NhDNAA@mail.gmail.com>
	<201106070917.41691.arnd@arndb.de>
	<BANLkTinsk0AzBYd+fO9Oz1RO9smNzJTsTA@mail.gmail.com>
	<A5ADAC80-98EE-4184-A958-965A3EC275F9@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40913 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773Ab1FHDDX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2011 23:03:23 -0400
Received: by vws1 with SMTP id 1so59005vws.19
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jun 2011 20:03:23 -0700 (PDT)
In-Reply-To: <A5ADAC80-98EE-4184-A958-965A3EC275F9@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Zhangfei Gao <zgao6@marvell.com>, Shawn Guo <shawn.guo@linaro.org>, Nicolas Pitre <nico@fluxnic.net>, Qiming Wu <wuqm@marvell.com>, Jun Nie <njun@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <w.sang@pengutronix.de>, Haojian Zhuang <haojian.zhuang@gmail.com>, Raymond Wu <xywu@marvell.com>, Chris Ball <cjb@laptop.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Tue, Jun 7, 2011 at 11:04 PM, Philip Rakity <prakity@marvell.com> wr=
ote:
>
> On Jun 7, 2011, at 12:31 AM, Eric Miao wrote:
>
>>> How about changing the title of the option though? A user will
>>> usually not know if he is using the v2 or v3 controller without
>>> reading the help text. If you change it to
>>>
>>> config MMC_SDHCI_PXAV2
>>> =A0 =A0 =A0 =A0tristate "Marvell PXA168 SD Host Controller support =
(PXAV2)"
>>> =A0 =A0 =A0 =A0default CPU_PXA168
>
> change to
>>> =A0 =A0 =A0 =A0tristate "Marvell PXA9xx SD Host Controller support =
(PXAV2)"
>
> the pxa168 will not work in all cases with the V2 code. =A0It needs I=
O_ACCESSORS for readw and
> a callback to sdhci.c to delay then time between transfers. =A0Once V=
2 code is mainline
> I will resubmit the pxa168 code.
>
>
>>>
>>> config MMC_SDHCI_PXAV3
>>> =A0 =A0 =A0 =A0tristate "Marvell MMP2/PX9XX SD Host Controller supp=
ort (PXAV3)"
>>> =A0 =A0 =A0 =A0default CPU_MMP2 || CPU_PXA910
>>>
>>
>> Yeah, the above is much cleaner/simpler.
>>
>>> you increase the chances of users getting the configuration right.
>>>
>>> =A0 =A0 =A0 =A0Arnd
>>>

Thanks for good suggestion. Will update to v4.
