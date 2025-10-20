Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5C62E22A7
	for <linux-mmc@vger.kernel.org>; Mon, 20 Oct 2025 07:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760946852; cv=none; b=KiCp3r9Xm0l82TNYOoDm85R2Vm9KzwCzv80oNNuvKPxfgbG4vppfp4Q+UVBR6Fa9ZiW17KnvaijSLMDjTsZmFtUHQQpEcuMbh5TgKuzF/DcVKLcg3xKr56TLxwRJyYheKw8u6qUzT57l30z5jK/X3ECg/op4puwAQ005Ougy6r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760946852; c=relaxed/simple;
	bh=9gcsyswJoRI2xLvDA/tNbkap32wzVrEtZOWP2220J+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNSEH2W+gc4HnAds4SadT9NdL13fF1GdAeVHnjx1WCXTyjqH0OE+uZdSyxRpS/Opv3y5khyfuhv0wS2mbDAhXypF/8XPaf/Af7qMWYtovFL7cGrkzUksye7hzWuG8xDrnTCEDkB58Q0+Q0ndetAuRaaNKSYZ4ZHvNT4LCCDRymY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agPN7HqP; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agPN7HqP"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c2731e3bc8so558371a34.2
        for <linux-mmc@vger.kernel.org>; Mon, 20 Oct 2025 00:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760946846; x=1761551646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRhB4goZZHeAeNM4L4TzxYzSUk03jlldDvspwEzH08s=;
        b=agPN7HqPztXNkz2I0NckA1Y0pqRmSPDfDZ/JKkH0dTPjApzaVn91S2o1C5USTFrkDv
         ryxR0Z0lpH8JrHFYhyBiCfuWRkPdr93N8SP0QCxYcJxkw+wjxQTfKT0GXuWR/lCgg2LR
         PylYh2p2beXr42WkZMyWQtrhe7ox6Au6VSIEwFsDwwO/vafMF3FvZt+pjW5prvf5gs7P
         xzDVP71jvf4Vu+FJMCmwNQtM7cyPHFl5Ub/kwKuQ8tUGzUKtWgUwo9OnXyhmcpV6u4On
         w+UftghFICefEtc59hVapXM/U/OHg7Egoyu1q+vI2y5Q+wN/7dOuPxMEiDYcxa3bOGC9
         j80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760946846; x=1761551646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRhB4goZZHeAeNM4L4TzxYzSUk03jlldDvspwEzH08s=;
        b=loU+gy43GTGQ4ejdd/UI1sODSkAlVHSGSvRHTqy/QXfRIqftFQGzxiJjyqliLfYrKZ
         2T3iYQuzLLPUOnqL7YWDCCVt8etaxm3kck7HPvk7WW5UiNW+4iwqF7Oq5Dc2S8w347Ur
         6UV5/fzzkk1K7uF2h5xe6gq92vqRQpDAmWoEVgKT4LFERwfUjQVvomvgcnk5Pc92cWhc
         QwoS+EQYwKqZ6LREmfr8A9grI2Nxj20tsTYyr/OotgPaaLHZa32geCaqZ0i1hsYCd0YG
         3s/mgjtB5o2Oc4suYMyyHmLgYd0Sd8rEdhNGr3l721HLnCG2wjmqXDbHJlp4+eA/H+cX
         gc7g==
X-Forwarded-Encrypted: i=1; AJvYcCU0Sa9mXAw//Nu4IOo8Aj3799Jpti5Q47CLmnnQq5f1lXs02Z4NvqKpcpS/lbQdqfwMtlWNQkxLKJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdP41ULhzeLM8HLmY5ya0U8rtWAA4OrqLXDKsPXjKUAaaUWmSJ
	SOvtmc8gBvh05KbUJKqS+S9zhleiIG4hkVj6jUmPAWr6hl9pMtMBriykQN6F1c9X
