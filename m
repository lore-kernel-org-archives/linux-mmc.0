From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2 07/11] omap: remove old hsmmc.[ch] and in Makefile
Date: Mon, 21 Oct 2019 19:07:31 +0200
Message-ID: <3FDBE28F-B2C5-4EDE-905C-687F601462B6@goldelico.com>
References: <cover.1571510481.git.hns@goldelico.com> <9bd4c0bb0df26523d7f5265cdb06d86d63dafba8.1571510481.git.hns@goldelico.com> <20191021143008.GS5610@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021143008.GS5610@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Kalle Valo <kvalo@codeaurora.org>, Mike Rapoport <rppt@linux.ibm.com>, David Sterba <dsterba@suse.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Petr Mladek <pmladek@suse.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Yangtao Li <tiny.windzz@gmail.com>, Alexios Zavras <alexios.zavras@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, John Stultz <john.stultz@linaro.org>, Bjorn Helgaas <bhelgaas@google.co>
List-Id: linux-mmc@vger.kernel.org


> Am 21.10.2019 um 16:30 schrieb Tony Lindgren <tony@atomide.com>:
> 
> * H. Nikolaus Schaller <hns@goldelico.com> [191019 18:43]:
>> --- a/arch/arm/mach-omap2/Makefile
>> +++ b/arch/arm/mach-omap2/Makefile
>> @@ -216,7 +216,6 @@ obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
>> 
>> # Platform specific device init code
>> 
>> -omap-hsmmc-$(CONFIG_MMC_OMAP_HS)	:= hsmmc.o
>> obj-y					+= $(omap-hsmmc-m) $(omap-hsmmc-y)
> 
> The related obj-y line can go now too, right?

Yes, I think so. It is a construction that I have never seen before :)
Therefore I did not recognize that it is related.

> And looks like common.h also has struct omap2_hsmmc_info
> so maybe check by grepping for hsmmc_info to see it's gone.

Yes, it is just a forward-declaration of the struct name with
no user anywhere.

Scheduled for v3.

BTW: should this series go through your tree since it is an
omap machine?

BR and thanks,
Nikolaus
