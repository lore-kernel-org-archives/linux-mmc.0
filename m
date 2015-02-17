From: John Tobias <john.tobias.ph@gmail.com>
Subject: Re: Kernel 3.19 on iMX6SL
Date: Tue, 17 Feb 2015 11:20:13 -0800
Message-ID: <CACUGKYM83t=VmAz8vGq2QsQRaaZH=+SR024-MjSXVsh66OBbVA@mail.gmail.com>
References: <CACUGKYMC-_F9fwXgM7jz4J3vabF6Sq-sh3=WdqO_doj1+rvmDA@mail.gmail.com>
	<CAOMZO5DBEifsCQBL2_S2tb9Ci1WN3pQzz2R7kYgP0H459rs7wQ@mail.gmail.com>
	<CACUGKYOKz_FG=1=pXZTsWroDdXOKamCsCwg5gOM9D4h4URb8Ew@mail.gmail.com>
	<CAOMZO5CdxwrFBuUiEwcxzQ_OcMT_oXDkvvKbntq5FtGwrpdQkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:43414 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbbBQTUO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Feb 2015 14:20:14 -0500
Received: by labms9 with SMTP id ms9so31789167lab.10
        for <linux-mmc@vger.kernel.org>; Tue, 17 Feb 2015 11:20:13 -0800 (PST)
In-Reply-To: <CAOMZO5CdxwrFBuUiEwcxzQ_OcMT_oXDkvvKbntq5FtGwrpdQkQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Aisheng Dong <Aisheng.Dong@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Dong Aisheng <dongas86@gmail.com>

Hi Fabio,

Thanks for the info. I will dig it once I started migrating from older
kernel to the latest one.

Regards,

John

On Tue, Feb 17, 2015 at 11:01 AM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi John,
>
> On Sun, Feb 15, 2015 at 5:00 AM, John Tobias <john.tobias.ph@gmail.com> wrote:
>> Hi Fabio,
>>
>> If I used kernel 3.13, it works fine. But, in kernel 3.19, it detect
>> and configured my eMMC in DDR50 mode. Sometimes, it boots okay and
>> able to login, but after few minutes it crashes.
>> Also, it happened during boot time.
>
> At this moment I don't have anything else to suggest other than
> running 'git bisect'.
