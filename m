Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2352253934
	for <linux-mmc@vger.kernel.org>; Tue, 29 Apr 2025 18:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745953139; cv=none; b=akj2Yt57fgAm6aqXwtusXtWoyHrJocthawGnoJtNaXv/lxxPjqObBvElM/SPop+XI//y/5KuZGUkzkE2vP2BdTHBd4Gyib6nqYBNvw9VkJe4jBfAwuJ6VPrYdZumQUGy5dmcNjBZtLH9Ka/x30Xmc5RkX+k0asw2UkZ29OHNcY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745953139; c=relaxed/simple;
	bh=8yooP29nCEbNjKVWmc+pZcLlNtE3MqRCQc1amUmP6Ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tBugH91ECwbXZDVdAKNU7R7ZeSIW/G1g7KKIe+pKgBLeH7lJdQXZNtl9qKbS+Eh38MAbG2fHfUnk4KYv7C7ozII+0XcQwBsrKNQ5zUJ2gM6bTBlV98jLaQgrCfOcdACO9W4dDh0sFBQfVDTTJtRERI2yJdhYvHgRVFipDwasfQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B01AF150C;
	Tue, 29 Apr 2025 11:58:44 -0700 (PDT)
Received: from [10.57.47.75] (unknown [10.57.47.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 525323F673;
	Tue, 29 Apr 2025 11:58:50 -0700 (PDT)
Message-ID: <149d6159-bc82-47e6-8886-3fa64b738ad7@arm.com>
Date: Tue, 29 Apr 2025 19:58:47 +0100
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
 <a013b589-3288-429f-a1e7-84501afa63a5@arm.com>
 <CAKh1g55LMAd9CVgZBiBCbHKu8+bJPt4D6B1aHsoa+rg0cE3ytg@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAKh1g55LMAd9CVgZBiBCbHKu8+bJPt4D6B1aHsoa+rg0cE3ytg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/29/25 19:53, Prasad Koya wrote:
> Thanks.
> 
> mmc_test module sets CMD23 for both CMD24 and CMD25.
> 
> I ran into something weird, which we also saw in the field is a CMD25
> with block count as 0.
> 
> Here are the kernel logs from the field:
> 
> [Sat Mar 29 01:31:07 2025] mmc0: Timeout waiting for hardware interrupt.
> [Sat Mar 29 01:31:07 2025] mmc0: sdhci: ============ SDHCI REGISTER
> DUMP ===========
> [Sat Mar 29 01:31:07 2025] mmc0: sdhci: Sys addr:  0xd3c01000 |
> Version:  0x00001002
> [Sat Mar 29 01:31:07 2025] mmc0: sdhci: Blk size:  0x00007200 | Blk
> cnt:  0x00000000
> [Sat Mar 29 01:31:07 2025] mmc0: sdhci: Argument:  0x0045d1a8 | Trn
> mode: 0x00000023
> [Sat Mar 29 01:31:07 2025] mmc0: sdhci: Present:   0x01ef0006 | Host
> ctl: 0x00000007
> [Sat Mar 29 01:31:07 2025] mmc0: sdhci: Power:     0x0000000f | Blk
> gap:  0x00000000
> [Sat Mar 29 01:31:07 2025] mmc0: sdhci: Wake-up:   0x00000000 | Clock:
>    0x00000207
> [Sat Mar 29 01:31:07 2025] mmc0: sdhci: Timeout:   0x0000000e | Int
> stat: 0x00000000
> [Sat Mar 29 01:31:07 2025] mmc0: sdhci: Int enab:  0x02ff008b | Sig
> enab: 0x02ff008b
> [Sat Mar 29 01:31:07 2025] mmc0: sdhci: ACmd stat: 0x00000000 | Slot
> int: 0x000000ff
> [Sat Mar 29 01:31:08 2025] mmc0: sdhci: Caps:      0x75fec8b2 |
> Caps_1:   0x00002501
> [Sat Mar 29 01:31:08 2025] mmc0: sdhci: Cmd:       0x0000193a | Max
> curr: 0x00c80064
> [Sat Mar 29 01:31:08 2025] mmc0: sdhci: Resp[0]:   0x00000900 |
> Resp[1]:  0xffffffff
> [Sat Mar 29 01:31:08 2025] mmc0: sdhci: Resp[2]:   0x320f5903 |
> Resp[3]:  0x00d04f01
> [Sat Mar 29 01:31:08 2025] mmc0: sdhci: Host ctl2: 0x00000000
> [Sat Mar 29 01:31:08 2025] mmc0: sdhci:
> ============================================
> [Sat Mar 29 01:31:10 2025] sdhci-pci 0000:00:14.7: Card stuck in wrong
> state! card_busy_detect status: 0xe00
> [Sat Mar 29 01:31:10 2025] mmc0: cache flush error -110
> [Sat Mar 29 01:31:11 2025] mmc0: tried to HW reset card, got error -110
> 
> If I send a CMD25 with data->blocks as 0 and with the same 'Argument:'
> value above for cmd->arg, I get a 10s timeout. I see that the cmd->arg
> is the "device address" or the logical block address as seen by the
> kernel.
> 
> Subsequent commands are failing with cmd->err as -110. CMD13 result
> comes with resp as 0x400d00. I see that the irq count for the sdhci
> controller goes up by 1 for each of these commands. Does it mean that
> the host controller knows the state of the card and does not forward
> the commands to the card?

It does send the command, the card rejects them as ILLEGAL and does not
respond, rightfully so, because it is still in data receive state.
A card only moves out of data receive after CMD25 if the blocks
set by CMD23 were sent or CMD12 is received.
The card seems to be behaving fine AFAICT.

> 
> Below are the eMMC traces on my box with CMD25 and above 'Argument:'
> or dev_addr value:
> 
>             bash-3281  [000] .... 77826.075030: mmc_request_start:
> mmc0: start struct mmc_request[00000000e720518c]: cmd_opcode=25
> cmd_arg=0x45d1a8 cmd_flags=0x35 cmd_retries=0 stop_opcode=0
> stop_arg=0x0 stop_flags=0x0 stop_retries=0 sbc_opcode=0 sbc_arg=0x0
> sbc_flags=0x0 sbc_retires=0 blocks=0 block_size=512 blk_addr=0
> data_flags=0x100 tag=0 can_retune=0 doing_retune=0 retune_now=0
> need_retune=0 hold_retune=1 retune_period=0
>             bash-3281  [000] ..s1 77826.076781: mmc_request_done:
> mmc0: end struct mmc_request[00000000e720518c]: cmd_opcode=25
> cmd_err=-110 cmd_resp=0x0 0x0 0x0 0x0 cmd_retries=0 stop_opcode=0
> stop_err=0 stop_resp=0x0 0x0 0x0 0x0 stop_retries=0 sbc_opcode=0
> sbc_err=0 sbc_resp=0x0 0x0 0x0 0x0 sbc_retries=0 bytes_xfered=0
> data_err=0 tag=0 can_retune=0 doing_retune=0 retune_now=0
> need_retune=0 hold_retune=1 retune_period=0
>             bash-3281  [000] .... 77826.076841: mmc_request_start:
> mmc0: start struct mmc_request[00000000e8466c12]: cmd_opcode=13
> cmd_arg=0x10000 cmd_flags=0x15 cmd_retries=0 stop_opcode=0
> stop_arg=0x0 stop_flags=0x0 stop_retries=0 sbc_opcode=0 sbc_arg=0x0
> sbc_flags=0x0 sbc_retires=0 blocks=0 block_size=0 blk_addr=0
> data_flags=0x0 tag=0 can_retune=0 doing_retune=0 retune_now=0
> need_retune=0 hold_retune=1 retune_period=0
>             bash-3281  [000] ..s. 77826.076879: mmc_request_done:
> mmc0: end struct mmc_request[00000000e8466c12]: cmd_opcode=13
> cmd_err=0 cmd_resp=0x400d00 0x0 0x0 0x0 cmd_retries=0 stop_opcode=0
> stop_err=0 stop_resp=0x0 0x0 0x0 0x0 stop_retries=0 sbc_opcode=0
> sbc_err=0 sbc_resp=0x0 0x0 0x0 0x0 sbc_retries=0 bytes_xfered=0
> data_err=0 tag=0 can_retune=0 doing_retune=0 retune_now=0
> need_retune=0 hold_retune=1 retune_period=0
> 
> Resetting the controller by the reset test (number 45) gets the
> controller out of that state.


CMD12 should suffice too, no?


> 
> We are following up with the card vendor as well.
> 
> In what situations would the kernel frame up a CMD25 with 0 blocks?
> Why does the controller or the card not like the dev_addr in the
> cmd->arg field?

This is the real issue, if that does happen.
Particularly the former, the kernel shouldn't send a CMD25 with 0
blocks.
If this happens during normal operation too (not mmc_test) a trace
would be interesting.

> 
> Thank you.
> 
> 
> On Fri, Apr 25, 2025 at 1:38 AM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 4/25/25 05:59, Prasad Koya wrote:
>>> Thanks Christian.
>>>
>>> I tried CMD25 with a different block size (mrq->data->blksz = 514) and
>>> I can see that the command was rejected with -EILSEQ (data->error =
>>> -84). But the card wasn't stuck. After the command was rejected, I see
>>> that the driver is sending CMD12 to signal the card the end of write.
>>> I see this comment in sdhci.c. Is CMD25 called an "open-ended
>>> multiblock transfer"?
>>
>> Yes indeed that's how that works.
>> IIUC your hypothesis was "card gets stuck in busy when CMD25 data was sent
>> with an invalid CRC"? That hypothesis you can now reject. (For open-ended
>> CMD25 anyway, you can also try CMD23+CMD25 and CMD24 writes).
>>
>>>
>>> 1291     /*
>>> 1292      * Need to send CMD12 if -
>>> 1293      * a) open-ended multiblock transfer (no CMD23)
>>> 1294      * b) error in multiblock transfer
>>> 1295      */
>>> 1296     if (data->stop &&
>>> 1297         (data->error ||
>>> 1298          !data->mrq->sbc)) {
>>> :
>>> 1308         } else {
>>> 1309             /* Avoid triggering warning in sdhci_send_command() */
>>> 1310             host->cmd = NULL;
>>> 1311             sdhci_send_command(host, data->stop);
>>> 1312         }
>>>
>>> Here are my emmc traces:
>>>
>>>             bash-10454 [000] ....  6902.122069: mmc_request_start:
>>> mmc0: start struct mmc_request[0000000001eb0468]: cmd_opcode=25
>>> cmd_arg=0x3a0000 cmd_flags=0x35 cmd_retries=0 stop_opcode=12
>>> stop_arg=0x0 stop_flags=0x1d stop_retries=0 sbc_opcode=0 sbc_arg=0x0
>>> sbc_flags=0x0 sbc_retires=0 blocks=17 block_size=1719
>>> blk_addr=15433700 data_flags=0x100 tag=0 can_retune=0 doing_retune=0
>>> retune_now=0 need_retune=0 hold_retune=1 retune_period=0
>>>    rs:main Q:Reg-3221  [000] ..s.  6902.125240: mmc_request_done:
>>> mmc0: end struct mmc_request[0000000001eb0468]: cmd_opcode=25
>>> cmd_err=0 cmd_resp=0x900 0x0 0x0 0x0 cmd_retries=0 stop_opcode=12
>>> stop_err=0 stop_resp=0xc00 0x0 0x0 0x0 stop_retries=0 sbc_opcode=0
>>> sbc_err=0 sbc_resp=0x0 0x0 0x0 0x0 sbc_retries=0 bytes_xfered=0
>>> data_err=-84 tag=0 can_retune=0 doing_retune=0 retune_now=0
>>> need_retune=0 hold_retune=1 retune_period=0
>>>             bash-10454 [000] ....  6902.126438: mmc_request_start:
>>> mmc0: start struct mmc_request[000000001c8ae402]: cmd_opcode=13
>>> cmd_arg=0x10000 cmd_flags=0x15 cmd_retries=0 stop_opcode=0
>>> stop_arg=0x0 stop_flags=0x0 stop_retries=0 sbc_opcode=0 sbc_arg=0x0
>>> sbc_flags=0x0 sbc_retires=0 blocks=0 block_size=0 blk_addr=0
>>> data_flags=0x0 tag=0 can_retune=0 doing_retune=0 retune_now=0
>>> need_retune=0 hold_retune=1 retune_period=0
>>>             bash-10454 [000] ..s1  6902.126911: mmc_request_done:
>>> mmc0: end struct mmc_request[000000001c8ae402]: cmd_opcode=13
>>> cmd_err=0 cmd_resp=0x900 0x0 0x0 0x0 cmd_retries=0 stop_opcode=0
>>> stop_err=0 stop_resp=0x0 0x0 0x0 0x0 stop_retries=0 sbc_opcode=0
>>> sbc_err=0 sbc_resp=0x0 0x0 0x0 0x0 sbc_retries=0 bytes_xfered=0
>>> data_err=0 tag=0 can_retune=0 doing_retune=0 retune_now=0
>>> need_retune=0 hold_retune=1 retune_period=0
>>>
>>> For our customers, something from the host to the card gets the card
>>> stuck. The status returned at that point is 0xe00. After CMD25 and
>>> CMD12 that took 10s each to timeout, all subsequent commands from the
>>> host fail immediately with -110 error.
>>
>> If the card is in busy it wont accept any new commands, so that's in
>> line. The only question is why is it stuck in busy? (The spec
>> mandates maximum busy times, they are sometimes violated by some card
>> vendors (especially SD cards), but nothing on the order of 10s should be
>> observed.)
>> Have you contacted the card vendor about this? I don't see any hint
>> on wrongdoing of the host here.
>>
>>
>>> Is there any other forum where I can post such questions. I'm a newbie
>>> to the driver. I'm looking at the JEDEC spec and trying to figure out
>>> the implementation.
>>
>> Not that I'm aware of.
>>
>>>
>>> Thanks.
>>>
>>>
>>> On Tue, Apr 22, 2025 at 2:54 PM Christian Loehle
>>> <christian.loehle@arm.com> wrote:
>>>>
>>>> On 4/22/25 18:37, Prasad Koya wrote:
>>>>> Hi Christian
>>>>>
>>>>> Thanks for going over and replying.
>>>>>
>>>>> I couldn't find any ioctl() that changed host's block size in the 6.14
>>>>> tree. We are using 5.10 kernel.
>>>>
>>>> Works on any kernel since a long time.
>>>> You can find a caller instance in mmc-utils: mmc_cmds.c, the field is
>>>> called blksz, if you've already familiarized yourself with the test
>>>> module I'd say don't bother though.
>>>>
>>>>>
>>>>> I did try mmc_test module so I can modify an existing test case and
>>>>> make it a simple one. Hacking this module, I could call CMD16 via
>>>>> mmc_test_set_blksize() and set the block size to 514 (0x202). Below
>>>>> are the eMMC traces for this test. A CMD16, followed by CMD25 with
>>>>> data, stop opcode and then CMD13. The multi-block write seems to go
>>>>> fine.
>>>>
>>>> Sorry, misunderstanding here. I meant changing the blocksize of the
>>>> transfer for the host *without* letting the card know (by issuing CMD16).
>>>> So leave out the CMD16 part and you should achieve what you want.
>>>>
>>>>>
>>>>>             bash-3958  [001] .... 34861.450688: mmc_request_start:
>>>>> mmc0: start struct mmc_request[00000000fe878338]: cmd_opcode=16
>>>>> cmd_arg=0x202 cmd_flags=0x95 cmd_retries=5 stop_opcode=0 stop_arg=0x0
>>>>> stop_flags=0x0 stop_retries=0 sbc_opcode=0 sbc_arg=0x0 sbc_flags=0x0
>>>>> sbc_retires=0 blocks=0 block_size=0 blk_addr=0 data_flags=0x0 tag=0
>>>>> can_retune=0 doing_retune=0 retune_now=0 need_retune=0 hold_retune=1
>>>>> retune_period=0
>>>>>        in:imklog-2971  [000] ..s. 34861.450737: mmc_request_done:
>>>>> mmc0: end struct mmc_request[00000000fe878338]: cmd_opcode=16
>>>>> cmd_err=0 cmd_resp=0x20000900 0x0 0x0 0x0 cmd_retries=5 stop_opcode=0
>>>>> stop_err=0 stop_resp=0x0 0x0 0x0 0x0 stop_retries=0 sbc_opcode=0
>>>>> sbc_err=0 sbc_resp=0x0 0x0 0x0 0x0 sbc_retries=0 bytes_xfered=0
>>>>> data_err=0 tag=0 can_retune=0 doing_retune=0 retune_now=0
>>>>> need_retune=0 hold_retune=1 retune_period=0
>>>>>             bash-3958  [001] .... 34861.451064: mmc_request_start:
>>>>> mmc0: start struct mmc_request[00000000c2f30356]: cmd_opcode=25
>>>>> cmd_arg=0x3a0000 cmd_flags=0x35 cmd_retries=0 stop_opcode=12
>>>>> stop_arg=0x0 stop_flags=0x1d stop_retries=0 sbc_opcode=0 sbc_arg=0x0
>>>>> sbc_flags=0x0 sbc_retires=0 blocks=128 block_size=512 blk_addr=0
>>>>> data_flags=0x100 tag=0 can_retune=0 doing_retune=0 retune_now=0
>>>>> need_retune=0 hold_retune=1 retune_period=0
>>>>>           <idle>-0     [000] ..s1 34861.456533: mmc_request_done:
>>>>> mmc0: end struct mmc_request[00000000c2f30356]: cmd_opcode=25
>>>>> cmd_err=0 cmd_resp=0x900 0x0 0x0 0x0 cmd_retries=0 stop_opcode=12
>>>>> stop_err=0 stop_resp=0xc00 0x0 0x0 0x0 stop_retries=0 sbc_opcode=0
>>>>> sbc_err=0 sbc_resp=0x0 0x0 0x0 0x0 sbc_retries=0 bytes_xfered=65536
>>>>> data_err=0 tag=0 can_retune=0 doing_retune=0 retune_now=0
>>>>> need_retune=0 hold_retune=1 retune_period=0
>>>>>             bash-3958  [001] .... 34861.456562: mmc_request_start:
>>>>> mmc0: start struct mmc_request[00000000e93d6161]: cmd_opcode=13
>>>>> cmd_arg=0x10000 cmd_flags=0x15 cmd_retries=0 stop_opcode=0
>>>>> stop_arg=0x0 stop_flags=0x0 stop_retries=0 sbc_opcode=0 sbc_arg=0x0
>>>>> sbc_flags=0x0 sbc_retires=0 blocks=0 block_size=0 blk_addr=0
>>>>> data_flags=0x0 tag=0 can_retune=0 doing_retune=0 retune_now=0
>>>>> need_retune=0 hold_retune=1 retune_period=0
>>>>>    rs:main Q:Reg-2972  [000] ..s. 34861.456688: mmc_request_done:
>>>>> mmc0: end struct mmc_request[00000000e93d6161]: cmd_opcode=13
>>>>> cmd_err=0 cmd_resp=0x900 0x0 0x0 0x0 cmd_retries=0 stop_opcode=0
>>>>> stop_err=0 stop_resp=0x0 0x0 0x0 0x0 stop_retries=0 sbc_opcode=0
>>>>> sbc_err=0 sbc_resp=0x0 0x0 0x0 0x0 sbc_retries=0 bytes_xfered=0
>>>>> data_err=0 tag=0 can_retune=0 doing_retune=0 retune_now=0
>>>>> need_retune=0 hold_retune=1 retune_period=0
>>>>>
>>>>> What we believe could be happening is an SEU that flips a bit in the
>>>>> data block after the host controller has sent the block on the DAT
>>>>> lines. Card should reject that after CRC mismatch. Does the card
>>>>> reject the command right when it sees a CRC mismatch or does it have
>>>>> to wait till all blocks and CMD12 is sent by the host?
>>>>
>>>> Open writes with CMD25-CMD12 indeed send all blocks until the card
>>>> can signal CRC error.
>>>>
>>>>>
>>>>> Thank you.
>>>>>
>>>>>
>>>>>
>>>>> On Wed, Apr 16, 2025 at 2:13 AM Christian Loehle
>>>>> <christian.loehle@arm.com> wrote:
>>>>>>
>>>>>> On 4/16/25 01:13, Prasad Koya wrote:
>>>>>>> Hi
>>>>>>>
>>>>>>> We use eMMC as a boot drive. At a random time, maybe a month or an
>>>>>>> year of uptime, we run into an issue where we see the eMMC driver
>>>>>>> prints this in the kernel logs and the drive no longer responds after
>>>>>>> that. We see this issue in the field on linux kernel 4.19.142 and
>>>>>>> 5.10.165. From the SDHCI register dump, it looks like CMD25 ran into a
>>>>>>> timeout first. After the first timeout, we see CMD12 in the second
>>>>>>> SDHCI register dump. Status returned by the card at that point in
>>>>>>> card_busy_detect() is 0xE00.
>>>>>>>
>>>>>>> I looked at the recent commits up to 6.15 and I do not see anything
>>>>>>> obvious that addresses issue like below.
>>>>>>>
>>>>>>> We are trying to reproduce the issue in our lab and understand the
>>>>>>> driver code. Is there a way I can send a block of data as part of
>>>>>>> CMD25 with invalid CRC?  Appreciate any pointers.
>>>>>>
>>>>>> CRC is appended by hardware, so it will always be correct.
>>>>>> What you can do though is change the blocksize of the transfer on the
>>>>>> host side (e.g. from 512 to 514 bytes) without changing it using CMD16.
>>>>>> The 2 bytes will be latched in as CRC by the card. Of course you won't
>>>>>> see the CRC ACK from the card in that case (as it clashes with the
>>>>>> hardware CRC signal from the host).
>>>>>> You can do all this using the ioctl interface in userspace btw.
>>>>
>>

