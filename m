From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH]omap hsmmc: fix incorrect capability reporting
Date: Tue, 30 Mar 2010 23:41:27 +0530
Message-ID: <618f0c911003301111r3781661asa444dd35042772c3@mail.gmail.com>
References: <618f0c911003300737w5562c18as1bfcb21671919718@mail.gmail.com>
	 <002a01cad020$47be5fb0$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <002a01cad020$47be5fb0$544ff780@am.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, kishore.kadiyala@ti.com
List-Id: linux-mmc@vger.kernel.org

> Madhusudhan <madhu.cr@ti.com> wrote:
>
>
>> -----Original Message-----
>> From: Venkatraman S
>> Sent: Tuesday, March 30, 2010 9:37 AM
>> To: linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org;
>> kishore.kadiyala@ti.com
>> Cc: Madhusudhan Chikkature
>> Subject: [PATCH]omap hsmmc: fix incorrect capability reporting
>>
>> MMC slots that support 8 bit mode also support 4 bit mode.
>> The capability flag has to reflect this, otherwise SDHC cards operat=
e
>> in 1 bit mode.
>>
>> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
>> Signed-off-by: Venkatraman S <svenkatr@ti.com>
>> ---
>> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_h=
smmc.c
>> index 83f0aff..dbf83a6 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -2093,7 +2093,7 @@ static int __init omap_hsmmc_probe(struct
>> platform_device *pdev)
>>
>> =A0 =A0 =A0 if (mmc_slot(host).wires >=3D 8)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_8_BIT_DATA;
>> - =A0 =A0 else if (mmc_slot(host).wires >=3D 4)
>> + =A0 =A0 if (mmc_slot(host).wires >=3D 4)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_4_BIT_DATA;
>>
>
> Since 8-bit is the max how about:
>
> =A0 =A0 =A0 =A0if (mmc_slot(host).wires =3D=3D 8)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_8_BIT_DATA | MM=
C_CAP_4_BIT_DATA;
> =A0 =A0 =A0 =A0if (mmc_slot(host).wires =3D=3D 4)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_4_BIT_DATA;
>
> This would be little easy to read the code.

Sure. Works for me.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
