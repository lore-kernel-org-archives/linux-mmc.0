From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH] MMC: Fix erase/trim for certain SanDisk cards.
Date: Tue, 12 Apr 2011 14:30:22 -0500
Message-ID: <BANLkTimE_b4vKPfoUpcaj_34JLe3AtgScg@mail.gmail.com>
References: <BANLkTi=N75ATcXHqbjDMpCMJ1bGnJggqog@mail.gmail.com>
	<1302638625-32106-1-git-send-email-andreiw@motorola.com>
	<m31v17z2lz.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og109.obsmtp.com ([64.18.0.188]:52245 "EHLO
	exprod5og109.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755251Ab1DLTaY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2011 15:30:24 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.130.20])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3CJSZm1021436
	for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2011 15:28:35 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3CIhZjP025675
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2011 15:28:34 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so9729205wyb.15
        for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2011 12:30:22 -0700 (PDT)
In-Reply-To: <m31v17z2lz.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Tue, Apr 12, 2011 at 2:33 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi Andrei,
>
> On Tue, Apr 12 2011, Andrei Warkentin wrote:
>> CMD38 argument is passed through EXT_CSD[113].
>>
>> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
>> ---

>
> You're still missing the final argument to mmc_switch(), no?
>
> Thanks,
>

I didn't amend before sending. Sorry. The right version has just been
resent with subject prefix [PatchRebased].

A
