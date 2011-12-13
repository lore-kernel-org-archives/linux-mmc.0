From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/4] SDHCI: add sdhci_get_cd callback to detect the card
Date: Tue, 13 Dec 2011 13:06:17 -0500
Message-ID: <m2aa6wl52e.fsf@bob.laptop.org>
References: <1323077026-12071-1-git-send-email-r66093@freescale.com>
	<F2681397-0395-43F7-902F-9A575EDD843B@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:54831 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755186Ab1LMSG0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 13 Dec 2011 13:06:26 -0500
In-Reply-To: <F2681397-0395-43F7-902F-9A575EDD843B@marvell.com> (Philip
	Rakity's message of "Mon, 5 Dec 2011 10:48:50 -0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "<r66093@freescale.com> <r66093@freescale.com>" <r66093@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jerry Huang <Chang-Ming.Huang@freescale.com>

Hi,

On Mon, Dec 05 2011, Philip Rakity wrote:
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 6d8eea3..66afd82 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2,6 +2,7 @@
>>  * linux/drivers/mmc/host/sdhci.c - Secure Digital Host Controller
>> Interface driver
>>  *
>>  *  Copyright (C) 2005-2008 Pierre Ossman, All Rights Reserved.
>> + *  Copyright (C) 2011 Freescale Semiconductor Inc.
>
>
> Lots of folks have made mods to this code and they have not added a
> copyright name.
> What is the rule Chris ?

You're right that many people have added far more significant changes
than this without adding a copyright string, so we shouldn't add this
one now.

In general, though, I'd say that the rule is that you may (but are not
required to) add a copyright string if your change is reasonably large
and non-obvious/non-boilerplate.  I don't think the copyright string
means anything -- copyright is implicit in the authorship history which
Git preserves -- but I'm not a lawyer.  Having your name in the
copyright string may make enforcing the GPL for that driver slightly
easier for you, so for that reason I'm glad Pierre added himself.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
