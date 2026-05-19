Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8890436BCCC
	for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 18:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216273; cv=none; b=lemo01NMAUgk/9yWpHYC8ImXIj1lYMQiRuyy+NS343duB5Z8BEOaKr45F/19nEWJaC1qOwcMHD5X0yM6hB3qrHtt4HtEdBuyr6mgjaNZ6+snOCbrjfR9SJpuzWcGmO59tlqDuoUJOpU/GD7Y8gvyewWLvgCOJL4lLPHJKrvre2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216273; c=relaxed/simple;
	bh=uz+vemUhmNNro/rp3qqtv3qctKFkHF52DqRroFw7jbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qOrg1fy/Dm3YMsIn4WBr9gqpGS1JRDvlOLfRx//b+VkHGWL2BdW1I7Oq3W7eBxdcr+O4brCtzzEWTXs9jO/7//UP3SHRCJhpKW6XruPXiomhSqd8dVr0cgsujdds6WSda6cHnZ3XjW3t8zWNQwvRuA5+2a2wEeHbweqddXCSdW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=Ur8iPei0; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Ur8iPei0"
Received: from eig-obgw-6005b.ext.cloudfilter.net ([10.0.30.162])
	by cmsmtp with ESMTPS
	id PK3HwZMwq4RkpPPQcwLtmo; Tue, 19 May 2026 18:44:30 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id PPQTwyet6D6ICPPQTwai9H; Tue, 19 May 2026 18:44:22 +0000
X-Authority-Analysis: v=2.4 cv=DcUXqutW c=1 sm=1 tr=0 ts=6a0caf8e
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=_Wotqz80AAAA:8 a=tBb2bbeoAAAA:8 a=pGLkceISAAAA:8 a=yC-0_ovQAAAA:8
 a=XdmyuPCCfbVxxrREcIQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=buJP51TR1BpY-zbLSsyS:22 a=Oj-tNtZlA1e06AYgeCfH:22 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WJd2PSagXT/7Zk3zROcElqGPnYAcaGo0Um1SeTGkppo=; b=Ur8iPei0kv4osbB1//cJPVZD0a
	vlWslvxBezPVYFTlw0OwRKbNe6KfLO1A7n5D1Mpcx8nuRZHWdD5FinrdA+tZCRm3FlynC/ywWqH+2
	uAtqZ8WYuOe4w0LUx6IWoRf/x/f5gcJohOJf37G14zkApHSvSgwOw4sFFh9iVOikGqZOvHYLvCyim
	v88TdbBOfc072zfC/ulTT/uJY0W9pHiwK332xVMVAuER7cwxzharnrrXGQtzkEOePmmetOzRRfaKx
	v8HkQ3NwrnYsqkJbdAxpGKzb1Fdo1OV0WUDcz4CXcyRblP3OeR+va8zRfY/dmk8FGrH4tkNrQxL8t
	Yd9HP+jQ==;
Received: from [177.238.17.117] (port=33822 helo=[192.168.0.11])
	by gator4166.hostgator.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1wPPQR-0000000210K-3gpT;
	Tue, 19 May 2026 13:44:20 -0500
Message-ID: <18c41409-e1d1-4877-87a6-1c3156f943aa@embeddedor.com>
Date: Tue, 19 May 2026 12:44:07 -0600
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: mmc_test: Fix counter tracking in
 mmc_test_alloc_mem()
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260519133025.618255-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVKOdzThVMOcQ1K9crUkyDutvuZsP2-5v5++SVFHkgtOA@mail.gmail.com>
 <CA+V-a8sFNjp9euEEfBf3BoscjU8W3isRT_pnzd7J4QsuiN6qfg@mail.gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <CA+V-a8sFNjp9euEEfBf3BoscjU8W3isRT_pnzd7J4QsuiN6qfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.17.117
X-Source-L: No
X-Exim-ID: 1wPPQR-0000000210K-3gpT
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.11]) [177.238.17.117]:33822
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHi8l6sAZjDlf5o8qw4OnyhjNAhXvr6ECN97nUPFK3IBnXZr3XkDa1aA82oYLV3YzdOedXkgjIjvOxZWfXakel1FVbtAaMicpxuRmW2pDPfT+PS1iYlj
 OhVR3tdxOhaf9yt+LFUBbkPTk6ITCgG4LX3WrZ6ON4E/ZDXH1+Lb25xQ7VS2ToVHEpYHzFb2Dh9yfK0NDHayDbT3WjApBMr716g=



