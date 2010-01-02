From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH v3] mmc: Make ID freq configurable
Date: Sat, 02 Jan 2010 17:04:08 -0600
Message-ID: <4B3FD0E8.1010507@gmail.com>
References: <1246492196.2980.17.camel@linux-51e8.site> <20090702135849.21370282@hskinnemoen-d830> <1246537056.2980.60.camel@linux-51e8.site> <4B3E570C.2060602@yahoo.es> <63809451-ED1D-487A-AE63-F72B23D136D8@niasdigital.com> <4B3F019F.6010306@yahoo.es> <49985427-DCB9-40E1-815B-43C812B41DE3@niasdigital.com> <20100102130809.121b7e10@mjolnir.ossman.eu> <AD8E15FA-A476-4275-A750-5EB587A93CEC@niasdigital.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:55453 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab0ABXEM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 2 Jan 2010 18:04:12 -0500
In-Reply-To: <AD8E15FA-A476-4275-A750-5EB587A93CEC@niasdigital.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Nizette <bn@niasdigital.com>
Cc: Pierre Ossman <pierre@ossman.eu>, Hein_Tibosch <hein_tibosch@yahoo.es>, Sascha Hauer <s.hauer@pengutronix.de>, Adrian Hunter <adrian.hunter@nokia.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Fleming <matt@console-pimps.org>

On 01/02/2010 04:23 PM, Ben Nizette wrote:
>
> On 02/01/2010, at 11:08 PM, Pierre Ossman wrote:
>
>> On Sat, 2 Jan 2010 20:07:01 +1100
>> Ben Nizette<bn@niasdigital.com>  wrote:
>>
>>>
>>> Pierre, thoughts?  All my cards were borderline spec but Hein's got a mainstream, common card which seems to completely ignore the spec.  Can we just take the few-hundred-uS hit and allow initialization down at the bottom end, say 100kHz?
>>>
>>
>> Broken cards seem to be all over the spectrum, so I wouldn't be
>> suprised if you find ones that break if you go too low as well.
>
> Yea good point, though given there might not even be a One Freq to Rule Them All, how about:
>
> ---8<---
>
> From: Ben Nizette<bn@niasdigital.com>
> Subject: [PATCH v3] mmc: Make ID freq configurable
>
> While the SD spec specifies a range of frequencies for the ID phase from 100-400kHz, not all cards play by the rules.  This patch adds a Kconfig option to allow the user to tweak this to their card/host config, though the default of 250kHz should be fine for all spec-abiding cards and most others besides.
>
> Signed-off-by: Ben Nizette<bn@niasdigital.com>
>
> ---
> diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
> index ab37a6d..a8e5003 100644
> --- a/drivers/mmc/core/Kconfig
> +++ b/drivers/mmc/core/Kconfig
> @@ -14,3 +14,15 @@ config MMC_UNSAFE_RESUME
>            This option is usually just for embedded systems which use
>            a MMC/SD card for rootfs. Most people should say N here.
>
> +config MMC_ID_FREQ
> +       int "SD/MMC Card initialisation frequency (Hz)"
> +       default 250000
> +       help
> +         The SD card specification allows for initialisation
> +         frequencies from 100-400kHz however some broken cards are
> +         known not to work across this whole range.
> +
> +         If you're having problems with a particular card not being
> +         detected, you may try adjusting this frequency up or down
> +         but for widest compatibility just leave it default.

Don't know that a kconfig option is best for this, it'd suck to have to 
recompile the kernel to change it. Module option might be better..
