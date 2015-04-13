From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 01/15] mmc: host: Add facility to support re-tuning
Date: Mon, 13 Apr 2015 14:30:53 +0200
Message-ID: <CAPDyKFp8yH9CMcAbx7T-zw1qjWbdc6kx4KErykcnCH=46dsAyw@mail.gmail.com>
References: <1427489863-9050-1-git-send-email-adrian.hunter@intel.com>
	<1427489863-9050-2-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFrs4X+nDDkikUNSO5uz+Wsoz3TmkLJ9RwvvdjYqd8+Ygg@mail.gmail.com>
	<551BDAEA.20405@intel.com>
	<CAPDyKFrve0VmhvPk-=V64Cab8AcqvMkGxOM1Aju8gV+u3vFxyg@mail.gmail.com>
	<551D6BCA.7040708@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36409 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbbDMMay (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Apr 2015 08:30:54 -0400
Received: by qku63 with SMTP id 63so177657131qku.3
        for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2015 05:30:53 -0700 (PDT)
In-Reply-To: <551D6BCA.7040708@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 2 April 2015 at 18:18, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 2/04/2015 4:05 p.m., Ulf Hansson wrote:
>>
>> [...]
>>
>>>>
>>>>>    - ability to enable / disable re-tuning
>>>>
>>>>
>>>> Handled internally by the mmc core.
>>>
>>>
>>> The host controller driver enables re-tuning based on whether the host
>>> controller requires it for that transfer mode. For example, only the
>>> SDHCI
>>> host controller knows if tuning is required for SDR50 mode according to
>>> the
>>> SDHCI capability register bit 45.
>>
>>
>> That seems a bit silly.
>>
>> All hosts wants the re-tuning to be "enabled" if the current used
>> speed mode requires it. It's not a host driver thing to deal with,
>> just the core.
>
>
> No it is up to the host controller. That is how it is in the
> SD Host Controller Specification. Both whether to tune SDR50 and
> whether to run a re-tuning timer.
>
> Tuning is inherently a host controller problem. The card can always
> receive correctly from the host, but the host has to adjust its
> "sampling point" to receive from the card. Only the host knows its
> capabilities in this regard.

The requirement of doing re-tuning is stated in the eMMC/SD specs. The
SDHCI spec is just adopting to what these specs already states. Then,
I think the mmc core is the only one, who shall be able of
enable/disable re-tuning and thus we shouldn't need any APIs for that.

Hosts needs to be able to flag that re-tuning is needed and to
configure the re-tuning timeout (optional).

[...]

Kind regards
Uffe
