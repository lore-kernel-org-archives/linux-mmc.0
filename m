From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Initial signal voltage ?
Date: Tue, 15 Sep 2015 14:43:36 -0300
Message-ID: <CAOMZO5Aa+gUkYaMShF9e=sp44jxrHX8zUq_efWXbqCfg6T_nrg@mail.gmail.com>
References: <1439225438.3120.94.camel@transmode.se>
	<CAPDyKFpDzBV9zXAZH_KddZVdUQ_t2W3Qb3yG70ceagv4+oy7cQ@mail.gmail.com>
	<1440505201.3349.59.camel@transmode.se>
	<CAPDyKFpv3HyZSvGXWb-dzD1nec0173TyzegxRiWuhTdm9GdXAg@mail.gmail.com>
	<1440686001.3349.115.camel@transmode.se>
	<CAPDyKFrVNoyeHdcBbTJ3AFhU2EeWZsXqBkCqHNswWzCKxUOs=A@mail.gmail.com>
	<1440695797.3349.121.camel@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:32822 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbbIORnh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Sep 2015 13:43:37 -0400
Received: by obbbh8 with SMTP id bh8so141447767obb.0
        for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2015 10:43:36 -0700 (PDT)
In-Reply-To: <1440695797.3349.121.camel@transmode.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Thu, Aug 27, 2015 at 2:16 PM, Joakim Tjernlund
<joakim.tjernlund@transmode.se> wrote:

>
> None the less, the info is there in the host caps so why not use it?
> If caps say 1.8V only why insist on trying 3/3.3 Volt?

Yes, it seems this is similar to the issue I tried to solve before:
http://www.spinics.net/lists/linux-mmc/msg32285.html
