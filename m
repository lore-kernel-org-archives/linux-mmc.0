From: merez@codeaurora.org
Subject: Re: [PATCH v8 1/2] mmc: add packed command feature of eMMC4.5
Date: Tue, 10 Jul 2012 03:45:15 -0700 (PDT)
Message-ID: <9177cd479f2dec231b65102cb35a3e6a.squirrel@www.codeaurora.org>
References: <006801cd55b0$314960f0$93dc22d0$%jun@samsung.com>
    <87y5msqhxy.fsf@octavius.laptop.org>
    <fc0bbbfabb899fd68e522b843b668041.squirrel@www.codeaurora.org>
    <87mx38qdcs.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:2455 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224Ab2GJKpQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jul 2012 06:45:16 -0400
In-Reply-To: <87mx38qdcs.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: merez@codeaurora.org, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, 'Subhash Jadavani' <subhashj@codeaurora.org>, "'S, Venkatraman'" <svenkatr@ti.com>, 'Saugata Das' <saugata.das@linaro.org>, 'Namjae Jeon' <linkinjeon@gmail.com>


On Tue, July 10, 2012 12:33 am, Chris Ball wrote:
> Hi,
>
> On Tue, Jul 10 2012, merez@codeaurora.org wrote:
>>> Sorry, I don't have a copy of the eMMC 4.5 spec -- is PACKED_EVENT_EN
>>> a one-time programmable fuse on the eMMC, like BKOPS_ENABLE was?
>>
>> No, it's not.
>
> Excellent, thanks.
>
> I've pushed both v8 patches to mmc-next.  Before pushing it up to Linus,
> I'd like to get a better idea of the variety of performances differences
> seen using packed writes -- has it been tried on devices from multiple
> eMMC vendors, and multiple host controller vendors?  Can we try to build
> up a quick table of results, with a standard test like iozone, to check
> that we've got decent test coverage?  Seungwon suggests using:
>
> iozone -az -i0 -I -s 10m -f /target/test -e
>
> I'm also worried about how much code this is adding, but I agree that
> it's worth it if the performance benefits are as described.
>
> Thanks,
>
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> --

Hi Chris,

I suggest to also use lmdd as a benchmark test for write packing, since
write packing is mostly beneficial in long sequential operations.
It can be used as follows:
lmdd if=internal of=/data/file1 bs=128k count=3000

Thanks,
Maya
-- 
Sent by consultant of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

