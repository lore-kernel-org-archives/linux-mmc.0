From: "Gao, Yunpeng" <yunpeng.gao@intel.com>
Subject: RE: pre-defined multiple block read/write vs. open ended multiple
 block read/write
Date: Thu, 7 Apr 2011 10:43:03 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A47357136749@shsmsx501.ccr.corp.intel.com>
References: <CE761E84DADF2947A4AF22FB8D97A473570B05A3@shsmsx501.ccr.corp.intel.com>
	<BANLkTi=+bJ60JeOed6E6DF4u8YAtngJOKA@mail.gmail.com>
 <BANLkTimhUjiuz8tMShONsNKdJNSWT=11FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:27769 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755404Ab1DGCpH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Apr 2011 22:45:07 -0400
In-Reply-To: <BANLkTimhUjiuz8tMShONsNKdJNSWT=11FQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

>>> So, the question is, why the current mmc driver does not use the
>pre-defined multiple block read/write commands? Any comments?
>>>
>>
>> While I really don't know, I would guess becase the SD spec has a
>> different definition of ACMD23 than MMC, so perhaps avoiding
>> ACMD/CMD23 that was chosen as the simpler more common alternative.
>> Alternatively, the difference might imply that at one time it was an
>> optional feature. I'll try digging up an early MMCA spec to confirm...
>
>Ok let me correct myself.
>
>For SD:
>ACMD23 - SET_WR_BLK_ERASE_COUNT might speed to the multiple write
>block, but still need CMD12 after the write.
>CMD23 - optional and mandatory on UHS104 cards. CMD23 support is noted
>in SCR register.

Thanks for the response.
I also checked the SD Spec, seems CMD23 was not supported in SD 2.0, but added in SD 3.0 as an optional command and is mandatory on UHS104 cards.

>> At least one new MMC feature now (reliable writes) requires CMD23, and
>> at the very least using SET_BLOCK_COUNT instead of STOP_TRANSMISSION
>> would make that code path more homogenous. Certainly the overhead is
>> the same for MMC - either send an extra command before or after the
>> transfer.

Agree. Although the open ended mode has better compatibility for MMC/SD card,
it does prevent some new eMMC features from being support,
such as Context Management, Data Tag Mechanism and so on.

So I think it makes sense to have an alternate way to enable the pre-defined multiple block read/write mode.

>> I am actually working on a patch to do just that...
>>
>Which I will send shortly.

Very nice. Glad to hear that.

Thanks.

Regards,
Yunpeng

