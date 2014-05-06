From: Tim Kryger <tim.kryger@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: Use mmc core regulator infrastucture
Date: Tue, 6 May 2014 16:42:07 -0700
Message-ID: <CAAYSxhob5-8VrgiTS5=BBnFjPei4N0zSE6fhsboWR-C-LvXJog@mail.gmail.com>
References: <1398378989-14575-1-git-send-email-tim.kryger@linaro.org>
	<CAPDyKFoZQUNCX7Y4C=kr-JDUF3WRxjxeNU4eJRwhZ+cFbmx7iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:53391 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbaEFXmI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 May 2014 19:42:08 -0400
Received: by mail-oa0-f47.google.com with SMTP id i7so264884oag.6
        for <linux-mmc@vger.kernel.org>; Tue, 06 May 2014 16:42:08 -0700 (PDT)
In-Reply-To: <CAPDyKFoZQUNCX7Y4C=kr-JDUF3WRxjxeNU4eJRwhZ+cFbmx7iw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, Mike Looijmans <mike.looijmans@topic.nl>, Andrew Bresticker <abrestic@chromium.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On Fri, Apr 25, 2014 at 1:15 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 25 April 2014 00:36, Tim Kryger <tim.kryger@linaro.org> wrote:
>> Switch the common SDHCI code over to use mmc_host's regulator pointers
>> and remove the ones in the sdhci_host structure.  Additionally, use the
>> common mmc_regulator_get_supply function to get the regulators and set
>> the ocr_avail mask.
>>
>> This change sets the ocr_avail directly based upon the voltage ranges
>> supported which ensures ocr_avail is set correctly while allowing the
>> use of regulators that can't provide exactly 1.8v, 3.0v, or 3.3v.
>>
>> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
>
> This looks good to me!
>
> I plan to get Russell's sdhci patchset merged, prior to this patch. So
> likely we need to rebase this patch on top of that soon.
>
> Kind regards
> Ulf Hansson

Hi Ulf,

Can you clarify if this is the series you intend to merge and provide
a rough estimate on when it might happen?

http://www.spinics.net/lists/arm-kernel/msg324984.html

Thanks,
Tim Kryger
