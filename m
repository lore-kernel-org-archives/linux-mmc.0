From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v6 00/11] mmc: use nonblock mmc requests to minimize latency
Date: Mon, 27 Jun 2011 17:29:54 +0200
Message-ID: <BANLkTi=NTqQ-U8AhL0SUYzBTs1RF==aD5g@mail.gmail.com>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org>
	<20110621075319.GN26089@n2100.arm.linux.org.uk>
	<BANLkTikOA3G0Gt4Cxua3EDnAzbFKLAk6Yw@mail.gmail.com>
	<BANLkTimfxrcKWLZJmVC+1zL27th7j4uzEA@mail.gmail.com>
	<20110623133702.GZ23234@n2100.arm.linux.org.uk>
	<BANLkTi=8Awu4Z3ESizE9WDEyWNw0r9N0ug@mail.gmail.com>
	<BANLkTinK88QT_7Zr2YF1sTAiM778Xp9rFQ@mail.gmail.com>
	<20110627100212.GA16103@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:33141 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070Ab1F0P3z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jun 2011 11:29:55 -0400
Received: by qyk9 with SMTP id 9so2732324qyk.19
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jun 2011 08:29:55 -0700 (PDT)
In-Reply-To: <20110627100212.GA16103@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>, vijay.kilari@stericsson.com
Cc: Per Forlin <per.forlin@linaro.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Chris Ball <cjb@laptop.org>, linaro-dev@lists.linaro.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Robert Fekete <robert.fekete@linaro.org>

On Mon, Jun 27, 2011 at 12:02 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> The next thing to think about in DMA-land is whether we should total =
up
> the size of the SG list and choose whether to flush the individual SG
> elements or do a full cache flush. =A0There becomes a point where the=
 full
> cache flush becomes cheaper than flushing each SG element individuall=
y.

We noticed that even for a single (large) buffer, any cache flush opera=
tion
above a certain threshold flushing indiviudal lines become more expensi=
ve
than flushing the entire cache.

I requested colleagues to look into implenting this threshold in the
arch/arm/mm/cache-v7.S file. but I think they ran into trouble and
eventually had to give up on it.

Vijay or Srinidhi, can you share your findings?

Thanks,
Linus Walleij
