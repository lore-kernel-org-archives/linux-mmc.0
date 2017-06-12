From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/3] omap_hsmmc: use mmc_regulator_get_supply() to get regulators
Date: Mon, 12 Jun 2017 09:59:04 +0200
Message-ID: <CAPDyKFpohB0i6donNvSP=k2unq5HbJmeE+hUDL07oQ-k19Ehmw@mail.gmail.com>
References: <20170607083612.14224-1-kishon@ti.com> <CAPDyKFrMnZ0EGjdm4J0mTuaq+dp8eTEr3W-pOCowuwNEV2zwYw@mail.gmail.com>
 <19f289a5-cc1d-a14a-130a-ae45710d969e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <19f289a5-cc1d-a14a-130a-ae45710d969e-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 9 June 2017 at 09:51, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> wrote:
> Hi Uffe,
>
> On Thursday 08 June 2017 12:45 PM, Ulf Hansson wrote:
>> On 7 June 2017 at 10:36, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> wrote:
>>> This series deprecates "vmmc_aux" supply property and uses the generic
>>> "vqmmc" property.
>>>
>>> Not sure how exactly to handle omap3-overo-base.dtsi which already has
>>> both vqmmc-supply and vmmc_aux-supply without breaking old dt
>>> compatibility. (vqmmc-supply seems to have been added there by mistake
>>> from 3.15).
>>>
>>> In the dt series that will follow, will replace all vmmc_aux-supply
>>> with vqmmc-supply (In omap3-overo-base.dtsi remove the existing
>>> vqmmc-supply and then replace vmmc_aux-supply with vqmmc-supply).
>>>
>>> Kishon Vijay Abraham I (3):
>>>   mmc: host: omap_hsmmc: Do not initialize MMC regulators to NULL on
>>>     error
>>>   mmc: host: omap_hsmmc: use mmc_regulator_get_supply() to get
>>>     regulators
>>>   Documentation: dt-bindings: Document deprecation of "vmmc_aux" and
>>>     using "vqmmc"
>>>
>>>  .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |  2 +-
>>>  drivers/mmc/host/omap_hsmmc.c                      | 55 +++++++++-------------
>>>  2 files changed, 24 insertions(+), 33 deletions(-)
>>>
>>> --
>>> 2.11.0
>>>
>>
>> Besides the minor comment for patch2 this looks good to me.
>>
>> In case there are no other comments, and that you agree with my
>> suggested change, you don't need to re-spin.
>
> Your suggested change looks good.

Great! I amended the change and I have applied this series for next!

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
