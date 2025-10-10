Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6BE42AA3
	for <linux-mmc@vger.kernel.org>; Fri, 10 Oct 2025 21:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760131047; cv=none; b=OJWzX1nUI46ex4f+Dbp2ZCCHMImcG3kb5zZ6wDe6ke9OGivatrqykg7OzBI8ItbrNhtqrbmMQExfYFfMetgtu3cZXIpvAgGJZVjkJlf7FcErZrQg1mfy5k6hvIv5lSMarWLDBNmmlX50T0d6R5ZGvR6kiuaGWqQE5NS7aJ297po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760131047; c=relaxed/simple;
	bh=MtELhE3sbb5H9xaYcrDuOGXiKnoylnwpYArRCyfLthU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFceupC95umfzhboTrwK2tgzEzMN24ChplMvxWhE9EDZV4fO0+pbH4xKUju2aN+JiHE9MQG++83y5FeMyNuk0SR8R05+Ds0v83HxmJ1Y4uehHn/LmISXSeqhSLJzOkp9kV2kuLCHdNw6KQmMORovviONTj+uo8J+5Hf4aw1h5yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gp5UzghQ; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gp5UzghQ"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-3c8d0d72889so32511fac.3
        for <linux-mmc@vger.kernel.org>; Fri, 10 Oct 2025 14:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760131045; x=1760735845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Qx2JZT4TD1rS3G5RywH6Dvyz1JgCkvXZ2Iv5K4YCpE=;
        b=Gp5UzghQxaxWcbXrq67LX2N5Ct7Nlw51bhswL1zpNKjrsd9JyPeEEuRBKqCW8aR07H
         ukxRH1EwdedD/SdGDYVG7hbNWHiCp4zjdo8GBQOt6O+Hw8NhbO0t+s8+FjdUwXqvIJBF
         /o/LAXaBV9U+eaYFcn9lvUnvCboESzZPcvm8FkXAt+sp1Uo+tBR6s0VRWPVvJVv9Nj2e
         pfZeGjleZpO8qSUbvRWj44niimuXrQ7JQdq6yeTHSIRS7AJm2BfcFPKmLb95TkPUiTk/
         rBYIkA7Fevu3y9vuSOYv6rloe2jNlWwO/oFbmenTEMkMvUiPsUEaB2ipYVzVm1Aqusg9
         Iqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760131045; x=1760735845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Qx2JZT4TD1rS3G5RywH6Dvyz1JgCkvXZ2Iv5K4YCpE=;
        b=eRPje7DB7UH7zKCQRFvkFSuyFuzY4YZpV/qEhLhInZAb3zB7wsRZS3Mw6tmX/BDa9f
         8/itc3PqBWU7unUOH1RZIcxx6f60rB/Y96AzGR0QXIJ3GpgYg3AD1tg9xyRGdMJqJ0Ns
         dSq91xLi6+mDFo4oFdJjX53ESRs/Gf8Klz1mKXPsW5rHF6CVfNnafwhFWMJV0OFlKmBL
         6R1yDJXH93UGhGEuw+7mmRMfl0yTujQeSZ0y8Tkchfz8CRtBbHVlsueWTrPQ+HqAYPAI
         4AKkRfnum8PM4yHGBnDQbiQ54kpJ6PcysbJhrcS6uB5ea7n7/VwwQ12vYKTnrEr5Aj/A
         sNFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi0Py3IGu8+DpBw9bvdSg2j3JOg1odrkHMlbd+QVRmt6+F3sq9mTw8+Lew3UT6+U7/C5VULYky7DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YynoVCyTSJ9M27lsTyj3NxemSjOxkxNFQjwEk+tv+KnfzM/VUkv
	m9p9qW/rtmw5O5+r6kX1hPBnBURHkNakI3MyYrcRGJmU8pUFQZM8aAK+
