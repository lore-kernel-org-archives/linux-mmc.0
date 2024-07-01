Received: from speedy.danman.eu (speedy.danman.eu [46.227.180.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2396E82C6C
	for <linux-mmc@vger.kernel.org>; Mon,  1 Jul 2024 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.227.180.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823250; cv=none; b=XSnmsVBG1eEOmq0Odahvu7bicDNRiuks7vR8KkXWHtzJ2Nzqu8CSdeY98jG8iuEP0dpYgNnYQjG1YdcZk2xGtBCv8H+19M3leJ01lP0Hq77sikV6PEs0urQXKQEt/Jlgla/54joqPt98GpFETsylvxq6yl+1offGlF62biWwp98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823250; c=relaxed/simple;
	bh=Jk8CmC9UKzBbIIcqAoo9VYQO5QXcxY8PwbYhf9zG4Qs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=h5pVuEtYtwq2ZCzU3LY2kbYkxuejH9hbEukRMAbkU4oFKLxrThjWDkYkFm6jESqCQmgKAt+UkJWny5K92geuRC9HygJPrpVCCiks4xdC0YSRsfb57xzYi5XZuLmCRixQOMqMO5sBOCwnTL86Hsgr1u6LDv8jceg1HN7rwRmsAv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danman.eu; spf=pass smtp.mailfrom=danman.eu; arc=none smtp.client-ip=46.227.180.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danman.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danman.eu
Received: from mail.danman.eu (localhost [IPv6:::1])
	by speedy.danman.eu (Postfix) with ESMTPA id 38426240B95;
	Mon,  1 Jul 2024 10:33:14 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 01 Jul 2024 10:33:14 +0200
From: Daniel Kucera <linux-mmc@danman.eu>
To: ulf.hansson@linaro.org
Cc: Avri Altman <Avri.Altman@wdc.com>, linux-mmc@vger.kernel.org,
 alcooperx@gmail.com
Subject: Re: [PATCH v4] mmc: core: allow detection of locked cards
In-Reply-To: <DM6PR04MB6575D856FD5D5E61D40576FAFCC92@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240606131222.1131880-1-linux-mmc@danman.eu>
 <CAPDyKFpuJexp_1hgKhJ3b8VCx+PwwhAQscbJT5-44Re0xmbxrg@mail.gmail.com>
 <c89d8a0c170fa3bc8593bfde25b07e4d@danman.eu>
 <CAPDyKFpLkmU-vjAaM=QDkc+3F3tMNjViOdnYSFNqyDduyfBm1g@mail.gmail.com>
 <6845f5386ccb71908eedba833e8ace29@danman.eu>
 <DM6PR04MB6575D856FD5D5E61D40576FAFCC92@DM6PR04MB6575.namprd04.prod.outlook.com>
User-Agent: Roundcube Webmail/1.5.0
Message-ID: <db8de534f6f2c39195f6a5f094c93312@danman.eu>
X-Sender: linux-mmc@danman.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi Ulf,

could you please reconsider this?
Or give some tips how to make this acceptable for merging?

Thank you,
Daniel.

On 2024-06-21 09:16, Avri Altman wrote:
>> On 2024-06-20 16:32, Ulf Hansson wrote:
>> > On Thu, 20 Jun 2024 at 14:59, Daniel Kucera <linux-mmc@danman.eu>
>> > wrote:
>> >>
>> >> On 2024-06-20 14:38, Ulf Hansson wrote:
>> >> > On Thu, 6 Jun 2024 at 15:12, <linux-mmc@danman.eu> wrote:
>> >> >>
>> >> >> From: Daniel Kucera <linux-mmc@danman.eu>
>> >> >>
>> >> >> Locked SD card will not reply to SEND_SCR or SD_STATUS commands so
>> >> >> it was failing to initialize previously. When skipped, the card
>> >> >> will get initialized and CMD42 can be sent using ioctl to unlock
>> >> >> the card or remove password protection.
>> >> >> For eMMC, this is not necessary because all initialization
>> >> >> commands are allowed in locked state.
>> >> >> Until unlocked, all read/write calls will timeout.
>> >> >
>> >> > Skipping the commands above, only means the card gets partially
>> >> > initialized.
>> >>
>> >> Correct, but it's an improvement in comparison to current state.
>> >
>> > Not sure I agree with that, sorry.
>> 
>> Are you saying that that being able to work with locked card is not an
>> improvement in comparison to not being able to? Or did I misunderstand
>> that?
>> 
>> >
>> >>
>> >> > Leaving a card in that state seems fragile.
>> >>
>> >> Fragile in what sense? Nothing can happen to the card as it is locked.
>> >
>> > We may end up having a card half-way initialized that we can't really
>> > communicate with in a stable manner. From a system point of view, I
>> > would be worried.
> Actually, it's what the spec expects - the CARD_IS_LOCKED is carried
> in CMD7 response.
> Then the card responds to class 0, class 7, and ACMD41.
> 
>> 
>> It's not half-way initialized, it's initialized correctly, it's just 
>> not using the full
>> potential of the card (higher speeds, etc.).
>> 
>> The situation would be the same as it is currently with emmc. Locked 
>> emmc
>> gets initialized correctly but reads/writes time-out. What is wrong in 
>> having
>> the same result for both sd and emmc?
>> 
>> >
>> > I would rather just power off the card if initialization fails and
>> > remove its corresponding device from the system.
>> >
>> >>
>> >> > What will
>> >> > happen to upper block layers and filesystems when trying to access it?
>> >>
>> >> Everything will simply time-out.
>> >
>> > Yes, but it's uncertain what that could lead to?
>> >
>> > What will happen with power consumption and power management
>> support,
>> > for example.
>> 
>> Okay, this is a valid concern. Would it be acceptable if we just 
>> enabled this
>> "feature" with a module parameter, something like 
>> "sd_initialize_locked=1"
>> with default 0?
>> 
>> >
>> >>
>> >> >
>> >> > Several years ago Al Cooper made an attempt [1] to manage the
>> >> > unlocking of the card during initialization, by finding the
>> >> > password through the "keys" subsystem. The series didn't really
>> >> > make it to the upstream kernel, but overall the approach seemed to make
>> sense to me.
>> >> > It should allow us to complete the initialization of the card
>> >> > inside the kernel and prevent unnecessary complexity for userspace to
>> manage.
>> >>
>> >> Yes, he did a great work but obviously no-one got too excited to
>> >> review/merge his work. His solution was complex.
>> >
>> > It's quite some amount of code. On the other hand, it seemed quite
>> > straight forward, not that complex to me.
>> 
>> It doesn't solve the situation when you don't know the password and 
>> you just
>> want to erase the card and continue using in. The (un)locking doesn't 
>> belong
>> to kernel IMO, if it can be implemented in user-space, it should and 
>> it is more
>> flexible that way.
> I also see little value in handling the unlocking process in the 
> kernel.
> I find the proposed approach, e.g.  co-exists with its sibling
> mmc-utils patch, straight forward and simpler.
> 
> Thanks,
> Avri
>> 
>> >
>> >>
>> >> Mine targets the smallest change possible to make it work at least.
>> >> I wanted to avoid a solution that would be hard to test, review and
>> >> maintain.
>> >> Especially when there is only a small interest in the feature.
>> >>
>> >> > Perhaps you can have a closer look at that series and see if it's
>> >> > possible to update it?
>> >>
>> >> I don't think I have the skills to revive his work.
>> >
>> > I see, maybe we should ping Al and other interested folkz to see if
>> > there still is some interest to move this forward?
>> 
>> Okay, Al, are you interested?
>> 
>> >
>> > [...]
>> >
>> > Kind regards
>> > Uffe
>> 
>> BR
>> Daniel
>> 
