From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [[v4] 2/5] MMC: Use CMD23 for multiblock transfers when we can.
Date: Thu, 19 May 2011 12:01:22 -0500
Message-ID: <BANLkTi=yJuEtN-SSokhp5CE_mCz9D9D5SA@mail.gmail.com>
References: <1302950458-1969-1-git-send-email-andreiw@motorola.com>
	<1303870235-29041-1-git-send-email-andreiw@motorola.com>
	<1303870235-29041-2-git-send-email-andreiw@motorola.com>
	<1303870235-29041-3-git-send-email-andreiw@motorola.com>
	<4DD48273.4060402@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og116.obsmtp.com ([64.18.0.147]:52791 "EHLO
	exprod5og116.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933550Ab1ESRBZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 May 2011 13:01:25 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.129.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p4JGx4nw012545
	for <linux-mmc@vger.kernel.org>; Thu, 19 May 2011 12:59:04 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p4JGwopo012396
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Thu, 19 May 2011 12:59:03 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so3061087wwb.3
        for <linux-mmc@vger.kernel.org>; Thu, 19 May 2011 10:01:22 -0700 (PDT)
In-Reply-To: <4DD48273.4060402@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, arindam.nath@amd.com, cjb@laptop.org, arnd@arndb.de, Kyungmin Park <kyungmin.park@samsung.com>

On Wed, May 18, 2011 at 9:37 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi Andrei
>
> Andrei Warkentin wrote:
>> CMD23-prefixed instead of open-ended multiblock transfers
>> have a performance advantage on some MMC cards.
>>
> you mentioned about "some MMC cards".
> Conversely, that means the some card didn't have a performance advantage?
>
> Did you find the performance advantage?
> if you found the advantage and you can tell me,
> i want to know what do you have the some MMC cards..
>

I've tested this on a Sandisk eMMC where I saw as good as
a 50% improvement on writes (30% real-life use cases). This was a
SEM32G 4.3+ part.

A
