From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 0/4] mmc: sdhci: Fix card detect race for Intel BXT/APL
Date: Thu, 11 Feb 2016 11:41:02 +0100
Message-ID: <CAPDyKFqadVcVM8Qcs9eUQzB1e1kZbTtoZPnB8qoLo=EdVEOvOg@mail.gmail.com>
References: <1455027158-21564-1-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFp0XCYa6LST2JJcdc5g10HEStPKTkX0P7aGC2iBn268Ww@mail.gmail.com>
	<56BC6330.20209@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:33776 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbcBKKlC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Feb 2016 05:41:02 -0500
Received: by mail-yw0-f174.google.com with SMTP id u200so35834597ywf.0
        for <linux-mmc@vger.kernel.org>; Thu, 11 Feb 2016 02:41:02 -0800 (PST)
In-Reply-To: <56BC6330.20209@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>

On 11 February 2016 at 11:32, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 11/02/16 12:00, Ulf Hansson wrote:
>> On 9 February 2016 at 15:12, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> Hi
>>>
>>> Here is V2 of patches to fix a problem on Intel BXT/APL.
>>> The PCI and ACPI Ids for BXT/APL were added in v4.4 so the
>>> patches are cc stable v4.4+.
>>>
>>> Changes in V2:
>>>
>>> Override the mmc host ->get_cd() operation instead of adding a
>>> new sdhci host operation.
>>>
>>>
>>> Adrian Hunter (4):
>>>       mmc: sdhci: Allow override of mmc host operations
>>>       mmc: sdhci: Allow override of get_cd() called from sdhci_request()
>>>       mmc: sdhci-pci: Fix card detect race for Intel BXT/APL
>>>       mmc: sdhci-acpi: Fix card detect race for Intel BXT/APL
>>>
>>>  drivers/mmc/host/sdhci-acpi.c     | 30 ++++++++++++++++++++++++++++++
>>>  drivers/mmc/host/sdhci-pci-core.c | 31 +++++++++++++++++++++++++++++++
>>>  drivers/mmc/host/sdhci.c          |  5 +++--
>>>  drivers/mmc/host/sdhci.h          |  1 +
>>>  4 files changed, 65 insertions(+), 2 deletions(-)
>>>
>>>
>>> Regards
>>> Adrian
>>
>> This seems like step in good direction for sdhci, as well as it solves
>> a regression.
>>
>> Do you want me to pick it up for fixes?
>
> That would be good, thanks!
>

Thanks, applied for fixes!

Kind regards
Uffe
