Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A405267AF6
	for <linux-mmc@vger.kernel.org>; Mon,  6 Oct 2025 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759742905; cv=none; b=kLx7+fAMEetmr/f6vxPbfxVoQ1fq836ECEPODblEoWbIeyrwHnvSMJJQKU3S710oTF0uU1IGs2s85oYzvr6VH2Hkch5tTpYsq6X03jWJUVxmwZI4YQ5vd3STjbtYI++m1ppPVx/75aFMv9zQHj69MIiqKE4yAhnlY9Kr2krisLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759742905; c=relaxed/simple;
	bh=6YXXysC1cWrKt1rE5lwkSbhw467QlHVJrTidJeTanWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCoV0PDPd1HLFZC9TejMfzVT7O4FPhUJwYzzwU+pBc4A6ksuSDXeYBF4frWCBPuaGtyyNTJMq5suQUiWDLacMZq4HyMJ45/lc8ZvNT4JXmiHXbmWdMyUlPUFiGHb/6DL3zkDrBwlbzFSFszCe9bVj0FrMgbdrPTwsvANjSAsw4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S98A/rx5; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S98A/rx5"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7a439f76688so448947a34.1
        for <linux-mmc@vger.kernel.org>; Mon, 06 Oct 2025 02:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759742902; x=1760347702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9X6wezq6nwZqxfyxFAVDn2DYaLflR3W1jtoNhuxnn34=;
        b=S98A/rx5Hojvpvaok6fVkTnX5cU5/OB75So6Hq8K6NJnbnv34ffbLr9gxbB8SLRSs7
         cYEsHtK0SERc9ExB0/k2IjRUjRqT7LP3vN7iQULhxxzdwYDXkMcGHmeCxMH0ldnauxo2
         FTYEpVamLh3duP3EzHgHeix1ruLOiw6xqKikMf7dxKuHqX0A3dm/vAs3ejXR94VGx4f0
         YmKCKgSL0tICO5zgASP7dJzR3bj1LaV4vFPbqrgotBzFemYPqte/eNslzK0GKLDE1BXP
         2TLV7uuc/u3qjIC2mYEympIeG3uDrntnXxicehzrM/zgGjqWddAJHImSjjS/bLVxXI2O
         NRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759742902; x=1760347702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9X6wezq6nwZqxfyxFAVDn2DYaLflR3W1jtoNhuxnn34=;
        b=kfBqNwrYX7vB0ylh8g0tpIDB/+jxR4ecuJizvWaavgd8Rpkh134SgI1C7a11NRdWQz
         GlgtH1mTrTjohBrvnFxifqyNWfimWmWlXaf/GSuNPK9r/RByvDxLjiQhkokwCJcECZkm
         d0MI3YI9PBrVN1KbArxYQ0oXPfdbkh4pI7tep+5Gb8EnRJO5FGfF3Wkizv88EgWm0XVN
         f7sIIES1uH4/65rXMUWsC+0AuBuJ8onn8QKkXrg82G+STHaJEVxxf0bqA/mdYwpcYbXa
         R+yq2CMLnMCiyfwnNJ3O51COmLLAOkphJdIesQykIa5lK5KfY0MlIE3kVjxSSjRGKcsy
         bFkA==
X-Forwarded-Encrypted: i=1; AJvYcCXnuSC4HgupA4HjSwTkFJCnDk7Qm39danRMg9gp6AqgYY4u8CfzmTwJp/imG0rCnfr1tl+6zjZIQIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5p8gv5oHhBRk8oPqdntThIp9bVDyKWLDPDm8/phEG6CCRqkbv
	gyLb9hAoAOEaK1wUqZ6GoxfoFFWYh8Bskw3ksEVJnwFd1hmMqTXDQ22Vjti5qkGD
X-Gm-Gg: ASbGncvUa85AWJxmbaqn351KE26Jo9XYN+h/DuT3oF8QPCq021jJqHshyLePtNLcgov
	HdDGnIZNl0NJdTrH620rNUSdAhpWHZq5zYEr1nq1XoyBmtqfAuGiUhuG15w7yXWxcleJugwuJCE
	9ICWRLZPgJNhjfadxZRU7I2BvRzyEbXBZ+blLgEPiTF77pKIMJXbY3sMdDr3Dr9KAn+gzzNgYBQ
	e8N7T0VG8mqfgcv0yk5C3sXcfqRkiMfpu2islDnaujavwcgTW00hwtmUFk1Az6yL/8Lq+yuPlZo
	uFZgGQLKrDfOmgJjA4myGtHJrmaPappr8ogmc35yKuLOveB/ZWnUEY/GgUwYEiugdFpLeVy1FM1
	zonxihqasj3GPvhMmD6CNxNf/6IPwj6f00L5ZgfLU96NgHz4Q9yxIypgjpIbZI+8ePN1dfAjcWw
	rJLUHAMTGSq7vwnYiYrA==
