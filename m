Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.131.191.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792980142;
	b=a+ynOahc/jjKUT1UorGwoWuxSRLNSCs+LfeVvTcdGeMag8MZt4PwuQQytlCHirddLo5s
	 lb53JFq+Skmpd+9atbJuYHTDJR8jh7+HMjy1semhUYmgztaU3OLKccY5cclo8W31pN1ga
	 Cnnqd8XX96q6FBJ80PdWUaoI2k2Z1zbIpSBdnoTarhNFND7q0h1EelfOFpevRbnlIX7NM
	 STREODexTgFQu5HHc/tvPSvbZqbzhvkLTvF1JALrFL1OFWPPlz5JFIJ0HhCAJxlvAUUpo
	 BC/tRDZnzKLdczK2F09FXsNmMGgX7p6tDZD00nZR71a7VF32eXaD7/TXuYYXMJux7rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792980142;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=XViPhepzIh5kjbiv0wX5ZgC1O2zAOqQBDGI8L4h/5H4=;
	b=OJNX8UjkzT9lfrkG7/uMoSIr6nAI5H5IULQxDAViUCMssuV9jAvItGS5oi/X7+evDXfX
	 fq+4/qxZ5FtX6fYR06d+qgusEzX/NAigzKROvnolAcpYW/j+Y3YwU6+iC8+X2ME5M9o5C
	 7Knr5hnQTbl03AkbCZb296cr8FwcJwv/xWHGny1zlwm9lkZNBcu5ZrlsWG5H6b1g+6vgG
	 cMdVwAWJxt4ftcY4KRYd86LmJKc2lq9kHX48uwjqiRJa8cIzb4w8AzVwcZyW8aua6t0QJ
	 hR8MPVQxXivhfIyD2iFaxGZcxlhXBkLyunPeFy8rzvbJeol3+YFUqtp5fjWEv5hTDZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=Nw26fTFO;
	arc=none smtp.remote-ip=103.131.191.25
