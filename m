From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Kernel 3.19 on iMX6SL
Date: Sat, 14 Feb 2015 16:28:12 -0200
Message-ID: <CAOMZO5DBEifsCQBL2_S2tb9Ci1WN3pQzz2R7kYgP0H459rs7wQ@mail.gmail.com>
References: <CACUGKYMC-_F9fwXgM7jz4J3vabF6Sq-sh3=WdqO_doj1+rvmDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:51110 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754091AbbBNS2N (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 14 Feb 2015 13:28:13 -0500
Received: by mail-lb0-f178.google.com with SMTP id w7so20825002lbi.9
        for <linux-mmc@vger.kernel.org>; Sat, 14 Feb 2015 10:28:12 -0800 (PST)
In-Reply-To: <CACUGKYMC-_F9fwXgM7jz4J3vabF6Sq-sh3=WdqO_doj1+rvmDA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Tobias <john.tobias.ph@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Aisheng Dong <Aisheng.Dong@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Dong Aisheng <dongas86@gmail.com>

Hi John,

On Fri, Feb 13, 2015 at 11:10 PM, John Tobias <john.tobias.ph@gmail.com> wrote:
> Hello Guys,
>
> I tried to use kernel 3.19 on my iMX6SL custom board and my eMMC is
> running DDR50 mode.
>
> Any available patch for this?.

Dong's series that added mx6sl DDR50 support has been applied already:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/205933.html

Make sure you have the 100 and 200MHz sdhc pinctrl entries in your dts
like it was done in this commit:

commit fa87dfd6d0b067bd962ab83754cf1991ee512c0c
Author: Dong Aisheng <b29396@freescale.com>
Date:   Wed Oct 9 19:20:07 2013 +0800

    ARM: dts: imx6sl: add pinctrl uhs states for usdhc

    This is needed for SD3.0 cards working on UHS mode.

    Signed-off-by: Dong Aisheng <b29396@freescale.com>
    Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
