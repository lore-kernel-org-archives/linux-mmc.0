From: Saeed Bishara <saeed@marvell.com>
Subject: RE: [PATCH] mmc: Add architecture dependency for Marvell SoC
 controller
Date: Wed, 15 Sep 2010 13:29:11 +0300
Message-ID: <FCBE654890C0334289D0AD3AF4EF009FD18EE74AE9@IL-MB01.marvell.com>
References: <1284366279-17140-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20100914190549.GA21918@void.printf.net>
	<20100915094006.GA21620@sirena.org.uk>
	<FCBE654890C0334289D0AD3AF4EF009FD18EE74AA8@IL-MB01.marvell.com>
	<20100915110001.GA4254@rakim.wolfsonmicro.main>
	<FCBE654890C0334289D0AD3AF4EF009FD18EE74AC7@IL-MB01.marvell.com>
 <AANLkTi=fsntfyAoFygrTrksVARvQpuxie6tFxCcuLtVR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from galiil.marvell.com ([199.203.130.254]:54589 "EHLO
	galiil.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055Ab0IOL3P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Sep 2010 07:29:15 -0400
In-Reply-To: <AANLkTi=fsntfyAoFygrTrksVARvQpuxie6tFxCcuLtVR@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

=20

>-----Original Message-----
>From: Haojian Zhuang [mailto:haojian.zhuang@gmail.com]=20
>Sent: Wednesday, September 15, 2010 1:21 PM
>To: Saeed Bishara
>Cc: Mark Brown; Chris Ball; Andrew Morton;=20
>linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] mmc: Add architecture dependency for=20
>Marvell SoC controller
>
>On Wed, Sep 15, 2010 at 6:06 PM, Saeed Bishara=20
><saeed@marvell.com> wrote:
>>
>>>Which CPUs does the driver actually support? =A0The Kconfig and
>>>commit log
>>>just say "Marvell" so I went for the conservative option and include=
d
>>>all Marvell CPUs I was aware of.
>> The Marvell Dove SoC includes this device, this SoC defined=20
>by ARCH_DOVE
>> I guess it found also only on mmp (defined by ARCH_MMP),=20
>Haojian, can you confirm?
>> saeed
>
>As I know, MG1 is also using this IP. Although MG1 isn't supported in
>mainline, it's planned to be added into ARCH_PXA or one new ARCH. So
>PLAT_PXA is preferred.
I think (ARCH_DOVE || ARCH_MMP) is prefered, when MG1 gets added to mai=
nline, then we will add that new ARCH.

saeed