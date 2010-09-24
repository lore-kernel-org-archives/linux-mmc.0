From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH v3 2/4] omap4 hsmmc: Fix the init if CONFIG_MMC_OMAP_HS is
 not set
Date: Fri, 24 Sep 2010 21:54:36 +0530
Message-ID: <AANLkTikADtXK=+vi_r9c7XHbwt1UjZoJv2VndmbJEqau@mail.gmail.com>
References: <14880.10.24.255.18.1285173821.squirrel@dbdmail.itg.ti.com>
	<4C9A457B.4060500@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <4C9A457B.4060500@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: kishore kadiyala <kishore.kadiyala@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Sep 22, 2010 at 11:35 PM, Sergei Shtylyov <sshtylyov@mvista.com=
> wrote:
> Hello.
>
> kishore kadiyala wrote:
>
>> From: Benoit Cousson <b-cousson@ti.com>
>
>> Avoid possible crash if CONFIG_MMC_OMAP_HS is not set
>
>> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
>> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/board-4430sdp.c | =A0 =A08 +++++++-
>> =A01 files changed, 7 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-4430sdp.c
>> b/arch/arm/mach-omap2/board-4430sdp.c
>> index a49f285..ac8541c 100644
>> --- a/arch/arm/mach-omap2/board-4430sdp.c
>> +++ b/arch/arm/mach-omap2/board-4430sdp.c
>> @@ -240,8 +240,14 @@ static int omap4_twl6030_hsmmc_late_init(struct
>> device *dev)
>>
>> =A0static __init void omap4_twl6030_hsmmc_set_late_init(struct devic=
e *dev)
>> =A0{
>> - =A0 =A0 =A0 struct omap_mmc_platform_data *pdata =3D dev->platform=
_data;
>> + =A0 =A0 =A0 struct omap_mmc_platform_data *pdata;
>>
>> + =A0 =A0 =A0 /* dev can be null if CONFIG_MMC_OMAP_HS is not set */
>> + =A0 =A0 =A0 if (!dev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Failed omap4_twl6030_hsmmc_set=
_late_init\n");
>
> =A0 pr_err("Failed %s\n", __func__);

OK , will have as mentioned
>
> WBR, Sergei

Regards,
Kishore
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
