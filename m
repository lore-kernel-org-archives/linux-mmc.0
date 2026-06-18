Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A8F14ABE;
	Thu, 18 Jun 2026 23:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781826608; cv=none; b=eYC6SQpD0eq1yUjVoUcsbna3mGIDnVZxte0MXW29i2ccrX9LA3queEoL5RAPDHVHzggMyc8+e6fG/Oh6P5J3hWqdP8oKSXiGky3pxPaFASZPzOxI7qf/HBjsjd+vFBaqX4FlQMwrLgsUGGIP3Ru3PgIOu90q4KGQrVonkpdZFYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781826608; c=relaxed/simple;
	bh=ZegRt3K1oOZW2GSLAietrNvB0Ykahl3wFYsiGeB240o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8Yda10XCURSU6LFVZfnyp+CJAAyVyUAfo8c56cl4RyBzl4oCOfi7XtUgPlwLitF1+fGTExNC3Je/EzPQkRSfWXTe9yJXg8ZUizLAalaAc2LG0LCWHWqbLnyaS4bFCOCxJ6/lZkvOCSka4rZLf17Y171I7bKZ/dqAUQKVmbA2z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7FC1F00A3D;
	Thu, 18 Jun 2026 23:50:02 +0000 (UTC)
Message-ID: <c26ae6bd-8901-4d40-8168-3a04a6e894b1@linux-m68k.org>
Date: Fri, 19 Jun 2026 09:49:45 +1000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/4] m68k: coldfire: fix non-standard readX()/writeX()
 functions
To: Paolo Abeni <pabeni@redhat.com>, linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org, arnd@kernel.org, wei.fang@nxp.com,
 frank.li@nxp.com, shenwei.wang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, nico@fluxnic.net, adureghello@baylibre.com,
 ulfh@kernel.org, linux-mmc@vger.kernel.org, linux-can@vger.kernel.org,
 linux-spi@vger.kernel.org, olteanv@gmail.com
References: <20260609142139.1563360-1-gerg@linux-m68k.org>
 <fe40891c-3fd1-417c-835e-6f1046db7844@redhat.com>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <fe40891c-3fd1-417c-835e-6f1046db7844@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 13/6/26 19:22, Paolo Abeni wrote:
> On 6/9/26 4:12 PM, Greg Ungerer wrote:
>> This odd collection of patches is aimed at fixing the non-standard ColdFire
>> set of readX()/writeX() IO access functions. Instead switching to using the
>> asm-generic definitions in include/asm-generic/io.h. The difficulty comes
>> in trying not to break any drivers with this change.
>>
>> The implementation of the readX()/writeX() family of IO access functions
>> is non-standard on ColdFire platforms. They either return big-endian (that
>> is native endian) data, or on platforms with PCI bus support check the
>> supplied address and return either big or little endian data based on that
>> check. This is non-standard, they are expected to always return
>> little-endian byte ordered data. Unfortunately this behavior also means
>> that ioreadX()/iowroteX() and their big-endian counter parts
>> ioreadXbe()/iowriteXbe() are currently broken because they are implemented
>> using the readX()/writeX() functions.
>>
>> Patches 1, 2 and 3 in this series are specific driver changes that can be
>> made independently of the final ColdFire readX()/writeX() change.
>>
>> Patch 4 is the actual switch to ColdFire building using asm-generic
>> readX()/writeX(), but also contains three driver fixes that are not easily
>> handled independently.
>>
>> Note that I don't have access to all supported hardware needed to fully
>> test all these changes. I have tested what I have, a bunch of the standard
>> Freescale ColdFire eval boards, and inspected generated code for differences.
>>
>> Note also that patch 3 relies on changes that are currently only in
>> linux-next, and are scheduled to hit mainline during the next v7.2
>> merge window. Those changes are also available in an immutable git tree
>> at git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git
>> cf-internal-io branch.
> 
> I understand that with this series you are targeting the m68K tree, am I
> correct?

All the changes are targeted at fixing an m68k issue, yes.


> A possibly better option would be, after that the pre-req patches land
> into Linus's tree, to share an immutable branch for this series, so that
> both m68k and net-next could pull it.

I can certainly do that. All pre-requisite changes are now in Linus' tree.
My preference would be for subsystem maintainers to pick up their respective
changes (so patches 1, 2 and 3). I expect I will push patch 4 via the m68knommu
git tree, with appropriate sign offs from affected subsystems.

Regards
Greg

