From: Wei Ni <wni@nvidia.com>
Subject: RE: Where to power on the wifi device before loading the driver.
Date: Thu, 14 Jun 2012 12:17:26 +0800
Message-ID: <6B4D417B830BC44B8026029FD256F7F1C377BFFE89@HKMAIL01.nvidia.com>
References: <6B4D417B830BC44B8026029FD256F7F1C377BFFE88@HKMAIL01.nvidia.com>
 <4FD8CED9.6030901@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:1725 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702Ab2FNERb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jun 2012 00:17:31 -0400
In-Reply-To: <4FD8CED9.6030901@broadcom.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Franky Lin' <frankyl@broadcom.com>
Cc: Stephen Warren <swarren@nvidia.com>, "'linux-wireless@vger.kernel.org'" <linux-wireless@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "'linux-mmc@vger.kernel.org'" <linux-mmc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mursalin Akon <makon@nvidia.com>, Rakesh Kumar <krakesh@nvidia.com>

Hi, Franky

On Thu, Jun 14, 2012 at 01:33:13, Franky Lin wrote:
>Hi Wei,
>
>On 06/13/2012 03:40 AM, Wei Ni wrote:
>> In the brcmfmac init routine, it call sdio_register_driver() to=20
>> register driver, if the wifi device is powered on, then the mmc
>> driver will enumerate it, and call the probe callback routine.
>>
>> On the Cardhu, the wifi's power is controlled by two gpios=20
>> (power-gpio and reset-gpio), the default state is power-off.
>> So we need to power on it before calling sdio_register_driver(),
>> if not, the mmc driver can't enumerate it, and will not call
>> the probe routine.
>> This power on sequence is:
>> set power-gpio to 1 ;
>> mdelay(100) ;
>> set reset-gpio to 1 ;
>> mdelay(200);
>>
>> My question is where to power on the wifi. We may have three places=20
>> to power on it:
>> 1. power on it in the brcmfmac driver before calling
>> sdio_register_driver(). But I think this power sequence is special f=
or=20
>> tegra30 cardhu, it's not good to add it in the generic wifi driver,=20
>> because different board may use the different way to power on the wi=
fi.
>> 2. power on it in the mmc driver. In our tegra SD driver, it has=20
>> power-gpios property, which allow the slot to be powered. But this p=
ower is=20
>> for mmc slot, could we add this wifi power sequence in the tegra SD =
driver?
>> 3. hard-coded into DT. Set these gpios in the DT, something like=20
>> pinmux settings, but in this way, it's not good to put the mdelay() =
value
>> in the DT.
>
>We introduced oob interrupt support in 3.5 [1]. We are using a virtual=
=20
>platform device to retrieve board specific oob interrupt GPIO setting.
>You should be able to implement the power control in this way as well.
>Brcmfmac gets the GPIOs through platform device interface, powers up=20
>the chip and triggers a card detection. Then 4329 should be enumerated=
=20
>by MMC stack. The reason we didn't implement this is the card detectio=
n.
>Some design doesn't have hardware card detection since the WiFi chip i=
s=20
>already on board. And the current MMC stack doesn't have virtual card=20
>detection interface.

Wei: Yes, in OOB mode, it's easy to add a device node in the DT, to pas=
s
the gpio property to brcmfmac driver. But the NO-OOB mode doesn=92t use=
 the
virtual platform device, so we can't pass the gpio to driver. We need t=
o find
a way to support these two mode both.
Could we use the virtual platform device both for OOB and NO-OOB mode? =
so that
we can implement power control in these two mode, and we can add a flag=
s to
control if need to power on or not.
BTW, does that power on sequence is generally for 4329?

>
>Franky
>
>[1]: http://www.spinics.net/lists/linux-wireless/msg89335.html



