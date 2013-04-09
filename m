From: Hector Palacios <hector.palacios@digi.com>
Subject: Re: [PATCH RFC] ARM: dts: mxs: leave card detect out of common mmc
 pins config
Date: Tue, 9 Apr 2013 09:18:12 +0200
Message-ID: <5163C0B4.60501@digi.com>
References: <1365415940-11609-1-git-send-email-hector.palacios@digi.com> <5162CCED.4070707@digi.com> <20130408145019.GD5044@S2101-09.ap.freescale.net> <201304081828.27127.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201304081828.27127.marex@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "maxime.ripard@free-electrons.com" <maxime.ripard@free-electrons.com>, "fabio.estevam@freescale.com" <fabio.estevam@freescale.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Dear Marek Vasut,

On 04/08/2013 06:28 PM, Marek Vasut wrote:
> Dear Shawn Guo,
>
>> On Mon, Apr 08, 2013 at 03:58:05PM +0200, Hector Palacios wrote:
>>> On 04/08/2013 02:48 PM, Shawn Guo wrote:
>>>> On Mon, Apr 08, 2013 at 12:12:20PM +0200, Hector Palacios wrote:
>>>>> MicroSD card sockets don't usually have card detect line. This pi=
n
>>>>> is actually not needed for the MMC to work and it is more of a
>>>>> platform design decission to have it.
>>>>> The card detect pin already has a configuration entry of its own:
>>>>> 'mmc0_cd_cfg' so we complete the iomux configuration here and let
>>>>> platforms to include it or not depending on whether the card dete=
ct
>>>>> line is routed to the SD socket.
>>>>
>>>> Sounds sensible.
>>>>
>>>>> Signed-off-by: Hector Palacios <hector.palacios@digi.com>
>>>>> ---
>>>>>
>>>>> Hello,
>>>>>
>>>>> All imx28 based platforms except 'bluegiga,apx4devkit' and
>>>>> 'schulercontrol,imx28-sps1', use 'mmc0_cd_cfg' in their mmc
>>>>> configuration so please check whether this patch would break thes=
e
>>>>> platforms.
>>>>
>>>> I just tested the patch on imx28-evk and card-detection still work=
s.  So
>>>> patches applied, thanks.
>>>
>>> The EVK and most platforms will work because they are using
>>> 'mmc0_cd_cfg' so actually this patch does not change anything on
>>> them.
>>> Platforms 'bluegiga,apx4devkit' and 'schulercontrol,imx28-sps1'
>>> however are not referencing 'mmc0_cd_cfg' so after applying this
>>> patch they will have unconfigured CD line and they may break.
>>
>> Ah, yes.  I thought that any board that has CD support has to refere=
nce
>> 'mmc0_cd_cfg'.  That's not necessarily true.
>>
>>> The driver will call get_cd() upon probing, which returns the statu=
s of
>>> the CD line. Please check these two platforms before applying.
>>
>> Ok, let's wait for people owning the boards to confirm.
>
> Maybe you want to use MMC_CAP_NEEDS_POLL as was noted by someone befo=
re on the
> olinuxino -- the slot is there, it's just the CD line that's missing.

I'm not sure of what you mean. The mxs-mmc.c driver already sets the=20
MMC_CAP_NEEDS_POLL flag by default in the probe() function. My platform=
 does not even=20
route the CD line because the microSD socket does not have it.
So what I have done is modify the driver to parse the property 'non-rem=
ovable' from=20
the device tree in order to set the MMC_CAP_NONREMOVABLE flag:

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 206fe49..2a3b9c9 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -679,15 +682,20 @@ static int mxs_mmc_probe(struct platform_device *=
pdev)
         /* set mmc core parameters */
         mmc->ops =3D &mxs_mmc_ops;
         mmc->caps =3D MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
-                   MMC_CAP_SDIO_IRQ | MMC_CAP_NEEDS_POLL;
+                   MMC_CAP_SDIO_IRQ;

         of_property_read_u32(np, "bus-width", &bus_width);
         if (bus_width =3D=3D 4)
                 mmc->caps |=3D MMC_CAP_4_BIT_DATA;
         else if (bus_width =3D=3D 8)
                 mmc->caps |=3D MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA=
;
-       host->wp_gpio =3D of_get_named_gpio_flags(np, "wp-gpios", 0, &f=
lags);

+       if (of_find_property(np, "non-removable", NULL))
+               mmc->caps |=3D MMC_CAP_NONREMOVABLE;
+       else
+               mmc->caps |=3D MMC_CAP_NEEDS_POLL;
+
+       host->wp_gpio =3D of_get_named_gpio_flags(np, "wp-gpios", 0, &f=
lags);
         if (flags & OF_GPIO_ACTIVE_LOW)
                 host->wp_inverted =3D 1;


In theory, and according to the mmc bindings doc, this flag must assume=
 the card is=20
always present. However the MMC core function mmc_rescan() will still c=
all at least=20
once the get_cd() hook, which in the mxs-mmc.c returns the value of the=
 CD line. In my=20
platform (where the CD line is not connected) this is returning 0, so I=
 needed to do=20
the following:

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 206fe49..2a3b9c9 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -95,6 +95,9 @@ static int mxs_mmc_get_cd(struct mmc_host *mmc)
         struct mxs_mmc_host *host =3D mmc_priv(mmc);
         struct mxs_ssp *ssp =3D &host->ssp;

+       if (mmc->caps & MMC_CAP_NONREMOVABLE)
+               return 1;
+
         return !(readl(ssp->base + HW_SSP_STATUS(ssp)) &
                  BM_SSP_STATUS_CARD_DETECT);
  }

to return a 1 when the driver should assume that the card is there. I w=
onder however=20
if this should be a global mmc patch instead, and have mmc_rescan() not=
 call the host=20
get_cd() hook at all if MMC_CAP_NONREMOVABLE is set.

Regards,
--=20
H=E9ctor Palacios
