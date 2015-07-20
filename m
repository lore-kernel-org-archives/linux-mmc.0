From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/6] mmc: sdhci-esdhci-imx: fix cd/wp regression
Date: Mon, 20 Jul 2015 14:44:07 +0200
Message-ID: <CAPDyKFruDiS=DV=AjiaGWvDxFN_Zj5Hp0LifROxCUpCySAeQpA@mail.gmail.com>
References: <1434564337-24720-1-git-send-email-aisheng.dong@freescale.com>
	<20150709075032.GD23464@tiger>
	<20150709092949.GB3917@shlinux1.ap.freescale.net>
	<20150709132736.GG23464@tiger>
	<20150713114310.GA9453@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:33105 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548AbbGTMoI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jul 2015 08:44:08 -0400
Received: by qged69 with SMTP id d69so42329513qge.0
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jul 2015 05:44:07 -0700 (PDT)
In-Reply-To: <20150713114310.GA9453@shlinux1.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>, Shawn Guo <shawnguo@kernel.org>
Cc: Dong Aisheng <aisheng.dong@freescale.com>, Chris Ball <chris@printf.net>, smoch@web.de, Steffen Trumtrar <s.trumtrar@pengutronix.de>, LW@karo-electronics.de, =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>, rabeeh@solid-run.com, gwenhael.goavec-merou@armadeus.com, Russell King <rmk+kernel@arm.linux.org.uk>, hs@denx.de, tharvey@gateworks.com, Sascha Hauer <s.hauer@pengutronix.de>, troy.kisky@boundarydevices.com, lisovy@gmail.com, robertcnelson@gmail.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, ipaton0@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, linux-mmc <linux-mmc@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>

On 13 July 2015 at 13:43, Dong Aisheng <b29396@freescale.com> wrote:
> On Thu, Jul 09, 2015 at 09:27:36PM +0800, Shawn Guo wrote:
>> On Thu, Jul 09, 2015 at 05:29:50PM +0800, Dong Aisheng wrote:
>> > I agree with you.
>> > One difference is that i'd like to fix it ASAP without reverting 8d86e4f
>> > due to more patches depends on it is already there as i mentioned above..
>> > Revert it may need to revert a lot others.
>> >
>> > The pain is that v4.1 is left broken.
>>
>> Oh, crap!  I thought it's been there with only v4.2-rc1, and did not
>> know v4.1 is already broken.  In that case, reverting 8d86e4f isn't
>> the best option.  I suggest you rebase the dts series on top of
>> v4.2-rc1, and send it via mmc tree.
>>
>
> Yes, will go that way.
>
> Then you may need help take care of new dts going through your tree
> to make sure no broken code in again.

Dong, Shawn,

I am happy to help out, I assume you want this to go as fixes for 4.2rc[n].

Correct me if I am wrong, you want me to apply the DTS patches prior
the MMC patches. I tried applying the DTS patches on 4.2rc3 - it still
works nicely so no re-base is needed.


So, then I need an ack from Shawn for the DTS series...

Kind regards
Uffe
