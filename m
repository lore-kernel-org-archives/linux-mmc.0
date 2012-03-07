From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 4/4] mmc: omap_hsmmc: Simplify init for twl6030 MMC card detect
Date: Wed, 07 Mar 2012 10:42:18 -0500
Message-ID: <m2lincifj9.fsf@bob.laptop.org>
References: <20120301185044.29210.44521.stgit@kaulin.local>
	<20120301185535.29210.71546.stgit@kaulin.local>
	<4F50643B.9050500@ti.com> <20120302172251.GJ18901@atomide.com>
	<4F548457.5050205@ti.com>
	<CANrkHUZysOnHKKUuLm0Vbo1KsNp0yUd=udjGvQ43=gTTXbWeCw@mail.gmail.com>
	<CANrkHUaYDpv=p0p81oKWCoewyjheyZYkCqvZY7_ZQxWi_=8YFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANrkHUaYDpv=p0p81oKWCoewyjheyZYkCqvZY7_ZQxWi_=8YFw@mail.gmail.com>
	(T. Krishnamoorthy's message of "Wed, 7 Mar 2012 21:06:42 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-mmc@vger.kernel.org

Hi Balaji,

On Wed, Mar 07 2012, T Krishnamoorthy, Balaji wrote:
> OMAP4 and OMAP3 HSMMC IP registers differ by 0x100 offset.
> Addng the offset to platform_device resource structure
> increments the start address for every insmod operation.
> MMC command fails on re-insertion as module due incorrect register base.
> Fix this by updating the ioremap base address only.
>
> Signed-off-by: Balaji T K <balajitk@ti.com>

Is this a regression, or has it never worked in mainline?

> Note:  eMMC detection is still failing on resertion due to card vcc
> power off on rmmod

And this?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
