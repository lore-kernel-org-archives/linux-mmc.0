From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [RFC] MMC: Proposals on reworking clock and power management
Date: Wed, 27 Oct 2010 20:37:19 +0530
Message-ID: <AANLkTikv_r5-tJEd2ozq-rcY3k3hTgAX2jXq+UKG7bDd@mail.gmail.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B0356A579AF@dbde02.ent.ti.com>
	<20101027153218.04462a45@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50698 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183Ab0J0PHV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Oct 2010 11:07:21 -0400
Received: by fxm16 with SMTP id 16so775211fxm.19
        for <linux-mmc@vger.kernel.org>; Wed, 27 Oct 2010 08:07:20 -0700 (PDT)
In-Reply-To: <20101027153218.04462a45@lxorguk.ukuu.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Ghorai, Sukumar" <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.ml.walleij@gmail.com>, Nicolas Pitre <nico@fluxnic.net>, Adrian Hunter <adrian.hunter@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "S, Venkatraman" <svenkatr@ti.com>

On Wed, Oct 27, 2010 at 8:02 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wr=
ote:
>> 2. Ideally host-driver driver should not tell the core to shut down
>> =A0 =A0the upper layers, instead the core should decide when to
>> =A0 =A0"disabled clock or cut the power".
>
> How will the core know ?
>
> I actually think you are simply perpetuating the mess in the existing=
 MMC
> driver where everything is driven by a core which as a result is a tw=
isty
> maze of exceptions and flags to say "except for this" "except for tha=
t".
>
> The core MMC code only knows when the *core* parts are no longer
> requiring power. It shouldn't know about anything deeper and if you a=
re
> using the runtime PM layer the runtime PM refcounting can do all your
> work.

Agree Alan,
Its better adapting the driver to Runtime PM instead fixing some thing
in the core.

Regards,
Kishore

>
> Alan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
