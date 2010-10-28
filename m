From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [RFC] MMC: Proposals on reworking clock and power management
Date: Thu, 28 Oct 2010 20:41:44 +0530
Message-ID: <AANLkTin3eMgnBjyOE1xzVtJkH7=7Ueaa1qtb5kyw_RWG@mail.gmail.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B0356A579AF@dbde02.ent.ti.com>
	<alpine.LFD.2.00.1010271551500.29484@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56927 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860Ab0J1PQt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Oct 2010 11:16:49 -0400
Received: by wwe15 with SMTP id 15so2151509wwe.1
        for <linux-mmc@vger.kernel.org>; Thu, 28 Oct 2010 08:16:48 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1010271551500.29484@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: "Ghorai, Sukumar" <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.ml.walleij@gmail.com>, Adrian Hunter <adrian.hunter@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "S, Venkatraman" <svenkatr@ti.com>

Nicolas,

<snip >
>
>> =A0 =A02.a) Card sleep, Power cutoff to the card:
>> =A0 =A0 =A0This should be handled in the core where based on block l=
ayer
>> =A0 =A0 =A0activity, calling corresponding API's from bus layer:
>> =A0 =A0 =A0mmc_power_save_host/ mmc_power_restore_host
>
> Same issue here. =A0Card power is for the core to decide, but the
> controller driver may perform opportunistic power down of the control=
ler
> itself when it is possible and the core does not need to know about i=
t.

I think card power decision is taken care in the core as per below patc=
h :
https://patchwork.kernel.org/patch/226631/

And regarding "opportunistic power down of the controller" can be done =
by
adapting driver to PM-Runtime

<snip>

Regards,
Kishore
