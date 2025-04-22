Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03F326C387
	for <linux-mmc@vger.kernel.org>; Tue, 22 Apr 2025 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745358847; cv=none; b=JxIO89J69hqbUXe17NCe0rMoOy8fr8FzN2fzYLsdI2Qw7t7TnsSlaG63Vz92+eQDUIgHtjQKJCwAYkTYyDpjcHNgqVOMF6pNhWP+/0eJlFOlSqFDvIIcFNhlFyFzRT+ZQCQ5mqaeRiDorvImsGtLzkDl0vUA012/44wWS8cJL+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745358847; c=relaxed/simple;
	bh=J77h4x7ktJNZsEZcXkBhtXZfUgBESN2/ejjDv/iAMsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IS5ge/jVlVzYE8VapOTlOH3TVB1HvwlI7G87gj2+gjqw11VGNiWTIVi3KnRY6O6cU3QP7CM9ehftq+PAhdzU2aiqJHBfO9p0dNXsZmvAIWjxfyZ5SzYb7ycgpMncd7HHsvvLvjLPPgELPA5KSnGs0uDHwBEHftipOsNjWgqm5Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DEC01516;
	Tue, 22 Apr 2025 14:53:58 -0700 (PDT)
Received: from [10.57.72.192] (unknown [10.57.72.192])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E15AF3F59E;
	Tue, 22 Apr 2025 14:54:01 -0700 (PDT)
Message-ID: <2343cad4-89aa-48c6-86e7-0c8847ecfe60@arm.com>
Date: Tue, 22 Apr 2025 22:53:59 +0100
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
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAKh1g55ErQRRsJSe6zEmp6mT6nAhEP_Br+HA8x5RvUa4B=4ERA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/22/25 18:37, Prasad Koya wrote:
> Hi Christian
> 
> Thanks for going over and replying.
> 
> I couldn't find any ioctl() that changed host's block size in the 6.14
> tree. We are using 5.10 kernel.

Works on any kernel since a long time.
You can find a caller instance in mmc-utils: mmc_cmds.c, the field is
called blksz, if you've already familiarized yourself with the test
module I'd say don't bother though.

> 
> I did try mmc_test module so I can modify an existing test case and
> make it a simple one. Hacking this module, I could call CMD16 via
> mmc_test_set_blksize() and set the block size to 514 (0x202). Below
> are the eMMC traces for this test. A CMD16, followed by CMD25 with
> data, stop opcode and then CMD13. The multi-block write seems to go
> fine.

Sorry, misunderstanding here. I meant changing the blocksize of the
transfer for the host *without* letting the card know (by issuing CMD16).
So leave out the CMD16 part and you should achieve what you want.

