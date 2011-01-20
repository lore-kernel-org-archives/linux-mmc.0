From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: [PATCH 3/3] mmc: remove anti clock gating quirk for wl1271
Date: Thu, 20 Jan 2011 08:17:51 +0100
Message-ID: <AANLkTingXmestJGOpi0A0eywz63iKA0q=S1FFb8-q4OO@mail.gmail.com>
References: <cover.1294588491.git.tardyp@gmail.com>
	<cb471b35d320b96a9d143103fd9e9b76f8998470.1294588491.git.tardyp@gmail.com>
	<20110120041412.GA5274@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:49075 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412Ab1ATHRw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Jan 2011 02:17:52 -0500
In-Reply-To: <20110120041412.GA5274@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Pierre Tardy <pierre.tardy@intel.com>

>
> This adds a defined-but-not-used warning. =A0The MMC tree doesn't
> currently generate any warnings, so it would be good to avoid adding =
new
> ones, though I understand why it might make sense in this case.
Yes, this is supposed to be used by future user patches.

Do you suggest to add __attribute__ ((unused)), or we just completly
remove those and will add them whenever we have user?

>> =A0static const struct mmc_fixup mmc_fixup_methods[] =3D {
>> =A0 =A0 =A0 { SDIO_ANY_ID, SDIO_ANY_ID,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_quirk_for_sdio_devices, MMC_QUIRK_BR=
OKEN_CLK_GATING }
>> + =A0 =A0 { SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271,
>> + =A0 =A0 =A0 =A0 =A0 =A0 remove_quirk_hook, MMC_QUIRK_BROKEN_CLK_GA=
TING },
>> =A0 =A0 =A0 { 0 }
>> =A0};
>>
>
> This doesn't compile, missing a comma. =A0Was it tested?
Hum, I must have screwed up with patch version.
I'm using this every day,,,

Regards,
Pierre
