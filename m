From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: SD card reader problems on Cherry-Trail
Date: Thu, 5 Oct 2017 11:10:02 +0300
Message-ID: <32d4293d-7e9d-8f0d-966f-235a8283182f@intel.com>
References: <CAL9uMOGXVgHP8iNdZbEWv3pSRjZ++hhswu6c+ZiPydGiw9SPEw@mail.gmail.com>
 <CAPDyKFpoHGKGhDyYRTdWMPTxOM0GLNDQjMTDThX5mvFDyVTwnw@mail.gmail.com>
 <CAL9uMOGog77MDUhVisEDcbSFXANGNfzecee1PzgXdwvZwexmUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:51951 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751299AbdJEIRB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 5 Oct 2017 04:17:01 -0400
In-Reply-To: <CAL9uMOGog77MDUhVisEDcbSFXANGNfzecee1PzgXdwvZwexmUA@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Carlo Caione <carlo@endlessm.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 05/10/17 10:59, Carlo Caione wrote:
> On Thu, Oct 5, 2017 at 9:52 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> + Adrian
> 
> /cut
>>> - With high speed SDHC cards I get a weird behavior where apparently
>>> there is no problem but it's impossible to format the card. mkfs.ext4
>>> gets stuck at:
>>>
>>> Discarding device blocks:    4096/3778299
> 
> Just discovered that this is just reeeeeally slow, not stuck. Still
> something is fishy about this.
> 
> /cut
>> Looping in Adrian, as he maintains sdhci.
>>
>> I guess some more useful information would also be about what commit
>> you are running and whether this is a regression or not.
> 
> Yeah, some more info:
> 
> - Reproduced with the latest master on linus repo (4.14.0-rc3)
> - No idea if this is a regression or not. This is a new hardware we
> are trying to enable and I have never seen it working fine (I should
> blindly try some old kernel)
> - Windows is working fine so not an HW issue
> - CPU is x5-Z8350

Can you provide an acpidump?
