From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v6] MMC: Add JZ4740 mmc driver
Date: Thu, 15 Jul 2010 23:37:49 +0200
Message-ID: <4C3F7FAD.5010106@metafoo.de>
References: <1278973245-25451-1-git-send-email-lars@metafoo.de>        <1279227964-17801-1-git-send-email-lars@metafoo.de> <20100715141653.1c0b6a8d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:65204 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933759Ab0GOViT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Jul 2010 17:38:19 -0400
In-Reply-To: <20100715141653.1c0b6a8d.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, Matt Fleming <matt@console-pimps.org>, linux-mmc@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton wrote:
> On Thu, 15 Jul 2010 23:06:04 +0200
> Lars-Peter Clausen <lars@metafoo.de> wrote:
> 
>> This patch adds support for the mmc controller on JZ4740 SoCs.
>>
>>
>> ...
>>
>> +		if (gpio_is_valid(host->pdata->gpio_power))
>> +			gpio_set_value(host->pdata->gpio_power,
>> +					!host->pdata->power_active_low);
>>
>> ...
>>
> 
> Should this driver have a `depends on GPIOLIB' in Kconfig?
> 

The driver depends on MACH_JZ4740 which selects ARCH_REQUIRE_GPIOLIB, so there
already is an implicit depends on GPIOLIB.

- - Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEUEARECAAYFAkw/f60ACgkQBX4mSR26RiNexQCfUXt0cqiMqEf17k+z+q6XVwRO
ImEAmPKxeyX9ANVasUNL60f51GxKofg=
=3NrE
-----END PGP SIGNATURE-----
