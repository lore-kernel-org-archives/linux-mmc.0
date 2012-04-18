From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH 8/8] ARM: omap_hsmmc: remove platform data dma_mask and initialization
Date: Wed, 18 Apr 2012 21:05:56 +0530
Message-ID: <CANrkHUYvKdBUZh9UmWcE30ywAAiqhN-KcnSAE2T56WJLFPX1gA@mail.gmail.com>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
	<E1SKRsg-0004bX-4w@rmk-PC.arm.linux.org.uk>
	<CANrkHUajRzoCp7K8L3cJArWN3xdqpft8L4k-o4gFTRTo8nmhmg@mail.gmail.com>
	<20120418152956.GP25053@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120418152956.GP25053@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Apr 18, 2012 at 8:59 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Apr 18, 2012 at 08:53:32PM +0530, T Krishnamoorthy, Balaji wr=
ote:
>> Hi,
>>
>> drivers/mmc/host/omap.c is also using dma_mask should that also be r=
emoved
>
> Does this driver make use of this platform data?
>
> If so, it needs converting to DMA engine _before_ this patch (which i=
s
> one reason why its a good idea to do these changes as separate patche=
s...
> as I've done.) =A0It means stuff like this can be slotted in as neces=
sary
> in the patch order.
>
> I'm told that driver is OMAP2 only - I don't have any OMAP2 platforms=
 to
> be able to test it on (I only have OMAP3 and OMAP4.)

Yes, this driver is for omap2420 and omap1 devices.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
