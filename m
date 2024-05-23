Received: from speedy.danman.eu (speedy.danman.eu [46.227.180.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E3E14D28C
	for <linux-mmc@vger.kernel.org>; Thu, 23 May 2024 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.227.180.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470274; cv=none; b=aLtHLqvmextcqFyJ8nSBK8D6vtiST5Eb/8QsDBIek+Dn+9Y0KFv/OrUV4imR8MNsnykQ+0m1p2Qj0ZsAeZ4RgIJ95MYdjaZ+wYxse7+EUsq+90EnvtBkrpcZE/KNdYhqCA5qKsL+tu1fU1FpF82HJg2EEPQpG/bIxsGkL0OwdQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470274; c=relaxed/simple;
	bh=5eFD16Gvx67oOSAOHbVU8+gIWUMV0Uat2d7TtxNafw0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ZvvM4kuRYu33Ke3v8mfaPD8jiWF8jOUTWQTc0/SgkwmaOtNY+7QuPnuefqhHz6ZWNCYfkwo5blxA5bWrAiPvQi2VSB8CXidPSDF+8PebzpgmHMdQsjj5W30jM17+L2D7Sfc+ZCLgmWbzCbl8LS/+CzEkpAaoTqakErLZJuYbju4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danman.eu; spf=pass smtp.mailfrom=danman.eu; arc=none smtp.client-ip=46.227.180.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danman.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danman.eu
Received: from mail.danman.eu (localhost [IPv6:::1])
	by speedy.danman.eu (Postfix) with ESMTPA id BA645240539;
	Thu, 23 May 2024 15:17:47 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 23 May 2024 15:17:47 +0200
From: Daniel Kucera <linux-mmc@danman.eu>
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Subject: Re: [PATCH] mmc: core: allow detection of locked cards
In-Reply-To: <bf9b0807-85fa-42bd-9dec-e59a6166197b@arm.com>
References: <20240521210455.543587-1-linux-mmc@danman.eu>
 <bf9b0807-85fa-42bd-9dec-e59a6166197b@arm.com>
User-Agent: Roundcube Webmail/1.5.0
Message-ID: <3c543a9b6a59b74b8007df2517caad84@danman.eu>
X-Sender: linux-mmc@danman.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2024-05-23 10:29, Christian Loehle wrote:
> On 5/21/24 22:04, linux-mmc@danman.eu wrote:
>> From: Daniel Kucera <linux-mmc@danman.eu>
>> 
>> Signed-off-by: Daniel Kucera <linux-mmc@danman.eu>
>> ---
>>  drivers/mmc/core/sd.c | 19 ++++++++++++++++---
>>  1 file changed, 16 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>> index 1c8148cdd..b22c30348 100644
>> --- a/drivers/mmc/core/sd.c
>> +++ b/drivers/mmc/core/sd.c
>> @@ -1475,9 +1475,22 @@ static int mmc_sd_init_card(struct mmc_host 
>> *host, u32 ocr,
>>  			goto free_card;
>>  	}
>> 
>> -	err = mmc_sd_setup_card(host, card, oldcard != NULL);
>> -	if (err)
>> -		goto free_card;
>> +        u32 card_status;
>> +
>> +        err = mmc_send_status(card, &card_status);
>> +        if (err){
>> +                pr_err("%s: unable to get card status\n",
>> +                        mmc_hostname(host));
>> +                goto free_card;
>> +        }
>> +
>> +        if (card_status & R1_CARD_IS_LOCKED){
>> +                pr_warn("%s: card is locked\n", mmc_hostname(host));
>> +        } else {
>> +                err = mmc_sd_setup_card(host, card, oldcard != NULL);
>> +                if (err)
>> +                        goto free_card;
>> +        }
>> 
>>  	/*
>>  	 * If the card has not been power cycled, it may still be using 1.8V
> 
> Does that work for you?
> I vaguely remember adding some checks before the block device setup and 
> some
> recovery as well since the partition scan (will fail) already triggered 
> resets.

Yes, it does, it shows a few read errors but then I run the unlock and 
mount without problems.
See:

[819348.273781] mmc1: card is locked
[819348.275379] mmc1: new SD card at address 0001
[819348.276149] mmcblk1: mmc1:0001 00000 1.89 GiB
[819351.379473] mmc1: card is locked
[819351.983845] I/O error, dev mmcblk1, sector 0 op 0x0:(READ) flags 0x0 
phys_seg 1 prio class 2
[819351.983861] Buffer I/O error on dev mmcblk1, logical block 0, async 
page read
[819355.631723] I/O error, dev mmcblk1, sector 0 op 0x0:(READ) flags 0x0 
phys_seg 1 prio class 2
[819355.631734] Buffer I/O error on dev mmcblk1, logical block 0, async 
page read
[819359.279802] I/O error, dev mmcblk1, sector 0 op 0x0:(READ) flags 0x0 
phys_seg 1 prio class 2
[819359.279813] Buffer I/O error on dev mmcblk1, logical block 0, async 
page read
[819359.279827] ldm_validate_partition_table(): Disk read failed.
[819362.927837] I/O error, dev mmcblk1, sector 0 op 0x0:(READ) flags 0x0 
phys_seg 1 prio class 2
[819362.927863] Buffer I/O error on dev mmcblk1, logical block 0, async 
page read
[819366.575712] I/O error, dev mmcblk1, sector 0 op 0x0:(READ) flags 0x0 
phys_seg 1 prio class 2
[819366.575724] Buffer I/O error on dev mmcblk1, logical block 0, async 
page read
[819370.223933] I/O error, dev mmcblk1, sector 0 op 0x0:(READ) flags 0x0 
phys_seg 1 prio class 2
[819370.223958] Buffer I/O error on dev mmcblk1, logical block 0, async 
page read
[819373.875932] I/O error, dev mmcblk1, sector 0 op 0x0:(READ) flags 0x0 
phys_seg 1 prio class 2
[819373.875952] Buffer I/O error on dev mmcblk1, logical block 0, async 
page read
[819373.875978] Dev mmcblk1: unable to read RDB block 0
[819377.520037] I/O error, dev mmcblk1, sector 0 op 0x0:(READ) flags 0x0 
phys_seg 1 prio class 2
[819377.520062] Buffer I/O error on dev mmcblk1, logical block 0, async 
page read
[819381.167907] I/O error, dev mmcblk1, sector 0 op 0x0:(READ) flags 0x0 
phys_seg 1 prio class 2
[819381.167933] Buffer I/O error on dev mmcblk1, logical block 0, async 
page read
[819384.815750] I/O error, dev mmcblk1, sector 24 op 0x0:(READ) flags 
0x0 phys_seg 1 prio class 2
[819384.815776] Buffer I/O error on dev mmcblk1, logical block 3, async 
page read
[819388.463981] I/O error, dev mmcblk1, sector 0 op 0x0:(READ) flags 0x0 
phys_seg 1 prio class 2
[819388.464007] Buffer I/O error on dev mmcblk1, logical block 0, async 
page read
[819392.111760] I/O error, dev mmcblk1, sector 0 op 0x0:(READ) flags 0x0 
phys_seg 1 prio class 2
[819392.111770] Buffer I/O error on dev mmcblk1, logical block 0, async 
page read
[819392.111786]  mmcblk1: unable to read partition table
[819395.759713] I/O error, dev mmcblk1, sector 3964800 op 0x0:(READ) 
flags 0x80700 phys_seg 1 prio class 2
[819399.408666] I/O error, dev mmcblk1, sector 3964800 op 0x0:(READ) 
flags 0x0 phys_seg 1 prio class 2
[819399.408691] Buffer I/O error on dev mmcblk1, logical block 495600, 
async page read

I waited several minutes and then I run the unlock and the partition is 
detected automatically:

[820514.276616]  mmcblk1: p1