On 5/19/26 07:44, Lad, Prabhakar wrote:
> Hi Geert,
> 
> Thank you for the review.
> 
> On Tue, May 19, 2026 at 2:34 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>
>> Hi Prabhakar,
>>
>> On Tue, 19 May 2026 at 15:30, Prabhakar <prabhakar.csengg@gmail.com> wrote:
>>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>>
>>> Fix an counter tracking in mmc_test_alloc_mem() that causes a kernel panic
>>> during error unwinding.
>>>
>>> The `struct mmc_test_mem` uses the `__counted_by(cnt)` annotation on its
>>> flexible array member `arr`. While kzalloc_flex() initially sets the
>>> counter field (`cnt`) to `max_segs`, the allocation loop needs to track
>>> how many elements have actually been populated.
>>>
>>> Previously, leaving `mem->cnt` at `max_segs` meant that if the loop failed
>>> midway (e.g., "Failed to map sg list"), the error unwinding path in
>>> mmc_test_free_mem() would attempt to clean up uninitialized trailing
>>> array slots. This resulted in passing NULL pointers to __free_pages(),
>>> triggering a kernel panic:
>>>
>>>    [   66.172845] mmc0: Failed to map sg list
>>>    [   66.176722] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>>>    ...
>>>    [   66.432747] Call trace:
>>>    [   66.435191]  ___free_pages+0x1c/0xc4 (P)
>>>    [   66.439119]  __free_pages+0x14/0x20
>>>    [   66.442608]  mmc_test_area_cleanup+0x58/0x84 [mmc_test]
>>>
>>> Fix this by explicitly resetting `mem->cnt` to 0 immediately after
>>> allocation. Then, move the existing `mem->cnt` increment so that it occurs
>>> prior to populating each array slot, using `mem->cnt - 1` for the actual
>>> assignment index. This guarantees that the counter accurately tracks
>>> initialized entries for safe error cleanup, while dynamically expanding
>>> the `__counted_by` validation boundary ahead of each flexible array write.
>>>
>>> Additionally, rewrite the cleanup loop in mmc_test_free_mem() to use a
>>> standard forward for-loop. This addresses the unsafe post-decrement logic
>>> in the original `while (mem->cnt--)` loop which evaluated and decremented
>>> the counter field before indexing the array, and avoids a potential integer
>>> underflow/wrap-around of the counter field if the cleanup path is invoked
>>> when `mem->cnt` is 0.
>>>
>>> Fixes: c3126dccfd7b ("mmc: mmc_test: use kzalloc_flex")
>>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>> ---
>>> v1->v2:
>>> - Started with cnt = 0 and incremented before assignment to ensure
>>>    accurate tracking of initialized entries in mmc_test_alloc_mem().
>>> - In mmc_test_free_mem(), replaced the while loop with a forward for-loop to
>>>    safely iterate over initialized entries without risking underflow.
>>> - Updated commit message to clarify the issue and the fix.
>>
>> Thanks for your patch!
>>
>>> --- a/drivers/mmc/core/mmc_test.c
>>> +++ b/drivers/mmc/core/mmc_test.c
>>> @@ -318,9 +318,8 @@ static void mmc_test_free_mem(struct mmc_test_mem *mem)
>>>   {
>>>          if (!mem)
>>>                  return;
>>> -       while (mem->cnt--)
>>> -               __free_pages(mem->arr[mem->cnt].page,
>>> -                            mem->arr[mem->cnt].order);
>>> +       for (unsigned int i = 0; i < mem->cnt; i++)
>>> +               __free_pages(mem->arr[i].page, mem->arr[i].order);
>>>          kfree(mem);
>>>   }
>>>
>>> @@ -356,6 +355,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsigned long min_sz,
>>>          mem = kzalloc_flex(*mem, arr, max_segs);
>>>          if (!mem)
>>>                  return NULL;
>>> +       mem->cnt = 0;
>>
>> This is not needed, as it is set to zero by kzalloc_flex().
>>
> Actually, kzalloc_flex() automatically sets mem->cnt to max_segs
> because cnt is annotated with __counted_by. Because of that implicit
> initialization, we need this explicit reset to get it back to zero.

An auxiliary variable could be used to avoid having to update the
counter too early[1][2].

I think it'll eventually become best practice to defer updating the
counter until after the flexible array has been fully initialized, or
after every major update that requires changing its boundaries.

-Gustavo

[1] https://git.kernel.org/linus/ea9e148c803b24eb
[2] https://embeddedor.com/blog/2024/06/18/how-to-use-the-new-counted_by-attribute-in-c-and-linux/
(I'm in the process of updating this blogpost with some *alloc_flex() examples and more.)
