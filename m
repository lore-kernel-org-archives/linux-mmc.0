From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH 2/2] sdhci-pxa: add call back interface to share
 sdhci-pxa
Date: Mon, 16 May 2011 21:27:48 -0700
Message-ID: <08119C91-F5AA-4E6A-99D4-CFB253B1AE7B@marvell.com>
References: <BANLkTimPN=GauwY7Rwh3xUEkV3=q3wfzAQ@mail.gmail.com>
 <m34o4zwo8t.fsf@pullcord.laptop.org>
 <487EBCAC-1795-4C69-ACDF-99EC9D7BF604@marvell.com>
 <m3ei42vhir.fsf@pullcord.laptop.org>
 <BANLkTinOaVziLLun7RyNVCFx=_=DcVXomA@mail.gmail.com>
 <583E304B-0E60-4F3E-8D92-0DE0B737A415@marvell.com>
 <BANLkTi=kYTF0bbcQN8uC_BLW8CQT6ucEkg@mail.gmail.com>
 <D8BA9376-7982-42BC-A6C1-60B8C33B9D2B@marvell.com>
 <BANLkTi=+wXUgP2hQH1q1mZKF9gRjKYP2vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:47785 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751188Ab1EQE2u convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 17 May 2011 00:28:50 -0400
In-Reply-To: <BANLkTi=+wXUgP2hQH1q1mZKF9gRjKYP2vA@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, "arnd@arndb.de Bergmann" <arnd@arndb.de>, Mark Brown <mark.brown314@gmail.com>


On May 16, 2011, at 7:02 PM, zhangfei gao wrote:

> On Mon, May 16, 2011 at 9:51 AM, Philip Rakity <prakity@marvell.com> wrote:
>> 
>> On May 15, 2011, at 11:26 PM, zhangfei gao wrote:
>> 
>>> On Sat, May 14, 2011 at 1:01 PM, Philip Rakity <prakity@marvell.com> wrote:
>>>> 
>>>> On May 13, 2011, at 10:11 PM, zhangfei gao wrote:
>>>> 
>>>>> On Fri, May 13, 2011 at 9:47 PM, Chris Ball <cjb@laptop.org> wrote:
>>>>>> Hi,
>>>>>> 
>>>>>> On Thu, May 12 2011, Philip Rakity wrote:
>>>>>>> All other platform specific code is in the host/ directory.
>>>>>>> 
>>>>>>> This moves it to arch/arm
>>>>>>> 
>>>>>>> If that is the direction the group wants to go in --> then the patch
>>>>>>> is fine provided the mmc group can review the patches.  Otherwise they
>>>>>>> are handled by the arm maintainer.
>>>>>> 
>>>>>> Thanks.  Wolfram, do you have any ideas on what the best design is for
>>>>>> these SoC-specific changes to sdhci-pxa?
>>>>>> 
>>>>>> - Chris.
>>>>> 
>>>>> The code in arch/arm is
>>>>> 1. Accessing private register, take pxa910 and mmp2 we want to support
>>>>> as example, there are several private registers differece, though they
>>>>> are same ip, with same issues and quirk.
>>>>> 2. Handle platform difference, for example, mmp2 used in two different
>>>>> platform, one use wp pin, the other does not.
>>>> 
>>>> The situation is a little more complicated.
>>> 
>>> The interface is used for long time among mmp2, pxa910 and mmp3.
>>> Also could be used for new controller with minor register difference
>>> but same ip, without adding new specific driver.
>> 
>> applies to both approaches.  The mmp2 specific code can be applied to other marvell
>> platforms that share the same controller.  Just change Kconfig and the Makefile to use
>> the mmp2 code.  The name of the file is not the important thing.  It is what it does.
>> 
>> The pxa168 and pxa910 code are a little less sharable due to io accessors and some
>> other quirks.
>> 
>> For other following the discussion we are probably talking about 100 liens of code.
>> 
>> The philosophical location of where the code belongs for host specific drivers is
>> to me more important.
>> 
>> Is it in arch/arm and not directly visible to the mmc list or is it like all other platform drivers
>> in drivers/mmc/host.
> 
> The code handle several register difference are located at
> arch/arm/mach-mmp/mmp2.c is for mmp2
> arch/arm/mach-mmp/pxa910.c is for pxa910 serious,
> arch/arm/mach-mmp/mmp3.c is for mmp3 serious, considering there may
> still registers changing.
> 
> The board difference are directly put in board.c
> For example ttc_dkb do not use wp pin, so get_ro is provided.

embedding the code in these chip files stops code sharing.  For example,
mmp3 has same controller as mmp2. 
> 
>> 
>> 
>> 
>>> 
>>>> 
>>>> pxa168 and pxa910 share (almost) the same IP  The are both based on SD 2.0
>>>> controller spec with extensions.  The pxa910 controller has fixes to the
>>>> pxa168 controller.  They share the same private registers that allow support
>>>> for clock gating and timing adjustments.
>>>> 
>>>> mmp2 is based on SD 3.0 spec.  The private register space is different.
>>>> 
>>>> mmc/host/Kconfig takes no account of these differences.  mmp2 and pxa168/910
>>>> cannot co-exist.   What is currently submitted does not work.  One cannot
>>>> compile mmp2 and pxa910  nor would they work if one could.
>>>> 
>>>> Mark Brown and I submitted patches to fix this.  We added code to the host/ directory
>>>> that took into account these differences.   It provided a common interface layer
>>>> that then used platform specific code in the host/ directory to handle the different
>>>> behavior.
>>>> 
>>>> Arng Bergmann provided advice and reviewed the patches to allow explicit selection of the
>>>> pxa familty controller and board.  Based on this comments we submitted a patch
>>>> to allow selection if the appropriate SoC.
>>>> 
>>>> These are two approaches.
>>>> 
>>>>> 
>>>>> Thanks
>>>>>> --
>>>>>> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
>>>>>> One Laptop Per Child
>>>>>> 
>>>> 
>>>> 
>> 
>> 

