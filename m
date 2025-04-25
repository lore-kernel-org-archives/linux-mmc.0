Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A33E23535F
	for <linux-mmc@vger.kernel.org>; Fri, 25 Apr 2025 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745570292; cv=none; b=lXVbUvGRy3/oXtsf3ygRl+zWwYd6qJOxqh6zLxbFuADnXfnoZbu0E4e3XY2SVHbn4UUOb2R1rc0czLbiBN0466OjcrGt5+kZ7UKk1P4RqJ4MqjigMoQA+0Mk/KPgBsjvR4v1NtmegBM5DIQ6PXFYuYfQEKdojN/HWiPma3SOo/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745570292; c=relaxed/simple;
	bh=eqfJhtU47JgTZCPL4wqfGT1Xr+DMREXNxbMKQSlwrDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0/W6R+eDQw5iFj4MW3FEZZfKvMqJYQ5UCft+mdnz+S3615eYSk6qzt1p0HpM70lrU60nXNVwmRj8lCrw1cJU7RCvxTRSbKyXDEXU5qPnwd3fWZYCtwbed1+Ee+rcd20/g6rEFctGF/St80yeu+ePkUk7RgUuL1SrI6ozhxkiYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B55F106F;
	Fri, 25 Apr 2025 01:38:03 -0700 (PDT)
Received: from [10.57.72.192] (unknown [10.57.72.192])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB3E63F66E;
	Fri, 25 Apr 2025 01:38:07 -0700 (PDT)
Message-ID: <a013b589-3288-429f-a1e7-84501afa63a5@arm.com>
Date: Fri, 25 Apr 2025 09:38:05 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: eMMC timeout reproduction. Can I send a block of data from the
 host to the card with invalid CRC?
To: Prasad Koya <prasad@arista.com>
Cc: Baptiste Covolato <baptiste@arista.com>,
 Sushrut Shirole <sushrut@arista.com>, linux-mmc@vger.kernel.org
References: <CAKh1g556YvHE9eib3WJG+mBHyyr88rxYSbNUHxpFYsUHcdOoUg@mail.gmail.com>
 <fb21ad0b-b45f-4636-9d74-1e758c3b2879@arm.com>
 <CAKh1g55ErQRRsJSe6zEmp6mT6nAhEP_Br+HA8x5RvUa4B=4ERA@mail.gmail.com>
 <2343cad4-89aa-48c6-86e7-0c8847ecfe60@arm.com>
 <CAKh1g54=F286nv6zA4UTJeXfxhgNxBLata54ict99ibneBZdcQ@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAKh1g54=F286nv6zA4UTJeXfxhgNxBLata54ict99ibneBZdcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/25/25 05:59, Prasad Koya wrote:
> Thanks Christian.
> 
> I tried CMD25 with a different block size (mrq->data->blksz = 514) and
> I can see that the command was rejected with -EILSEQ (data->error =
> -84). But the card wasn't stuck. After the command was rejected, I see
> that the driver is sending CMD12 to signal the card the end of write.
> I see this comment in sdhci.c. Is CMD25 called an "open-ended
> multiblock transfer"?

Yes indeed that's how that works.
IIUC your hypothesis was "card gets stuck in busy when CMD25 data was sent
with an invalid CRC"? That hypothesis you can now reject. (For open-ended
CMD25 anyway, you can also try CMD23+CMD25 and CMD24 writes).

