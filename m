From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH v3 01/12] mmc: sdhci: add support for auto CMD23
Date: Sat, 16 Apr 2011 03:20:49 -0500
Message-ID: <BANLkTimVQwbDt9OSe63miCwsErt=wKQKCA@mail.gmail.com>
References: <1302863942-1774-1-git-send-email-arindam.nath@amd.com>
	<1302863942-1774-2-git-send-email-arindam.nath@amd.com>
	<BANLkTimZGonC+D0czjiY4i7pFFW=upj_qw@mail.gmail.com>
	<6C03668EAF45B747AF947A1603D1B300EB443FB6@SAUSEXMBP01.amd.com>
	<BANLkTimEKQceSiuL=dX2yhMw+MLu7BzLvQ@mail.gmail.com>
	<BANLkTimfQo7wJ3_ecs64VSp7xKJrjYdJ3w@mail.gmail.com>
	<BANLkTikoAWEMGOAHrxJT4jNknVFtyuhdqw@mail.gmail.com>
	<000001cbfbfd$efa6e120$cef4a360$@org>
	<6C03668EAF45B747AF947A1603D1B300EB444353@SAUSEXMBP01.amd.com>
	<001601cbfc00$b87eac20$297c0460$@org>
	<6C03668EAF45B747AF947A1603D1B300EB444355@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og109.obsmtp.com ([64.18.0.188]:53104 "EHLO
	exprod5og109.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112Ab1DPIUx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Apr 2011 04:20:53 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3G8J1Oc020350
	for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 04:19:01 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3G8J0N6020343
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 04:19:01 -0400 (EDT)
Received: by wwb28 with SMTP id 28so3735414wwb.3
        for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 01:20:49 -0700 (PDT)
In-Reply-To: <6C03668EAF45B747AF947A1603D1B300EB444355@SAUSEXMBP01.amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Nath, Arindam" <Arindam.Nath@amd.com>
Cc: Subhash Jadavani <subhashj@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Sat, Apr 16, 2011 at 1:43 AM, Nath, Arindam <Arindam.Nath@amd.com> wrote:
>> and
>> then sending the CMD23 for multi block read/write. MMC cards also
>> supports
>> CMD23 so in that case again you have to check MMC EXT_CSD register for
>> CMD23
>
> Yes, you are right. I followed the Physical Layer Spec v3.01 as is, so in case the support is needed for MMC cards, we will need to take care of that too.

It's already done. In the block layer. All you need to do is honor
mmc_request->sbc and set Auto-CMD23 and the CMD23 argument.

>> support. All this logic is better be in core/block layer and let
>> core/block
>> layer inform host controller when to send CMD23 and when not to.
>
> Well in that case, Auto CMD23 will never make sense.

I am unsure why you think that. All Auto CMD23 means is that instead
of manually sending CMD23 (and incurring the extra interrupt penalty),
I have the host automatically do it. But this feature should only be
enabled when upper layers care to enabled it. This is what the CMD23
support plumbed in.

A
