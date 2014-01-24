From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through DT
Date: Fri, 24 Jan 2014 15:35:23 -0200
Message-ID: <CAOMZO5DdTP0gimwdsBUZK3wXrnUd2FN3w-FszLQkvCwM8gvPpg@mail.gmail.com>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
	<1390190215-22700-2-git-send-email-olof@lixom.net>
	<20140120164859.GF15937@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f45.google.com ([209.85.212.45]:60645 "EHLO
	mail-vb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbaAXRfY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jan 2014 12:35:24 -0500
In-Reply-To: <20140120164859.GF15937@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, jsarha@ti.com
Cc: Olof Johansson <olof@lixom.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, ijc+devicetree@hellion.org.ok, Kumar Gala <galak@codeaurora.org>, chris@printf.net

On Mon, Jan 20, 2014 at 2:48 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> So far so good.  Now, what about this external oscillator which has its
> own separate power control.  My immediate thought is that this can be
> specified via card_ext_clock - I would simply need to declare a fixed-rate
> clock with either a regulator (power switch) controlled via a gpio (which
> would probably be closer to the hardware) or a gpio as an enable... ah,
> that requires me to write a common clock driver for that bit since this
> is currently not modelled by CCF...

Jiry Sarha posted a gpio controlled clock proposal:
http://www.spinics.net/lists/devicetree/msg16651.html

Regards,

Fabio Estevam
