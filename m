From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through DT
Date: Mon, 20 Jan 2014 11:14:35 -0800
Message-ID: <CAOesGMgT_xEy-fK+tNb14MM0-FY0SsAVtDNr9aprNQNuS74Aug@mail.gmail.com>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
	<1390190215-22700-2-git-send-email-olof@lixom.net>
	<CAOMZO5A=tdzq8SW7P-D_Lxd6Ptjqkk+bKn29T2ggOZar=r4X+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:37934 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbaATTOg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jan 2014 14:14:36 -0500
Received: by mail-qa0-f44.google.com with SMTP id w5so5883217qac.3
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jan 2014 11:14:36 -0800 (PST)
In-Reply-To: <CAOMZO5A=tdzq8SW7P-D_Lxd6Ptjqkk+bKn29T2ggOZar=r4X+A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, ijc+devicetree@hellion.org.ok, Kumar Gala <galak@codeaurora.org>, chris@printf.net

On Mon, Jan 20, 2014 at 11:14 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Mon, Jan 20, 2014 at 1:56 AM, Olof Johansson <olof@lixom.net> wrote:
>
>> +Card power and reset control:
>> +The following properties can be specified for cases where the MMC
>> +peripheral needs additional reset, regulator and clock lines. It is for
>> +example common for WiFi/BT adapters to have these separate from the main
>> +MMC bus:
>> +  - card-reset-gpios: Specify GPIOs for card reset (reset active low)
>
> Wouldn't it be better not to assume that the card reset is always
> active low and read the GPIO_ACTIVE_xxx flags instead?

That's actually what the code does, I need to update the text. Thanks
for spotting it.


-Olof
