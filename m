From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: host: use of_property_read_bool()
Date: Tue, 25 Aug 2015 23:19:02 +0200
Message-ID: <CAPDyKFqjUZv2950ekKTiJCdt5TZe-YXWaX+DWeRbbep_AURSmg@mail.gmail.com>
References: <3376063.1JTtbbjJ3D@wasted.cogentembedded.com>
	<CAPDyKFrBoa6Jdg6qpYV2UXKgm11q-CQu33j0JCnFkXOsURhtYg@mail.gmail.com>
	<55DC98A7.5000202@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:34368 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291AbbHYVTD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2015 17:19:03 -0400
Received: by iodb91 with SMTP id b91so202509043iod.1
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2015 14:19:02 -0700 (PDT)
In-Reply-To: <55DC98A7.5000202@cogentembedded.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 25 August 2015 at 18:32, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 08/25/2015 03:05 PM, Ulf Hansson wrote:
>
>>> Use more compact of_property_read_bool() calls instead of the
>>> of_find_property()
>>> calls.
>
>
>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
>
>> Thanks, applied for next!
>
>
>    Thanks to you! :-)
>
>> Next, time please run checkpatch to remove errors/warnings.
>
>
>    Hum, I just did and the patch seems clean:
>
> [headless@wasted mmc]$ scripts/checkpatch.pl
> patches/mmc-host-use-of_property_read_bool.patch
> total: 0 errors, 0 warnings, 81 lines checked
>
> patches/mmc-host-use-of_property_read_bool.patch has no obvious style
> problems and is ready for submission.
>
>    What do you mean?

WARNING: Possible unwrapped commit description (prefer a maximum 75
chars per line)
#12:
Use more compact of_property_read_bool() calls instead of the of_find_property()

total: 0 errors, 1 warnings, 81 lines checked

I suspect we might use different versions of the checkpatch script.
Mine is from 4.2rc7.

No worries then!

Kind regards
Uffe
