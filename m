Received: from speedy.danman.eu (speedy.danman.eu [46.227.180.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6CA5C96
	for <linux-mmc@vger.kernel.org>; Thu,  6 Jun 2024 08:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.227.180.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717661885; cv=none; b=YVS2KemEItJ5DgynPbSolUJKZwlnVAL5ZRhkSah69lqiiCI8n88bEkxp22zUfhg5Tl+WveRX2i8J0os+FHohgY4Csu1XzA4DvOe1O+zAnF+9utofrubYFcNF+zcCrz8bZbQ1wKTOPOsMLFa+jDqL6AhBueo3gpdqeVKDDZk3QbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717661885; c=relaxed/simple;
	bh=dnbQgJcycV4ZFTIVEcHP8lN5ekPLm1U9Tef5ExHk158=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=YU3bb4bHYnvL5XCx/neFBZRtXQ0olCkD2qNyPcthNPs1g5WCT/DGlF7qy6rFmbMFXPyYMGodBMoj0DbJA8i7yt6gZrM7+b/+5XBVV6xwjuisESjcQ3oKchotmXvmUJd2GJ+prdZqFSk3U295cKUFsf59DxSf7YmjZyfin7D4sQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danman.eu; spf=pass smtp.mailfrom=danman.eu; arc=none smtp.client-ip=46.227.180.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danman.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danman.eu
Received: from mail.danman.eu (localhost [IPv6:::1])
	by speedy.danman.eu (Postfix) with ESMTPA id 93D00240A83;
	Thu,  6 Jun 2024 10:17:52 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 06 Jun 2024 10:17:52 +0200
From: Daniel Kucera <linux-mmc@danman.eu>
To: Avri Altman <Avri.Altman@wdc.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Subject: Re: [PATCH v3] mmc: core: allow detection of locked cards
In-Reply-To: <DM6PR04MB6575B624ABC7190E84D73D4EFCFE2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240523132016.599343-1-linux-mmc@danman.eu>
 <8e03fa17dd41180f53fede6897ab1bf8@danman.eu>
 <DM6PR04MB65758D11355C0A516B10704DFCFE2@DM6PR04MB6575.namprd04.prod.outlook.com>
 <4716f78bbe71f4d8262b16a546393758@danman.eu>
 <DM6PR04MB6575B624ABC7190E84D73D4EFCFE2@DM6PR04MB6575.namprd04.prod.outlook.com>
User-Agent: Roundcube Webmail/1.5.0
Message-ID: <f6b219a15cdbdb96b302d8923d7768e6@danman.eu>
X-Sender: linux-mmc@danman.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi Avri,

On 2024-06-02 14:59, Avri Altman wrote:
>> Hello Avri,
>> 
>> On 2024-06-02 07:26, Avri Altman wrote:
>> >> On 2024-05-23 15:20, linux-mmc@danman.eu wrote:
>> >> > From: Daniel Kucera <linux-mmc@danman.eu>
>> >> >
>> >> > Locked card will not reply to SEND_SCR or SD_STATUS commands so it
>> >> > was failing to initialize previously. When skipped, the card will
>> >> > get initialized and CMD42 can be sent using ioctl to unlock the
>> >> > card or remove password protection.
>> >> > Until unlocked, all read/write calls will timeout.
>> >> >
>> >> > Signed-off-by: Daniel Kucera <linux-mmc@danman.eu>
>> >> > ---
>> >> >  drivers/mmc/core/sd.c | 13 ++++++++++++-
>> >> >  1 file changed, 12 insertions(+), 1 deletion(-)
>> >> >
>> >> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
>> >> > 1c8148cdd..ae821df7d 100644
>> >> > --- a/drivers/mmc/core/sd.c
>> >> > +++ b/drivers/mmc/core/sd.c
>> >> > @@ -928,8 +928,19 @@ int mmc_sd_setup_card(struct mmc_host *host,
>> >> > struct mmc_card *card,
>> >> >       bool reinit)
>> >> >  {
>> >> >       int err;
>> >> > +     u32 card_status;
>> >> >
>> >> > -     if (!reinit) {
>> >> > +     err = mmc_send_status(card, &card_status);
>> >> > +     if (err){
>> >> > +             pr_err("%s: unable to get card status\n", mmc_hostname(host));
>> >> > +             return err;
>> >> > +     }
>> >> > +
>> >> > +     if (card_status & R1_CARD_IS_LOCKED){
>> >> > +             pr_warn("%s: card is locked\n", mmc_hostname(host));
>> >> > +     }
>> >> > +
>> >> > +     if (!reinit && !(card_status & R1_CARD_IS_LOCKED)) {
>> >> >               /*
>> >> >                * Fetch SCR from card.
>> >> >                */
>> >>
>> >> Any feedback please?
>> > You didn't address my comment from your v1 - Since eMMC & SD shares
>> > the very same locking feature (non-COP SD that
>> > is) -
>> > You should at least explain in your commit log why it isn't an issue
>> > for eMMC, If indeed it is not.
>> 
>> I'm sorry, I didn't get what you mean by that. I am touching only the 
>> sd.c code, not
>> the mmc.c (where eMMC is initialized, am I correct?).
>> How should I address this?
>> Should I test with eMMC to SD adaptor? I don't have any currently.
> Theoretically, looking in the eMMC spec, a locked eMMC device
> shouldn't have any issue returning from power down.
> The only flow that is affected is that its not allowed to switch to
> hs200 in a locked state until unlocked - not to say that it is a
> problem.
> If you can't verify that via code review,  can you test your mmc-utils
> code on an eMMC platform?

I've just tested with an eMMC to SD adapter in my reader and it is 
detected correctly:

[1463181.072006] mmc1: unexpected status 0x2000900 after switch
[1463181.074560] mmc1: unexpected status 0x2000900 after switch
[1463181.077038] mmc1: unexpected status 0x2000900 after switch
[1463181.079709] mmc1: unexpected status 0x2000900 after switch
[1463181.081972] mmc1: unexpected status 0x2000900 after switch
[1463181.083412] mmc1: unexpected status 0x2000900 after switch
[1463181.084831] mmc1: unexpected status 0x2000900 after switch
[1463181.084836] mmc1: new high speed MMC card at address 0001
[1463181.085195] mmcblk1: mmc1:0001 004GA0 2.59 GiB

Do I need to do some changes to the patch?

> 
> Thanks,
> Avri
>> 
>> I am sorry if these are stupid questions, I am a layman.
>> 
>> >
>> > Thanks,
>> > Avri
>> >
>> >>
>> >> D.
>> 
>> Thank you.
>> Daniel.

Thank you,
Daniel
