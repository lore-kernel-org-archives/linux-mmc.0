Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BE22E0B67
	for <linux-mmc@vger.kernel.org>; Thu, 12 Jun 2025 22:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749767921; cv=none; b=OfGcf6U54GjhULIT+D6MQRTiV95Jhtr3AYs7HnHp10VB5im21iFse0z5rjMVHrjPClyKrw2E7RjyEsZLQ+OhVsroG5EZsme9UV9PP6DPL50I+VV2/BF44CFu+c1PgOuQpxzSICV8Ig1YVDE4fAD8cqTbjIolloaCf9M97A6HgYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749767921; c=relaxed/simple;
	bh=dRr7uKKA55m+x/SpNygPJJmIkndRsX8fi88dJkdt2uA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOYP25Fbf9MjAGeY16CCezq0w9QGu5z7cG34zVwdy27d0A/BczCA2OSK86RVERgHoy6pW6LUm4db4J4nftZXKwm16RUR7I3rLVWhM40qRab0jNqMC2aO5GP67eqSu4aWhWOC9RAKXShFTvpvmCCbugkTSBtR8TcWkw8vV2mPty8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC7ED1007;
	Thu, 12 Jun 2025 15:38:16 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2A943F673;
	Thu, 12 Jun 2025 15:38:35 -0700 (PDT)
Message-ID: <8dc24db5-f7a2-4cf8-9eb7-2c9430fe47d6@arm.com>
Date: Thu, 12 Jun 2025 23:38:32 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Clarification on safe power-off behavior of SD card without
 power-off notification extension
To: =?UTF-8?B?SsOpcsO0bWUgQ2FycmV0ZXJv?= <cJ-ko@zougloub.eu>,
 linux-mmc@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: Vivien Didelot <vivien.didelot+linux@gmail.com>
References: <eaaab4af4cb6161c508a07734beabba27117ce4f.camel@zougloub.eu>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <eaaab4af4cb6161c508a07734beabba27117ce4f.camel@zougloub.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/12/25 15:53, Jérôme Carretero wrote:
> Hi Ulf, Avri, list,
> 
> 
> 
> As I was inquiring with an FAE of an SD-card manufacturer on how to
> reliably safely turn off power of their cards -- they're making SD
> cards which do not implement power-off notification extension, nor
> CMD48, but do perform background operations -- I was told that the way
> to make sure that the card can be turned off (having stopped any
> background work) is to issue GO_IDLE (CMD0) prior to turning off the
> card.
> 
> 
> As I'm not familiar with the Linux MMC code I went to do:
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -154,6 +154,10 @@ int __mmc_go_idle(struct mmc_host *host)
>         cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_NONE | MMC_CMD_BC;
>  
>         err = mmc_wait_for_cmd(host, &cmd, 0);
> +
> +       pr_info("%s: go idle %d\n",
> +        mmc_hostname(host), err);
> +

dump_stack() maybe would've been nicer FYI.


>         mmc_delay(1);
> 
> Only to notice that the only time this is called is when the SD card is
> inserted.
> 
> 
> While I certainly can issue CMD0 by userspace according to their
> recommendation and call it a day, I wanted to know what you think of
> it: does it look odd (looking at what public information I can find
> about SD cards, this "do CMD0 before unplugging" seems reasonable),
> or is Linux missing some functionality?

So my two cents again (something according to this is discussed
surprisingly often recently?):
CMD0 is sort-of unsuitable for this, it doesn't have a response or
a way to signal busy, so the host isn't aware of a CMD0 'completion'.
CMD0 is just a FSM transition, any FTL behavior this may or may not
trigger (and some card manufacturers may or may not have implemented)
are unpredictable and hard to guarantee.
