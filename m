From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH v2] ARM: EDMA: Fix clearing of unused list for DT DMA
 resources
Date: Tue, 30 Jul 2013 00:05:25 -0500
Message-ID: <51F74995.2050202@ti.com>
References: <1374515989-7391-1-git-send-email-joelf@ti.com>
 <51F4589E.5070108@ti.com> <51F6140B.3070600@ti.com> <51F738BF.7070808@ti.com>
 <51F74688.3090702@ti.com>
Reply-To: joelf@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51F74688.3090702@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Balaji TK <balajitk@ti.com>, Arnd Bergmann <arnd@arndb.de>, Mark Jackson <mpfj-list@newflow.co.uk>, Tony Lindgren <tony@atomide.com>, Pantel Antoniou <panto@antoniou-consulting.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, Jason Kridner <jkridner@beagleboard.org>, Benoit Cousson <benoit.cousson@linaro.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 07/29/2013 11:52 PM, Sekhar Nori wrote:> On Tuesday 30 July 2013
09:23 AM, Joel Fernandes wrote:
>> On 07/29/2013 02:04 AM, Sekhar Nori wrote:
>>> On Sunday 28 July 2013 05:02 AM, Joel Fernandes wrote:
>>>> Hi Tony or Sekhar,
>>>>
>>>> If this patch looks ok, could you pick it up for -rc cycle?
>>>>
>>>> It fixes DMA breakages after the merge window for devices for which DMA
>>>> resources are being populated in device tree instead pdev.
>>>
>>> But which DT-enabled platform in kernel is using EDMA? A grep for edma
>>> over arch/arm/boot/dts/* brings up nothing.
>>> Does this really have to go into the -rc cycle or can it wait till
>>> v3.12?
>>
>>
>> But unused channel list is also populated for private EDMA callers like
>> davinci-pcm no? IIRC, HWMOD data is also removed for McASP so EDMA for
>> those may break.
>
> Yes, but which DT-enabled platform has davinci-pcm working today?
> AFAICS, this bug affects DT-enabled platforms only.

Yes, you're right. I didn't realize nothing else is working yet. I guess
its fine then for next kernel release.

Thanks,

-Joel
