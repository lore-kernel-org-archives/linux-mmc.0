Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39547602F
	for <linux-mmc@vger.kernel.org>; Wed,  6 Mar 2024 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709723524; cv=none; b=Y0ESbMhKtignPbG7W50IiLGRH89zjsI52fQh/aBRy2W39UoLFqQxT6XMl2C37spfsemFiQTXhIfzR4VxUY87rUhwTcsC+KHwaW6/bSedEsMIhffvtNqJRklx/1fyrfntctOftpU/W6UB4APiMPGMHXNvNUIsVhA1mOEBG83RDSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709723524; c=relaxed/simple;
	bh=2HhFsY/RXmfM6bvnDU/LMzhBVN1o6z9YOIR9J6tR1zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXYy3TNkcgzM9kbL04Z3d6nMtsv270S1oGFjuGYGJdYrokmxlAZaEg3Tl7hSNs+kp6vi1Cb/vvdzPhd95F3dfgtZgI2vUMfb5t/jODxgcYnTwBXCvWeijPlRpR+/nxcD93RM1g1NzrRrlNBCCAYa1BULBGhWFWYG/5AssMswpNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C4D91FB;
	Wed,  6 Mar 2024 03:12:38 -0800 (PST)
Received: from [10.57.95.153] (unknown [10.57.95.153])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 464B83F738;
	Wed,  6 Mar 2024 03:12:00 -0800 (PST)
Message-ID: <ba258d15-6237-4ccf-b4d9-d6ddc105d89f@arm.com>
Date: Wed, 6 Mar 2024 11:11:58 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question regarding informing MMC subsystem about upcoming power
 loss.
Content-Language: en-US
To: Patryk <pbiel7@gmail.com>
Cc: linux-mmc@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>
References: <CA+DkFDZbYvL9ecEtbpkj=HLMuPC=5QuQHgM8fi_WH2Qu-taDOg@mail.gmail.com>
 <1b300835-fa8b-4b5d-8430-6bfa8e577433@arm.com>
 <CA+DkFDYMtEW9vp4EmU9ayhb+qCRgqYwKEeAU3LgWiuedSvUt8w@mail.gmail.com>
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CA+DkFDYMtEW9vp4EmU9ayhb+qCRgqYwKEeAU3LgWiuedSvUt8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/03/2024 15:59, Patryk wrote:
> wt., 5 mar 2024 o 16:33 Christian Loehle <christian.loehle@arm.com> napisał(a):
>> Immune to what exactly?
>> - (User) data loss of data that is still in the cache of the sd card?
>> (That would be saved by a timely cache flush)
>> - (User) data loss of data that should've been written to flash already?
>> - SD cards breaking?
>> - Explosions?
> 
> Data loss of data that is still in the cache of the sd card

Then my (very biased) opinion is:
Anything >1s window between being notified and power-loss a userspace umount/fsync
might be an improvement enough for your case.
Anything <1s window is then so storage-module-implementation specific that
it's hard to draft a solution that actually provides a measurable improvement.
Of course, turning off the SD cache completely is always an option (with drawbacks
like reduced performance and endurance).

> 
>> (Anything but the first IMO should be fixed by procurement and not by the
>> kernel, but I'm not sure if that's consensus).
>>
>>> Assuming that I have the information about upcoming power loss
>>> (provided by e.g. external interrupt, PSU voltage monitoring etc) how
>>> should I pass this information to the Kernel so that it will try to
>>> clean up resources - in particular MMC subsystem?
> 
>> There was a discussion, currently there aren't really, but it depends
>> on the scenario you're afraid of. Just issuing a cache flush might be fine.
>> https://www.phoronix.com/news/Linux-Priority-Based-Shutdown
>> https://lore.kernel.org/lkml/2023112403-laxative-lustiness-6a7f@gregkh/T/
> 
> Thanks, I didn't know about this, I will check it.

Forgot to CC Oleksij before, did it now.

Kind Regards,
Christian

> 
>> One of the fundamental questions IMO remains: How much time do we actually
>> have between being notified?
> 
> I haven't done any measurements yet, sorry.
> 
> Best regards
> Patryk

