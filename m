From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC v02 04/15] dmaengine: edma: Add support for DMA filter
 mapping to slave devices
Date: Wed, 2 Dec 2015 12:02:14 +0200
Message-ID: <565EC1A6.3090806@ti.com>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
 <1448891145-10766-5-git-send-email-peter.ujfalusi@ti.com>
 <20151201172212.GC1696@localhost> <1589780.JL62pLTh05@wuerfel>
 <20151202043730.GA1854@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151202043730.GA1854@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Arnd Bergmann <arnd@arndb.de>
Cc: andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, nsekhar@ti.com, linux-spi@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 12/02/2015 06:37 AM, Vinod Koul wrote:
> On Tue, Dec 01, 2015 at 09:20:28PM +0100, Arnd Bergmann wrote:
>> On Tuesday 01 December 2015 22:52:12 Vinod Koul wrote:
>>> On Mon, Nov 30, 2015 at 03:45:34PM +0200, Peter Ujfalusi wrote:
>>>> Add support for providing device to filter_fn mapping so client dr=
ivers
>>>> can switch to use the dma_request_chan() API.
>>>
>>> Any reason why we dont want to go with DT based only for edma here?
>>
>> I think the OMAP2 based platforms using edma are all DT-only, but ma=
ch-davinci
>> would need a lot of work for that.
>=20
> Okay sound fine then

Yes, daVinci is mostly board file based and the problem is that those d=
evices
are hard to find to do the conversion to DT.

--=20
P=E9ter