> 
> 1291     /*
> 1292      * Need to send CMD12 if -
> 1293      * a) open-ended multiblock transfer (no CMD23)
> 1294      * b) error in multiblock transfer
> 1295      */
> 1296     if (data->stop &&
> 1297         (data->error ||
> 1298          !data->mrq->sbc)) {
> :
> 1308         } else {
> 1309             /* Avoid triggering warning in sdhci_send_command() */
> 1310             host->cmd = NULL;
> 1311             sdhci_send_command(host, data->stop);
> 1312         }
> 
> Here are my emmc traces:
> 
>             bash-10454 [000] ....  6902.122069: mmc_request_start:
> mmc0: start struct mmc_request[0000000001eb0468]: cmd_opcode=25
> cmd_arg=0x3a0000 cmd_flags=0x35 cmd_retries=0 stop_opcode=12
> stop_arg=0x0 stop_flags=0x1d stop_retries=0 sbc_opcode=0 sbc_arg=0x0
> sbc_flags=0x0 sbc_retires=0 blocks=17 block_size=1719
> blk_addr=15433700 data_flags=0x100 tag=0 can_retune=0 doing_retune=0
> retune_now=0 need_retune=0 hold_retune=1 retune_period=0
>    rs:main Q:Reg-3221  [000] ..s.  6902.125240: mmc_request_done:
> mmc0: end struct mmc_request[0000000001eb0468]: cmd_opcode=25
> cmd_err=0 cmd_resp=0x900 0x0 0x0 0x0 cmd_retries=0 stop_opcode=12
> stop_err=0 stop_resp=0xc00 0x0 0x0 0x0 stop_retries=0 sbc_opcode=0
> sbc_err=0 sbc_resp=0x0 0x0 0x0 0x0 sbc_retries=0 bytes_xfered=0
> data_err=-84 tag=0 can_retune=0 doing_retune=0 retune_now=0
> need_retune=0 hold_retune=1 retune_period=0
>             bash-10454 [000] ....  6902.126438: mmc_request_start:
> mmc0: start struct mmc_request[000000001c8ae402]: cmd_opcode=13
> cmd_arg=0x10000 cmd_flags=0x15 cmd_retries=0 stop_opcode=0
> stop_arg=0x0 stop_flags=0x0 stop_retries=0 sbc_opcode=0 sbc_arg=0x0
> sbc_flags=0x0 sbc_retires=0 blocks=0 block_size=0 blk_addr=0
> data_flags=0x0 tag=0 can_retune=0 doing_retune=0 retune_now=0
> need_retune=0 hold_retune=1 retune_period=0
>             bash-10454 [000] ..s1  6902.126911: mmc_request_done:
> mmc0: end struct mmc_request[000000001c8ae402]: cmd_opcode=13
> cmd_err=0 cmd_resp=0x900 0x0 0x0 0x0 cmd_retries=0 stop_opcode=0
> stop_err=0 stop_resp=0x0 0x0 0x0 0x0 stop_retries=0 sbc_opcode=0
> sbc_err=0 sbc_resp=0x0 0x0 0x0 0x0 sbc_retries=0 bytes_xfered=0
> data_err=0 tag=0 can_retune=0 doing_retune=0 retune_now=0
> need_retune=0 hold_retune=1 retune_period=0
> 
> For our customers, something from the host to the card gets the card
> stuck. The status returned at that point is 0xe00. After CMD25 and
> CMD12 that took 10s each to timeout, all subsequent commands from the
> host fail immediately with -110 error.

If the card is in busy it wont accept any new commands, so that's in
line. The only question is why is it stuck in busy? (The spec
mandates maximum busy times, they are sometimes violated by some card
vendors (especially SD cards), but nothing on the order of 10s should be
observed.)
Have you contacted the card vendor about this? I don't see any hint
on wrongdoing of the host here.


> Is there any other forum where I can post such questions. I'm a newbie
> to the driver. I'm looking at the JEDEC spec and trying to figure out
> the implementation.

Not that I'm aware of.

