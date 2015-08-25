From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2] mmc: host: use of_property_read_bool()
Date: Wed, 26 Aug 2015 00:49:56 +0300
Message-ID: <55DCE304.7020001@cogentembedded.com>
References: <3376063.1JTtbbjJ3D@wasted.cogentembedded.com>
 <CAPDyKFrBoa6Jdg6qpYV2UXKgm11q-CQu33j0JCnFkXOsURhtYg@mail.gmail.com>
 <55DC98A7.5000202@cogentembedded.com>
 <CAPDyKFqjUZv2950ekKTiJCdt5TZe-YXWaX+DWeRbbep_AURSmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:35373 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbbHYVt7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2015 17:49:59 -0400
Received: by lbcbn3 with SMTP id bn3so108322456lbc.2
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2015 14:49:58 -0700 (PDT)
In-Reply-To: <CAPDyKFqjUZv2950ekKTiJCdt5TZe-YXWaX+DWeRbbep_AURSmg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 08/26/2015 12:19 AM, Ulf Hansson wrote:

>>>> Use more compact of_property_read_bool() calls instead of the
>>>> of_find_property()
>>>> calls.

>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>>> Thanks, applied for next!
>>
>>     Thanks to you! :-)
>>
>>> Next, time please run checkpatch to remove errors/warnings.
>>
>>     Hum, I just did and the patch seems clean:
>>
>> [headless@wasted mmc]$ scripts/checkpatch.pl
>> patches/mmc-host-use-of_property_read_bool.patch
>> total: 0 errors, 0 warnings, 81 lines checked
>>
>> patches/mmc-host-use-of_property_read_bool.patch has no obvious style
>> problems and is ready for submission.
>>
>>     What do you mean?

> WARNING: Possible unwrapped commit description (prefer a maximum 75
> chars per line)
> #12:
> Use more compact of_property_read_bool() calls instead of the of_find_property()

> total: 0 errors, 1 warnings, 81 lines checked

> I suspect we might use different versions of the checkpatch script.
> Mine is from 4.2rc7.

    Tried several variants, the last one was in your repo's 'next' branch 
(4.2-rc7 based). No warning. :-)

> No worries then!

> Kind regards
> Uffe

MBR, Sergei

