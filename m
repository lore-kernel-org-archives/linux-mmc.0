From: Roger Quadros <roger.quadros@nokia.com>
Subject: Re: [RFC] MMC: Proposals on reworking clock and power management
Date: Fri, 29 Oct 2010 13:47:59 +0300
Message-ID: <4CCAA65F.2050905@nokia.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B0356A579AF@dbde02.ent.ti.com> <alpine.LFD.2.00.1010271551500.29484@xanadu.home> <AANLkTin3eMgnBjyOE1xzVtJkH7=7Ueaa1qtb5kyw_RWG@mail.gmail.com> <AANLkTi=wMWGJVP0YHZzjXjeEyVYrxBFEx9_T0a5GLNCn@mail.gmail.com> <AANLkTimAfVhz80SDifeF2EgZ=3Hz-Mvye9GhyTLQpa19@mail.gmail.com> <alpine.LFD.2.00.1010281206480.2647@xanadu.home> <AANLkTi=556hdm7SSc9j8FF9F37M6A8Q2P7mJsD1mq5Lo@mail.gmail.com> <AANLkTi=SAwgaR5ugPZw-Nf4JRJMqgLAmZbKPJpkyRSGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:34868 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326Ab0J2Kqu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Oct 2010 06:46:50 -0400
In-Reply-To: <AANLkTi=SAwgaR5ugPZw-Nf4JRJMqgLAmZbKPJpkyRSGg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ext Ohad Ben-Cohen <ohad@wizery.com>
Cc: Kishore Kadiyala <kishorek.kadiyala@gmail.com>, Nicolas Pitre <nico@fluxnic.net>, "Ghorai, Sukumar" <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.ml.walleij@gmail.com>, Adrian Hunter <adrian.hunter@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "S, Venkatraman" <svenkatr@ti.com>

On 10/28/2010 11:51 PM, ext Ohad Ben-Cohen wrote:
> On Thu, Oct 28, 2010 at 6:40 PM, Kishore Kadiyala
> <kishorek.kadiyala@gmail.com>  wrote:
>> On Thu, Oct 28, 2010 at 9:43 PM, Nicolas Pitre<nico@fluxnic.net>  wrote:
>>> This is not clear that this is something that the core can effectively
>>> help with.  Opportunistic power saving at the host controller level is
>>> pretty much hardware dependent and may wildly vary in capabilities...
>>> and bugs.  So in this later case I think the driver for the host
>>> controller is the best place to just set up a timer and gate the clock
>>> after a certain period of inactivity for example.
>
> makes sense, thanks.

just to be sure, we're talking about controller clock and not card clock. right?

>
>> Agree,
>> So briefly, calling pm_runtime_put_sync using a activity based timer
>> in the host Controller
>> driver will gate the clock to the controller .
>
> Just make sure you call pm_suspend_ignore_children(), because you want
> to be able to gate that clock even when the card is still active

Let's be specific when we say clock. Which clock?

-- 
regards,
-roger
