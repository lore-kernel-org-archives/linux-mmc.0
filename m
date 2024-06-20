Received: from speedy.danman.eu (speedy.danman.eu [46.227.180.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F347739AFD
	for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 18:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.227.180.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718907352; cv=none; b=Z+CYRQLrwex/MAUIQc/ea1DSFLdRHXA+gCbqZEPPoKQDyvsyzPPXLnQ3hl5Mfz1JtBscy6Ycxup+Rz9VG1jk7k7t0FK6dxyfsOky5T4mFxrgCCYt8YG3sACBb+yWwTjxeX/64B6bLvDD2tRoXT8nRW5PGpHMBPgMkjMASbmFHAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718907352; c=relaxed/simple;
	bh=ypGc2zYe+wqov6S3Tym5U5XSyoLlMSKBOHHr92+QkZc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=iG66plIbPv8++3hmx/v5Eeso5vgYLwd4q96JnyeaPUUnE9O7tvBIfBfLlS6J91u6FyVvyo2OhPsqnddgCLkA3iuMNRRS9RBmBDWTcMSlIGEKbYxGOzj+0sm1NFE/x7PC+uZt6qg0eFxl4CPzRQKvWJ5425hY044qqpSIt4cVV9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danman.eu; spf=pass smtp.mailfrom=danman.eu; arc=none smtp.client-ip=46.227.180.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danman.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danman.eu
Received: from mail.danman.eu (localhost [IPv6:::1])
	by speedy.danman.eu (Postfix) with ESMTPA id 42E4B24091D;
	Thu, 20 Jun 2024 20:15:45 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Jun 2024 20:15:45 +0200
From: Daniel Kucera <linux-mmc@danman.eu>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, alcooperx@gmail.com
Subject: Re: [PATCH v4] mmc: core: allow detection of locked cards
In-Reply-To: <CAPDyKFpLkmU-vjAaM=QDkc+3F3tMNjViOdnYSFNqyDduyfBm1g@mail.gmail.com>
References: <20240606131222.1131880-1-linux-mmc@danman.eu>
 <CAPDyKFpuJexp_1hgKhJ3b8VCx+PwwhAQscbJT5-44Re0xmbxrg@mail.gmail.com>
 <c89d8a0c170fa3bc8593bfde25b07e4d@danman.eu>
 <CAPDyKFpLkmU-vjAaM=QDkc+3F3tMNjViOdnYSFNqyDduyfBm1g@mail.gmail.com>
User-Agent: Roundcube Webmail/1.5.0
Message-ID: <6845f5386ccb71908eedba833e8ace29@danman.eu>
X-Sender: linux-mmc@danman.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2024-06-20 16:32, Ulf Hansson wrote:
> On Thu, 20 Jun 2024 at 14:59, Daniel Kucera <linux-mmc@danman.eu> 
> wrote:
>> 
>> On 2024-06-20 14:38, Ulf Hansson wrote:
>> > On Thu, 6 Jun 2024 at 15:12, <linux-mmc@danman.eu> wrote:
>> >>
>> >> From: Daniel Kucera <linux-mmc@danman.eu>
>> >>
>> >> Locked SD card will not reply to SEND_SCR or SD_STATUS commands
>> >> so it was failing to initialize previously. When skipped,
>> >> the card will get initialized and CMD42 can be sent using
>> >> ioctl to unlock the card or remove password protection.
>> >> For eMMC, this is not necessary because all initialization
>> >> commands are allowed in locked state.
>> >> Until unlocked, all read/write calls will timeout.
>> >
>> > Skipping the commands above, only means the card gets partially
>> > initialized.
>> 
>> Correct, but it's an improvement in comparison to current state.
> 
> Not sure I agree with that, sorry.

Are you saying that that being able to work with locked card is not an
improvement in comparison to not being able to? Or did I misunderstand
that?

> 
>> 
>> > Leaving a card in that state seems fragile.
>> 
>> Fragile in what sense? Nothing can happen to the card as it is locked.
> 
> We may end up having a card half-way initialized that we can't really
> communicate with in a stable manner. From a system point of view, I
> would be worried.

It's not half-way initialized, it's initialized correctly, it's just not
using the full potential of the card (higher speeds, etc.).

The situation would be the same as it is currently with emmc. Locked
emmc gets initialized correctly but reads/writes time-out. What is wrong
in having the same result for both sd and emmc?

> 
> I would rather just power off the card if initialization fails and
> remove its corresponding device from the system.
> 
>> 
>> > What will
>> > happen to upper block layers and filesystems when trying to access it?
>> 
>> Everything will simply time-out.
> 
> Yes, but it's uncertain what that could lead to?
> 
> What will happen with power consumption and power management support,
> for example.

Okay, this is a valid concern. Would it be acceptable if we just enabled
this "feature" with a module parameter, something like
"sd_initialize_locked=1" with default 0?

> 
>> 
>> >
>> > Several years ago Al Cooper made an attempt [1] to manage the
>> > unlocking of the card during initialization, by finding the password
>> > through the "keys" subsystem. The series didn't really make it to the
>> > upstream kernel, but overall the approach seemed to make sense to me.
>> > It should allow us to complete the initialization of the card inside
>> > the kernel and prevent unnecessary complexity for userspace to manage.
>> 
>> Yes, he did a great work but obviously no-one got too excited to
>> review/merge
>> his work. His solution was complex.
> 
> It's quite some amount of code. On the other hand, it seemed quite
> straight forward, not that complex to me.

It doesn't solve the situation when you don't know the password and you
just want to erase the card and continue using in. The (un)locking
doesn't belong to kernel IMO, if it can be implemented in user-space, it
should and it is more flexible that way.

> 
>> 
>> Mine targets the smallest change possible to make it work at least.
>> I wanted to avoid a solution that would be hard to test, review and
>> maintain.
>> Especially when there is only a small interest in the feature.
>> 
>> > Perhaps you can have a closer look at that series and see if it's
>> > possible to update it?
>> 
>> I don't think I have the skills to revive his work.
> 
> I see, maybe we should ping Al and other interested folkz to see if
> there still is some interest to move this forward?

Okay, Al, are you interested?

> 
> [...]
> 
> Kind regards
> Uffe

BR
Daniel

