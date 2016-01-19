From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/2] sdio: Prevent re-tuning conflicting with custom sleep
Date: Tue, 19 Jan 2016 11:51:56 +0200
Message-ID: <569E073C.7080204@intel.com>
References: <1430232341-8307-1-git-send-email-adrian.hunter@intel.com>
 <565701FE.9010403@intel.com>
 <CAPDyKFrxM25QmbVEqnfRi+gjT6Jg_uAFXuO2xdCw6H2ST7EDZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:53056 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757627AbcASJzT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 19 Jan 2016 04:55:19 -0500
In-Reply-To: <CAPDyKFrxM25QmbVEqnfRi+gjT6Jg_uAFXuO2xdCw6H2ST7EDZw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Arend van Spriel <arend@broadcom.com>, linux-mmc <linux-mmc@vger.kernel.org>

On 27/11/15 16:06, Ulf Hansson wrote:
> On 26 November 2015 at 13:58, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 28/04/15 17:45, Adrian Hunter wrote:
>>> Here are 2 patches that allow brcmfmac to awake from a
>>> custom sleep state that conflicts with re-tuning.
>>>
>>> The first patch adds sdio_retune_hold_now() and
>>> sdio_retune_release(). They are used in the 2nd patch
>>> to prevent re-tuning for the 'wake-up' command.
>>>
>>>
>>> Adrian Hunter (2):
>>>       mmc: core: Add functions for SDIO to hold re-tuning
>>>       brcmfmac: Prevent re-tuning conflicting with 'wake-up'
>>>
>>>  drivers/mmc/core/host.c                        |  6 ++++++
>>>  drivers/mmc/core/host.h                        |  1 +
>>>  drivers/mmc/core/sdio_io.c                     | 13 +++++++++++++
>>>  drivers/net/wireless/brcm80211/brcmfmac/sdio.c |  6 ++++++
>>>  include/linux/mmc/sdio_func.h                  |  3 +++
>>>  5 files changed, 29 insertions(+)
>>
>> Hi
>>
>> These patches still apply and are still needed.
>> Can they be applied?
>>
> 
> I need to have yet another round of thinking about this, I will get
> back to as soon as I can.

I see drivers/net/wireless/brcm80211/brcmfmac/sdio.c has moved but otherwise
these still apply.  Any chance to look at this?

