From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/3] powerpc/esdhc: add property to disable the CMD23
Date: Tue, 18 Sep 2012 00:00:55 -0500
Message-ID: <02298E64-619A-4F41-A329-5FA3C909B224@kernel.crashing.org>
References: <1347347565-17474-1-git-send-email-Chang-Ming.Huang@freescale.com> <1347347565-17474-2-git-send-email-Chang-Ming.Huang@freescale.com> <20120911075429.GA27028@lizard> <20120911080457.GA28235@lizard> <110EED8CC96DFC488B7E717A2027A27C176170@039-SN1MPN1-002.039d.mgd.msft.net> <6D8C87BA-CA06-4215-94F5-63EBF5162B0A@kernel.crashing.org> <2A6FCAE3-288F-4972-90C0-15105932F13E@kernel.crashing.org> <87k3w0y5yn.fsf@octavius.laptop.org> <FC22FA36-B2CF-49C2-A0B1-8A0EA614B9CB@kernel.crashing.org> <8B1F0805-759E-417A-B787-40DF197896F3@kernel.crashing.org> <110EED8CC96DFC488B7E717A2027A27C1785D0@039-SN1MPN1-002.039d.mgd.msft.net> <4E15F856-D385-40C4-A5FD-5F298C70F402@kernel.crashing.org> <m3k3vsn7wf.fsf@pullcord.laptop.org> <1166FFD6-342F-4BDA-BF23-794DAEA95CC9@kernel.crashing.org> <110EED8CC96
 DFC488B7E717A2027A27C17DBCA@039-SN1MPN1-002.039d.mgd.msft.net>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:42237 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752658Ab2IRFBJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Sep 2012 01:01:09 -0400
In-Reply-To: <110EED8CC96DFC488B7E717A2027A27C17DBCA@039-SN1MPN1-002.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <R66093@freescale.com>
Cc: Chris Ball <cjb@laptop.org>, "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Anton Vorontsov <cbouatmailru@gmail.com>


On Sep 17, 2012, at 8:09 PM, Huang Changming-R66093 wrote:

>> On Sep 17, 2012, at 7:36 AM, Chris Ball wrote:
>> 
>>> Hi,
>>> 
>>> On Thu, Sep 13 2012, Kumar Gala wrote:
>>>>>> Can you list out which SoCs support it and which don't.  Having
>>>>>> this list will be useful in understanding which controller versions
>> supported it.
>>>>>> 
>>>>> P1020, p1021, p1022, p1024, p1015 and p4080 can't support it.
>>>>> Mpc8536, p2020, and the other current DPAA silicon (e.g. p5020, p3041)
>> support it.
>>>> 
>>>> Based on this, why don't we use the HOSTVER register to detect instead
>> of device tree:
>>> 
>>> I've got a mild preference for handling quirk assignment in the DT
>>> rather than in driver code, so I'd prefer to just push the original
>>> patch to mmc-next as-is.  Does that sound okay?
>> 
>> Why?  I only ask because I agree with Scott that this means you have to
>> update your device tree to get proper functionality.
>> 
> When the new silicon does not support CMD23,
> if we don't update the device tree, then we must update the SDHC driver.
> I prefer to add the property in device tree,
> because we just add this property in new device tree, we don't need more effort to modify driver.
> 

Jerry,

I think doing it driver makes more sense because:

1. means older device tree's still work
2. odds that CMD23 not being supported in future devices is near 0%
   (Now that we support AutoCMD23 [and thus CMD23] we aren't likely to stop supporting it in future)
3. If IP changes you are going to have to update driver anyways for new features

I really think we should NOT utilize device tree for this.

- k



