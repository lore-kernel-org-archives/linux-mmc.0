From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: use resource_size_t to store physical address
Date: Wed, 18 Nov 2015 20:10:25 +0200
Message-ID: <CAHp75VdFun5aLxLxau9SN_V+_aF+z2M7pvL9Cjui-i+jN-CUCg@mail.gmail.com>
References: <28102387.ALpaBHpim0@wuerfel>
	<7083277.bjzG62aVmx@wuerfel>
	<CAHp75VfnD=MPigeTdo8YKPTs4zZN+XcSiMBZkma3ibaT4DEZiQ@mail.gmail.com>
	<6347082.461jehYssD@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6347082.461jehYssD@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Nov 18, 2015 at 6:22 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 18 November 2015 18:17:32 Andy Shevchenko wrote:
>> On Wed, Nov 18, 2015 at 5:45 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Wednesday 18 November 2015 17:29:19 Andy Shevchenko wrote:
>
>> >> For me it clearly looks like a platform (HW / SW) configuration issue.
>> >
>> > I think some people have argued in the past that we should always use
>> > the same type for dma_addr_t, resource_size_t and phys_addr_t. That
>> > would certainly fix the problem you describe as well. In practice,
>> > everyone has that already, and my patch by itself fixes all the
>> > cases where the FIFO is at a high address and dma_addr_t is already
>> > 64-bit wide.
>>
>> Let me summarize.
>>
>> We have to have classification by address space
>> 1) physical
>> 2) virtual
>
> That classification is oversimplified, as the DMA address space
> is often not the same as physical.
>

>> dma_addr_t is a physical address wrt DMA mask.
>>
>> Correct?
>
> dma_addr_t is how a device sees RAM, it is limited by the DMA mask
> that is a subset of the capabilities of the device and the buses
> through which it is connected, and is subject to IOMMU translation
> and possible platform or bus specific offsets from the physical
> memory. I still don't know where you're getting with this.

This is off the review already. I'm just structuring knowledge in my head.
In principle I agree with your patch.


-- 
With Best Regards,
Andy Shevchenko
