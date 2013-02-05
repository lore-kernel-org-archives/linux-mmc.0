From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
Date: Tue, 5 Feb 2013 16:30:45 +0100
Message-ID: <CACRpkdaUQ60W8Vmg3MpvP5uV+3jD3y4+9V2et4Ni+z-7k=aFTg@mail.gmail.com>
References: <510C2A47.1090607@mvista.com>
	<20130201205600.GA31762@arwen.pp.htv.fi>
	<20130201213003.GW2637@n2100.arm.linux.org.uk>
	<20130204154153.GA18237@arwen.pp.htv.fi>
	<510FF1A6.403@mvista.com>
	<20130204164712.GB4269@arwen.pp.htv.fi>
	<510FF5C9.3030600@mvista.com>
	<20130204170216.GC4269@arwen.pp.htv.fi>
	<51100A72.6030909@ti.com>
	<CACRpkdZihnp3_Df==QRWxQupgi7W_YXZxc-MxkusVH6J+Vx56A@mail.gmail.com>
	<20130204203358.GX4720@opensource.wolfsonmicro.com>
	<CACRpkdbPyZt8=pLhz-5qcaSSAk6VBn61dPTNp6teU9HksBwN2w@mail.gmail.com>
	<51102E25.8040107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180]:61135 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754007Ab3BEPaq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Feb 2013 10:30:46 -0500
Received: by mail-ia0-f180.google.com with SMTP id f27so280871iae.11
        for <linux-mmc@vger.kernel.org>; Tue, 05 Feb 2013 07:30:46 -0800 (PST)
In-Reply-To: <51102E25.8040107@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Cyril Chemparathy <cyril@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, balbi@ti.com, Sergei Shtylyov <sshtylyov@mvista.com>, Linux Documentation List <linux-doc@vger.kernel.org>, Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, "Nair, Sandeep" <sandeep_n@ti.com>, Chris Ball <cjb@laptop.org>, Matt Porter <mporter@ti.com>, Arnd Bergmann <arnd@arndb.de>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Rob Herring <rob.herring@calxeda.com>, Linux OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, "Cousson, Benoit" <b-cousson@ti.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Landley <rob@landley.net>, Dan Williams <djbw@fb.com>Linux

On Mon, Feb 4, 2013 at 10:54 PM, Cyril Chemparathy <cyril@ti.com> wrote:
> On 02/04/2013 04:11 PM, Linus Walleij wrote:

>> Cyril, just stack up the cookies and take a sweep over them to see
>> which ones are baked when the NAPI poll comes in -> problem
>> solved.
>
> You're assuming that cookies complete in order.  That is not necessarily
> true.

So put them on a wait list? Surely you will have a list of pending
cookies and pick from the front of the queue if there isn't a hole on
queue position 0.

Yours,
Linus Walleij
