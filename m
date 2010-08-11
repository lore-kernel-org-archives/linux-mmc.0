From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v4 3/8] wireless: wl1271: add platform driver to get board
	data
Date: Thu, 12 Aug 2010 01:18:25 +0300
Message-ID: <AANLkTinq_9YEaN7LrGAsV+rz8t7HNQPLz18fYvnc8y5Z@mail.gmail.com>
References: <1281550913-17633-1-git-send-email-ohad@wizery.com>
	<1281550913-17633-4-git-send-email-ohad@wizery.com> <5A47E75E594F054BAF48C5E4FC4B92AB0324110ABD@dbde02.ent.ti.com>
	<20100811184742.GA21778@nokia.com> <AANLkTikLbiJ8PsUbSnmYrfY6oNW4okejf-UdyQyfYbUz@mail.gmail.com>
	<AANLkTinu8vvPRf=78n2LaX4KQMS9tQRCbg7UUHG1ZO5W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <AANLkTinu8vvPRf=78n2LaX4KQMS9tQRCbg7UUHG1ZO5W@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: felipe.balbi@nokia.com, Kalle Valo <kalle.valo@iki.fi>, "Pandita, Vikram" <vikram.pandita@ti.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Quadros Roger (Nokia-MS/Helsinki)" <roger.quadros@nokia.com>, Tony Lindgren <tony@atomide.com>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Nicolas Pitre <nico@fluxnic.net>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ido Yariv <ido@wizery.com>, San Mehat <san@google.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "Coelho Luciano (Nokia-MS/Helsinki)" <Luciano.Coelho@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ext DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi Vitaly,

On Thu, Aug 12, 2010 at 12:34 AM, Vitaly Wool <vitalywool@gmail.com> wr=
ote:
> On Wed, Aug 11, 2010 at 10:10 PM, Ohad Ben-Cohen <ohad@wizery.com> wr=
ote:
>> Think of several wl1271 devices, each of which is represented by two
>> devices; an SDIO function, and a platform device. The SDIO function
>> stands for a specific MMC controller the device is hardwired to, and
>> the platform device stands for the external irq line that the device
>> is hardwired to.
>
> my view on this is that you're hunting the false problem here. I
> wonder how likely it is that two hardwired WL12xx chips are there on
> the same board.
>
> It's theoretically possible that there's one hardwired device and one
> hot-pluggable one but the latter one can't have platform_data anyway.

We do have strange-looking setups with two hardwired devices
(especially on new bring-ups), so it would be nice not to limit the
driver to a single device. But I agree, it's far from being important.

Thanks,
Ohad.

>
> So in my opinion, we either should keep things simple and consider 2
> hardwired WL12XX's to be a very very unlikely case, or we'll end up
> discussing board_info once again.
>
> Thanks,
> =A0 Vitaly
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
