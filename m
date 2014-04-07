From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH] sdhci: Forward EPROBE_DEFER on vmmc and vqmmc regulators
Date: Mon, 7 Apr 2014 15:11:17 +0200
Message-ID: <5342A3F5.606@topic.nl>
References: <1395991817-3503-1-git-send-email-mike.looijmans@topic.nl> <10471336.Pb8zVvW3Hp@wuerfel> <53429AD4.7030508@topic.nl> <4902841.krZFXFDZqb@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp103.mer-nm.internl.net ([217.149.192.139]:34050 "EHLO
	smtp103.mer-nm.internl.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754650AbaDGNLU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 7 Apr 2014 09:11:20 -0400
In-Reply-To: <4902841.krZFXFDZqb@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, cjb@laptop.org, gdjakov@mm-sol.com

=EF=BB=BFOn 04/07/2014 02:51 PM, Arnd Bergmann wrote:
> On Monday 07 April 2014 14:32:20 Mike Looijmans wrote:
>> On 04/07/2014 02:25 PM, Arnd Bergmann wrote:
>>
>> Judging from the kernel output, regulator_get_optional returns -ENOD=
EV if the
>> supply wasn't found.
>>
>> Maybe the API is confusing (or wrong?) here.
>>
>> If you change the code as per your suggestion, the SD will not work =
unless you
>> explicitly assign supplies. And judging from what I've seen so far, =
I am the
>> first to have ever attached a power supply to this controller...
>
> It's certainly not very "optional" if it returns an error here.
>
> You could try to special-case the "-ENODEV" return here, but I think =
it
> would be better to change the regulator interface to be less confusin=
g.
>

Judging from the code:
http://lxr.free-electrons.com/source/drivers/regulator/core.c#L1476

The behaviour is supposed to be something like "regulator_get_optional"=
 will=20
return an error if the supply wasn't found, but "regulator_get" will cr=
eate a=20
dummy supply for you instead of returning an error code.

So "regulator_get_optional" means: "I handle my own problems, just gimm=
e the=20
bad news". But "regulator_get" appears to imply: "I will shoot the mess=
enger,=20
so do whatever you can to get me something to say 'enable' to".

In this case, the IS_NULL part is wrong indeed, it will never return NU=
LL.

I still think it's unrelated to my patch and should be submitted separa=
tely.

Mike.


Met vriendelijke groet / kind regards,

Mike Looijmans

TOPIC Embedded Systems
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: (+31) (0) 499 33 69 79
Telefax:  (+31) (0) 499 33 69 70
E-mail: mike.looijmans@topic.nl
Website: www.topic.nl

Please consider the environment before printing this e-mail

Visit us at the Hannover Messe 7 - 11 April 2014 - Hall 002/D10 (Dutch =
Pavillion)
http://www.hannovermesse.de/exhibitor/topic-embedded-products/V229623

