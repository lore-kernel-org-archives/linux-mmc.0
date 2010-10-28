From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [RFC] MMC: Proposals on reworking clock and power management
Date: Thu, 28 Oct 2010 21:09:04 +0530
Message-ID: <AANLkTi=wMWGJVP0YHZzjXjeEyVYrxBFEx9_T0a5GLNCn@mail.gmail.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B0356A579AF@dbde02.ent.ti.com>
	<alpine.LFD.2.00.1010271551500.29484@xanadu.home>
	<AANLkTin3eMgnBjyOE1xzVtJkH7=7Ueaa1qtb5kyw_RWG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54860 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759113Ab0J1PjH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Oct 2010 11:39:07 -0400
Received: by eye27 with SMTP id 27so1557471eye.19
        for <linux-mmc@vger.kernel.org>; Thu, 28 Oct 2010 08:39:06 -0700 (PDT)
In-Reply-To: <AANLkTin3eMgnBjyOE1xzVtJkH7=7Ueaa1qtb5kyw_RWG@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: "Ghorai, Sukumar" <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.ml.walleij@gmail.com>, Adrian Hunter <adrian.hunter@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "S, Venkatraman" <svenkatr@ti.com>

On Thu, Oct 28, 2010 at 8:41 PM, Kishore Kadiyala
<kishorek.kadiyala@gmail.com> wrote:
> Nicolas,
>
> <snip >
>>
>>> =A0 =A02.a) Card sleep, Power cutoff to the card:
>>> =A0 =A0 =A0This should be handled in the core where based on block =
layer
>>> =A0 =A0 =A0activity, calling corresponding API's from bus layer:
>>> =A0 =A0 =A0mmc_power_save_host/ mmc_power_restore_host
>>
>> Same issue here. =A0Card power is for the core to decide, but the
>> controller driver may perform opportunistic power down of the contro=
ller
>> itself when it is possible and the core does not need to know about =
it.
>
> I think card power decision is taken care in the core as per below pa=
tch :
> https://patchwork.kernel.org/patch/226631/

Actually I was looking into the series posted by
Ohad - https://patchwork.kernel.org/patch/226611/ .

Looking at the below patches, which takes care of card power off/on
once adapted to PM-Runtime
https://patchwork.kernel.org/patch/226631/
https://patchwork.kernel.org/patch/226671/

Wouldn't adapting the host driver just to PM-Runtime will answer the
above issues?

Regards,
Kishore
>
> And regarding "opportunistic power down of the controller" can be don=
e by
> adapting driver to PM-Runtime
>
> <snip>
>
> Regards,
> Kishore
>