X-Gm-Gg: ASbGncu7Wot2o1LEu6bwxkknvi1P4oABD1HiX8GCXe+bfYEfVmd6qgm+4USkWtQ1jFO
	WUi9eknNRMyly4VWDth84WMwkzmpxRVzVefHcJ8Fo5H9j8Rv3tkwWA85epey3inO/ymQpkHt962
	iq7gPI0ay7o+lqOAMHqY/jZMAJE3ZEtvwLyUmRSfqD+wkX9a42AlZeGI97MWATj7OW89BqTpGjg
	J5TfoeRde9LaXxwOKpgO1DD1762kiBPzeQnnf2IP6B/4eGEqYZp+8/ZVGYcigt8ERMB0wFIvHtB
	53x8fbfY3vR0gGPBfe7a9Vvfh8UpWAeQ78o0+ltMxWBUMgSB5iRyhdo1VO87B0BVfhW1zSEL4hB
	/0oBuETBb/HeafFhKT2JMCBYKTK1xBSZyD6DrKNKAJVEcqEhqnKHvRpi1b5LKZ21CidDOoU/1jU
	aiQXpShvb2Ogbk7NmYiFxGEmBu42CvWzvq+b1NcfcRdmemHiw=
X-Google-Smtp-Source: AGHT+IHNf+LHCvG3rUp+Jr6JdQPPOZYl9e4bMtKND5N9q7EtWK7YQgKv5erskbMGBL2zkKFdJWYHKQ==
X-Received: by 2002:a05:6830:6731:b0:795:f1bd:1dd8 with SMTP id 46e09a7af769-7c27c9f45fcmr2731018a34.1.1760946846011;
        Mon, 20 Oct 2025 00:54:06 -0700 (PDT)
Received: from Michael-ArchMiniPC.shack.lan ([75.167.211.129])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c28879e84fsm2434665a34.7.2025.10.20.00.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 00:54:05 -0700 (PDT)
From: Michael Garofalo <officialtechflashyt@gmail.com>
X-Google-Original-From: Michael Garofalo <officialTechflashYT@gmail.com>
To: adrian.hunter@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	officialtechflashyt@gmail.com,
	ulf.hansson@linaro.org
