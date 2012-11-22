From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: mmci: Support non-power-of-two block sizes for
 ux500v2 variant
Date: Thu, 22 Nov 2012 14:50:30 +0000
Message-ID: <20121122145030.GH5764@n2100.arm.linux.org.uk>
References: <1350050522-8852-1-git-send-email-ulf.hansson@stericsson.com>
 <20121121153811.GN3290@n2100.arm.linux.org.uk>
 <CAFEEs1kzJUgsvnzgWwU4i7o1jkE=8iTq5+NJ_t1jdiHEm7b-RQ@mail.gmail.com>
 <20121121165048.GO3290@n2100.arm.linux.org.uk>
 <CAPDyKFq4dBfP0ruxB-rQKruiXfk0iDLo5OKCkSQ4idK_gg1-Lg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFq4dBfP0ruxB-rQKruiXfk0iDLo5OKCkSQ4idK_gg1-Lg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Per Forlin <per.lkml@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Nov 22, 2012 at 02:43:10PM +0100, Ulf Hansson wrote:
> The mmci_pio_read|write functions are being provided with sg element
> buffers, which may have any length and any address alignment, as you
> stated.
> 
> This example is a read:
> -sg-list has 2 elements.
> -sg-element [0], is 3 bytes long, and the address is not aligned to 4 bytes.
> -sg-element [1], is 1 bytes long and the address is aligned to 4 bytes.

Notice here you're talking about the _length_ of the buffer, not its
alignment.  So you're talking about something entirely different from
what I'm saying.

The alignment of the buffer has precisely NOTHING to do with what you're
talking about above.

If the first sg-element is three bytes long and the second is one byte
long, it makes no difference what so ever whether it's aligned to 4 bytes
or not.  Think about it.  You're going to have to read three bytes from
the first sg element whatever.  You can't read four bytes from it and
hope that the additional byte in the second sg-element was following it.

So actually, if you have sg-element[0].length=3 and sg-lement[1].length=1
you can't deal with that case if you're going to be loading 4 bytes
_irrespective_ of the alignment of sg-element[0]'s buffer.

See?  The memory buffer location has absolutely nothing to do with this
issue.

> pio_read will start by reading one word (4 bytes) from the FIFO and
> fill the sg-element [0] with 3 of those 4 bytes. Then it will return
> that 3 bytes has been read.
> The upper pio_irq loop still think there is 1 byte more to read but
> will never be able to read it. Instead the DATAEND irq will be
> triggered and the mmc request will be "successfully" ended.
> 
> The above problem, can be fixed by reading data to a local allocated
> buffer instead of directly to the sg-element buffer. Thus an extra
> memcpy will be needed. Our concern is that it will be messy when
> solving the corner cases and thus affecting the "hot path" too much
> for pio_read.
> 
> Instead we decided to figure out a way to prevent us from needing to
> take care of such pio_read situations completely. Since sg-element
> buffers can be considered to be consecutive in memory and by adding
> the 4 bytes alignment constraint of the buffer address, we believe
> this should do it. The idea is that it will then only be the _last_
> read to the FIFO which might be done as "unaligned" due to that the
> _length_ of data does not have to be 4 bytes aligned. Such read is
> already handled properly by pio_read.

... and thereby penalise all cases where (eg) you're transferring 16
bytes but are misaligned?

No, I think you've got this all wrong.
