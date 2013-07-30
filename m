From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH v2] ARM: EDMA: Fix clearing of unused list for DT DMA
 resources
Date: Mon, 29 Jul 2013 22:53:35 -0500
Message-ID: <51F738BF.7070808@ti.com>
References: <1374515989-7391-1-git-send-email-joelf@ti.com> <51F4589E.5070108@ti.com> <51F6140B.3070600@ti.com>
Reply-To: <joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51F6140B.3070600@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Vinod Koul <vinod.koul@intel.com>, Benoit Cousson <benoit.cousson@linaro.org>, Balaji TK <balajitk@ti.com>, Arnd Bergmann <arnd@arndb.de>, Jason Kridner <jkridner@beagleboard.org>, Mark Jackson <mpfj-list@newflow.co.uk>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Pantel Antoniou <panto@antoniou-consulting.com>
List-Id: linux-mmc@vger.kernel.org

On 07/29/2013 02:04 AM, Sekhar Nori wrote:
> On Sunday 28 July 2013 05:02 AM, Joel Fernandes wrote:
>> Hi Tony or Sekhar,
>>
>> If this patch looks ok, could you pick it up for -rc cycle?
>>
>> It fixes DMA breakages after the merge window for devices for which DMA
>> resources are being populated in device tree instead pdev.
> 
> But which DT-enabled platform in kernel is using EDMA? A grep for edma
> over arch/arm/boot/dts/* brings up nothing.
> Does this really have to go into the -rc cycle or can it wait till
> v3.12?


But unused channel list is also populated for private EDMA callers like
davinci-pcm no? IIRC, HWMOD data is also removed for McASP so EDMA for
those may break.

Thanks,

-Joel
