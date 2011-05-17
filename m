From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH 2/2] sdhci-pxa: add call back interface to share sdhci-pxa
Date: Mon, 16 May 2011 22:02:19 -0400
Message-ID: <BANLkTi=+wXUgP2hQH1q1mZKF9gRjKYP2vA@mail.gmail.com>
References: <BANLkTimPN=GauwY7Rwh3xUEkV3=q3wfzAQ@mail.gmail.com>
	<m34o4zwo8t.fsf@pullcord.laptop.org>
	<487EBCAC-1795-4C69-ACDF-99EC9D7BF604@marvell.com>
	<m3ei42vhir.fsf@pullcord.laptop.org>
	<BANLkTinOaVziLLun7RyNVCFx=_=DcVXomA@mail.gmail.com>
	<583E304B-0E60-4F3E-8D92-0DE0B737A415@marvell.com>
	<BANLkTi=kYTF0bbcQN8uC_BLW8CQT6ucEkg@mail.gmail.com>
	<D8BA9376-7982-42BC-A6C1-60B8C33B9D2B@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51985 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095Ab1EQCCU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 May 2011 22:02:20 -0400
Received: by vws1 with SMTP id 1so36645vws.19
        for <linux-mmc@vger.kernel.org>; Mon, 16 May 2011 19:02:20 -0700 (PDT)
In-Reply-To: <D8BA9376-7982-42BC-A6C1-60B8C33B9D2B@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, "arnd@arndb.de Bergmann" <arnd@arndb.de>, Mark Brown <mark.brown314@gmail.com>

On Mon, May 16, 2011 at 9:51 AM, Philip Rakity <prakity@marvell.com> wr=
ote:
>
> On May 15, 2011, at 11:26 PM, zhangfei gao wrote:
>
>> On Sat, May 14, 2011 at 1:01 PM, Philip Rakity <prakity@marvell.com>=
 wrote:
>>>
>>> On May 13, 2011, at 10:11 PM, zhangfei gao wrote:
>>>
>>>> On Fri, May 13, 2011 at 9:47 PM, Chris Ball <cjb@laptop.org> wrote=
:
>>>>> Hi,
>>>>>
>>>>> On Thu, May 12 2011, Philip Rakity wrote:
>>>>>> All other platform specific code is in the host/ directory.
>>>>>>
>>>>>> This moves it to arch/arm
>>>>>>
>>>>>> If that is the direction the group wants to go in --> then the p=
atch
>>>>>> is fine provided the mmc group can review the patches. =A0Otherw=
ise they
>>>>>> are handled by the arm maintainer.
>>>>>
>>>>> Thanks. =A0Wolfram, do you have any ideas on what the best design=
 is for
>>>>> these SoC-specific changes to sdhci-pxa?
>>>>>
>>>>> - Chris.
>>>>
>>>> The code in arch/arm is
>>>> 1. Accessing private register, take pxa910 and mmp2 we want to sup=
port
>>>> as example, there are several private registers differece, though =
they
>>>> are same ip, with same issues and quirk.
>>>> 2. Handle platform difference, for example, mmp2 used in two diffe=
rent
>>>> platform, one use wp pin, the other does not.
>>>
>>> The situation is a little more complicated.
>>
>> The interface is used for long time among mmp2, pxa910 and mmp3.
>> Also could be used for new controller with minor register difference
>> but same ip, without adding new specific driver.
>
> applies to both approaches. =A0The mmp2 specific code can be applied =
to other marvell
> platforms that share the same controller. =A0Just change Kconfig and =
the Makefile to use
> the mmp2 code. =A0The name of the file is not the important thing. =A0=
It is what it does.
>
> The pxa168 and pxa910 code are a little less sharable due to io acces=
sors and some
> other quirks.
>
> For other following the discussion we are probably talking about 100 =
liens of code.
>
> The philosophical location of where the code belongs for host specifi=
c drivers is
> to me more important.
>
> Is it in arch/arm and not directly visible to the mmc list or is it l=
ike all other platform drivers
> in drivers/mmc/host.

The code handle several register difference are located at
arch/arm/mach-mmp/mmp2.c is for mmp2
arch/arm/mach-mmp/pxa910.c is for pxa910 serious,
arch/arm/mach-mmp/mmp3.c is for mmp3 serious, considering there may
still registers changing.

The board difference are directly put in board.c
=46or example ttc_dkb do not use wp pin, so get_ro is provided.

>
>
>
>>
>>>
>>> pxa168 and pxa910 share (almost) the same IP =A0The are both based =
on SD 2.0
>>> controller spec with extensions. =A0The pxa910 controller has fixes=
 to the
>>> pxa168 controller. =A0They share the same private registers that al=
low support
>>> for clock gating and timing adjustments.
>>>
>>> mmp2 is based on SD 3.0 spec. =A0The private register space is diff=
erent.
>>>
>>> mmc/host/Kconfig takes no account of these differences. =A0mmp2 and=
 pxa168/910
>>> cannot co-exist. =A0 What is currently submitted does not work. =A0=
One cannot
>>> compile mmp2 and pxa910 =A0nor would they work if one could.
>>>
>>> Mark Brown and I submitted patches to fix this. =A0We added code to=
 the host/ directory
>>> that took into account these differences. =A0 It provided a common =
interface layer
>>> that then used platform specific code in the host/ directory to han=
dle the different
>>> behavior.
>>>
>>> Arng Bergmann provided advice and reviewed the patches to allow exp=
licit selection of the
>>> pxa familty controller and board. =A0Based on this comments we subm=
itted a patch
>>> to allow selection if the appropriate SoC.
>>>
>>> These are two approaches.
>>>
>>>>
>>>> Thanks
>>>>> --
>>>>> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
>>>>> One Laptop Per Child
>>>>>
>>>
>>>
>
>
