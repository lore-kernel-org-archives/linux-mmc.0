From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2 10/20] omap: zoom: add fixed regulator device for wlan
Date: Fri, 23 Jul 2010 02:13:38 +0300
Message-ID: <AANLkTin2dyLNo1RMQgLG-4DtN-CsXqNNLAfITXDbMIvl@mail.gmail.com>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com>
	<1279733634-21974-11-git-send-email-ohad@wizery.com> <20100721175930.GD10930@sirena.org.uk>
	<4C48287D.1000603@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <4C48287D.1000603@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
To: Roger Quadros <roger.quadros@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kalle Valo <kalle.valo@iki.fi>, Pandita Vikram <vikram.pandita@ti.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, San Mehat <san@google.com>, Chikkature Rajashekar Madhusudhan <madhu.cr@ti.com>, "Coelho Luciano (Nokia-MS/Helsinki)" <Luciano.Coelho@nokia.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jul 22, 2010 at 2:16 PM, Roger Quadros <roger.quadros@nokia.com=
> wrote:
> On 07/21/2010 08:59 PM, ext Mark Brown wrote:
>>
>> On Wed, Jul 21, 2010 at 08:33:44PM +0300, Ohad Ben-Cohen wrote:
>>
>>> +static struct regulator_consumer_supply zoom_vmmc3_supply =3D {
>>> + =A0 =A0 =A0 .supply =A0 =A0 =A0 =A0 =3D "vmmc",
>>> +};
>>
>> This looks like a misconfiguration on the consumer - I'd strongly ex=
pect
>> the consumer to have a dev_name specified also with the name being i=
n
>> terms of the consumer device.
>
> you need to add something like
>
> .dev_name =A0 =A0 =A0 =3D "mmci-omap-hs.2"

I already set the .dev member of the consumer in a similar manner to
how all other regulators are configured in this board - please check
out patch 13:

https://patchwork.kernel.org/patch/113418/

Does this look reasonable to you ?

Thanks,
Ohad.

>
> regards,
> -roger
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
