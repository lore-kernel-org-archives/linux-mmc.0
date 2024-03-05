Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB31684A48
	for <linux-mmc@vger.kernel.org>; Tue,  5 Mar 2024 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652823; cv=none; b=bw/tJxCWjt3eJEIv2Czmtk8gAfLwgcArsl3vA4HNzZBvF9LVcOZIrTPZWMGf10+MXRADL+rqvrkpyoGH3cd5Yd2oo2YxnHC6/ArCARjI8J201PPxu6hGBPIk4plN2yNOOGomMpOLg77QeZxGlpYRKyFuHOggUqhIQjL3RMVO3go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652823; c=relaxed/simple;
	bh=PPTppRvtduqCgtMQymmqgm6KwRIdd+rm9xX0T9xKvIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OdwtG0MSVLQvjah/2K6T7W9eJZ6udh55eGN7qexKLRi9WkOPlVAXFTJV1AawLd7PhbTepmdN8ppbg09h1qv9aP74gXi1jtDw0jBfLbpkRJ1+tAscZDo8FixMrJB5q4zd8Ytyh1j0EA86iEddw01WblziqUtlkGvfZ++WnsfC2Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D77961FB;
	Tue,  5 Mar 2024 07:34:17 -0800 (PST)
Received: from [10.1.29.29] (e133047.arm.com [10.1.29.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C9413F738;
	Tue,  5 Mar 2024 07:33:40 -0800 (PST)
Message-ID: <1b300835-fa8b-4b5d-8430-6bfa8e577433@arm.com>
Date: Tue, 5 Mar 2024 15:33:38 +0000
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
To: Patryk <pbiel7@gmail.com>, linux-mmc@vger.kernel.org
References: <CA+DkFDZbYvL9ecEtbpkj=HLMuPC=5QuQHgM8fi_WH2Qu-taDOg@mail.gmail.com>
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CA+DkFDZbYvL9ecEtbpkj=HLMuPC=5QuQHgM8fi_WH2Qu-taDOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/03/2024 15:22, Patryk wrote:
> Hi,
> I'm wondering - is there a way/interface that I could use to notify
> the Linux kernel that the power is about to go down? I'm thinking
> about SD cards in particular and how to make them more immune to
> unexpected power loss, and I've found that some SD cards support
> something like "mmc_poweroff_notify", which is called in the
> mmc_suspend function.

Immune to what exactly?
- (User) data loss of data that is still in the cache of the sd card?
(That would be saved by a timely cache flush)
- (User) data loss of data that should've been written to flash already?
- SD cards breaking?
- Explosions?

(Anything but the first IMO should be fixed by procurement and not by the
kernel, but I'm not sure if that's consensus).

> Assuming that I have the information about upcoming power loss
> (provided by e.g. external interrupt, PSU voltage monitoring etc) how
> should I pass this information to the Kernel so that it will try to
> clean up resources - in particular MMC subsystem?
>
> Let me show some background - we have a SoM which has a lot of
> components. On the SoM we have a PSU which operates on 24V voltage. We
> would like to monitor the PSU's voltage and when we detect that the
> voltage has dropped from 24V to 12V this is highly likely an
> unexpected power loss/cut, therefore we would like to inform the
> Kernel (in particular mmc subsystem) that the power loss is coming. I
> can imagine something like this - we have a driver that does voltage
> measurements or waits for an external interrupt (triggered when PSU's
> voltage drops from 24V to 12V) and then calls some functions that will
> allow the Kernel to do some cleanups, but the question is what are
> these functions? Are there any?

There was a discussion, currently there aren't really, but it depends
on the scenario you're afraid of. Just issuing a cache flush might be fine.
https://www.phoronix.com/news/Linux-Priority-Based-Shutdown
https://lore.kernel.org/lkml/2023112403-laxative-lustiness-6a7f@gregkh/T/

One of the fundamental questions IMO remains: How much time do we actually
have between being notified?

Best Regards.
Christian
