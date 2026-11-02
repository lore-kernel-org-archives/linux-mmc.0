Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.129.254.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793586751;
	b=EwboYEsRqrHD2bI4ZWeY1IbeWeDPyjzJWeEGFQMHRAi2gJOjyalXdvh/IZr5fJJmcRwH
	 /ZRxAGcf+lEqeTbhyXH460I1hvKugABZrPaiP5X8Bmf6VbnRPRo4kqshlnsQ7KIBlUlwf
	 bBhy5Jmc0tqkyQorZyn0nrY0pp0wyGhnP9mWCZODzON+TeEBfpq+dUyYbjcVP60LjCs+u
	 CpuOOipagum2gM/HmPm1GXxG2PksYx8TE5/3/KWoAu4CzImLaKw8cDhE139u3HCsMxTfC
	 gn3QEZ11fqXSdkVGEIEkLsumVJh9xePbzgPbmJDMQrLWRhtcQhqeFUXqSmtU4xN/iog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793586751;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=2pPnorE0LxN/PfxugLihwsDjDLI3d0aIZZ4NVOe8X4I=;
	b=yHHd2v38zi/KZ5nEA/L3lkMt3qn/c/gZ0qkHe9qgHbm9BLAPu6OvihDVnVB9w/D5/OtQ
	 Z7rrZhcPBZIa7BVakrkA5lt/a8zJDSmHSA6GNBTcOg0pOvGcP9ZY16Nm96m7ksgIkpiEL
	 F+tzNBES+0YsTUcGNdRsfGZ5VO/bgQulc8OjM5e++/Ofe9Ayi2V/sLCdUs799W/EwM7TN
	 h/2wUeaQT+IgCiU2N7pSDx7OIGr7Z4M7hyjVQfnsIfSV/chuRGxn6TE9lSVLGNHnh5ICC
	 3WBox2IXqTcLne2679h55CvSlHZQiu/0orMSSn/aSEiP9sEFvKpipBGyAyutRpkHBrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b="eXeB/XMJ";
	arc=none smtp.remote-ip=103.129.254.108
Received: from mail-m254108.xmail.ntesmail.com (mail-m254108.xmail.ntesmail.com [103.129.254.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B54E606A324;
	Mon,  2 Nov 2026 02:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B54E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=eXeB/XMJ
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 531c8f784;
	Mon, 2 Nov 2026 10:32:18 +0800 (GMT+08:00)
Message-ID: <dc3e350e-fafe-436d-b847-5bcba99d1c1d@rock-chips.com>
Date: Mon, 2 Nov 2026 10:32:17 +0800
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
Cc: shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>,
 Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mmc: dw_mmc: disable bh_work and stop timers on
 remove
To: BeaCox <0xbeac@gmail.com>
References: <20261101063719.88570-1-0xbeac@gmail.com>
 <e206aa41-fc3c-45fd-8653-b9a65cffe0ad@rock-chips.com>
 <20261102022644.49510-1-0xbeac@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261102022644.49510-1-0xbeac@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa19a19b59e03a4kunmec8040523af107
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHhhJVk4YSk9IHUIfQx9LSVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=eXeB/XMJtqyec0fr//gL9Pkr1EVJjIbQz4w4K4jYpQFSQAI0cP8nA9cAmuSRg2WOKKS0nqX5Y2gsXv5LxZYqDKqCz80J2HbjCZt2hcULp1JNbun3QoESULMkmjQN1GSWcDFlkPhUXTiTiOB0lXYz8ffdl8nQgeOZ/nuhBPcXlcE=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=2pPnorE0LxN/PfxugLihwsDjDLI3d0aIZZ4NVOe8X4I=;
	h=date:mime-version:subject:message-id:from;

在 2026/11/02 星期一 10:26, BeaCox 写道:
> Hi Shawn,
> 
> Thanks for the review and for checking the history.  You are right on
> both points.
> 
> dw_mci_remove() never called tasklet_kill(), so the race goes back to
> the original driver (f95f3850f7a9); 921c87ba3893 only replaced
> tasklet_schedule() with queue_work().  I have replaced the Fixes tag
> accordingly.
> 
> I have also split the fix in two, since the two parts have different
> lifetimes:
> 
>    1/2 drains bh_work.  This is the long-standing race and the patch
>        applies to 6.11 and later, where the bh_work form exists; it is
>        marked Cc: stable # 6.11+.
>    2/2 cancels the watchdog timer.  That code is new in 7.4
>        (ce0043b9a302), so there is nothing to backport it to.
> 
> The code is otherwise unchanged.  v2 follows shortly.
> 
> If you would rather keep it as a single patch without the stable tag,
> just let me know and I will squash them.
> 

I'm fine with split the fix in two patches.

> Thanks,
> BeaCox
> 