Received: from mail-m10313119125.xmail.ntesmail.com (mail-m10313119125.xmail.ntesmail.com [103.131.191.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E42F606A31A;
	Mon, 26 Oct 2026 02:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E42F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=Nw26fTFO
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 524b64229;
	Mon, 26 Oct 2026 10:02:06 +0800 (GMT+08:00)
Message-ID: <46a26683-9d8e-451b-bc98-505b1c13b09f@rock-chips.com>
Date: Mon, 26 Oct 2026 10:02:06 +0800
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jensen Huang <jensenhuang@friendlyarm.com>,
 llj@rock-chips.com
Subject: Re: [PATCH 2/2] mmc: core: sdio: skip CMD11 if signalling is already
 1.8V
To: Deomid rojer Ryabkov <rojer@rojer.me>, Ulf Hansson <ulfh@kernel.org>
References: <20261023232813.2983368-1-rojer@rojer.me>
 <20261023232813.2983368-3-rojer@rojer.me>
 <4e8bbb32-e062-40fe-8ee4-363e83a68f2b@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <4e8bbb32-e062-40fe-8ee4-363e83a68f2b@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa175f18c7703a4kunm16d623a93d3d0f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSEpIVh9MTkxPSB0aTE0fQlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Nw26fTFO6BOWTqN54PHNFZFGnZvlKjDxJtN8aSirjzYWdkGBuQPOJHvyghhqdEoV9jaFo+uCGE8F4yuW0LdG08PMHejDZU4+5vpx1fMP9Jd5Nw8MOdgY7gY5K2V/rbBJqMR67d9+rvL+RqHjPgGWQzQqIpMfm7w1S+jBxPNHvp4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=XViPhepzIh5kjbiv0wX5ZgC1O2zAOqQBDGI8L4h/5H4=;
	h=date:mime-version:subject:message-id:from;

Cc: Longjian

在 2026/10/24 星期六 10:24, Shawn Lin 写道:
> 
> 
> 在 2026/10/24 星期六 7:28, Deomid rojer Ryabkov 写道:
>> Per the SDIO Simplified Specification Version 3.00, section 3.1.2, a card
>> whose signalling is already at 1.8V must report S18A = 0 in the R4
>> response, and the core relies on that: it only sends CMD11
>> (SD_SWITCH_VOLTAGE) when S18A is set.
>>
>> Some cards don't follow this. The Realtek RTL8822CS (as fitted on the
>> FriendlyElec NanoPi R2S Plus, where the M.2 SDIO bus is wired to a fixed
>> 1.8V vqmmc) answers CMD5 with S18A = 1 even though the bus is already at
>> 1.8V. CMD11 then times out:
>>
>>    dwmmc_rockchip ff5f0000.mmc: Unexpected CMD11 timeout
>>    mmc_host mmc2: Timeout sending command (cmd 0x10202000 arg 0x0 
>> status 0x90202000)
>>    mmc2: new high speed SDIO card at address 0001
>>

Longjian is working on the SWT6621S, which misbehaves exactly the same 
way as the RTL8822CS does. Hope he could have a test.


>> and the card ends up in 50 MHz high-speed mode instead of SDR104.
>>
>> When vqmmc can't do 3.3V, mmc_set_initial_signal_voltage() has already
>> fallen back to 1.8V by the time CMD5 is sent, so the host knows there is
>> nothing to switch. Skip CMD11 in that case. ocr keeps R4_18V_PRESENT, so
>> mmc_sdio_init_uhs_card() still runs and the card is tuned to SDR104:
>>
>>    dwmmc_rockchip ff5f0000.mmc: Successfully tuned phase to 64
>>    mmc2: new ultra high speed SDR104 SDIO card at address 0001
>>
>> Hosts that start at 3.3V are not affected, nor are compliant cards that
>> report S18A = 0 at 1.8V. A non-compliant card that does need CMD11
>> before entering UHS at 1.8V would now fail UHS init; with the previous
>> patch it falls back to high-speed mode and keeps working.
>>
>> FriendlyElec's BSP for this board works around this with a card
>> quirk, MMC_QUIRK_BROKEN_ROCR_S18A[1], matched on the "realtek,rtl8822cs"
>> compatible, which drops the switch request whenever this chip is
> 
> 
> Thanks for this series.
> 
> I knew some vendor's SDIO cards misbehave it on Rockchip's bug trace
> system, including this one. This patch matches what I suggested there
> instead of the alternative one. FWIW,
> 
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
>> present. The misreported S18A is the card's fault, but ignoring it is
>> only correct when the bus is already at 1.8V: on a board with a
>> switchable vqmmc the same chip would then be run in UHS at 3.3V. A card
>> quirk would need knowledge of the board's supply that it doesn't have.
>> The core does know the current signal voltage, so handle it there, which
>> also takes care of any other card that turns out to behave the same way.
>>
>> [1] https://github.com/friendlyarm/kernel-rockchip/commit/ 
>> aee62cf7ae16b5ede6c6d92a8ee20e796482754e
>> Cc: Jensen Huang <jensenhuang@friendlyarm.com>
>> Signed-off-by: Deomid rojer Ryabkov <rojer@rojer.me>
>> ---
>>   drivers/mmc/core/sdio.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
>> index 6787fdf1c5..a986ee04ba 100644
>> --- a/drivers/mmc/core/sdio.c
>> +++ b/drivers/mmc/core/sdio.c
>> @@ -737,9 +737,11 @@ static int mmc_sdio_init_card(struct mmc_host 
>> *host, u32 ocr,
>>        * 1.8v, the card sets S18A to 0 in the R4 response. So it will
>>        * fails to check rocr & R4_18V_PRESENT,  but we still need to
>>        * try to init uhs card. sdio_read_cccr will take over this task
>> -     * to make sure which speed mode should work.
>> +     * to make sure which speed mode should work. Some cards (RTL8822CS)
>> +     * set S18A regardless, so don't send CMD11 if we are already at 
>> 1.8V.
>>        */
>> -    if (rocr & ocr & R4_18V_PRESENT) {
>> +    if ((rocr & ocr & R4_18V_PRESENT) &&
>> +        host->ios.signal_voltage != MMC_SIGNAL_VOLTAGE_180) {
>>           err = mmc_set_uhs_voltage(host, ocr_card);
>>           if (err == -EAGAIN) {
>>               mmc_sdio_pre_init(host, ocr_card, card);
> 
> 