> 
>             bash-3958  [001] .... 34861.450688: mmc_request_start:
> mmc0: start struct mmc_request[00000000fe878338]: cmd_opcode=16
> cmd_arg=0x202 cmd_flags=0x95 cmd_retries=5 stop_opcode=0 stop_arg=0x0
> stop_flags=0x0 stop_retries=0 sbc_opcode=0 sbc_arg=0x0 sbc_flags=0x0
> sbc_retires=0 blocks=0 block_size=0 blk_addr=0 data_flags=0x0 tag=0
> can_retune=0 doing_retune=0 retune_now=0 need_retune=0 hold_retune=1
> retune_period=0
>        in:imklog-2971  [000] ..s. 34861.450737: mmc_request_done:
> mmc0: end struct mmc_request[00000000fe878338]: cmd_opcode=16
> cmd_err=0 cmd_resp=0x20000900 0x0 0x0 0x0 cmd_retries=5 stop_opcode=0
> stop_err=0 stop_resp=0x0 0x0 0x0 0x0 stop_retries=0 sbc_opcode=0
> sbc_err=0 sbc_resp=0x0 0x0 0x0 0x0 sbc_retries=0 bytes_xfered=0
> data_err=0 tag=0 can_retune=0 doing_retune=0 retune_now=0
> need_retune=0 hold_retune=1 retune_period=0
>             bash-3958  [001] .... 34861.451064: mmc_request_start:
> mmc0: start struct mmc_request[00000000c2f30356]: cmd_opcode=25
> cmd_arg=0x3a0000 cmd_flags=0x35 cmd_retries=0 stop_opcode=12
> stop_arg=0x0 stop_flags=0x1d stop_retries=0 sbc_opcode=0 sbc_arg=0x0
> sbc_flags=0x0 sbc_retires=0 blocks=128 block_size=512 blk_addr=0
> data_flags=0x100 tag=0 can_retune=0 doing_retune=0 retune_now=0
> need_retune=0 hold_retune=1 retune_period=0
>           <idle>-0     [000] ..s1 34861.456533: mmc_request_done:
> mmc0: end struct mmc_request[00000000c2f30356]: cmd_opcode=25
> cmd_err=0 cmd_resp=0x900 0x0 0x0 0x0 cmd_retries=0 stop_opcode=12
> stop_err=0 stop_resp=0xc00 0x0 0x0 0x0 stop_retries=0 sbc_opcode=0
> sbc_err=0 sbc_resp=0x0 0x0 0x0 0x0 sbc_retries=0 bytes_xfered=65536
> data_err=0 tag=0 can_retune=0 doing_retune=0 retune_now=0
> need_retune=0 hold_retune=1 retune_period=0
>             bash-3958  [001] .... 34861.456562: mmc_request_start:
> mmc0: start struct mmc_request[00000000e93d6161]: cmd_opcode=13
> cmd_arg=0x10000 cmd_flags=0x15 cmd_retries=0 stop_opcode=0
> stop_arg=0x0 stop_flags=0x0 stop_retries=0 sbc_opcode=0 sbc_arg=0x0
> sbc_flags=0x0 sbc_retires=0 blocks=0 block_size=0 blk_addr=0
> data_flags=0x0 tag=0 can_retune=0 doing_retune=0 retune_now=0
> need_retune=0 hold_retune=1 retune_period=0
>    rs:main Q:Reg-2972  [000] ..s. 34861.456688: mmc_request_done:
> mmc0: end struct mmc_request[00000000e93d6161]: cmd_opcode=13
> cmd_err=0 cmd_resp=0x900 0x0 0x0 0x0 cmd_retries=0 stop_opcode=0
> stop_err=0 stop_resp=0x0 0x0 0x0 0x0 stop_retries=0 sbc_opcode=0
> sbc_err=0 sbc_resp=0x0 0x0 0x0 0x0 sbc_retries=0 bytes_xfered=0
> data_err=0 tag=0 can_retune=0 doing_retune=0 retune_now=0
> need_retune=0 hold_retune=1 retune_period=0
> 
> What we believe could be happening is an SEU that flips a bit in the
> data block after the host controller has sent the block on the DAT
> lines. Card should reject that after CRC mismatch. Does the card
> reject the command right when it sees a CRC mismatch or does it have
> to wait till all blocks and CMD12 is sent by the host?

Open writes with CMD25-CMD12 indeed send all blocks until the card
can signal CRC error.

> 
> Thank you.
> 
> 
> 
> On Wed, Apr 16, 2025 at 2:13 AM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 4/16/25 01:13, Prasad Koya wrote:
>>> Hi
>>>
>>> We use eMMC as a boot drive. At a random time, maybe a month or an
>>> year of uptime, we run into an issue where we see the eMMC driver
>>> prints this in the kernel logs and the drive no longer responds after
>>> that. We see this issue in the field on linux kernel 4.19.142 and
>>> 5.10.165. From the SDHCI register dump, it looks like CMD25 ran into a
>>> timeout first. After the first timeout, we see CMD12 in the second
>>> SDHCI register dump. Status returned by the card at that point in
>>> card_busy_detect() is 0xE00.
>>>
>>> I looked at the recent commits up to 6.15 and I do not see anything
>>> obvious that addresses issue like below.
>>>
>>> We are trying to reproduce the issue in our lab and understand the
>>> driver code. Is there a way I can send a block of data as part of
>>> CMD25 with invalid CRC?  Appreciate any pointers.
>>
>> CRC is appended by hardware, so it will always be correct.
>> What you can do though is change the blocksize of the transfer on the
>> host side (e.g. from 512 to 514 bytes) without changing it using CMD16.
>> The 2 bytes will be latched in as CRC by the card. Of course you won't
>> see the CRC ACK from the card in that case (as it clashes with the
>> hardware CRC signal from the host).
>> You can do all this using the ioctl interface in userspace btw.

