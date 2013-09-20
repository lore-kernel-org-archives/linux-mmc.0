From: Dirk Behme <dirk.behme@gmail.com>
Subject: Re: Adding aliases to mmc
Date: Fri, 20 Sep 2013 18:37:24 +0200
Message-ID: <523C79C4.1070308@gmail.com>
References: <CAOMZO5CJ36JHJMaiG3QVdtpBoWd_ZyHQuRTrKHz4bLP39gpJtQ@mail.gmail.com> <5239C40C.9030503@wwwdotorg.org> <5239DC65.3080803@gmail.com> <5239DF55.8010308@wwwdotorg.org> <523A8A08.2060508@gmail.com> <523C7231.7040701@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:33578 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228Ab3ITQh0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Sep 2013 12:37:26 -0400
In-Reply-To: <523C7231.7040701@wwwdotorg.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Fabio Estevam <festevam@gmail.com>, linux-mmc@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>

Am 20.09.2013 18:05, schrieb Stephen Warren:
> On 09/18/2013 11:22 PM, Dirk Behme wrote:
> ...
>> If you have an embedded system were you just care a little about boot
>> time you don't want to do anything like U-Boot's "part uuid" every time
>> you boot. Or even worse, you just have a minimalistic boot loader (e.g.
>> U-Boot's SPL) which doesn't know anything about UUIDs and file systems.
>>
>> As mentioned above, no I don't think UUIDs work for production embedded
>> systems.
>
> As I said above, whatever generates the filesystem image can easily
> embed the appropriate UUID in the system's boot scripts or bootloader
> environment. There's no need to run the "part" command at run-time if
> there's a more appropriate flow for your situation.

Using a simple boot loader as an example, there are no boot scripts or 
boot loader environment. The only thing the boot loader does is 
loading the device tree and the kernel into RAM. Where do you want to 
embed an UUID in such a product?

To my understanding, the UUID is different for each SD card/eMMC, correct?

Best regards

Dirk

