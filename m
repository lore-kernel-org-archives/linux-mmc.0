From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v10 03/15] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
Date: Thu, 08 May 2014 18:37:58 +0200
Message-ID: <536BB2E6.5040800@redhat.com>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com> <1399046249-19472-4-git-send-email-hdegoede@redhat.com> <CAPDyKFoinhyob7GZLgH4Dm7KdHCxj1+OpuZYKDK3OkU8RFsY8A@mail.gmail.com> <53678DB4.60209@redhat.com> <CAPDyKFpAGNLaKagJ_RPt1vbz70pNWJzo-s6Ao50Mh0gFrRLN0g@mail.gmail.com> <536B69FA.5090600@redhat.com> <CAPDyKFqbN61EgiTbktL-vm+L7q06OTeedCTVXJsP16ZZZd8g8A@mail.gmail.com> <536B78FF.2020808@redhat.com> <20140508153525.GW7047@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDRZXY4CYYORB4HFV2NQKGQE3RXHR5Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140508153525.GW7047@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?ISO-8859-1?Q?David_Lanzend=F6?= =?ISO-8859-1?Q?rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 05/08/2014 05:35 PM, Maxime Ripard wrote:
> On Thu, May 08, 2014 at 02:30:55PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 05/08/2014 02:17 PM, Ulf Hansson wrote:
>>> On 8 May 2014 13:26, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>>> Hi,
>>>>
>>>> On 05/05/2014 10:33 PM, Ulf Hansson wrote:
>>>>> [snip]
>>>>>
>>>>>> On 05/05/2014 02:41 PM, Ulf Hansson wrote:
>>>>>>>> +struct sunxi_mmc_host {
>>>>>>>> +       struct mmc_host *mmc;
>>>>>>>> +       struct regulator *vmmc;
>>>>>>>
>>>>>>> Instead of having a specific regulator for this driver, please use the
>>>>>>> mmc_regulator_get_supply API.
>>>>>>
>>>>>> We cannot use mmc_regulator_get_supply because for the sunxi mmc controller
>>>>>> not only vqmmc but also vmmc itself is optional, and mmc_regulator_get_supply
>>>>>> calls devm_regulator_get rather then devm_regulator_get_optional for vmmc.
>>>>>
>>>>> Is that because the mmc controller handle the power to the card or
>>>>> because you have a fixed supply?
>>>>>
>>>>> Having a fixed regulator supply could easily be set up in DT, which
>>>>> then also dynamically gives you the ocr mask instead of having a them
>>>>> "hard coded".
>>>>
>>>> It is because the sdcard slot power tends to be hooked directly to the 3.3V
>>>> of the board. So in a sense this is a fixed regulator, but I really, REALLY
>>>> don't want to add fixed regulator boilerplate to all sunxi dts files for this.
>>>
>>> So, how would you then distinguish between let's say a 3.1V and 3.3V
>>> fixed regulator? That is something that is board specific, thus I
>>> don't think you can get away from not adding them to DT.
>>
>> All boards I've seen sofar use 3.3V which seems sensible since that is
>> what the spec says you must supply to SDSC cards. I agree that if a board
>> differs from the standard 3.3V, a fixed regulator node specifying the
>> voltage should be added.
> 
> I think we introduced the sunxi-regulators DTSI just for this :)
> 
> I'd really like to start stabilizing a bit the DT and at least
> consider being able to use an older DT on a newer kernel. If we take
> such approach, I'm afraid it will break at some point.

Ok, I'll do some patches on top of the mmc patches you've already merged
adding a vmmc regulator to all boards.

Regards,

Hans
