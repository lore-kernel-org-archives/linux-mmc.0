Return-Path: <SRS0=kdqm=AL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805B4C433E3
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Jun 2020 06:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64D4B20759
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Jun 2020 06:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbgF3Gb4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 30 Jun 2020 02:31:56 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:41058 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730002AbgF3Gbz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 30 Jun 2020 02:31:55 -0400
X-Greylist: delayed 36006 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jun 2020 02:31:53 EDT
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 4EA0BBC078;
        Tue, 30 Jun 2020 06:31:41 +0000 (UTC)
Subject: Re: [PATCH] Remove handhelds.org links and email addresses
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     corbet@lwn.net, aaro.koskinen@iki.fi, tony@atomide.com,
        linux@armlinux.org.uk, daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, kgene@kernel.org, krzk@kernel.org,
        dmitry.torokhov@gmail.com, lee.jones@linaro.org,
        ulf.hansson@linaro.org, davem@davemloft.net, kuba@kernel.org,
        b.zolnierkie@samsung.com, j.neuschaefer@gmx.net,
        mchehab+samsung@kernel.org, gustavo@embeddedor.com,
        gregkh@linuxfoundation.org, yanaijie@huawei.com,
        daniel.vetter@ffwll.ch, rafael.j.wysocki@intel.com,
        Julia.Lawall@inria.fr, linus.walleij@linaro.org,
        viresh.kumar@linaro.org, arnd@arndb.de, jani.nikula@intel.com,
        yuehaibing@huawei.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-parisc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
References: <20200629203121.7892-1-grandmaster@al2klimov.de>
 <20200629211027.GA1481@kunai>
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
Message-ID: <09c27ac7-f5bc-064b-6751-9edc04de1679@al2klimov.de>
Date:   Tue, 30 Jun 2020 08:31:40 +0200
MIME-Version: 1.0
In-Reply-To: <20200629211027.GA1481@kunai>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: +
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



Am 29.06.20 um 23:10 schrieb Wolfram Sang:
> Hi Alexander,
> 
> thanks for trying to fix this, yet I have some doubts.
> 
> On Mon, Jun 29, 2020 at 10:31:21PM +0200, Alexander A. Klimov wrote:
>> Rationale:
>> https://lore.kernel.org/linux-doc/20200626110706.7b5d4a38@lwn.net/
> 
> I think we need some text here. Clicking on a link to understand what a
> patch is about is not comfortable. You can add the link with a Link: tag
> for additional information.
Fine. I can easily make a v2 patch, but first...

> 
> Removing stale email addresses may have some value, but removing...
> 
>>   Compaq's Bootldr + John Dorsey's patch for Assabet support
>> -(http://www.handhelds.org/Compaq/bootldr.html)
> 
> ... information like this is not good. 'Wayback machine' still has
> copies in case someone wants to look at where the infos came from.
If we shall not remove *this link*, maybe we shall not remove *all links*?

@Jon You've kinda initiated the patch, what's your opinion? Bad 
squatters or good Wayback machine?

> 
>> - * Copyright 2004-2005  Phil Blundell <pb@handhelds.org>
>> + * Copyright 2004-2005  Phil Blundell
> 
> This is an OK case in my book...
> 
> 
>> -MODULE_AUTHOR("Phil Blundell <pb@handhelds.org>");
>> +MODULE_AUTHOR("Phil Blundell");
> 
> ... same here ...
> 
>> @@ -435,7 +435,6 @@
>>                              case a PCI bridge (DEC chip 21152). The value of
>>                              'pb' is now only initialized if a de4x5 chip is
>>                              present.
>> -                           <france@handhelds.org>
> 
> This is kind of a signature and should be kept IMO.
What for? An email address is for someone who'd like to send an email to 
it. At the moment handhelds.org doesn't even have an MX record.

> 
>>    * 2001/07/23: <rmk@arm.linux.org.uk>
>> - *	- Hand merge version from handhelds.org CVS tree.  See patch
>> + *	- Hand merge version from CVS tree.  See patch
> 
> That information may be useful.
Again: What for? For visiting it and thinking like damn, it's gone?

> 
> 
>>   /* SPDX-License-Identifier: GPL-2.0-only */
>>   /* -*- linux-c -*-
>> - *
>> - * (C) 2003 zecke@handhelds.org
> 
> Removing copyright is a bad idea.
IMAO the CREDITS file is for (c) headers.
If you didn't submit a patch for that - your problem.

If you disagree, I can look up git blame.

> 
> Probably some comment blocks are cruft meanwhile and can be removed as a
> whole. That can be discussed. But removing only the handhelds.org part
> makes most parts worse IMHO.
> 
> Thanks and happy hacking,
> 
>     Wolfram
> 
