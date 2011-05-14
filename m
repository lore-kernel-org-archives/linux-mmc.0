From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH 2/2] sdhci-pxa: add call back interface to share sdhci-pxa
Date: Sat, 14 May 2011 13:11:44 +0800
Message-ID: <BANLkTinOaVziLLun7RyNVCFx=_=DcVXomA@mail.gmail.com>
References: <BANLkTimPN=GauwY7Rwh3xUEkV3=q3wfzAQ@mail.gmail.com>
	<m34o4zwo8t.fsf@pullcord.laptop.org>
	<487EBCAC-1795-4C69-ACDF-99EC9D7BF604@marvell.com>
	<m3ei42vhir.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:36095 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770Ab1ENFLp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 14 May 2011 01:11:45 -0400
Received: by vxi39 with SMTP id 39so2259782vxi.19
        for <linux-mmc@vger.kernel.org>; Fri, 13 May 2011 22:11:44 -0700 (PDT)
In-Reply-To: <m3ei42vhir.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Philip Rakity <prakity@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>

On Fri, May 13, 2011 at 9:47 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Thu, May 12 2011, Philip Rakity wrote:
>> All other platform specific code is in the host/ directory.
>>
>> This moves it to arch/arm
>>
>> If that is the direction the group wants to go in --> then the patch
>> is fine provided the mmc group can review the patches. =A0Otherwise =
they
>> are handled by the arm maintainer.
>
> Thanks. =A0Wolfram, do you have any ideas on what the best design is =
for
> these SoC-specific changes to sdhci-pxa?
>
> - Chris.

The code in arch/arm is
1. Accessing private register, take pxa910 and mmp2 we want to support
as example, there are several private registers differece, though they
are same ip, with same issues and quirk.
2. Handle platform difference, for example, mmp2 used in two different
platform, one use wp pin, the other does not.

Thanks
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
>
