From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v9 03/17] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
Date: Tue, 29 Apr 2014 10:26:13 +0200
Message-ID: <535F6225.80202@redhat.com>
References: <1398507381-5614-1-git-send-email-hdegoede@redhat.com> <1398507381-5614-4-git-send-email-hdegoede@redhat.com> <20140428193629.GI3134@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDRZXY4CYYORBL6E7WNAKGQE7FDTXNA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140428193629.GI3134@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, =?ISO-8859-1?Q?David_Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On 04/28/2014 09:36 PM, Maxime Ripard wrote:
> On Sat, Apr 26, 2014 at 12:16:07PM +0200, Hans de Goede wrote:
>> From: David Lanzend=F6rfer <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
>>
>> The Allwinner sunxi mmc host uses dma in bus-master mode using a built-i=
n
>> designware idmac controller, which is identical to the one found in the =
mmc-dw
>> hosts. However the rest of the host is not identical to mmc-dw, it deals=
 with
>> sending stop commands in hardware which makes it significantly different
>> from the mmc-dw devices.
>>
>> HdG: Various cleanups and fixes.
>>
>> Signed-off-by: David Lanzend=F6rfer <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> ---
>>  .../devicetree/bindings/mmc/sunxi-mmc.txt          |   43 +
>>  drivers/mmc/host/Kconfig                           |    7 +
>>  drivers/mmc/host/Makefile                          |    2 +
>>  drivers/mmc/host/sunxi-mmc.c                       | 1125 +++++++++++++=
+++++++
>>  4 files changed, 1177 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
>>  create mode 100644 drivers/mmc/host/sunxi-mmc.c
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Docum=
entation/devicetree/bindings/mmc/sunxi-mmc.txt
>> new file mode 100644
>> index 0000000..f0c06e7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
>> @@ -0,0 +1,43 @@
>> +* Allwinner sunxi MMC controller
>> +
>> +The highspeed MMC host controller on Allwinner SoCs provides an interfa=
ce
>> +for MMC, SD and SDIO types of memory cards.
>> +
>> +Supported maximum speeds are the ones of the eMMC standard 4.5 as well
>> +as the speed of SD standard 3.0.
>> +Absolute maximum transfer rate is 200MB/s
>> +
>> +Required properties:
>> + - compatible : "allwinner,sun4i-a10-mmc" or "allwinner,sun5i-a13-mmc"
>> + - reg : mmc controller base registers
>> + - clocks : a list with 2 phandle + clock specifier pairs
>> + - clock-names : must contain "ahb" and "mod"
>=20
> Again, this is not a module0 clock, so the clock name is misleading.

Ah, I see what you're getting at, yes giving it a different name here makes
sense I'll change it to mmc in the next version of the patch-set.

Regards,

Hans


--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