Subject: Re: [PATCH 0/2] mmc: sdhci: add quirk to disable bounce buffer
Date: Mon, 20 Oct 2025 00:53:48 -0700
Message-ID: <20251020075348.266824-1-officialTechflashYT@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <b7bcd7e2-5be5-4cb7-9971-42617f57be3e@intel.com>
References: <b7bcd7e2-5be5-4cb7-9971-42617f57be3e@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On 11/10/2025 00:16, Michael Garofalo wrote:
>>> On 08/10/2025 04:10, Michael Garofalo wrote:
>>>>> On 06/10/2025 12:28, Michael Garofalo wrote:
>>>>>>> On 06/10/2025 10:35, Adrian Hunter wrote:
>>>>>>>> On 06/10/2025 04:36, Michael Garofalo wrote:
>>>>>>>>> This patch series adds a new bit to quirks2 for disabling the bounce
>>>>>>>>> buffer.  On some hardware, this is required for proper operation.  An
>>>>>>>>> example of such hardware is the SDHCI controller of the Nintendo Wii's
>>>>>>>>> "Hollywood" chipset.  Without this patch, the onboard Broadcom 4318
>>>>>>>>> Wi-Fi fails to connect to any networks.
>>>>>>>>
>>>>>>>> The bounce buffer should not make any difference, so it is likely
>>>>>>>> a different problem that gets hidden when the bounce buffer is not
>>>>>>>> used.
>>>>>>>>
>>>>>>>>> Could you enable dynamic debug messages and show the messages
>>>>>>>>> for the failing case?
>>>>>>>>
>>>>>>>> Actually will also need to see the messages in the "fixed" case
>>>>>>>> to compare.
>>>>>> I'm afraid I won't be able to provide those easily, at least not with the
>>>>>> commands you've provided.  Since the rootfs is _also_ running from SD,
>>>>>> turning on full MMC logs like this produces an obscene amount of noise
>>>>>> from the storage, unrelated to the SDIO wireless.  It gets even worse with
>>>>>> my original intention, which was to save the logs to SD Card, (since my USB
>>>>>> Gecko serial console is rather flakey, and introduces corruption now and then),
>>>>>> since it's now logging the writes of it's own logs in a permanent loop.
>>>>>> If there's a way to narrow down the logs to specifically whatever portions
>>>>>> you're interested in, and filter out the noise, I would happily provide it.
>>>>>
>>>>> Are there any error messages?
>>>> If I drop the debug logs you mentioned so that I can actually see what's
>>>> going on (they produce hundreds of lines / sec), here's what the Wi-Fi card
>>>> actually reports with, vs without, MMC bounce buffers.  With bounce buffers on,
>>>> it takes several tries to load the firmware, and it can't authenticate to any
>>>> network.  I've tested and confirmed this effect on multiple consoles, across
>>>> multiple reboots, on multiple Wi-Fi networks.  Meanwhile with MMC bounce buffers
>>>> off, it's much more functional.
>>>>
>>>> Logs with MMC bounce buffers *on* (without my patches):
>>>> [  168.492687] b43-sdio mmc1:0001:1: Chip ID 14e4:4318
>>>> [  168.493516] ssb: Found chip with id 0x4710, rev 0x00 an package 0x00
>>>> [  168.508519] ssb: WARNING: Multiple ChipCommon found
>>>> [  168.510597] b43-sdio mmc1:0001:1: Sonics Silicon Backplane found on SDIO device mmc1:0001:1
>>>> [  168.510886] b43-phy0: Broadcom 4710 WLAN found (core revision 9)
>>>> [  168.530151] b43-phy0: Found PHY: Analog 3, Type 2 (G), Revision 7
>>>> [  168.538447] b43-phy0: Found Radio: Manuf 0x17F, ID 0x2050, Revision 8, Version 0
>>>> [  168.719257] Broadcom 43xx driver loaded [ Features: S ]
>>>> [  168.722231] b43 ssb0:0: Direct firmware load for b43/ucode5.fw failed with error -2
>>>> [  168.724613] b43 ssb0:0: Direct firmware load for b43/ucode5.fw failed with error -2
>>>> [  168.740666] b43 ssb0:0: Direct firmware load for b43-open/pcm5.fw failed with error -2
>>>> [  168.762630] ieee80211 phy0: Slected rate control algorithm 'minstrel_ht'
>>>> [  176.156693] b43-phy0: Loading OpenSource firmware version 410.31754
>>>> [  176.157159] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>> [  179.993008] b43-phy0: Loading OpenSource firmware version 410.31754
>>>> [  179.994373] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>> [  186.940346] b43-phy0: Loading OpenSource firmware version 410.31754
>>>> [  186.942559] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>> [  216.368668] b43-phy0: Loading OpenSource firmware version 410.31754
>>>> [  216.369135] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>> [  221.750016] b43-phy0: Loading OpenSource firmware version 410.31754
>>>> [  221.757700] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>> [  223.437731] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
>>>> [  223.437764] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
>>>> [  223.648472] wlan0: send auth to da:b3:70:18:7c:14 (try 2/3)
>>>> [  223.859770] wlan0: send auth to da:b3:70:18:7c:14 (try 3/3)
>>>> [  224.064469] wlan0: authentication with da:b3:70:18:7c:14 timed out
>>>> [  226.045361] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
>>>> [  226.045393] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
>>>> [  226.248488] wlan0: send auth to da:b3:70:18:7c:14 (try 2/3)
>>>> [  226.462378] wlan0: send auth to da:b3:70:18:7c:14 (try 3/3)
>>>> [  226.664487] wlan0: authentication with da:b3:70:18:7c:14 timed out
>>>> [  250.424168] b43-phy0: Loading OpenSource firmware version 410.31754
>>>> [  250.425629] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>> [  255.806790] b43-phy0: Loading OpenSource firmware version 410.31754
>>>> [  255.807256] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>> [  257.467380] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
>>>> [  257.467414] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
>>>> [  257.672475] wlan0: send auth to da:b3:70:18:7c:14 (try 2/3)
>>>> [  257.880474] wlan0: send auth to da:b3:70:18:7c:14 (try 3/3)
>>>> [  258.093974] wlan0: authentication with da:b3:70:18:7c:14 timed out
>>>> [  284.326415] b43-phy0: Loading OpenSource firmware version 410.31754
>>>> [  284.326922] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>> [  289.836233] b43-phy0: Loading OpenSource firmware version 410.31754
>>>> [  289.837612] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>> [  291.528250] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
>>>> [  291.528283] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
>>>> [  291.736473] wlan0: send auth to da:b3:70:18:7c:14 (try 2/3)
>>>> [  291.944482] wlan0: send auth to da:b3:70:18:7c:14 (try 3/3)
>>>> [  292.152470] wlan0: authentication with da:b3:70:18:7c:14 timed out
>>>> <keeps trying and failing forever....>
>>>>
>>>> Logs with MMC bounce buffers *off* (with my patches):
>>>> [  383.974268] b43-sdio mmc1:0001:1: Chip ID 14e4:4318
>>>> [  383.975824] ssb: Found chip with id 0x4710, rev 0x00 and package 0x00
>>>> [  383.986645] ssb: WARNING: Multiple ChipCommon found
>>>> [  383.987414] b43-sdio mmc1:0001:1: Sonics Silicon Backplane found on SDIO device mmc1:0001:1
>>>> [  383.987744] b43-phy0: Broadcom 4710 WLAN found (core revision 9)
>>>> [  383.995898] b43-phy0: Found PHY: Analog 3, Type 2 (G), Revision 7
>>>> [  383.996249] b43-phy0: Found Radio: Manuf 0x17F, ID 0x2050, Revision 8, Version 0
>>>> [  384.077562] b43 ssb0:0: Direct firmware load for b43/ucode5.fw failed with error -2
>>>> [  384.077687] b43 ssb0:0: Direct firmware load for b43/ucode5.fw failed with error -2
>>>> [  384.086571] Broadcom 43xx driver loaded [ Features: S ]
>>>> [  384.144620] b43 ssb0:0: Direct firmware load for b43-open/pcm5.fw failed with error -2
>>>> [  384.190831] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
>>>> [  395.097838] b43-phy0: Loading OpenSource firmware version 410.31754
>>>> [  395.098158] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>> [  397.667851] b43-phy0: Loading OpenSource firmware version 410.31754
>>>> [  397.668171] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>> [  403.940787] b43-phy0: Loading OpenSource firmware version 410.31754
>>>> [  403.941110] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>> [  405.366065] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
>>>> [  405.366095] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
>>>> [  405.389013] wlan0: authenticated
>>>> [  405.392814] wlan0: associate with da:b3:70:18:7c:14 (try 1/3)
>>>> [  405.600498] wlan0: associate with da:b3:70:18:7c:14 (try 2/3)
>>>> [  405.808479] wlan0: associate with da:b3:70:18:7c:14 (try 3/3)
>>>> [  406.016481] wlan0: association with da:b3:70:18:7c:14 timed out
>>>> [  414.301216] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
>>>> [  414.301245] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
>>>> [  414.351544] wlan0: authenticated
>>>> [  414.403769] wlan0: associate with da:b3:70:18:7c:14 (try 1/3)
>>>> [  414.422775] wlan0: RX AssocResp from da:b3:70:18:7c:14 (capab=0x1411 status=0 aid=25)
>>>> [  414.431879] wlan0: associated
>>>> [  415.272393] wlan0: Limiting TX power to 36 (36 - 0) dBm as advertised by da:b3:70:18:7c:14
>>>>
>>>> If there's anything further that would be useful here, let me know and I'd be happy to provide them.
>>>
>>> Seems the SDIO function driver b43-sdio does not print any error
>>> messages.  All the error paths in drivers/ssb/sdio.c print debug
>>> messages instead.
>>>
>>> I would suggest the following, which would limit messages to
>>> host mmc1 which is what is shown in message "b43-sdio mmc1:0001:1:
>>> Chip ID 14e4:4318"
>>>
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index 860378bea557..2719b21783ad 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -169,33 +169,33 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
>>>  	 * - The card was removed (...so just complete everything no matter
>>>  	 *   if there are errors or retries)
>>>  	 */
>>> -	if (!err || !cmd->retries || mmc_card_removed(host->card)) {
>>> +	if (host->index == 1 && (!err || !cmd->retries || mmc_card_removed(host->card))) {
>>>  		mmc_should_fail_request(host, mrq);
>>>  
>>>  		if (!host->ongoing_mrq)
>>>  			led_trigger_event(host->led, LED_OFF);
>>>  
>>>  		if (mrq->sbc) {
>>> -			pr_debug("%s: req done <CMD%u>: %d: %08x %08x %08x %08x\n",
>>> +			pr_info("%s: req done <CMD%u>: %d: %08x %08x %08x %08x\n",
>>>  				mmc_hostname(host), mrq->sbc->opcode,
>>>  				mrq->sbc->error,
>>>  				mrq->sbc->resp[0], mrq->sbc->resp[1],
>>>  				mrq->sbc->resp[2], mrq->sbc->resp[3]);
>>>  		}
>>>  
>>> -		pr_debug("%s: req done (CMD%u): %d: %08x %08x %08x %08x\n",
>>> +		pr_info("%s: req done (CMD%u): %d: %08x %08x %08x %08x\n",
>>>  			mmc_hostname(host), cmd->opcode, err,
>>>  			cmd->resp[0], cmd->resp[1],
>>>  			cmd->resp[2], cmd->resp[3]);
>>>  
>>>  		if (mrq->data) {
>>> -			pr_debug("%s:     %d bytes transferred: %d\n",
>>> +			pr_info("%s:     %d bytes transferred: %d\n",
>>>  				mmc_hostname(host),
>>>  				mrq->data->bytes_xfered, mrq->data->error);
>>>  		}
>>>  
>>>  		if (mrq->stop) {
>>> -			pr_debug("%s:     (CMD%u): %d: %08x %08x %08x %08x\n",
>>> +			pr_info("%s:     (CMD%u): %d: %08x %08x %08x %08x\n",
>>>  				mmc_hostname(host), mrq->stop->opcode,
>>>  				mrq->stop->error,
>>>  				mrq->stop->resp[0], mrq->stop->resp[1],
>> 
>> With these patches, I still get copious amounts of spam, but at least relevant
>> to the wifi card now.
>> Here's a hopefully useful snippet (it's just a lot of these, from what I could see),
>> from with my patches:
>> 
>> [  154.177276] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
>> [  154.177297] mmc1:     4 bytes transferred: 0
>> <...>
>> [  186.707195] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
>> [  186.707217] mmc1:     20 bytes transferred: 0
>> [  186.707358] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
>> [  186.707382] mmc1:     384 bytes transferred: 0
>> [  186.707477] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
>> [  186.707498] mmc1:     24 bytes transferred: 0
>> 
>> And the one from without is very similar, except I noticed this pattern:
>> [   85.942269] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
>> [   85.942299] mmc1:     4 bytes transferred: 0
>> [   85.942523] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
>> [   85.942555] mmc1:     4 bytes transferred: 0
>> [   85.944548] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
>> [   85.944581] mmc1:     2 bytes transferred: 0
>> [   85.944777] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
>> [   85.945160] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
>> [   85.945187] mmc1:     2 bytes transferred: 0
>> ... occasionally, some of the requests don't have an "[x] bytes transferred: 0".
>> 
>> Hopefully these help.  I can get a capture of the entire log spam and
>> put it on on pastebin or something, if that would be more useful.
> 
> Need to know if there are any errors.  In "[x] bytes transferred: 0"
> messages, the "0" is the error code i.e. no error.  So you might be able
> to find errors like:
> 
> 	dmesg | grep 'bytes transferred' | grep -v 'bytes transferred: 0'
> 
> Also the debug patch could be tweaked to show errors only:
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 2719b21783ad..7b18fe6d5738 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -169,7 +169,7 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
>  	 * - The card was removed (...so just complete everything no matter
>  	 *   if there are errors or retries)
>  	 */
> -	if (host->index == 1 && (!err || !cmd->retries || mmc_card_removed(host->card))) {
> +	if (host->index == 1 && (err || (mrq->data && mrq->data->error))) {
>  		mmc_should_fail_request(host, mrq);
>  
>  		if (!host->ongoing_mrq)
These patches were mildly revealing, I see this near the start of the logs:
[   32.222988] b43-sdio mmc1:0001:1: Chip ID 14e4:4318
[   32.224789] ssb: Found chip with id 0x4710, rev 0x00 and package 0x00
[   32.227574] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
[   32.227834] mmc1:     0 bytes transferred: -84
[   32.229615] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
[   32.229876] mmc1:     0 bytes transferred: -84
[   32.230400] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
[   32.230659] mmc1:     0 bytes transferred: -84
[   32.231173] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
[   32.231476] mmc1:     0 bytes transferred: -84
[   32.233287] ssb: WARNING: Multiple ChipCommon found
[   32.234489] b43-sdio mmc1:0001:1: Sonics Silicon Backplane found on SDIO device mmc1:0001:1
[   32.238533] b43-phy0: Broadcom 4710 WLAN found (core revision 9)
[   32.264908] b43-phy0: Found PHY: Analog 3, Type 2 (G), Revision 7
[   32.272565] b43-phy0: Found Radio: Manuf 0x17F, ID 0x2050, Revision 8, Version 0

This occurs either with, or without, my patches.  However, no further
errors were logged.  Despite the lack of reported errors, the
functional behavior remained the same as I described earlier.
