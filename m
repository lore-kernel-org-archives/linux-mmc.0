From: "Arend van Spriel" <arend@broadcom.com>
Subject: Re: v3.6-rc1: modprobe hangs with sdhci failure on dell e6410
Date: Sun, 26 Aug 2012 10:03:55 +0200
Message-ID: <5039D86B.5040208@broadcom.com>
References: <5034E895.4050105@broadcom.com>
 <CAOzJMDTTAzzV3VHgvY6B3ooe1ZyWkRGvfDgbFw4ZonQJFu3uAQ@mail.gmail.com>
 <50373A31.7040803@broadcom.com> <5037DCE3.2010505@broadcom.com>
 <35709C36-C251-4701-965A-D3B5DBD6B66A@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mms2.broadcom.com ([216.31.210.18]:2789 "EHLO mms2.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750Ab2HZIEJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 26 Aug 2012 04:04:09 -0400
In-Reply-To: <35709C36-C251-4701-965A-D3B5DBD6B66A@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: linux-mmc@vger.kernel.org

On 08/24/2012 10:10 PM, Philip Rakity wrote:
>
> Arend,
>
> Are you saying issue has nothing to do with mmc ?

Nope. What I meant to be saying is:

1. the issue occurs regardless whether the slot is populated or not.
2. it occurs on multiple machine so it seems not a hardware issue on a 
single machine.
3. the issue is not seen on same laptop model running 64-bit kernel.

Gr. AvS

> Philip
> On Aug 24, 2012, at 12:58 PM, Arend van Spriel <arend@broadcom.com> wrote:
>
>> On 08/24/2012 10:24 AM, Arend van Spriel wrote:
>>> On 08/23/2012 04:58 PM, Aaron Lu wrote:
>>>> On Wed, Aug 22, 2012 at 10:11 PM, Arend van Spriel
>>>> <arend@broadcom.com> wrote:
>>>>> A quick search using google did not provide clues. Regardless if
>>>>> there is
>>>>> anything inserted the hang occurs.
>>>>>
>>>>> Gr. AvS
>>>>
>>>> Also, your .config might be helpful.
>>>
>>> True. Here it is.
>>>
>>> Gr. AvS
>>
>> Inspected the logs on another machine running the same kernel and it has
>> the same issue. I was not using the mmc slot on that machine so I was
>> not aware. On x86_64 I am not seeing the issue (so far).
>>
>> Gr. AvS
>>
>
>


