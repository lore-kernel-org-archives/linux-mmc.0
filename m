From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: dw_mmc: use resource_size_t to store physical address
Date: Wed, 18 Nov 2015 17:22:47 +0100
Message-ID: <6347082.461jehYssD@wuerfel>
References: <28102387.ALpaBHpim0@wuerfel> <7083277.bjzG62aVmx@wuerfel>
 <CAHp75VfnD=MPigeTdo8YKPTs4zZN+XcSiMBZkma3ibaT4DEZiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAHp75VfnD=MPigeTdo8YKPTs4zZN+XcSiMBZkma3ibaT4DEZiQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Wednesday 18 November 2015 18:17:32 Andy Shevchenko wrote:
> On Wed, Nov 18, 2015 at 5:45 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 18 November 2015 17:29:19 Andy Shevchenko wrote:

> >> For me it clearly looks like a platform (HW / SW) configuration issue.
> >
> > I think some people have argued in the past that we should always use
> > the same type for dma_addr_t, resource_size_t and phys_addr_t. That
> > would certainly fix the problem you describe as well. In practice,
> > everyone has that already, and my patch by itself fixes all the
> > cases where the FIFO is at a high address and dma_addr_t is already
> > 64-bit wide.
> 
> Let me summarize.
> 
> We have to have classification by address space
> 1) physical
> 2) virtual

That classification is oversimplified, as the DMA address space
is often not the same as physical.

> Therefore
> resource_addr_t must be equal to phys_addr_t since it may carry any
> possible physical address.

Right, in theory it can also be larger than phys_addr_t, but there is no
need for that.

> dma_addr_t is a physical address wrt DMA mask.
> 
> Correct?

dma_addr_t is how a device sees RAM, it is limited by the DMA mask
that is a subset of the capabilities of the device and the buses
through which it is connected, and is subject to IOMMU translation
and possible platform or bus specific offsets from the physical
memory. I still don't know where you're getting with this.

	Arnd
