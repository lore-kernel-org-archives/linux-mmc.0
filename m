From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC v02 00/15] dmaengine: New 'universal' API for requesting
 channel
Date: Wed, 2 Dec 2015 14:29:33 +0200
Message-ID: <565EE42D.2030705@ti.com>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
 <20151201165954.GA1696@localhost> <3124382.EhiMyQGKTA@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37301 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754641AbbLBMaF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 2 Dec 2015 07:30:05 -0500
In-Reply-To: <3124382.EhiMyQGKTA@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@intel.com>
Cc: andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, nsekhar@ti.com, linux-spi@vger.kernel.org

On 12/01/2015 10:17 PM, Arnd Bergmann wrote:
> On Tuesday 01 December 2015 22:29:54 Vinod Koul wrote:
>> On Mon, Nov 30, 2015 at 03:45:30PM +0200, Peter Ujfalusi wrote:
>>> channel via DT, ACPI or in case if the kernel booted in non DT/ACPI=
 mode
>>> it will use a filter lookup table and retrieves the needed informat=
ion from
>>> the dma_filter_map provided by the DMA drivers.
>>
>> That sounds right, for the third case would the arch, driver or some=
one else
>> configure this?
>=20
> The typical case is for the configuration to be defined in arch or pl=
atform
> code and passed down to the dmaengine driver.
>=20
> I just noticed that the text above (and probably the code too) should
> be changed so we always fall back to this. There are cases where the
> platform is booted with DT in principle, but the DMA engine does not
> (yet) use DT and still wants to be converted. I think we can easily
> handle that case by always trying this if the other methods fail.

Yes, it was intentional actually to not fall back to legacy lookup. Wit=
h the
dma_request_slave_channel_compat() I have had cases when the DT binding=
 was
not correct - or actually when trying to get deferred working that the =
code
would fall back to legacy mode and it got me a channel which is not usa=
ble.
I did not know that we have platforms booting in DT but the dma binding=
 is not
working so it uses other method to get channel.
I think, if we allow the fall back within dma_request_chan() it would n=
ot
cause the same issue as the dma_request_slave_channel_compat() did as l=
ong as
we are not providing the lookup table on DT booted cases when the DMA b=
inding
is working correctly.
Let me see the flow, but I think it is doable.

--=20
P=E9ter
