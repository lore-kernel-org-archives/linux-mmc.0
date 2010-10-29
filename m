From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC] MMC: Proposals on reworking clock and power management
Date: Fri, 29 Oct 2010 16:03:17 +0200
Message-ID: <AANLkTikcQhsNVrE5DF7KGhfZ9hU0cYuia+w8Zp=SV7Oz@mail.gmail.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B0356A579AF@dbde02.ent.ti.com>
 <alpine.LFD.2.00.1010271551500.29484@xanadu.home> <AANLkTin3eMgnBjyOE1xzVtJkH7=7Ueaa1qtb5kyw_RWG@mail.gmail.com>
 <AANLkTi=wMWGJVP0YHZzjXjeEyVYrxBFEx9_T0a5GLNCn@mail.gmail.com>
 <AANLkTimAfVhz80SDifeF2EgZ=3Hz-Mvye9GhyTLQpa19@mail.gmail.com>
 <alpine.LFD.2.00.1010281206480.2647@xanadu.home> <AANLkTi=556hdm7SSc9j8FF9F37M6A8Q2P7mJsD1mq5Lo@mail.gmail.com>
 <AANLkTi=SAwgaR5ugPZw-Nf4JRJMqgLAmZbKPJpkyRSGg@mail.gmail.com> <4CCAA65F.2050905@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:32997 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402Ab0J2ODj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Oct 2010 10:03:39 -0400
Received: by ywk9 with SMTP id 9so1979601ywk.19
        for <linux-mmc@vger.kernel.org>; Fri, 29 Oct 2010 07:03:38 -0700 (PDT)
In-Reply-To: <4CCAA65F.2050905@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roger Quadros <roger.quadros@nokia.com>
Cc: Kishore Kadiyala <kishorek.kadiyala@gmail.com>, Nicolas Pitre <nico@fluxnic.net>, "Ghorai, Sukumar" <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.ml.walleij@gmail.com>, Adrian Hunter <adrian.hunter@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "S, Venkatraman" <svenkatr@ti.com>

On Fri, Oct 29, 2010 at 12:47 PM, Roger Quadros <roger.quadros@nokia.com> wrote:
> just to be sure, we're talking about controller clock and not card clock.
> right?

yes.

>>> driver will gate the clock to the controller .
>>
>> Just make sure you call pm_suspend_ignore_children(), because you want
>> to be able to gate that clock even when the card is still active
>
> Let's be specific when we say clock. Which clock?

controller.
