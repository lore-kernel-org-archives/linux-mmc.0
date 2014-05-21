From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v2] s3cmci: port DMA code to dmaengine API
Date: Wed, 21 May 2014 12:10:17 +0300
Message-ID: <CA+E=qVdt0jb0Cf72eFxJgJeih_rH4oH1TbtO7HR+WCpLh=kpoQ@mail.gmail.com>
References: <1400617259-6939-1-git-send-email-anarsoul@gmail.com> <4563444.HLmgOoMRYe@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:43131 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbaEUJKh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 May 2014 05:10:37 -0400
Received: by mail-ob0-f182.google.com with SMTP id wn1so1829754obc.41
        for <linux-mmc@vger.kernel.org>; Wed, 21 May 2014 02:10:37 -0700 (PDT)
In-Reply-To: <4563444.HLmgOoMRYe@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: arm-linux <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Jaehoon Chung <jh80.chung@samsung.com>, Mark Brown <broonie@kernel.org>, Ben Dooks <ben-linux@fluff.org>

On Wed, May 21, 2014 at 11:57 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 20 May 2014 23:20:59 Vasily Khoruzhick wrote:
>> index 1384f67..e70e4cf 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -420,6 +420,7 @@ config MMC_SPI
>>  config MMC_S3C
>>         tristate "Samsung S3C SD/MMC Card Interface support"
>>         depends on ARCH_S3C24XX
>> +       select S3C24XX_DMAC
>>         help
>>           This selects a driver for the MCI interface found in
>>            Samsung's S3C2410, S3C2412, S3C2440, S3C2442 CPUs.
>>
>
> I think you should use 'depends on S3C24XX_DMAC' here.
>
> Other than that,

Ok, will send v3 tonight.

Regards
Vasily

> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
>         Arnd
