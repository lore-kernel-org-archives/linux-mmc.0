From: Joel A Fernandes <agnel.joel@gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: add AM33XX MMC support
Date: Fri, 14 Jun 2013 14:54:33 -0500
Message-ID: <CAD=GYpb3+nvoz863+VKO7iJijRHnM5RzsVj-5VJfQ-OHoUy19Q@mail.gmail.com>
References: <1362629799-22485-1-git-send-email-mporter@ti.com>
	<1362629799-22485-3-git-send-email-mporter@ti.com>
	<41fde401c8e646689123d7c6d3a2dffc@DLEE71.ent.ti.com>
	<20130307141235.GQ6209@beef>
	<79CD15C6BA57404B839C016229A409A83EC20C57@DBDE01.ent.ti.com>
	<20130307144656.GR6209@beef>
	<79CD15C6BA57404B839C016229A409A83EC20CCA@DBDE01.ent.ti.com>
	<20130307150408.GU6209@beef>
	<79CD15C6BA57404B839C016229A409A83EC20D27@DBDE01.ent.ti.com>
	<20130307160236.GV6209@beef>
	<79CD15C6BA57404B839C016229A409A83EC213C8@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EC213C8@DBDE01.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Porter, Matt" <mporter@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi Tony, Vaibhav,

>> I just doublechecked MMC rootfs on bone and evmsk as it's the standard
>> smoke test. My EVM is intermittent now so trying to coax it to power up
>> to reverify.
>>
>
> Matt,
>
> Your branch is working for me, I tested it on EVM. Not sure what is wrong with manual rebasing
> I did yesterday. I will try to nail-down root-cause here.
>
> And you can submit the next version fixing the comments I have given.

The only comment I could find in the whole discussion was adding of
the interrupts property. I tested I don't have any problem booting
with Matt's patch, without having the interrupts property.

Can this patch be pulled in for 3.11?

Tested-by: Joel A Fernandes <joelagnel@ti.com>

Thanks,
Joel