X-Gm-Gg: ASbGncvUSg0CL9yJ+IeZL9tarfQ05WBcwjtdSpIfy8hQWf0or4V7tL9xkSj8LlTXGVE
	N6ml5qvOkL11D7TH9bD7/TQvwq+T/zfQ6QGN1CZ4qYBbuBYe0TSyN7uJmT7BFThnMe9GC/zfgwX
	D6LfXF0Vk7o/j3TDmlNtVCSvnhn63q0+GNlEpQvv3KPpcQsjvbcm39qSa+u9eapea0lg5TXFMvk
	WqdE8pOQL/QbijRizd4uwAtH1jJj4CJc//MhzTUqEDsXuOl1Qt9s9S0a53WoSnATSJM8ufrGZMm
	Rh9ESqIZxjlS+lBzrS2+F6a7kVSSfs0QrMweEAe2tDyzaV6WXxuApQUO2aWpswp8e+qlm4Ufd+c
	gZ7fdE81rupWKmZgbH5oWkP3qJUp71yYctvda8fs3/YWZ5tjCalQatrJkBmicewp2twVepGz+YC
	ZOew==
X-Google-Smtp-Source: AGHT+IHq0K/UXinrq5QDUst1B1GfxksE64BgOC0+sSuNOZMmKnRKCwCpQAuyTxeSif6R3owIeUhmQw==
X-Received: by 2002:a05:6870:678d:b0:30b:84eb:37b3 with SMTP id 586e51a60fabf-3c0f56cc642mr3189639fac.3.1760131044577;
        Fri, 10 Oct 2025 14:17:24 -0700 (PDT)
Received: from Michael-ArchMiniPC.shack.lan ([75.167.107.197])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3c8cc646221sm1051059fac.6.2025.10.10.14.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 14:17:24 -0700 (PDT)
From: Michael Garofalo <officialtechflashyt@gmail.com>
X-Google-Original-From: Michael Garofalo <officialTechflashYT@gmail.com>
To: adrian.hunter@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	officialtechflashyt@gmail.com,
	ulf.hansson@linaro.org
