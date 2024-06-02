Received: from speedy.danman.eu (speedy.danman.eu [46.227.180.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E183BBF7
	for <linux-mmc@vger.kernel.org>; Sun,  2 Jun 2024 12:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.227.180.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717331860; cv=none; b=qDAPaQgt4jYotRoECKRKxbzGT57hafyYI2nulllAmwTKFogyYQHsrfVmdm9gE2sp38o7dhb8m67/XnPacB4YT/fN0U3Ug5PXqKVHusgefCijxOx8OuD6LmoUy8cDGy520lqwDvWlzPEggej6NLIY7vlT3fHY1ymg8svd05JQR+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717331860; c=relaxed/simple;
	bh=X9Bcvu1qp9OdgF4P/wLSERubQd3HhPEndrvcVzL2GZg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=h/CSHatKIvtu98NB4kU3UW+0qVpKbGMtBAB5+88c+B6tA/VLlCTzFeXuPoOUs7iTtWZoP/0UmbQB2dnPp1aYpSUnlIOZ7WgEFAHXgXwQ4DfGmLbedVzIDQDgkhi8ZM1SVdqyEXIsYI15MBQmyiyom8zrfwOgH78LZYBWWtxsGW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danman.eu; spf=pass smtp.mailfrom=danman.eu; arc=none smtp.client-ip=46.227.180.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danman.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danman.eu
Received: from mail.danman.eu (localhost [IPv6:::1])
	by speedy.danman.eu (Postfix) with ESMTPA id 8BA23240192;
	Sun,  2 Jun 2024 14:37:33 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 02 Jun 2024 14:37:33 +0200
From: Daniel Kucera <linux-mmc@danman.eu>
To: Avri Altman <Avri.Altman@wdc.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Subject: Re: [PATCH v3] mmc: core: allow detection of locked cards
In-Reply-To: <DM6PR04MB65758D11355C0A516B10704DFCFE2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240523132016.599343-1-linux-mmc@danman.eu>
 <8e03fa17dd41180f53fede6897ab1bf8@danman.eu>
 <DM6PR04MB65758D11355C0A516B10704DFCFE2@DM6PR04MB6575.namprd04.prod.outlook.com>
User-Agent: Roundcube Webmail/1.5.0
Message-ID: <4716f78bbe71f4d8262b16a546393758@danman.eu>
X-Sender: linux-mmc@danman.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hello Avri,

On 2024-06-02 07:26, Avri Altman wrote:
>> On 2024-05-23 15:20, linux-mmc@danman.eu wrote:
>> > From: Daniel Kucera <linux-mmc@danman.eu>
>> >
>> > Locked card will not reply to SEND_SCR or SD_STATUS commands so it was
>> > failing to initialize previously. When skipped, the card will get
>> > initialized and CMD42 can be sent using ioctl to unlock the card or
>> > remove password protection.
>> > Until unlocked, all read/write calls will timeout.
>> >
>> > Signed-off-by: Daniel Kucera <linux-mmc@danman.eu>
>> > ---
>> >  drivers/mmc/core/sd.c | 13 ++++++++++++-
>> >  1 file changed, 12 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
>> > 1c8148cdd..ae821df7d 100644
>> > --- a/drivers/mmc/core/sd.c
>> > +++ b/drivers/mmc/core/sd.c
>> > @@ -928,8 +928,19 @@ int mmc_sd_setup_card(struct mmc_host *host,
>> > struct mmc_card *card,
>> >       bool reinit)
>> >  {
>> >       int err;
>> > +     u32 card_status;
>> >
>> > -     if (!reinit) {
>> > +     err = mmc_send_status(card, &card_status);
>> > +     if (err){
>> > +             pr_err("%s: unable to get card status\n", mmc_hostname(host));
>> > +             return err;
>> > +     }
>> > +
>> > +     if (card_status & R1_CARD_IS_LOCKED){
>> > +             pr_warn("%s: card is locked\n", mmc_hostname(host));
>> > +     }
>> > +
>> > +     if (!reinit && !(card_status & R1_CARD_IS_LOCKED)) {
>> >               /*
>> >                * Fetch SCR from card.
>> >                */
>> 
>> Any feedback please?
> You didn't address my comment from your v1 -
> Since eMMC & SD shares the very same locking feature (non-COP SD that 
> is) -
> You should at least explain in your commit log why it isn't an issue 
> for eMMC,
> If indeed it is not.

I'm sorry, I didn't get what you mean by that. I am touching only the 
sd.c code, not the mmc.c (where eMMC is initialized, am I correct?).
How should I address this?
Should I test with eMMC to SD adaptor? I don't have any currently.

I am sorry if these are stupid questions, I am a layman.

> 
> Thanks,
> Avri
> 
>> 
>> D.

Thank you.
Daniel.
