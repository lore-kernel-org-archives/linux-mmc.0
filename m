From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V3] powerpc/85xx: Add support for 85xx cpu type
 detection
Date: Tue, 16 Jul 2013 18:54:25 -0500
Message-ID: <1374018865.8183.349@snotra>
References: <1373502232-4772-1-git-send-email-Haijun.Zhang@freescale.com>
	<99E897753B6F7048BD8CCDB4661D02E13C0099@039-SN2MPN1-023.039d.mgd.msft.net>
	<1373994129.8183.330@snotra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:54079
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755071Ab3GPXye convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 16 Jul 2013 19:54:34 -0400
In-Reply-To: <1373994129.8183.330@snotra> (from scottwood@freescale.com on
	Tue Jul 16 12:02:09 2013)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Wood <scottwood@freescale.com>
Cc: Zhang Haijun-B42677 <B42677@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, Wood Scott-B07421 <B07421@freescale.com>, Fleming Andy-AFLEMING <afleming@freescale.com>, Wrobel Heinz-R39252 <r39252@freescale.com>, Zhao Chenhui-B35336 <B35336@freescale.com>

On 07/16/2013 12:02:09 PM, Scott Wood wrote:
> On 07/16/2013 03:46:44 AM, Zhang Haijun-B42677 wrote:
>> Hi, scott
>> 
>> Need I change something?
>> I have some patches depend on this.
>> Expect your advice.
>> 
>> Thanks.
>> 
>> Regards
>> Haijun.
> 
> It looks OK; go ahead and send the patches that depend on it.

Actually, could you add p2040, p4040, p4080, p5021, and any other  
missing ones you notice (lots of e500v2 P1/P2 chips are missing too)?

At the very least p2040 and p5021 ought to be there if you're using  
this to check for p2041/p5040 errata, since they're basically the same  
chip and thus have the same errata.

-Scott
