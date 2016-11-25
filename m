From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 6/10] mmc: sdhci-xenon: Add Marvell Xenon SDHC core functionality
Date: Fri, 25 Nov 2016 14:01:04 +0100
Message-ID: <CAPDyKFrObxNVN+9uY7arCyGLDh_3jKCfdpw0d8KnncnGugwCbw@mail.gmail.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
 <0390e7a05b6163deabb545f93729ea615eeaaee2.1477911954.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFpqPSqiEi=0UW5LoZmy+y-KHm9nbcGKBSy3RzchdLU9cA@mail.gmail.com>
 <dd230463-04f6-df31-7056-1a185eb6cfc7@marvell.com> <CAPDyKFr9uEjVQmTNP0KK8Zj9mxCW3i564E=47vTK0RLvXCjw3Q@mail.gmail.com>
 <76ce72f8-4b86-3b83-544f-b9a7ef871393@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <76ce72f8-4b86-3b83-544f-b9a7ef871393-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ziji Hu <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Cc: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Jimmy Xu <zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ryan Gao <ygao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Doug Jones <dougj-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "Wei(SOCP) Liu" <liuw-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

[...]

>>
>> Moreover, we have ->enable_sdio_irq() ops that deals with this.
>>
>    Yes. I mean the SDIO irqs on DAT1 line in async mode.
>    This field enables our host to recognize the async SDIO irq from SDIO device.
>    It controls our host side behavior, other than the SDIO device.
>
>    I think ->enable_sdio_irq() is a more reasonable place to put this workraound.
>    I will export sdhci_enable_sdio_irq() and implement out host own
>    enable_sdio_irq() calling sdhci_enable_sdio)irq() plus this workaround.
>    Does it sound reasonable to you?

Yes.

[...]

>>
>> Got it. Although I think we can cope with that fine just by using the
>> different SD/eMMC speed modes settings defined in DT (or from the
>> SDHCI caps register)
>>
>     In my very opinion, I'm not sure if there is any corner case that driver cannot
>     determine the eMMC card type from DT and SDHC caps.
>
>>>    Unfortunately, MMC driver cannot determine the card type yet when eMMC voltage
>>>    setting should be executed.
>>>    Thus an flag is required here to tell driver to execute eMMC voltage setting.
>>>
>>>    Besides, additional eMMC specific settings might be implemented in future, besides
>>>    voltage setting. Most of them should be completed before MMC driver recognizes the
>>>    card type. Thus I have to keep this flag to indicate current SDHC is for eMMC.
>>
>> I doubt you will need a generic "eMMC" flag, but let's see when we go forward.
>>
>> Currently it's clear you don't need such a flag, so I will submit a
>> change adding a DT binding for "mmc-ddr-3_3v" then we can take it from
>> there, to see if it suits your needs.
>>
>
>     Actually, our eMMC is usually fixed as 1.8V.
>
>     The pair "no-sd" + "no-sdio" can provide the similar information.
>     But I'm not sure if it is proper to use those two property in such a way.

Well, potentially those could be used like that.

The point of why we added them was to allow hosts that don't support
the different protocols (which is somewhat true for your case, because
of signal voltage issues) to tell the mmc core about it. That instead
of having to all kind of crazy hacks in the drives, that in then
didn't work out so well.

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
