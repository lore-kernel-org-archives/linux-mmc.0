Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9A63B05AD
	for <linux-mmc@vger.kernel.org>; Mon,  5 Oct 2026 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791189023; cv=none; b=soAZRegxGOyK0SDP937pN9M72jr4m5GvlYZrKUlQjz6HABxSSdkDzh6FCD077tNxdoAZVPfT8fzcHsTxIs5XuXbyizfmdZFqkjpQCjLzo75oh0tN6BLLj6M+JYkFoMTZw3p1KSAHkGxqzwikHKMaqEHqgMt/DDQiCAsQK2Jrn2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791189023; c=relaxed/simple;
	bh=vyTwTI8VlQ0pCbmAtLYSj9W7L6C9GYAol3GzhJTQf1g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MS37T53yC+R6Zyljga77FmDVb42HAYYUh5AkkCcPFL/Qsdokdihar9UV1Uadur0eum39sj4cHkP5XrIHvUY6kHWhuSuxKDrjYT9tiv8Ewu72FA3ayq5jCt97IX6QDW+UwJFvPoWje3pd0kflQkdDo22oIjmdjM41DoX3RVs18nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/EUI7So; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/EUI7So"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d8239so12657175e9.0
        for <linux-mmc@vger.kernel.org>; Mon, 05 Oct 2026 01:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791189016; x=1791793816; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sd1BmBIq6PAEb87txh8tHMQ7YpHFp1uklRh5l7OqDQs=;
        b=c/EUI7SoBfNBQAAdVHR7FXUjXzbc859r/vcm9DEFj2V3V+ztdzanJyKA16TllyawQP
         kEWRD1WC9U/anctRdZfCaupCHlSCySWN7lX4pi1zeV3YzoMGIhGXA6DrYaTZ/Mj8vGxS
         O8mkGDyF6/9t6GwrYSI6IVNxFZFlPA5qf95wzN2WrvfL8NzgR/7PZH7bLx6hYps01bkd
         dW5ICTMKKPfEVzjyTXKrgX820y5vccZaq0BkiyTghs5wZ6hFfqm4M7OVDCOBWZWB0Njg
         yI7xDLtFgQsnReo1W6g2ofBbFmG2PHxDrM2flnf7zWFsSScYNs/MZUxPv30b9NUxbq2p
         Ca1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791189016; x=1791793816;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sd1BmBIq6PAEb87txh8tHMQ7YpHFp1uklRh5l7OqDQs=;
        b=eavKu9OeZJjE2DP1ojs0dLwyHnhFW9WgmMytIHxT82zTEpjl3t+Ncv9I9pKNDIRrMf
         HxwbI8L2jxSdqhGR4+MP91LV3CGKR+8NABLzZlfy4LWfJFWIMbHg6FKO9djD46d68NrY
         z8Q6Ob2sLBHikNfee+6pwLkB+WheuLPv2IyxLCAKXKp0O9EMLgv8H2+Svl5TjWq0xCoS
         EIdglXzAFR8JDrA11s/OXeSsDwlW8vmJZSBxqncNoIykSl5VkBCGgKZ2xtLlPzN6J9QE
         wN0uT0gAls+6cE5/Pt5sq+AtUaRFDUlA2K/oHAEWh3m9BTUdwAG026AUUIFz1Irt9Qqx
         hmwA==
X-Forwarded-Encrypted: i=1; AKwUvBwz5HLrq25vAcecuj9Z5OnzIcJBVY+LgYRhERRH26i9SBNOw/sZ10FQVf9LdieRLsK6l8VWdi9/KIg=@vger.kernel.org
X-Gm-Message-State: AFuF++kmtV5G/WqXohGVvf90dPmj2AiyQ9hrTlne5d+/Krxz/CJbMv2o
	Rir2hNTqt1ytMW5+AGzsFbeElC6pToqXsWPO1DffDMwj/RmCzTozXV8L
