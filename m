From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RESEND v7 2/2] mmc: host: sdhci: Add support to disable
 SDR104/SDR50/DDR50 based on capability register 0.
Date: Mon, 8 Jun 2015 10:38:22 +0200
Message-ID: <CAPDyKFqA5BGXUV+_r63Xwtpm6Bzi2HB=UN0pDcu6FkjtHOaqew@mail.gmail.com>
References: <1432197817-22110-1-git-send-email-stripathi@apm.com>
	<1432197817-22110-3-git-send-email-stripathi@apm.com>
	<CAPDyKFpxkNF9C8AOJ6+18CEcpZTKycPR0i5OuwPRr1Zc+VPJ5Q@mail.gmail.com>
	<CAOHikRASDmy7PwFjqmX7JAjW52DYR+d3RkE3yd_45NN5sHK7Pg@mail.gmail.com>
	<CAOHikRBB9Uyh4Z34_pFTdmA0A-vnV09zTi8iYEU+01XvmzSr_A@mail.gmail.com>
	<20150605145323.GA15110@shlinux1.ap.freescale.net>
	<CAOHikRCXuJryKgo7pjehi-SyosE1Rr2zFjc+9yWJwke_ib=Azw@mail.gmail.com>
	<CAPDyKFqk1_B-wH0Z2QwfxftJy8LLH6Ey9cg56eFxAj7zmeFmOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFqk1_B-wH0Z2QwfxftJy8LLH6Ey9cg56eFxAj7zmeFmOg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Dong Aisheng <aisheng.dong-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Anton Vorontsov <anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mark Langsdorf <mlangsdo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, patches <patches-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 8 June 2015 at 10:37, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> [...]
>
>>> >
>>> >    Can you test this patch  on imx SoC ?
>>> >
>>>
>>> (Your email have some format issue.)
>>
>> Yeah missed to sent in plain text mode.
>>
>>>
>>> I have tested this patch and it does not break imx SoC.
>>> You can add my tag.
>>> Tested-by: Dong Aisheng <aisheng.dong-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>>
>> Thanks Dong !!
>>
>>>
>>> However, it looks to me SDHCI_CAN_VDD_180 is only indicating the host VDD
>>> capabiliies, not IO voltage capability.
>
> I think Dong is correct. I don't think SDHCI_CAN_VDD_180 is not

/s /is not /is

> related to UHS modes at all.
>
> At least the name of the field (SDHCI_CAN_VDD_180) indicates it's
> about VDD/VCC, the core power and not the IO voltage.
>
>> Are you sure on this ?? If SDHCI host VDD is  1.8V then the cards are
>> also capable to operate at 1.8V ? Didn't understand what you mean by
>> IO voltage capability
>>
>>
>>> SD3.0 cards require 1.8v IO voltage support.
>>> So should this bit affect SD3.0 support?
>>
>> The preset value resgister says that  SDR modes requires 1.8V and we
>> disable the modes based on capability or quirk.
>
> It requires 1.8V *IO voltage*, not VDD/VCC.
>
> [...]
>
> Kind regards
> Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