X-Google-Smtp-Source: AGHT+IEEYY5ntlIbRvyboFEkoT1IS8+qMFgikJsiS3VtzQDHAVRzDoM9dGZgtzv25ryEtwksTrduMw==
X-Received: by 2002:a05:6808:1823:b0:43f:4769:b0e1 with SMTP id 5614622812f47-43fc181a6b0mr2846991b6e.6.1759742902569;
        Mon, 06 Oct 2025 02:28:22 -0700 (PDT)
Received: from Michael-ArchMiniPC.shack.lan ([75.167.107.197])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43fb25d1251sm2852093b6e.28.2025.10.06.02.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 02:28:21 -0700 (PDT)
From: Michael Garofalo <officialtechflashyt@gmail.com>
X-Google-Original-From: Michael Garofalo <officialTechflashYT@gmail.com>
To: adrian.hunter@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	officialtechflashyt@gmail.com,
	ulf.hansson@linaro.org
Subject: Re: [PATCH 0/2] mmc: sdhci: add quirk to disable bounce buffer
Date: Mon,  6 Oct 2025 02:28:15 -0700
Message-ID: <20251006092815.2555733-1-officialTechflashYT@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <21d7f0c8-9a61-4759-b655-b12a6fad9885@intel.com>
References: <21d7f0c8-9a61-4759-b655-b12a6fad9885@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On 06/10/2025 10:35, Adrian Hunter wrote:
>> On 06/10/2025 04:36, Michael Garofalo wrote:
>>> This patch series adds a new bit to quirks2 for disabling the bounce
>>> buffer.  On some hardware, this is required for proper operation.  An
>>> example of such hardware is the SDHCI controller of the Nintendo Wii's
>>> "Hollywood" chipset.  Without this patch, the onboard Broadcom 4318
>>> Wi-Fi fails to connect to any networks.
>> 
>> The bounce buffer should not make any difference, so it is likely
>> a different problem that gets hidden when the bounce buffer is not
>> used.
>> 
>>> Could you enable dynamic debug messages and show the messages
>>> for the failing case?
>>
>>Actually will also need to see the messages in the "fixed" case
>>to compare.
I'm afraid I won't be able to provide those easily, at least not with the
commands you've provided.  Since the rootfs is _also_ running from SD,
turning on full MMC logs like this produces an obscene amount of noise
from the storage, unrelated to the SDIO wireless.  It gets even worse with
my original intention, which was to save the logs to SD Card, (since my USB
Gecko serial console is rather flakey, and introduces corruption now and then),
since it's now logging the writes of it's own logs in a permanent loop.
If there's a way to narrow down the logs to specifically whatever portions
you're interested in, and filter out the noise, I would happily provide it.

(P.S. sorry about the blank message there, still working out how to deal with mailing lists)
>
>> 
>> Dynamic debug for mmc
>> ---------------------
>> 
>>     Kernel must be configured:
>> 
>>         CONFIG_DYNAMIC_DEBUG=y
>> 
>>     To enable mmc debug via sysfs:
>> 
>>         echo 'file drivers/mmc/core/* +p' > /sys/kernel/debug/dynamic_debug/control
>>         echo 'file drivers/mmc/host/* +p' > /sys/kernel/debug/dynamic_debug/control
>> 
>>     To enable mmc debug via kernel command line:
>> 
>>         dyndbg="file drivers/mmc/core/* +p;file drivers/mmc/host/* +p"
>> 
>>     To disable mmc debug:
>> 
>>         echo 'file drivers/mmc/core/* -p' > /sys/kernel/debug/dynamic_debug/control
>>         echo 'file drivers/mmc/host/* -p' > /sys/kernel/debug/dynamic_debug/control
>> 
>>     More general information in kernel documentation in kernel tree:
>> 
>>         Documentation/admin-guide/dynamic-debug-howto.rst
>> 	https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html
>> 
>> 
>>>
>>> Patch 1 introduces the new quirk bit.
>>> Patch 2 applies it to sdhci-of-hlwd.
>>>
>>> Michael Garofalo (2):
>>>   mmc: sdhci: add quirk to disable the bounce buffer
>>>   mmc: sdhci-of-hlwd: disable bounce buffer usage
>>>
>>>  drivers/mmc/host/sdhci-of-hlwd.c | 1 +
>>>  drivers/mmc/host/sdhci.c         | 8 +++++---
>>>  drivers/mmc/host/sdhci.h         | 4 ++++
>>>  3 files changed, 10 insertions(+), 3 deletions(-)
>>>
>> 
