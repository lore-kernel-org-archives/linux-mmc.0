From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Kernel 3.19 on iMX6SL
Date: Tue, 17 Feb 2015 17:01:00 -0200
Message-ID: <CAOMZO5CdxwrFBuUiEwcxzQ_OcMT_oXDkvvKbntq5FtGwrpdQkQ@mail.gmail.com>
References: <CACUGKYMC-_F9fwXgM7jz4J3vabF6Sq-sh3=WdqO_doj1+rvmDA@mail.gmail.com>
	<CAOMZO5DBEifsCQBL2_S2tb9Ci1WN3pQzz2R7kYgP0H459rs7wQ@mail.gmail.com>
	<CACUGKYOKz_FG=1=pXZTsWroDdXOKamCsCwg5gOM9D4h4URb8Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:39639 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341AbbBQTBC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Feb 2015 14:01:02 -0500
Received: by labgq15 with SMTP id gq15so37761463lab.6
        for <linux-mmc@vger.kernel.org>; Tue, 17 Feb 2015 11:01:00 -0800 (PST)
In-Reply-To: <CACUGKYOKz_FG=1=pXZTsWroDdXOKamCsCwg5gOM9D4h4URb8Ew@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Tobias <john.tobias.ph@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Aisheng Dong <Aisheng.Dong@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Dong Aisheng <dongas86@gmail.com>

Hi John,

On Sun, Feb 15, 2015 at 5:00 AM, John Tobias <john.tobias.ph@gmail.com> wrote:
> Hi Fabio,
>
> If I used kernel 3.13, it works fine. But, in kernel 3.19, it detect
> and configured my eMMC in DDR50 mode. Sometimes, it boots okay and
> able to login, but after few minutes it crashes.
> Also, it happened during boot time.

At this moment I don't have anything else to suggest other than
running 'git bisect'.
