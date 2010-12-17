From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] mmc: Test bus-width for old MMC devices (v2)
Date: Thu, 16 Dec 2010 18:33:49 -0800
Message-ID: <50D31EC8-BD9E-4920-8CEB-2AD10DF9C5C5@marvell.com>
References: <s5hfwtzbj8v.wl%tiwai@suse.de>
 <20101216234032.GA17239@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:36629 "HELO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750943Ab0LQCeG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 16 Dec 2010 21:34:06 -0500
In-Reply-To: <20101216234032.GA17239@void.printf.net>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Takashi Iwai <tiwai@suse.de>, Aries Lee <arieslee@jmicron.com>, zhangfei gao <zhangfei.gao@gmail.com>, Qiming Wu <wuqm@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


Chris,

It is not possible for bus_width to be not initialized.  This would imp=
ly ARRAY_SIZE(bus_widths) is 1.  Certainly not true.
We could just initialize by changing
+		unsigned idx, bus_width;
to
+		unsigned idx, bus_width =3D 0;

I wonder what compiler are you using so we can avoid this issue in futu=
re.

Philip


+		static unsigned ext_csd_bits[][2] =3D {
+			{ EXT_CSD_BUS_WIDTH_8, EXT_CSD_DDR_BUS_WIDTH_8 },
+			{ EXT_CSD_BUS_WIDTH_4, EXT_CSD_DDR_BUS_WIDTH_4 },
+			{ EXT_CSD_BUS_WIDTH_1, EXT_CSD_BUS_WIDTH_1 },
+		};
+		static unsigned bus_widths[] =3D {
+			MMC_BUS_WIDTH_8,
+			MMC_BUS_WIDTH_4,
+			MMC_BUS_WIDTH_1
+		};
+		unsigned idx, bus_width;
+
+		if (host->caps & MMC_CAP_8_BIT_DATA)
+			idx =3D 0;
+		else
+			idx =3D 1;
+		for (; idx < ARRAY_SIZE(bus_widths); idx++) {
+			bus_width =3D bus_widths[idx];
+			if (bus_width =3D=3D MMC_BUS_WIDTH_1)
+				ddr =3D 0; /* no DDR for 1-bit width */


On Dec 16, 2010, at 3:40 PM, Chris Ball wrote:

> Hi Takashi,
>=20
> On Wed, Dec 15, 2010 at 08:14:24AM +0100, Takashi Iwai wrote:
>> From: Aries Lee <arieslee@jmicron.com>
>>=20
>> Some old MMC devices fail with the 4/8 bits the driver tries to use
>> exclusively.  This patch adds a test for the given bus setup and fal=
ls
>> back to the lower bit mode (until 1-bit mode) when the test fails.
>>=20
>> [Major rework and refactoring by tiwai]
>> [Quirk addition and many fixes by prakity]
>>=20
>> v1->v2:
>> - Rebased to the code with DDR support, set DDR bit properly
>> - Return always error when bus-switching fallback failed
>> - Define MMC_BUS_TEST_{R|W} in linux/mmc/mmc.h
>> - Add quirk MMC_CAP_BUS_WIDTH_TEST -- default not used for compatibi=
lity
>> - Ignore errors on BUS_TEST_W -- improves chances test will work
>>=20
>> Signed-off-by: Aries Lee <arieslee@jmicron.com>
>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>> Tested-by: Philip Rakity <prakity@marvell.com>
>=20
> This looks good, but adds a warning:
>=20
> drivers/mmc/core/mmc.c: In function =91mmc_init_card=92:
> drivers/mmc/core/mmc.c:547: warning: =91bus_width=92 may be used unin=
itialized in this function
>=20
> Thanks,
>=20
> --=20
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child