> 
> Thanks.
> 
> 
> On Tue, Apr 22, 2025 at 2:54 PM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 4/22/25 18:37, Prasad Koya wrote:
>>> Hi Christian
>>>
>>> Thanks for going over and replying.
>>>
>>> I couldn't find any ioctl() that changed host's block size in the 6.14
>>> tree. We are using 5.10 kernel.
>>
>> Works on any kernel since a long time.
>> You can find a caller instance in mmc-utils: mmc_cmds.c, the field is
>> called blksz, if you've already familiarized yourself with the test
>> module I'd say don't bother though.
>>
>>>
>>> I did try mmc_test module so I can modify an existing test case and
>>> make it a simple one. Hacking this module, I could call CMD16 via
>>> mmc_test_set_blksize() and set the block size to 514 (0x202). Below
>>> are the eMMC traces for this test. A CMD16, followed by CMD25 with
>>> data, stop opcode and then CMD13. The multi-block write seems to go
>>> fine.
>>
>> Sorry, misunderstanding here. I meant changing the blocksize of the
>> transfer for the host *without* letting the card know (by issuing CMD16).
>> So leave out the CMD16 part and you should achieve what you want.
>>
>>>
>>>             bash-3958  [001] .... 34861.450688: mmc_request_start:
>>> mmc0: start struct mmc_request[00000000fe878338]: cmd_opcode=16
>>> cmd_arg=0x202 cmd_flags=0x95 cmd_retries=5 stop_opcode=0 stop_arg=0x0
>>> stop_flags=0x0 stop_retries=0 sbc_opcode=0 sbc_arg=0x0 sbc_flags=0x0
>>> sbc_retires=0 blocks=0 block_size=0 blk_addr=0 data_flags=0x0 tag=0
>>> can_retune=0 doing_retune=0 retune_now=0 need_retune=0 hold_retune=1
>>> retune_period=0
>>>        in:imklog-2971  [000] ..s. 34861.450737: mmc_request_done:
>>> mmc0: end struct mmc_request[00000000fe878338]: cmd_opcode=16
>>> cmd_err=0 cmd_resp=0x20000900 0x0 0x0 0x0 cmd_retries=5 stop_opcode=0
>>> stop_err=0 stop_resp=0x0 0x0 0x0 0x0 stop_retries=0 sbc_opcode=0
>>> sbc_err=0 sbc_resp=0x0 0x0 0x0 0x0 sbc_retries=0 bytes_xfered=0
>>> data_err=0 tag=0 can_retune=0 doing_retune=0 retune_now=0
>>> need_retune=0 hold_retune=1 retune_period=0
>>>             bash-3958  [001] .... 34861.451064: mmc_request_start:
>>> mmc0: start struct mmc_request[00000000c2f30356]: cmd_opcode=25
>>> cmd_arg=0x3a0000 cmd_flags=0x35 cmd_retries=0 stop_opcode=12
>>> stop_arg=0x0 stop_flags=0x1d stop_retries=0 sbc_opcode=0 sbc_arg=0x0
>>> sbc_flags=0x0 sbc_retires=0 blocks=128 block_size=512 blk_addr=0
>>> data_flags=0x100 tag=0 can_retune=0 doing_retune=0 retune_now=0
>>> need_retune=0 hold_retune=1 retune_period=0
>>>           <idle>-0     [000] ..s1 34861.456533: mmc_request_done:
>>> mmc0: end struct mmc_request[00000000c2f30356]: cmd_opcode=25
>>> cmd_err=0 cmd_resp=0x900 0x0 0x0 0x0 cmd_retries=0 stop_opcode=12
>>> stop_err=0 stop_resp=0xc00 0x0 0x0 0x0 stop_retries=0 sbc_opcode=0
>>> sbc_err=0 sbc_resp=0x0 0x0 0x0 0x0 sbc_retries=0 bytes_xfered=65536
>>> data_err=0 tag=0 can_retune=0 doing_retune=0 retune_now=0
>>> need_retune=0 hold_retune=1 retune_period=0
>>>             bash-3958  [001] .... 34861.456562: mmc_request_start:
>>> mmc0: start struct mmc_request[00000000e93d6161]: cmd_opcode=13
>>> cmd_arg=0x10000 cmd_flags=0x15 cmd_retries=0 stop_opcode=0
>>> stop_arg=0x0 stop_flags=0x0 stop_retries=0 sbc_opcode=0 sbc_arg=0x0
>>> sbc_flags=0x0 sbc_retires=0 blocks=0 block_size=0 blk_addr=0
>>> data_flags=0x0 tag=0 can_retune=0 doing_retune=0 retune_now=0
>>> need_retune=0 hold_retune=1 retune_period=0
>>>    rs:main Q:Reg-2972  [000] ..s. 34861.456688: mmc_request_done:
>>> mmc0: end struct mmc_request[00000000e93d6161]: cmd_opcode=13
>>> cmd_err=0 cmd_resp=0x900 0x0 0x0 0x0 cmd_retries=0 stop_opcode=0
>>> stop_err=0 stop_resp=0x0 0x0 0x0 0x0 stop_retries=0 sbc_opcode=0
>>> sbc_err=0 sbc_resp=0x0 0x0 0x0 0x0 sbc_retries=0 bytes_xfered=0
>>> data_err=0 tag=0 can_retune=0 doing_retune=0 retune_now=0
>>> need_retune=0 hold_retune=1 retune_period=0
>>>
>>> What we believe could be happening is an SEU that flips a bit in the
>>> data block after the host controller has sent the block on the DAT
>>> lines. Card should reject that after CRC mismatch. Does the card
>>> reject the command right when it sees a CRC mismatch or does it have
>>> to wait till all blocks and CMD12 is sent by the host?
>>
>> Open writes with CMD25-CMD12 indeed send all blocks until the card
>> can signal CRC error.
>>
>>>
>>> Thank you.
>>>
>>>
>>>
>>> On Wed, Apr 16, 2025 at 2:13 AM Christian Loehle
>>> <christian.loehle@arm.com> wrote:
>>>>
>>>> On 4/16/25 01:13, Prasad Koya wrote:
>>>>> Hi
>>>>>
>>>>> We use eMMC as a boot drive. At a random time, maybe a month or an
>>>>> year of uptime, we run into an issue where we see the eMMC driver
>>>>> prints this in the kernel logs and the drive no longer responds after
>>>>> that. We see this issue in the field on linux kernel 4.19.142 and
>>>>> 5.10.165. From the SDHCI register dump, it looks like CMD25 ran into a
>>>>> timeout first. After the first timeout, we see CMD12 in the second
>>>>> SDHCI register dump. Status returned by the card at that point in
>>>>> card_busy_detect() is 0xE00.
>>>>>
>>>>> I looked at the recent commits up to 6.15 and I do not see anything
>>>>> obvious that addresses issue like below.
>>>>>
>>>>> We are trying to reproduce the issue in our lab and understand the
>>>>> driver code. Is there a way I can send a block of data as part of
>>>>> CMD25 with invalid CRC?  Appreciate any pointers.
>>>>
>>>> CRC is appended by hardware, so it will always be correct.
>>>> What you can do though is change the blocksize of the transfer on the
>>>> host side (e.g. from 512 to 514 bytes) without changing it using CMD16.
>>>> The 2 bytes will be latched in as CRC by the card. Of course you won't
>>>> see the CRC ACK from the card in that case (as it clashes with the
>>>> hardware CRC signal from the host).
>>>> You can do all this using the ioctl interface in userspace btw.
>>

