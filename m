From: Hein_Tibosch <hein_tibosch@yahoo.es>
Subject: Re: [PATCH v3] mmc: Make ID freq configurable
Date: Sun, 03 Jan 2010 16:00:09 +0800
Message-ID: <4B404E89.4060103@yahoo.es>
References: <1246492196.2980.17.camel@linux-51e8.site>	<20090702135849.21370282@hskinnemoen-d830>	<1246537056.2980.60.camel@linux-51e8.site>	<4B3E570C.2060602@yahoo.es>	<63809451-ED1D-487A-AE63-F72B23D136D8@niasdigital.com>	<4B3F019F.6010306@yahoo.es>	<49985427-DCB9-40E1-815B-43C812B41DE3@niasdigital.com>	<20100102130809.121b7e10@mjolnir.ossman.eu>	<AD8E15FA-A476-4275-A750-5EB587A93CEC@niasdigital.com> <20100103003804.66021fe9@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:1945 "EHLO
	smtp-vbr4.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583Ab0ACIB2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 3 Jan 2010 03:01:28 -0500
In-Reply-To: <20100103003804.66021fe9@mjolnir.ossman.eu>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pierre Ossman <pierre@ossman.eu>
Cc: Ben Nizette <bn@niasdigital.com>, Sascha Hauer <s.hauer@pengutronix.de>, Adrian Hunter <adrian.hunter@nokia.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Fleming <matt@console-pimps.org>

Pierre Ossman wrote:
> On Sun, 3 Jan 2010 09:23:30 +1100
> Ben Nizette <bn@niasdigital.com> wrote:
>
>   
>>> Broken cards seem to be all over the spectrum, so I wouldn't be
>>> suprised if you find ones that break if you go too low as well.
>>>       
>> Yea good point, though given there might not even be a One Freq to Rule Them All, how about:
>>
>> ---8<---
>>
>> From: Ben Nizette <bn@niasdigital.com>
>> Subject: [PATCH v3] mmc: Make ID freq configurable
>>
>> While the SD spec specifies a range of frequencies for the ID phase from 100-400kHz, not all cards play by the rules.  This patch adds a Kconfig option to allow the user to tweak this to their card/host config, though the default of 250kHz should be fine for all spec-abiding cards and most others besides.
>>
>> Signed-off-by: Ben Nizette <bn@niasdigital.com>
>>
>>     
>
> This is not a good solution. We all use the same pool of cards so we
> should all be using the same init sequence. If there isn't a single
> frequency where all cards will work, then we'll have to make something
> more advanced where the kernel will try the init several times with
> different clocking.
>   
As I'm lucky to have main-stream cards that break the rule (on
avr32/AP7) I'll dive deeper into it and see if I can make it "automatic"
so that initialization will work for any of cards. Indeed using a kind
of 'bisect approach' approach.
... although I must say that before Sascha Hauer's patch, we never had
problems with any of the cards, using the controller's minimum freq of
137 Khz.

Hein



