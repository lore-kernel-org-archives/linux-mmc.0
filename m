From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH 2/2] sdhci-pxa: add call back interface to share
 sdhci-pxa
Date: Sat, 14 May 2011 10:01:52 -0700
Message-ID: <583E304B-0E60-4F3E-8D92-0DE0B737A415@marvell.com>
References: <BANLkTimPN=GauwY7Rwh3xUEkV3=q3wfzAQ@mail.gmail.com>
 <m34o4zwo8t.fsf@pullcord.laptop.org>
 <487EBCAC-1795-4C69-ACDF-99EC9D7BF604@marvell.com>
 <m3ei42vhir.fsf@pullcord.laptop.org>
 <BANLkTinOaVziLLun7RyNVCFx=_=DcVXomA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:58814 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751430Ab1ENRCI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 14 May 2011 13:02:08 -0400
In-Reply-To: <BANLkTinOaVziLLun7RyNVCFx=_=DcVXomA@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, "arnd@arndb.de Bergmann" <arnd@arndb.de>, Zhangfei Gao <zhangfei.gao@gmail.com>


On May 13, 2011, at 10:11 PM, zhangfei gao wrote:

> On Fri, May 13, 2011 at 9:47 PM, Chris Ball <cjb@laptop.org> wrote:
>> Hi,
>> 
>> On Thu, May 12 2011, Philip Rakity wrote:
>>> All other platform specific code is in the host/ directory.
>>> 
>>> This moves it to arch/arm
>>> 
>>> If that is the direction the group wants to go in --> then the patch
>>> is fine provided the mmc group can review the patches.  Otherwise they
>>> are handled by the arm maintainer.
>> 
>> Thanks.  Wolfram, do you have any ideas on what the best design is for
>> these SoC-specific changes to sdhci-pxa?
>> 
>> - Chris.
> 
> The code in arch/arm is
> 1. Accessing private register, take pxa910 and mmp2 we want to support
> as example, there are several private registers differece, though they
> are same ip, with same issues and quirk.
> 2. Handle platform difference, for example, mmp2 used in two different
> platform, one use wp pin, the other does not.

The situation is a little more complicated.

pxa168 and pxa910 share (almost) the same IP  The are both based on SD 2.0
controller spec with extensions.  The pxa910 controller has fixes to the
pxa168 controller.  They share the same private registers that allow support
for clock gating and timing adjustments.  

mmp2 is based on SD 3.0 spec.  The private register space is different.

mmc/host/Kconfig takes no account of these differences.  mmp2 and pxa168/910
cannot co-exist.   What is currently submitted does not work.  One cannot
compile mmp2 and pxa910  nor would they work if one could.  

Mark Brown and I submitted patches to fix this.  We added code to the host/ directory
that took into account these differences.   It provided a common interface layer
that then used platform specific code in the host/ directory to handle the different
behavior.  

Arng Bergmann provided advice and reviewed the patches to allow explicit selection of the
pxa familty controller and board.  Based on this comments we submitted a patch
to allow selection if the appropriate SoC. 

These are two approaches. 

> 
> Thanks
>> --
>> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
>> One Laptop Per Child
>> 

