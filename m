From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: Use mmc core regulator infrastucture
Date: Wed, 7 May 2014 10:28:58 +0200
Message-ID: <CAPDyKFohigtcYwhVV3jDGp_H2vXfPX5UUbKe8bUuoyGVebGU7A@mail.gmail.com>
References: <1398378989-14575-1-git-send-email-tim.kryger@linaro.org>
	<CAPDyKFoZQUNCX7Y4C=kr-JDUF3WRxjxeNU4eJRwhZ+cFbmx7iw@mail.gmail.com>
	<CAAYSxhob5-8VrgiTS5=BBnFjPei4N0zSE6fhsboWR-C-LvXJog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:62338 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbaEGI27 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 7 May 2014 04:28:59 -0400
Received: by mail-qg0-f46.google.com with SMTP id q108so674570qgd.19
        for <linux-mmc@vger.kernel.org>; Wed, 07 May 2014 01:28:58 -0700 (PDT)
In-Reply-To: <CAAYSxhob5-8VrgiTS5=BBnFjPei4N0zSE6fhsboWR-C-LvXJog@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tim Kryger <tim.kryger@linaro.org>
Cc: Chris Ball <chris@printf.net>, Mike Looijmans <mike.looijmans@topic.nl>, Andrew Bresticker <abrestic@chromium.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On 7 May 2014 01:42, Tim Kryger <tim.kryger@linaro.org> wrote:
> On Fri, Apr 25, 2014 at 1:15 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 25 April 2014 00:36, Tim Kryger <tim.kryger@linaro.org> wrote:
>>> Switch the common SDHCI code over to use mmc_host's regulator pointers
>>> and remove the ones in the sdhci_host structure.  Additionally, use the
>>> common mmc_regulator_get_supply function to get the regulators and set
>>> the ocr_avail mask.
>>>
>>> This change sets the ocr_avail directly based upon the voltage ranges
>>> supported which ensures ocr_avail is set correctly while allowing the
>>> use of regulators that can't provide exactly 1.8v, 3.0v, or 3.3v.
>>>
>>> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
>>
>> This looks good to me!
>>
>> I plan to get Russell's sdhci patchset merged, prior to this patch. So
>> likely we need to rebase this patch on top of that soon.
>>
>> Kind regards
>> Ulf Hansson
>
> Hi Ulf,
>
> Can you clarify if this is the series you intend to merge and provide
> a rough estimate on when it might happen?

Currently, Chris is waiting for Russell to send him a PR.

>
> http://www.spinics.net/lists/arm-kernel/msg324984.html

It's that patchset I refer to, but with some minor changes and likely
not patch 34 and onwards.

Kind regards
Ulf Hansson

>
> Thanks,
> Tim Kryger
