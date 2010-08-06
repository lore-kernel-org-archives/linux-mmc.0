From: Lee Jones <lee.jones@canonical.com>
Subject: Re: MMC: [PATCH 0/2 v2] Two fixes for mmc system
Date: Fri, 06 Aug 2010 07:39:21 +0100
Message-ID: <4C5BAE19.7040607@canonical.com>
References: <1280579825-6174-1-git-send-email-maximlevitsky@gmail.com>	<1281015363.9324.35.camel@maxim-laptop>	<20100805152219.ae41a175.akpm@linux-foundation.org>	<1281047979.7148.2.camel@maxim-laptop> <20100805154503.42599438.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:39418 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759224Ab0HFGjY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Aug 2010 02:39:24 -0400
In-Reply-To: <20100805154503.42599438.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>

Well done Maxim.

Thank you Andrew.

Once this is released in mainline I will have 100's of happy users.

Kind regards,
Lee

On 05/08/10 23:45, Andrew Morton wrote:
> On Fri, 06 Aug 2010 01:39:39 +0300
> Maxim Levitsky <maximlevitsky@gmail.com> wrote:
> 
>> On Thu, 2010-08-05 at 15:22 -0700, Andrew Morton wrote: 
>>> On Thu, 05 Aug 2010 16:36:03 +0300
>>> Maxim Levitsky <maximlevitsky@gmail.com> wrote:
>>>
>>>> On Sat, 2010-07-31 at 15:37 +0300, Maxim Levitsky wrote: 
>>>>> Hi,
>>>>>
>>>>> This is resend of these patches.
>>>>> Tell me if I don't need to resent the first patch, it doesn't much matter to me.
>>>>>
>>>>> The second patch is slightly updated to plug last oportunety for a race.
>>>>> Also fixed accident move of EXPORT_SYMBOL.
>>>>
>>>> Any update? Comments?
>>>> Will I see that upstream?
>>>>
>>>
>>> I merged the update to [patch 2/2] two days ago - you should have
>>> received the commit email?
>>
>> I have seen message about merge to -mm, but I am asking about mainline.
>>
> 
> I merge in the second week of the -rc1 merge window.  I'm not presently
> aware of any reason why these patches shouldn't be included.
> 

