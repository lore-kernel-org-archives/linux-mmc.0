From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: sunxi mmc on A10 / A13 does not have a sample clock, cannot do
 ddr ?
Date: Wed, 6 Jul 2016 10:20:45 +0800
Message-ID: <CAGb2v67SBNO1jgyqghBESQ3Mz6WpYCei=amoCNatGSwL1vWMaw@mail.gmail.com>
References: <de974dc5-2192-a87f-d727-a8e9e9f4b079@redhat.com> <20160705082922.GJ7643@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:41436 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033AbcGFCVJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jul 2016 22:21:09 -0400
Received: from mail-io0-f173.google.com (mail-io0-f173.google.com [209.85.223.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: b93043)
	by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 44D2620708
	for <linux-mmc@vger.kernel.org>; Wed,  6 Jul 2016 10:21:06 +0800 (CST)
Received: by mail-io0-f173.google.com with SMTP id g13so188601130ioj.1
        for <linux-mmc@vger.kernel.org>; Tue, 05 Jul 2016 19:21:06 -0700 (PDT)
In-Reply-To: <20160705082922.GJ7643@lukather>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Tue, Jul 5, 2016 at 4:29 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Sun, Jul 03, 2016 at 05:20:43PM +0200, Hans de Goede wrote:
>> Hi Chen-Yu,
>>
>> While working on some dts cleanups I tested
>> the latest sunxi-next kernel code on my A13
>> Utoo P66 tablet and the emmc no longer works.
>>
>> The kernel tries to enable DDR52 mode on it,
>> since it apparently can do that and after that
>> the kernel can no longer talk to it.
>>
>> Removing MMC_CAP_1_8V_DDR from sunxi-mmc.c
>> fixes this.
>>
>> Part of the problem likely is that it seems
>> that the mmc clock on sun4i / sun5i do
>> not have sample / output phase clks.
>>
>> It does not matter what one writes to
>> 0x1c20088 / 0x1c20090, bits 8-10 and
>> 20-22 are always 0.
>>
>> I've observed this on both sun4i and sun5i,
>> and the sun4i / sun5i datasheets
>> also do not mention the phase bits
>> for register 0x1c20088 / 0x1c20090.
>>
>> As such I'm thinking that the best way to fix
>> this is:
>>
>> 1) In sunxi-mmc.c make the sample clocks
>> optional; and if not present then do not
>> set MMC_CAP_1_8V_DDR (and do not try to
>> set sample clks)
>>
>> 2) Remove the sample clks from the base
>> sun4i / sun5i dtsi files
>
> That looks like the right approach to me.

Ack.

ChenYu
