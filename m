From: merez@codeaurora.org
Subject: RE: [PATCH v7 1/3] mmc: core: Add packed command feature of eMMC4.5
Date: Tue, 12 Jun 2012 12:15:21 -0700 (PDT)
Message-ID: <113bb1f38dbc386f1adfc580e10dc2e5.squirrel@www.codeaurora.org>
References: <000601cd47ab$8ad77c50$a08674f0$%jun@samsung.com>
    <CANfBPZ9dwwAOBbXPqGV64k-sB-MzRtTO8x7tXnZBjtYN+V88XQ@mail.gmail.com>
    <000001cd489c$115f03b0$341d0b10$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:31827 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612Ab2FLTPW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jun 2012 15:15:22 -0400
In-Reply-To: <000001cd489c$115f03b0$341d0b10$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: "'S, Venkatraman'" <svenkatr@ti.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Maya Erez' <merez@codeaurora.org>, 'Subhash Jadavani' <subhashj@codeaurora.org>


> S, Venkatraman <svenkatr@ti.com> wrote:
>> On Mon, Jun 11, 2012 at 1:53 PM, Seungwon Jeon <tgih.jun@samsung.com>
>> wrote:
>> > This patch adds packed command feature of eMMC4.5.
>> > The maximum number for packing read(or write) is offered
>> > and exception event relevant to packed command which is
>> > used for error handling is enabled. If host wants to use
>> > this feature, MMC_CAP2_PACKED_CMD should be set.
>> >
>> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>>
>> Can you please post some clear performance benchmarks with your patchset
>> ?
>> Given that #merez claims to see a significant performance drop for
>> reads, it will be
>> good to compare notes.
>> If it's not too much trouble, both CFQ and deadline scheduler figures
>> would be useful, on a
>> set of read only, write only and parallel read write usecases.
>>
>> I can also try to replicate your results if you can publish the exact
>> configuration you used
>> for testing (example: iozone parameters)
> I'm checking the merez's result.
> Currently packed command is effective on write.
> When running packed write with iozone, there is 25% performance gains.
> (ex: iozone -az -i0 -I -s 10m -f /target/test -e)
>
Our tests shows performance gain of 50-60% in scenarios of only write lmdd
operations.

As I mentioned in the write packing control thread the degradation of read
performance in case of mix read/write operations appears also without
write packing. Therefore I don't think it should stop us from approving
the write packing patch, that gives a significant improvement to the write
performance.
The read performance degradation should be resolved regardless of the
write packing patch.

Thanks,
Maya Erez
--
Sent by consultant of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

