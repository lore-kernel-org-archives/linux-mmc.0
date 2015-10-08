From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH v3 1/3] mmc: sprd: Add MMC host driver for Spreadtrum SoC
Date: Thu, 8 Oct 2015 15:54:42 +0200
Message-ID: <CAPDyKFp2o=RAnizGrWgt080kYqWkBabh6NsCR11q3SPVCfaBAw@mail.gmail.com>
References: <1439571353-30165-1-git-send-email-wuht06@gmail.com>
	<1439571353-30165-2-git-send-email-wuht06@gmail.com>
	<CAPDyKFp=XH+Vo_diRyhrMuB+v1rmTmxo3Lid3Wc-u1ohqNisKw@mail.gmail.com>
	<CAG_R4_VTXCV4NVMOwv-9F56-_pVsK0hU4go79ZhV3OFxwcF0mA@mail.gmail.com>
	<CAPDyKFo3xp3wU3XW3kMV7Xz7DFgkxts3CArthYY7-CyWk8cjXw@mail.gmail.com>
	<CAG_R4_X3kQj5xSA5KLyu75aqusPNXj0H4Xqx+m+5Sg5cZ15bBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAG_R4_X3kQj5xSA5KLyu75aqusPNXj0H4Xqx+m+5Sg5cZ15bBg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hongtao Wu <wuht06-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "Orson.Zhai-lxIno14LUO0EEoCn2XhGlw@public.gmane.org" <Orson.Zhai-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>, "Chunyan.Zhang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org" <Chunyan.Zhang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>, "Jason.Wu-lxIno14LUO0EEoCn2XhGlw@public.gmane.org" <Jason.Wu-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

[...]

>> Thanks for clarifying!
>>
>> You have some differences towards the "standard" sdhci variant, but
>> that doesn't mean you should go off and implement a new driver from
>> scratch, instead you should create a new sdhci variant and re-use code
>> from the generic sdhci driver.
>>
>> The current problem with such approach, is that the sdhci driver isn't
>> designed as a library but instead a driver consisting of too many
>> quirks and callbacks. While you start to adopt your driver towards
>> sdhci, you will need to add yet another bunch of new quirks and
>> callbacks to suite your hw.
>>
>> Now, as the number of callbacks and quirks continues to increase I
>> will sooner or later give up maintaining it, as each line of code will
>> depend on a quirk. So, we need to start turning sdhci into a library
>> *right now*! Russell King, has pointed out this several times as well,
>> but unfortunate I haven't yet seen anyone willing to help out in this
>> field.
>>
>> I would of course be very happy if you would like to have a look at
>> that, but I realize it's a difficult task, So, unless you are happy
>> with taking on such a challenge, I suggest you go for an intermediate
>> step, which thus means convert your driver to a sdhci variant driver
>> and add the quirks/callbacks you need to suite your hw.
>>
>> [...]
>>
>> Kind regards
>> Uffe
>
> Thanks for kindly suggestion!
> I think it's a good idea to turn sdhci into a library. But for me it's
> too difficult to
> take on such a challenge. However, I will try my best to support you to do
> it.

Yes, I totally understand and thanks for your support.

>
> As you suggested, I will consider converting our eMMC host driver to a
> sdhci variant driver. However, our controller has some features, which
> differentiate it from standard sd host controller. For example, our controller
> doesn't have such functions as follows: tuning or re-tuning, Power Control
> Register, PIO or ADMA transfer mode, UHS-II and so on. So, if we use sdchi
> variant driver right now, I think it has a litter redundancy.

I realize that, but I would very much appreciate if you give it try -
I think it should be doable.

Of course, you will need to change the "sdhci core" to suite your
needs and normally people do that via adding callbacks and quirks.
Perhaps you can keep my request in mind of turning sdhci into a
library and thus limit the number of added quirks and callbacks...

>
> Now our sdio team are discussing improving  our eMMC host controller, we are
> making it more standardized. But you know, changing a IP block is a long
> process. Maybe it will take us about one or two years. So what do you think
> if we use ourself eMMC host driver right now, and convert it when our new host
> controller is ready.
>

Well, that won't help the current HW so I would encourage you to do
the "sdhci variant" work anyway. Likely it will also benefit you when
you try to upstream the next variant of the driver to cope with your
new HW.

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
