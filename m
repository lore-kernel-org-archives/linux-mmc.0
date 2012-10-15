From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH 0/4] MMC: some omap_hsmmc fixes
Date: Mon, 15 Oct 2012 21:37:43 +0530
Message-ID: <CAOyx1LqzM7a3dkCiWAw8zMf1UGO-A0CBesdE5KcsqGyWH++VTw@mail.gmail.com>
References: <1350039495-360-1-git-send-email-zonque@gmail.com>
	<50792DFE.9060609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:57687 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302Ab2JOQHp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Oct 2012 12:07:45 -0400
In-Reply-To: <50792DFE.9060609@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linus Walleij <linus.walleij@stericsson.com>

Daniel,
On Sat, Oct 13, 2012 at 2:31 PM, Daniel Mack <zonque@gmail.com> wrote:
> On 12.10.2012 12:58, Daniel Mack wrote:
>> Here are some assorted patches for the omap_hsmmc driver that I need on
>> top Linus' current development branch to make it work on a AM33xx board.
>>
>> 1/4 and 2/4 qualify as bug fixes and I'm puzzled that these didn't hit
>> anyone else yet.
>>
>>
>> Daniel Mack (4):
>>   MMC: omap_hsmmc: set platform data after probe from DT node
>>   MMC: omap_hsmmc: fix DMA config block
>>   MMC: omap_hsmmc: claim pinctrl at probe time
>>   MMC: omap_hsmmc: add DT property for max bus frequency
>
> Ok, so 1/4 and 2/4 will be solved differently upstream, so they can be
> dropped.
>
> The other two remain, and 3/4 got an Acked-by Linus W.
>
Thanks.
I've just clubbed your two patches with Balaji's fixes and sent to Chris.
