From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ARM: OMAP: hsmmc: add max_freq field
Date: Fri, 17 Feb 2012 14:44:18 +0100
Message-ID: <CACTFLAMCoKfQbTe2RLTvi1_CH0nKzAOthAwrifNe2+F2sf3uPA@mail.gmail.com>
References: <1323868927-3738-1-git-send-email-zonque@gmail.com>
	<CANrkHUY3Zf4a2K5769Z=7Wng339zB6+z_Tgd4mOPChZ1RvZ=Kw@mail.gmail.com>
	<4EFC6992.4020501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <4EFC6992.4020501@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

ping? Could anyone care for queueing this please?


On Thu, Dec 29, 2011 at 2:22 PM, Daniel Mack <zonque@gmail.com> wrote:
> On 12/23/2011 04:40 PM, T Krishnamoorthy, Balaji wrote:
>> On Wed, Dec 14, 2011 at 6:52 PM, Daniel Mack <zonque@gmail.com> wrot=
e:
>>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_=
hsmmc.c
>>> index 101cd31..8215ef9 100644
>>> --- a/drivers/mmc/host/omap_hsmmc.c
>>> +++ b/drivers/mmc/host/omap_hsmmc.c
>>> @@ -1927,8 +1927,12 @@ static int __init omap_hsmmc_probe(struct pl=
atform_device *pdev)
>>> =A0 =A0 =A0 =A0if (mmc_slot(host).vcc_aux_disable_is_sleep)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_slot(host).no_off =3D 1;
>>>
>>> - =A0 =A0 =A0 mmc->f_min =A0 =A0 =A0=3D OMAP_MMC_MIN_CLOCK;
>>> - =A0 =A0 =A0 mmc->f_max =A0 =A0 =A0=3D OMAP_MMC_MAX_CLOCK;
>>> + =A0 =A0 =A0 mmc->f_min =3D OMAP_MMC_MIN_CLOCK;
>>
>> Stray change for f_min ?
>
> No, this was intended. The indentation doesn't make sense anymore whe=
n
> not grouped with the f_max assignment.
>
> Other than that, what is necessary to get this picked? Tony? :)
>
>
> Thanks,
> Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
