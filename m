From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] ARM: pxa: propagate errors from regulator_enable() to pxamci
Date: Tue, 23 Jul 2013 12:15:54 -0700
Message-ID: <CAOesGMiVzH7qyu_tBpKV5PTHBvvwE9E6Q9f39ENfVOO-6wY3+w@mail.gmail.com>
References: <201307051751.20729.arnd@arndb.de>
	<8638rt3svt.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:48094 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933733Ab3GWTPz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Jul 2013 15:15:55 -0400
Received: by mail-qc0-f181.google.com with SMTP id u12so4502540qcx.26
        for <linux-mmc@vger.kernel.org>; Tue, 23 Jul 2013 12:15:54 -0700 (PDT)
In-Reply-To: <8638rt3svt.fsf@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mike Rapoport <mike@compulab.co.il>, Paul Gortmaker <paul.gortmaker@windriver.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Jul 5, 2013 at 8:53 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Fri, Jul 05 2013, Arnd Bergmann wrote:
>> The em_x270_mci_setpower() and em_x270_usb_hub_init() functions
>> call regulator_enable(), which may return an error that must
>> be checked.
>>
>> This changes the em_x270_usb_hub_init() function to bail out
>> if it fails, and changes the pxamci_platform_data->setpower
>> callback so that the a failed em_x270_mci_setpower call
>> can be propagated by the pxamci driver into the mmc core.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> For pxamci:
>
> Acked-by: Chris Ball <cjb@laptop.org>

Applied with your ack to arm-soc fixes branch for 3.11, after fixing
the set/test ordering pointed out in the thread.

Thanks!

-Olof
