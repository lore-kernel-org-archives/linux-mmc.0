From: NamJae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH 3/4] mmc: Logging neatening
Date: Wed, 16 Nov 2011 11:08:27 +0900
Message-ID: <CAKYAXd9GVQkLvhy2cx7n77jMtxBNK=1xG5wZ8zx_kcihHZGkFw@mail.gmail.com>
References: <cover.1321398814.git.joe@perches.com>
	<d2c1a76fea1844ae7ac3e7e17183fb39df19178e.1321398814.git.joe@perches.com>
	<CAKYAXd8_mDF68PnEnpuZZQ+O8-QmrfRpP4jv+SpHDx1juTxFGQ@mail.gmail.com>
	<1321408236.9189.3.camel@Joe-Laptop>
	<CAKYAXd8fki1HfFRuRyi4_HNLK6aiFM5NAbyKApgbGaaR=VOTEg@mail.gmail.com>
	<1321408846.9189.5.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46722 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932911Ab1KPCI3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Nov 2011 21:08:29 -0500
In-Reply-To: <1321408846.9189.5.camel@Joe-Laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Manuel Lauss <manuel.lauss@gmail.com>, Cliff Cai <cliff.cai@analog.com>, Nicolas Pitre <nico@fluxnic.net>, Chris Ball <cjb@laptop.org>, Sascha Sommer <saschasommer@freenet.de>, Alex Dubov <oakad@yahoo.com>, Bruce Chang <brucechang@via.com.tw>, Harald Welte <HaraldWelte@viatech.com>, Tony Olech <tony.olech@elandigitalsystems.com>, Pierre Ossman <pierre@ossman.eu>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, uclinux-dist-devel@blackfin.uclinux.org, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

2011/11/16 Joe Perches <joe@perches.com>:
> On Wed, 2011-11-16 at 10:55 +0900, NamJae Jeon wrote:
>> 2011/11/16 Joe Perches <joe@perches.com>:
>> > On Wed, 2011-11-16 at 10:48 +0900, NamJae Jeon wrote:
>> >
>> > [123K of untrimmed reply]
>> >
>> > If you wrote something, I didn't find it.
>> >
>>
>> > - =C2=A0 =C2=A0 =C2=A0 dev_info(&pdev->dev, "DW MMC controller at =
irq %d, "
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"%d bit h=
ost data width, "
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"%u deep =
fifo\n",
>> > + =C2=A0 =C2=A0 =C2=A0 dev_info(&pdev->dev,
>> > + =C2=A0 =C2=A0 =C2=A0 "DW MMC controller at irq %d, %d bit host d=
ata width, %u deep fifo\n",
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 irq, width=
, fifo_size);
>>
>> I think that tab is needed this "DW MMC controller at irq ...." ?
>
> Argument alignment isn't always the right thing.
>
> Very long formats should not necessarily be aligned
> at the open parenthesis. =C2=A0It helps to determine
> when the format string or the dmesg output line length
> is too long.
Okay~ I understand clearly.
Thanks.

> Coalesce formats.
> Align arguments.
> Add pr_fmt, remove prefixes from format strings.
> Neaten DBG uses, rearrange argument order.
>
> Signed-off-by: Joe Perches <joe@perches.com>
Reviewed-by: NamJae Jeon <linkinjeon@gmail.com>
>
>
>
>
>
>
