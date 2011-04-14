From: "Gao, Yunpeng" <yunpeng.gao@intel.com>
Subject: RE: SET_BLOCK_COUNT-bounded multiblock transfers
Date: Thu, 14 Apr 2011 17:05:25 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A473571F5610@shsmsx501.ccr.corp.intel.com>
References: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
 <BANLkTikFWhDhCjGKBBE4PP9sNa2ynVEOtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:4046 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932181Ab1DNJF4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Apr 2011 05:05:56 -0400
In-Reply-To: <BANLkTikFWhDhCjGKBBE4PP9sNa2ynVEOtg@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "arnd@arndb.de" <arnd@arndb.de>, "cjb@laptop.org" <cjb@laptop.org>

>-----Original Message-----
>From: linux-mmc-owner@vger.kernel.org
>[mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Andrei Warkentin
>Sent: Thursday, April 14, 2011 8:04 AM
>To: linux-mmc@vger.kernel.org
>Cc: arnd@arndb.de; cjb@laptop.org; Gao, Yunpeng
>Subject: Re: SET_BLOCK_COUNT-bounded multiblock transfers
>
>On Wed, Apr 13, 2011 at 7:38 PM, Andrei Warkentin
><andreiw@motorola.com> wrote:
>> This is a request for comments for a patch set that enables
>> predefined multiblock transfers if these are supported.
>>
>> Before this patch set, all multiblock transfers look like (for example)
>>
>> CMD25 -> [block] [block] [block] [block] -> CMD12 (stop)
>>
>> ...or for controllers with Auto-CMD12
>>
>> CMD25 -> [block] [block] [block] [block] (host sends CMD12 itself).
>>
>> We want to enable -
>>
>> CMD23(4 blocks) CMD25 [data] [data] [data] [data]
>>
>> ...and for controllers with Auto-CMD23 -
>>
>> (Host sends CMD23(4 blocks)) CMD25 [data] [data] [data] [data]
>>
>> The interrupt overhead is the same, but for cards that optimize for
>predefined transfers
>> we can see better transfer rates. I've tested this on a Sandisk eMMC where I
>saw as good as
>> a 50% improvement on writes, and on a Toshiba eMMC where I saw no
>improvement at all. Also,
>> reliable writes use CMD23, so this cleans up that code path as well. Note,
>that if a transfer
>> fails, CMD12 must still be sent, so it is not sufficient to just not fill the
>mrq->stop field
>> while doing a CMD23-enabled transfer. Due to this error handling and
>off-loads of Auto-CMD23
>> (and interaction with Auto-CMD12) handling of SET_BLOCK_COUNT, just like
>STOP, is left to the host driver.
>> Host driver now exposes MMC_CAP_CMD23 if it has been changed to
>handle the new "sbc" field in struct mmc_request.
>> If a host doesn't expose this capability, open-ended transfers are used, and
>all functionality
>> relying on CMD23 (such as reliable writes) is disabled.
>>
>> The third patch has been only tested on SD cards that don't expose CMD23.
>Still need to get an SDXC
>> card and test it out, but I wanted to get eyes on this patch set anyway :-).
>>
>> I had a fourth patch enabling Auto-CMD23 for SDHCI, but I'll hold off until I
>can verify it.
>>
>> Thoughts?
>>
>> Table of Contents:
>> [RFC 1/3] MMC: use CMD23 for multiblock transfers when we can.
>> [RFC 2/3] MMC: Implement MMC_CAP_CMD23 for SDHCI.
>> [RFC 3/3] MMC: Block CMD23 support for UHS104/SDXC cards.
>>
>> A
>>
>
>+ Yunpeng

Thanks for add me in the loop. I'm fine with the 3 patches.

And just think that maybe it's not necessary to enable the Auto-CMD23 for SDHCI,
because I have an impression that some Silicon bugs related to Auto-CMD12/Auto-CMD23
existed in some vendor's SDHCI host controller IP, and I'm not sure they have been fixed or not by now.

Regards,
Yunpeng

