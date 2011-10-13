From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/4] mmc: mmci: Bugfix in pio read for small packets
Date: Thu, 13 Oct 2011 16:48:03 +0100
Message-ID: <20111013154803.GH21648@n2100.arm.linux.org.uk>
References: <1317109568-17905-1-git-send-email-ulf.hansson@stericsson.com> <20111001160937.GF11710@n2100.arm.linux.org.uk> <4E8F028C.10102@stericsson.com> <20111008091036.GF25689@n2100.arm.linux.org.uk> <CACRpkdY=DFW+J_pQetK38mPqic2iBuDWCx5QZTo-NkL1L37Fuw@mail.gmail.com> <4E92AB66.1030406@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42158 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849Ab1JMPsQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Oct 2011 11:48:16 -0400
Content-Disposition: inline
In-Reply-To: <4E92AB66.1030406@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lee Jones <lee.jones@linaro.org>, Stefan NILSSON9 <stefan.xk.nilsson@stericsson.com>

On Mon, Oct 10, 2011 at 10:23:02AM +0200, Ulf Hansson wrote:
> Linus Walleij wrote:
>> On Sat, Oct 8, 2011 at 11:10 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>> On Fri, Oct 07, 2011 at 03:45:48PM +0200, Ulf Hansson wrote:
>>>
>>> Well, the patch system says that each one depends on the previous one,
>>> and the first one in the series contains the PIO read thing.
>>>
>>> Do 7108/1 onwards depend on 7106/1 and 7107/1 ?
>>
>> Probably my fault, since I was helping Ulf out with the patch tracker
>> introduction.
>>
>> The patches should be pretty much semantically orthogonal as
>> far as I can tell, the only reason dependency was stated that way
>> was that I couldn't tell from head-parsing whether there were
>> syntactical dependencies. (And wanted to avoid the annoyance
>> of non-applying patches...)
>>
>> So if they apply, they are independent AFAICT.
>
> 7108/1 and 7109/1, have real dependencies. Otherwise there none.

Ok, I assume that those depend on the first two patches.

So, I tried applying 7110/1 .. 7112/1 but the first rejects because it
doesn't have the non-power-of-2 support patch applied (7107/1).  And
it seems sensible that 7107/1 depends on 7106/1 (the PIO patch) which
I believe to be a problem.

Therefore, I don't think any of these can be applied without the
initial PIO patch.

One thing I haven't yet mentioned is about the non-power-of-2 support -
surely this can only be supported if blksz_datactrl16 is set?  If so,
shouldn't it key off that?  I don't see how it could otherwise support
non-power of 2 block sizes with just a log2 of the block size programmed
into the data control register.
