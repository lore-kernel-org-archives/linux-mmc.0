From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Wed, 17 Nov 2010 08:46:44 +0200
Message-ID: <4CE37A54.20509@compulab.co.il>
References: <AANLkTim+Ez8FonyZDu42u4NX-KKV0YS_J-Ya-zT-Gf9q@mail.gmail.com>	<AANLkTinJ2K2cz9PSdyNoNGUS8GWfLpqRBH2C3XjO5vjO@mail.gmail.com>	<AANLkTi=VAU=9Q+Ga7yQyu3aL7gV0vbzymQ-2uJAg1jf8@mail.gmail.com>	<AANLkTi=QT6_zyddRz=3f6GDx-RVoiROOumhegm8pFuHU@mail.gmail.com>	<AANLkTimfp0pPqpO03-R4yBsADQ27RLQ_PxLTfBAMfPGk@mail.gmail.com>	<AANLkTi=gFmq47Xq+CxnU18aHyhcaF78WrWYDhga4Xf2X@mail.gmail.com>	<AANLkTimqFBBsDCCDNOq22fuqjw7pezizZ9At+1ucGZ-j@mail.gmail.com>	<AANLkTi=RP0i5cWO4AogGJx-sQ+17YKuiptQWi0ypYVnA@mail.gmail.com>	<AANLkTiktD13-UC8=gwWhp9oR9_vGcM98VpRQ9i0CQg_-@mail.gmail.com>	<AANLkTi=8Xd1xTfFvAJkicR_89JOu4P2uwyoMHvXCBKv8@mail.gmail.com>	<AANLkTi=cPURFAitedD=mjkNiD_=ZCjakkMN6z7ecqv6k@mail.gmail.com>	<AANLkTi=EaZbdnJzJWGH2fUadvNkUhdQgTU1rAoS5wMAs@mail.gmail.com>	<AANLkTinzvte389GNHtD2N0wO9mYsys
 CG9+Z1AFVZRn0E@mail.gmail.com>	<AANLkTimRFC81ZiLuiUmhvXOpUddBjhVBezJEB8_BDyuu@mail.gmail.com> <AANLkTinAP0J3RncxJZciKVD9TKdfZLLvDsGn3NpnF0Dz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:39202 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752799Ab0KQGr6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 17 Nov 2010 01:47:58 -0500
In-Reply-To: <AANLkTinAP0J3RncxJZciKVD9TKdfZLLvDsGn3NpnF0Dz@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Daniel Drake <dsd@laptop.org>, Arnd Hannemann <arnd@arndnet.de>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, libertas-dev@lists.infradead.org

On 11/16/10 16:49, Ohad Ben-Cohen wrote:
> On Tue, Nov 16, 2010 at 4:29 PM, Daniel Drake <dsd@laptop.org> wrote:
>> On 16 November 2010 13:22, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>>> Just to update the list, the problem with the XO-1.5 was because the
>>> sd8686 has an external reset gpio line which is currently being
>>> manipulated manually by an out-of-tree kernel patch:
>>>
>>> http://dev.laptop.org/git/olpc-2.6/commit/?h=olpc-2.6.35&id=e9bee721fb0cc303286d1fe5df4930ce79b0b1e0
>>>
>>> ... which makes me wonder whether we really want to take that
>>> MMC_CAP_RUNTIME_PM road. I'm not sure anymore.
>>
>> OLPC is not the only user of the sd8686.
>> Every other user will face the same problem.
>>
>> Other users may not have the luxury of having a GPIO hooked up to the
>> reset line.
> 
> Agree; those users will need a MMC_CAP_RUNTIME_PM (or maybe call it
> with the capability it really stands for which is something like
> MMC_CAP_POWER_OFF_CARD).
> 
> But I want to be positively sure we have such users (or is it that obvious?).
> 
> How is the sd8686's reset line manipulated on other platforms ? Or is
> the sd8686 usually just kept powered on after boot ?

On our platforms we just keep it powered on after boot with the reset line held
high. (e.g. arch/arm/mach-pxa/cm-x300.c, arch/arm/mach-omap/board-cm-t35.c). We
don't bother much for power savings, though.

> I'm looping in libertas-dev.
> 
> Thanks,
> Ohad.
> 
> _______________________________________________
> libertas-dev mailing list
> libertas-dev@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/libertas-dev


-- 
Sincerely yours,
Mike.
