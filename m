Received: from speedy.danman.eu (speedy.danman.eu [46.227.180.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA9C1ACE62
	for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 12:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.227.180.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888367; cv=none; b=hRv2KlYazlAFkbu1Bzxx3IH2qPzOPSvObEtEWGIu0IqksF017LElvmN+7FSn1/Y1x6irsVcG355tKVfQxbEXB++ntyl4Z/SbqlDcYdpTJgZru8RoQO/NItukIfktugN/kOcCnMSYPiybSGodPCMOtuhlSy0TOpVGYAK97pajdz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888367; c=relaxed/simple;
	bh=KMwWlT6HRkERlJyX/6IpQ36bBlEwEeBQvljwGk0egQU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=aHJh5fEPIYtuxWpd5+eRp+glsD+691Z9ofn2nz4y5qbAOLcJUe/YHn7uYJdpjrnlbXA0mr3+6EkQxqchuye17l12PXP9gWu8yWqc+5YEoJdjc/5t5uIwzEx/Z012VeWmmDmzL0OHHwffuzKC+e/xdVEt7l6PwdzRfRArDSPz6sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danman.eu; spf=pass smtp.mailfrom=danman.eu; arc=none smtp.client-ip=46.227.180.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danman.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danman.eu
Received: from mail.danman.eu (localhost [IPv6:::1])
	by speedy.danman.eu (Postfix) with ESMTPA id 88A9F24029C;
	Thu, 20 Jun 2024 14:59:15 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Jun 2024 14:59:15 +0200
From: Daniel Kucera <linux-mmc@danman.eu>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Subject: Re: [PATCH v4] mmc: core: allow detection of locked cards
In-Reply-To: <CAPDyKFpuJexp_1hgKhJ3b8VCx+PwwhAQscbJT5-44Re0xmbxrg@mail.gmail.com>
References: <20240606131222.1131880-1-linux-mmc@danman.eu>
 <CAPDyKFpuJexp_1hgKhJ3b8VCx+PwwhAQscbJT5-44Re0xmbxrg@mail.gmail.com>
User-Agent: Roundcube Webmail/1.5.0
Message-ID: <c89d8a0c170fa3bc8593bfde25b07e4d@danman.eu>
X-Sender: linux-mmc@danman.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2024-06-20 14:38, Ulf Hansson wrote:
> On Thu, 6 Jun 2024 at 15:12, <linux-mmc@danman.eu> wrote:
>> 
>> From: Daniel Kucera <linux-mmc@danman.eu>
>> 
>> Locked SD card will not reply to SEND_SCR or SD_STATUS commands
>> so it was failing to initialize previously. When skipped,
>> the card will get initialized and CMD42 can be sent using
>> ioctl to unlock the card or remove password protection.
>> For eMMC, this is not necessary because all initialization
>> commands are allowed in locked state.
>> Until unlocked, all read/write calls will timeout.
> 
> Skipping the commands above, only means the card gets partially
> initialized.

Correct, but it's an improvement in comparison to current state.

> Leaving a card in that state seems fragile.

Fragile in what sense? Nothing can happen to the card as it is locked.

> What will
> happen to upper block layers and filesystems when trying to access it?

Everything will simply time-out.

> 
> Several years ago Al Cooper made an attempt [1] to manage the
> unlocking of the card during initialization, by finding the password
> through the "keys" subsystem. The series didn't really make it to the
> upstream kernel, but overall the approach seemed to make sense to me.
> It should allow us to complete the initialization of the card inside
> the kernel and prevent unnecessary complexity for userspace to manage.

Yes, he did a great work but obviously no-one got too excited to 
review/merge
his work. His solution was complex.

Mine targets the smallest change possible to make it work at least.
I wanted to avoid a solution that would be hard to test, review and 
maintain.
Especially when there is only a small interest in the feature.

> Perhaps you can have a closer look at that series and see if it's
> possible to update it?

I don't think I have the skills to revive his work.

> 
> Kind regards
> Uffe

BR
Daniel

> 
> [1]
> https://lore.kernel.org/linux-mmc/1433526147-25941-1-git-send-email-alcooperx@gmail.com/
> 
>> 
>> Signed-off-by: Daniel Kucera <linux-mmc@danman.eu>
>> ---
>>  drivers/mmc/core/sd.c | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>> index 1c8148cdd..ae821df7d 100644
>> --- a/drivers/mmc/core/sd.c
>> +++ b/drivers/mmc/core/sd.c
>> @@ -928,8 +928,19 @@ int mmc_sd_setup_card(struct mmc_host *host, 
>> struct mmc_card *card,
>>         bool reinit)
>>  {
>>         int err;
>> +       u32 card_status;
>> 
>> -       if (!reinit) {
>> +       err = mmc_send_status(card, &card_status);
>> +       if (err){
>> +               pr_err("%s: unable to get card status\n", 
>> mmc_hostname(host));
>> +               return err;
>> +       }
>> +
>> +       if (card_status & R1_CARD_IS_LOCKED){
>> +               pr_warn("%s: card is locked\n", mmc_hostname(host));
>> +       }
>> +
>> +       if (!reinit && !(card_status & R1_CARD_IS_LOCKED)) {
>>                 /*
>>                  * Fetch SCR from card.
>>                  */
>> --
>> 2.34.1
>> 
