From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] mmc: agressive clocking framework v9
Date: Mon, 8 Nov 2010 01:47:47 -0800
Message-ID: <C771C677-E21B-41FC-ABEE-DBEFEFA8569D@marvell.com>
References: <43E4817426ED174AA81263BCECB4351D131D9D41BC@sc-vexch3.marvell.com>
 <AANLkTi=6FeuxhEL1ht4thc6PQ05wLFo7d2NA-XUYwHxy@mail.gmail.com>
 <041757E8-9FCD-4FA8-8079-7A3FC07E4038@marvell.com>
 <AANLkTimWg_EE+hg__b0NW792szvY+4Rc_4XsjbHN_tJv@mail.gmail.com>
 <4CD7C4DB.7070105@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:58197 "HELO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751822Ab0KHJsf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 8 Nov 2010 04:48:35 -0500
In-Reply-To: <4CD7C4DB.7070105@stericsson.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, David Vrabel <david.vrabel@csr.com>


On Nov 8, 2010, at 1:37 AM, Linus Walleij wrote:

> Ohad Ben-Cohen wrote:
> 
>> So the decision whether to enable clock gating for SDIO should not be
>> static (eventually. I'm not saying this is something Linus should take
>> care of in his patch, it's up to us to make this work). By default,
>> SDIO clock gating should be disabled, but we need to allow drivers to
>> explicitly enable it if supported.
> 
> I currently (patch v8) disable gating for all SDIO cards,
> but I guess there are two approaches to cases where you'd
> like to enable it:
> 
> - Card (including SDIO device) whitelisting.

do not understand the term whitelisting ..  please explain.

> 
> - Host whitelisting - for the case where as gateable SDIO
>  device is soldered to the bus.
> 
> The first looks like big-ish so would be a separate patch, but a
> host flag for the latter like MMC_CAP_GATE_SDIO can easily be
> folded into a v10 of this patch.

Nico was not in favor of this.  He thought it best to have the core/ layer handle this.


> 
> Is that desireable?
> 
> Yours,
> Linus Walleij