Subject: Re: [PATCH 0/2] mmc: sdhci: add quirk to disable bounce buffer
Date: Fri, 10 Oct 2025 14:16:51 -0700
Message-ID: <20251010211651.85281-1-officialTechflashYT@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <c895cd11-4d8d-475c-8ef8-3007f9037aef@intel.com>
References: <c895cd11-4d8d-475c-8ef8-3007f9037aef@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On 08/10/2025 04:10, Michael Garofalo wrote:
>>> On 06/10/2025 12:28, Michael Garofalo wrote:
>>>>> On 06/10/2025 10:35, Adrian Hunter wrote:
>>>>>> On 06/10/2025 04:36, Michael Garofalo wrote:
>>>>>>> This patch series adds a new bit to quirks2 for disabling the bounce
>>>>>>> buffer.  On some hardware, this is required for proper operation.  An
>>>>>>> example of such hardware is the SDHCI controller of the Nintendo Wii's
>>>>>>> "Hollywood" chipset.  Without this patch, the onboard Broadcom 4318
>>>>>>> Wi-Fi fails to connect to any networks.
>>>>>>
>>>>>> The bounce buffer should not make any difference, so it is likely
>>>>>> a different problem that gets hidden when the bounce buffer is not
>>>>>> used.
>>>>>>
>>>>>>> Could you enable dynamic debug messages and show the messages
>>>>>>> for the failing case?
>>>>>>
>>>>>> Actually will also need to see the messages in the "fixed" case
>>>>>> to compare.
>>>> I'm afraid I won't be able to provide those easily, at least not with the
>>>> commands you've provided.  Since the rootfs is _also_ running from SD,
>>>> turning on full MMC logs like this produces an obscene amount of noise
>>>> from the storage, unrelated to the SDIO wireless.  It gets even worse with
>>>> my original intention, which was to save the logs to SD Card, (since my USB
>>>> Gecko serial console is rather flakey, and introduces corruption now and then),
>>>> since it's now logging the writes of it's own logs in a permanent loop.
>>>> If there's a way to narrow down the logs to specifically whatever portions
>>>> you're interested in, and filter out the noise, I would happily provide it.
>>>
>>> Are there any error messages?
>> If I drop the debug logs you mentioned so that I can actually see what's
>> going on (they produce hundreds of lines / sec), here's what the Wi-Fi card
>> actually reports with, vs without, MMC bounce buffers.  With bounce buffers on,
>> it takes several tries to load the firmware, and it can't authenticate to any
>> network.  I've tested and confirmed this effect on multiple consoles, across
>> multiple reboots, on multiple Wi-Fi networks.  Meanwhile with MMC bounce buffers
>> off, it's much more functional.
>> 
>> Logs with MMC bounce buffers *on* (without my patches):
>> [  168.492687] b43-sdio mmc1:0001:1: Chip ID 14e4:4318
>> [  168.493516] ssb: Found chip with id 0x4710, rev 0x00 an package 0x00
>> [  168.508519] ssb: WARNING: Multiple ChipCommon found
>> [  168.510597] b43-sdio mmc1:0001:1: Sonics Silicon Backplane found on SDIO device mmc1:0001:1
>> [  168.510886] b43-phy0: Broadcom 4710 WLAN found (core revision 9)
>> [  168.530151] b43-phy0: Found PHY: Analog 3, Type 2 (G), Revision 7
>> [  168.538447] b43-phy0: Found Radio: Manuf 0x17F, ID 0x2050, Revision 8, Version 0
>> [  168.719257] Broadcom 43xx driver loaded [ Features: S ]
>> [  168.722231] b43 ssb0:0: Direct firmware load for b43/ucode5.fw failed with error -2
>> [  168.724613] b43 ssb0:0: Direct firmware load for b43/ucode5.fw failed with error -2
>> [  168.740666] b43 ssb0:0: Direct firmware load for b43-open/pcm5.fw failed with error -2
>> [  168.762630] ieee80211 phy0: Slected rate control algorithm 'minstrel_ht'
>> [  176.156693] b43-phy0: Loading OpenSource firmware version 410.31754
>> [  176.157159] b43-phy0: Hardware crypto acceleration not supported by firmware
>> [  179.993008] b43-phy0: Loading OpenSource firmware version 410.31754
>> [  179.994373] b43-phy0: Hardware crypto acceleration not supported by firmware
>> [  186.940346] b43-phy0: Loading OpenSource firmware version 410.31754
>> [  186.942559] b43-phy0: Hardware crypto acceleration not supported by firmware
>> [  216.368668] b43-phy0: Loading OpenSource firmware version 410.31754
>> [  216.369135] b43-phy0: Hardware crypto acceleration not supported by firmware
>> [  221.750016] b43-phy0: Loading OpenSource firmware version 410.31754
>> [  221.757700] b43-phy0: Hardware crypto acceleration not supported by firmware
>> [  223.437731] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
>> [  223.437764] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
>> [  223.648472] wlan0: send auth to da:b3:70:18:7c:14 (try 2/3)
>> [  223.859770] wlan0: send auth to da:b3:70:18:7c:14 (try 3/3)
>> [  224.064469] wlan0: authentication with da:b3:70:18:7c:14 timed out
>> [  226.045361] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
>> [  226.045393] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
>> [  226.248488] wlan0: send auth to da:b3:70:18:7c:14 (try 2/3)
>> [  226.462378] wlan0: send auth to da:b3:70:18:7c:14 (try 3/3)
>> [  226.664487] wlan0: authentication with da:b3:70:18:7c:14 timed out
>> [  250.424168] b43-phy0: Loading OpenSource firmware version 410.31754
>> [  250.425629] b43-phy0: Hardware crypto acceleration not supported by firmware
>> [  255.806790] b43-phy0: Loading OpenSource firmware version 410.31754
>> [  255.807256] b43-phy0: Hardware crypto acceleration not supported by firmware
>> [  257.467380] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
>> [  257.467414] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
>> [  257.672475] wlan0: send auth to da:b3:70:18:7c:14 (try 2/3)
>> [  257.880474] wlan0: send auth to da:b3:70:18:7c:14 (try 3/3)
>> [  258.093974] wlan0: authentication with da:b3:70:18:7c:14 timed out
>> [  284.326415] b43-phy0: Loading OpenSource firmware version 410.31754
>> [  284.326922] b43-phy0: Hardware crypto acceleration not supported by firmware
>> [  289.836233] b43-phy0: Loading OpenSource firmware version 410.31754
>> [  289.837612] b43-phy0: Hardware crypto acceleration not supported by firmware
>> [  291.528250] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
>> [  291.528283] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
>> [  291.736473] wlan0: send auth to da:b3:70:18:7c:14 (try 2/3)
>> [  291.944482] wlan0: send auth to da:b3:70:18:7c:14 (try 3/3)
>> [  292.152470] wlan0: authentication with da:b3:70:18:7c:14 timed out
>> <keeps trying and failing forever....>
>> 
>> Logs with MMC bounce buffers *off* (with my patches):
>> [  383.974268] b43-sdio mmc1:0001:1: Chip ID 14e4:4318
>> [  383.975824] ssb: Found chip with id 0x4710, rev 0x00 and package 0x00
>> [  383.986645] ssb: WARNING: Multiple ChipCommon found
>> [  383.987414] b43-sdio mmc1:0001:1: Sonics Silicon Backplane found on SDIO device mmc1:0001:1
>> [  383.987744] b43-phy0: Broadcom 4710 WLAN found (core revision 9)
>> [  383.995898] b43-phy0: Found PHY: Analog 3, Type 2 (G), Revision 7
>> [  383.996249] b43-phy0: Found Radio: Manuf 0x17F, ID 0x2050, Revision 8, Version 0
>> [  384.077562] b43 ssb0:0: Direct firmware load for b43/ucode5.fw failed with error -2
>> [  384.077687] b43 ssb0:0: Direct firmware load for b43/ucode5.fw failed with error -2
>> [  384.086571] Broadcom 43xx driver loaded [ Features: S ]
>> [  384.144620] b43 ssb0:0: Direct firmware load for b43-open/pcm5.fw failed with error -2
>> [  384.190831] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
>> [  395.097838] b43-phy0: Loading OpenSource firmware version 410.31754
>> [  395.098158] b43-phy0: Hardware crypto acceleration not supported by firmware
>> [  397.667851] b43-phy0: Loading OpenSource firmware version 410.31754
>> [  397.668171] b43-phy0: Hardware crypto acceleration not supported by firmware
>> [  403.940787] b43-phy0: Loading OpenSource firmware version 410.31754
>> [  403.941110] b43-phy0: Hardware crypto acceleration not supported by firmware
>> [  405.366065] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
>> [  405.366095] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
>> [  405.389013] wlan0: authenticated
>> [  405.392814] wlan0: associate with da:b3:70:18:7c:14 (try 1/3)
>> [  405.600498] wlan0: associate with da:b3:70:18:7c:14 (try 2/3)
>> [  405.808479] wlan0: associate with da:b3:70:18:7c:14 (try 3/3)
>> [  406.016481] wlan0: association with da:b3:70:18:7c:14 timed out
>> [  414.301216] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
>> [  414.301245] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
>> [  414.351544] wlan0: authenticated
>> [  414.403769] wlan0: associate with da:b3:70:18:7c:14 (try 1/3)
>> [  414.422775] wlan0: RX AssocResp from da:b3:70:18:7c:14 (capab=0x1411 status=0 aid=25)
>> [  414.431879] wlan0: associated
>> [  415.272393] wlan0: Limiting TX power to 36 (36 - 0) dBm as advertised by da:b3:70:18:7c:14
>> 
>> If there's anything further that would be useful here, let me know and I'd be happy to provide them.
> 
> Seems the SDIO function driver b43-sdio does not print any error
> messages.  All the error paths in drivers/ssb/sdio.c print debug
> messages instead.
> 
> I would suggest the following, which would limit messages to
> host mmc1 which is what is shown in message "b43-sdio mmc1:0001:1:
> Chip ID 14e4:4318"
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 860378bea557..2719b21783ad 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -169,33 +169,33 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
>  	 * - The card was removed (...so just complete everything no matter
>  	 *   if there are errors or retries)
>  	 */
> -	if (!err || !cmd->retries || mmc_card_removed(host->card)) {
> +	if (host->index == 1 && (!err || !cmd->retries || mmc_card_removed(host->card))) {
>  		mmc_should_fail_request(host, mrq);
>  
>  		if (!host->ongoing_mrq)
>  			led_trigger_event(host->led, LED_OFF);
>  
>  		if (mrq->sbc) {
> -			pr_debug("%s: req done <CMD%u>: %d: %08x %08x %08x %08x\n",
> +			pr_info("%s: req done <CMD%u>: %d: %08x %08x %08x %08x\n",
>  				mmc_hostname(host), mrq->sbc->opcode,
>  				mrq->sbc->error,
>  				mrq->sbc->resp[0], mrq->sbc->resp[1],
>  				mrq->sbc->resp[2], mrq->sbc->resp[3]);
>  		}
>  
> -		pr_debug("%s: req done (CMD%u): %d: %08x %08x %08x %08x\n",
> +		pr_info("%s: req done (CMD%u): %d: %08x %08x %08x %08x\n",
>  			mmc_hostname(host), cmd->opcode, err,
>  			cmd->resp[0], cmd->resp[1],
>  			cmd->resp[2], cmd->resp[3]);
>  
>  		if (mrq->data) {
> -			pr_debug("%s:     %d bytes transferred: %d\n",
> +			pr_info("%s:     %d bytes transferred: %d\n",
>  				mmc_hostname(host),
>  				mrq->data->bytes_xfered, mrq->data->error);
>  		}
>  
>  		if (mrq->stop) {
> -			pr_debug("%s:     (CMD%u): %d: %08x %08x %08x %08x\n",
> +			pr_info("%s:     (CMD%u): %d: %08x %08x %08x %08x\n",
>  				mmc_hostname(host), mrq->stop->opcode,
>  				mrq->stop->error,
>  				mrq->stop->resp[0], mrq->stop->resp[1],

With these patches, I still get copious amounts of spam, but at least relevant
to the wifi card now.
Here's a hopefully useful snippet (it's just a lot of these, from what I could see),
from with my patches:

[  154.177276] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
[  154.177297] mmc1:     4 bytes transferred: 0
<...>
[  186.707195] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
[  186.707217] mmc1:     20 bytes transferred: 0
[  186.707358] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
[  186.707382] mmc1:     384 bytes transferred: 0
[  186.707477] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
[  186.707498] mmc1:     24 bytes transferred: 0

And the one from without is very similar, except I noticed this pattern:
[   85.942269] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
[   85.942299] mmc1:     4 bytes transferred: 0
[   85.942523] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
[   85.942555] mmc1:     4 bytes transferred: 0
[   85.944548] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
[   85.944581] mmc1:     2 bytes transferred: 0
[   85.944777] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
[   85.945160] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
[   85.945187] mmc1:     2 bytes transferred: 0
... occasionally, some of the requests don't have an "[x] bytes transferred: 0".

Hopefully these help.  I can get a capture of the entire log spam and
put it on on pastebin or something, if that would be more useful.