X-Gm-Gg: AYBFou3iK4XwXOWmo7FTNdW1Nc/UqNXo7NmKpxvuo/FHYLIofBtNDHzqoTnMBDTE4CD
	Ax3jv/qZ+UodMNP9tLTk/+KWIkKb9qNpGqR/55cMRL4s3vXgqYH9aLZU/EgHy9jn67cHGyyK3Yc
	Pj2NGrjxcY262hEJvmPBzER3Ns647rcezISTTaZVIq2lUDMtWlunXPY+q/Su6jFCqZOCyhhLBni
	vmq0OG9PTfmNZB32XZAi3LMd0fHgj1bqG5lj/3JuKmfigieI0G123iVy373jvYn+kD0ppcrDKX1
	JB71sfxcEyken+0udhylZsP/8DGBrAFp/ijpsAOKbCpwKXT5DD/ueL6/MFWcjhFA4eYCd+0OW7T
	P2aV/0LAgtLFJxoSR9EWzz0kwxI3zDgJf85JgP9k+J9Bp9tWV0qVmNTse+O4aipcTbpMxG045KU
	Z6IXDSbiiAmZhB1wG2bo0pnZmtNLn7S90Ze2FAIgwA42FPD2r3BTVnGuj4SxgsV2B4cbyv8EFJ3
	s08OvkTJg==
X-Received: by 2002:a05:600c:4592:b0:4a0:bc9:28c6 with SMTP id 5b1f17b1804b1-4a0276b6860mr152436465e9.34.1791189014935;
        Mon, 05 Oct 2026 01:30:14 -0700 (PDT)
Received: from foxbook (bfj133.neoplus.adsl.tpnet.pl. [83.28.47.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c63904832sm1548590f8f.14.2026.10.05.01.30.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 05 Oct 2026 01:30:14 -0700 (PDT)
Date: Mon, 5 Oct 2026 10:30:11 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Sean Rhodes <sean@starlabs.systems>
Cc: Ulf Hansson <ulfh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Ricky Wu
 <ricky_wu@realtek.com>, Lee Jones <lee@kernel.org>, Roger Tseng
 <rogerable@realtek.com>, Dan Carpenter <error27@gmail.com>, Jisheng Zhang
 <jszhang@kernel.org>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] misc: rtsx_usb: avoid USB I/O in runtime
 autosuspend
Message-ID: <20261005103011.03175826.michal.pecio@gmail.com>
In-Reply-To: <7acac70a471452a6ccf23b7ccc557f3c3861e0ad.1783352430.git.sean@starlabs.systems>
References: <cover.1783352430.git.sean@starlabs.systems>
	<7acac70a471452a6ccf23b7ccc557f3c3861e0ad.1783352430.git.sean@starlabs.systems>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 Jul 2026 16:40:43 +0100, Sean Rhodes wrote:
> The runtime autosuspend callback currently queries card status and
> clears OCP by issuing USB register accesses. This can run from the
> USB runtime-PM path itself, which is the wrong place to start more
> device I/O.
> 
> Keep a cached copy of the card-status bits from normal status reads
> instead. During runtime autosuspend, use that cached value only to
> preserve the existing Memory Stick autosuspend deferral.

How is the driver supposed to detect card insertion after the last poll
but before the reader goes to suspend and can issue remote wakeup?

This is exactly what happens now: if I insert a new card within two
seconds of the "card removed" message showing up (which itself happens
up to a second after removal) the insertion is never detected and the
reader enters suspend with the card in.

It seems that not only was "starting more I/O in the runtime-PM path"
actually a good idea, but polling should only stop when the parent USB
device suspends, not the child MMC host, because there is a two second
delay between them. And even with this patch reverted, insertion never
works if USB autosuspend is simply disabled altogether.

Also, does anyone know if there is any way to utilize the interrupt
endpoint instead of polling? I tried submitting a URB to it and got
regular responses, but only zeros. Can this be changed?

> Do not treat raw SD_CD as an autosuspend blocker, because tray-based
> SD readers can assert SD_CD with an empty tray. A real SD card is
> protected by the SD/MMC child runtime-PM usage once powered.

Sounds like the proper condition is to ignore the card if and only if
it failed to initialize and has not been swapped for a new one.

Hence the question about interrupts: this would vastly reduce the risk
that a swap for an actual working card remains undetected.

Regards,
Michal
