Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9449B1DB373
	for <linux-mmc@vger.kernel.org>; Mon,  7 Oct 2024 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320458; cv=none; b=QO0qvIdO8pJZBlDnLbIZfaFFsTsTo+9RcOLZAuaS7fkMN8ckgI0JYvqGkG6AHBUPmd9NU1vNPR0MKEZi2ARZnLRRBN8dWrNPQYiV5YF5UJwAWOh88UropMDz9ugSdJbUan+bDgXzjU7sQZIAlEFpajych3/N2+TiRvTVjqrcmUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320458; c=relaxed/simple;
	bh=UOoGn+zvSGFL8SJvtiTFx4KbUeFVxXI6nBbXBufgRPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=j8qTtI/k35orIcdLDfvnC+yrUnTQMCF1StANxCMju3CSFtZMOf0FNGv8IO/UGo+pj0pHUT9pGtwAv7qQS/S9IjzhUfUSBHMyMB2+eaSfxNsjC4pLpxjRnymDDWoZyIJgGj+YuFgiSoXaSAeiBZ2QB8DBwdAm6o3Arw5oeYtGzZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=DeqeVA7f; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DeqeVA7f"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241007170053euoutp01ad1d38d3ef49aa47c8d7f93501ba1eed~8Okuj5MGv1840118401euoutp01e
	for <linux-mmc@vger.kernel.org>; Mon,  7 Oct 2024 17:00:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241007170053euoutp01ad1d38d3ef49aa47c8d7f93501ba1eed~8Okuj5MGv1840118401euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728320453;
	bh=wPNp07tNyiwzwYC01UpMVWFkjl9s+pnqpLcfp6+AL5w=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=DeqeVA7fV/IR6LWP/r9I8kBQi+5i9vQB6rgRUtnPLdVVWTlPepeAMIOlVU3RlxEJq
	 Psx1PAY1X7Zce85jnLexM5es6nIZewtMcXKDipZaQO+4PIeuI+XqWmtk5DC6X+h8Eo
	 UkMtXmCLimWva2XIh7CtkzmfsY+QK2h7FUVNxfLQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241007170053eucas1p248d666b1df839ffab952b7527dea584e~8OkuQGsIl2927229272eucas1p2_;
	Mon,  7 Oct 2024 17:00:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id C4.29.09875.5C314076; Mon,  7
	Oct 2024 18:00:53 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241007170052eucas1p22d6058f74d6c0d0d4e8f4e0371ac8062~8Okt3ytNc0543705437eucas1p2d;
	Mon,  7 Oct 2024 17:00:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241007170052eusmtrp27f45b9f0f817b271242eecf342b29411~8Okt2Qg5F0981809818eusmtrp2b;
	Mon,  7 Oct 2024 17:00:52 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-ff-670413c5f223
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 7E.06.19096.4C314076; Mon,  7
	Oct 2024 18:00:52 +0100 (BST)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241007170052eusmtip1ed7dc25fb222693ea0dff9ff47495149~8OktTdaw21666816668eusmtip1c;
	Mon,  7 Oct 2024 17:00:52 +0000 (GMT)
Message-ID: <deeda5fb-16a6-4d89-a224-18898aba9a0b@samsung.com>
Date: Mon, 7 Oct 2024 19:00:43 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mmc: sdhci: Prevent stale command and data interrupt
 handling
To: Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	m.szyprowski@samsung.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <51b6cee1-d23f-475e-bfe0-979e96e687c6@intel.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djPc7pHhVnSDXYvYbU4+WQNm8XW37PY
	LS7vmsNmceR/P6PFts8tbBZrj9xlt3h5uYfZom0Wv8XxteEOnB5vXr5k8Tjc8YXdY/Gel0we
	d67tYfPYvKTeo2/LKkaPS83X2T0+b5IL4IjisklJzcksSy3St0vgyvjxuajgnn7FjCVHWBoY
	b6h1MXJySAiYSPTemMvWxcjFISSwglHiSfdeVgjnC6NE84QeFpAqIYHPjBKLnnDBdBz4uJIJ
	Ir6cUeJnAwdEw1tGiccN/9hBErwCdhK/jy0GaubgYBFQkbixswYiLChxcuYTsJmiAvIS92/N
	ACsXFgiXOLbrKjPIHBGBZYwSKxf9YgNJMAvESfw43c0CYYtL3HoyH2wxm4CRxIPl81lBbE4B
	W4kDX+8xQ9TIS2x/OwdskIRAM6dEx8lHLBBXu0hs+vMYyhaWeHV8CzuELSPxfyfEUAmBfIkH
	Wz8xQ9g1Ejt7jkPZ1hJ3zoEcxAG0QFNi/S59iLCjxL/280wgYQkBPokbbwUhTuCTmLRtOjNE
	mFeio00IolpNYmpPL9zScyu2MU1gVJqFFCqzkDw5C8kzsxD2LmBkWcUonlpanJueWmyUl1qu
	V5yYW1yal66XnJ+7iRGYqE7/O/5lB+PyVx/1DjEycTAeYpTgYFYS4Y1Yw5guxJuSWFmVWpQf
	X1Sak1p8iFGag0VJnFc1RT5VSCA9sSQ1OzW1ILUIJsvEwSnVwDSDbZWE8/pFkcsTSyZO4POL
	f5anqX248ZLOi4L4J7vKjuv3inBfsXP+UVEaNpNhU06GyW3tG9OzHiXk77n89rprg5nD/KZn
	GdIys756Ofnk7m1ylO5W/PHEmGcXb+u7L9V6C1nW+B5sf+nTHidQlxwgZZyy07Q58cKX7y1C
	b69nhwX9ksp5vvOly1bGpyEuXNfK8jsZWh8JMVfL3nqabr0fmFL07yiHNHNM5i47lV/5mPO8
	c9g7r2T52aqvHl/Uns7bfSQ3P/1TRLeN26y/QQsyPKw+rrvEnfSvoervH6uaM3c2cSmWHz/k
	zFJ6LevKw6rLB2bXzj5mMvOu8EVuxoZkzVm5f7oMoxbOendTiaU4I9FQi7moOBEAlNF1wcMD
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xu7pHhFnSDa5M17Q4+WQNm8XW37PY
	LS7vmsNmceR/P6PFts8tbBZrj9xlt3h5uYfZom0Wv8XxteEOnB5vXr5k8Tjc8YXdY/Gel0we
	d67tYfPYvKTeo2/LKkaPS83X2T0+b5IL4IjSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQz
	NDaPtTIyVdK3s0lJzcksSy3St0vQy/jxuajgnn7FjCVHWBoYb6h1MXJySAiYSBz4uJKpi5GL
	Q0hgKaPEnj3/mCASMhLXul+yQNjCEn+udbFBFL1mlPh38i4jSIJXwE7i97HFQEUcHCwCKhI3
	dtZAhAUlTs58AtYrKiAvcf/WDHYQW1ggXOLYrqvMIHNEBJYxSizovcUKkmAWiJN4eP4/I8SC
	Y4wSf3v72CAS4hK3nswHu4hNwEjiwfL5YA2cArYSB77eYwZZzCygLrF+nhBEubzE9rdzmCcw
	Cs1CcscsJJNmIXTMQtKxgJFlFaNIamlxbnpusZFecWJucWleul5yfu4mRmB0bjv2c8sOxpWv
	PuodYmTiYDzEKMHBrCTCG7GGMV2INyWxsiq1KD++qDQntfgQoykwKCYyS4km5wPTQ15JvKGZ
	gamhiZmlgamlmbGSOC/blfNpQgLpiSWp2ampBalFMH1MHJxSDUxuVe92TJFP2vOFR2932lXV
	pTYfBWTWNorceTQtl9t16mu7sLSLjKbXZIzy8ja4TH3m2GC9Ypu2a5fdpw+ZU/T/6e3PWsMt
	l+h0JuvjCr+LfkJirkKc2w+t5N9bc/eOlnuCqd63aV4WHjw/+ILXV/Yfc7i0dnb22vs1XgYX
	Xylab9hp99VQV8XqvVSHaPIUox3iNWdE1Y/Ot3/Jw7zjwBYVw1+XpeYb3E6RLrrKeuTxOW+O
	nqIH5V6MnvvyfXUT9mbdKNnx8Ni8y790LAsPRn75u/PFVZbHf/Zv2T23MWU1W4B8Rpnw79Y7
	Ag77HO672tt6RZxbbe7+VMi4cZq6qchV1gTDer0yxWlfeJlmrlViKc5INNRiLipOBADrlnzF
	VwMAAA==
X-CMS-MailID: 20241007170052eucas1p22d6058f74d6c0d0d4e8f4e0371ac8062
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241003161012eucas1p2ab704a8771869e142b024cc95d5ecb5d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241003161012eucas1p2ab704a8771869e142b024cc95d5ecb5d
References: <CGME20241003161012eucas1p2ab704a8771869e142b024cc95d5ecb5d@eucas1p2.samsung.com>
	<20241003161007.3485810-1-m.wilczynski@samsung.com>
	<51b6cee1-d23f-475e-bfe0-979e96e687c6@intel.com>



On 10/7/24 18:09, Adrian Hunter wrote:
> On 3/10/24 19:10, Michal Wilczynski wrote:
>> While working with the T-Head 1520 LicheePi4A SoC, certain conditions
>> arose that allowed me to reproduce a race issue in the sdhci code.
>>
>> To reproduce the bug, you need to enable the sdio1 controller in the
>> device tree file
>> `arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi` as follows:
>>
>> &sdio1 {
>> 	bus-width = <4>;
>> 	max-frequency = <100000000>;
>> 	no-sd;
>> 	no-mmc;
>> 	broken-cd;
>> 	cap-sd-highspeed;
>> 	post-power-on-delay-ms = <50>;
>> 	status = "okay";
>> 	wakeup-source;
>> 	keep-power-in-suspend;
>> };
>>
>> When resetting the SoC using the reset button, the following messages
>> appear in the dmesg log:
>>
>> [    8.164898] mmc2: Got command interrupt 0x00000001 even though no
>> command operation was in progress.
>> [    8.174054] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
>> [    8.180503] mmc2: sdhci: Sys addr:  0x00000000 | Version:  0x00000005
>> [    8.186950] mmc2: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
>> [    8.193395] mmc2: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
>> [    8.199841] mmc2: sdhci: Present:   0x03da0000 | Host ctl: 0x00000000
>> [    8.206287] mmc2: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
>> [    8.212733] mmc2: sdhci: Wake-up:   0x00000000 | Clock:    0x0000decf
>> [    8.219178] mmc2: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
>> [    8.225622] mmc2: sdhci: Int enab:  0x00ff1003 | Sig enab: 0x00ff1003
>> [    8.232068] mmc2: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>> [    8.238513] mmc2: sdhci: Caps:      0x3f69c881 | Caps_1:   0x08008177
>> [    8.244959] mmc2: sdhci: Cmd:       0x00000502 | Max curr: 0x00191919
>> [    8.254115] mmc2: sdhci: Resp[0]:   0x00001009 | Resp[1]:  0x00000000
>> [    8.260561] mmc2: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
>> [    8.267005] mmc2: sdhci: Host ctl2: 0x00001000
>> [    8.271453] mmc2: sdhci: ADMA Err:  0x00000000 | ADMA Ptr:
>> 0x0000000000000000
>> [    8.278594] mmc2: sdhci: ============================================
>>
>> I also enabled some traces to better understand the problem:
>>
>>      kworker/3:1-62      [003] .....     8.163538: mmc_request_start:
>> mmc2: start struct mmc_request[000000000d30cc0c]: cmd_opcode=5
>> cmd_arg=0x0 cmd_flags=0x2e1 cmd_retries=0 stop_opcode=0 stop_arg=0x0
>> stop_flags=0x0 stop_retries=0 sbc_opcode=0 sbc_arg=0x0 sbc_flags=0x0
>> sbc_retires=0 blocks=0 block_size=0 blk_addr=0 data_flags=0x0 tag=0
>> can_retune=0 doing_retune=0 retune_now=0 need_retune=0 hold_retune=1
>> retune_period=0
>>           <idle>-0       [000] d.h2.     8.164816: sdhci_cmd_irq:
>> hw_name=ffe70a0000.mmc quirks=0x2008008 quirks2=0x8 intmask=0x10000
>> intmask_p=0x18000
>>      irq/24-mmc2-96      [000] .....     8.164840: sdhci_thread_irq:
>> msg=
>>      irq/24-mmc2-96      [000] d.h2.     8.164896: sdhci_cmd_irq:
>> hw_name=ffe70a0000.mmc quirks=0x2008008 quirks2=0x8 intmask=0x1
>> intmask_p=0x1
>>      irq/24-mmc2-96      [000] .....     8.285142: mmc_request_done:
>> mmc2: end struct mmc_request[000000000d30cc0c]: cmd_opcode=5
>> cmd_err=-110 cmd_resp=0x0 0x0 0x0 0x0 cmd_retries=0 stop_opcode=0
>> stop_err=0 stop_resp=0x0 0x0 0x0 0x0 stop_retries=0 sbc_opcode=0
>> sbc_err=0 sbc_resp=0x0 0x0 0x0 0x0 sbc_retries=0 bytes_xfered=0
>> data_err=0 tag=0 can_retune=0 doing_retune=0 retune_now=0 need_retune=0
>> hold_retune=1 retune_period=0
>>
>> Here's what happens: the __mmc_start_request function is called with
>> opcode 5. Since the power to the Wi-Fi card, which resides on this SDIO
>> bus, is initially off after the reset, an interrupt SDHCI_INT_TIMEOUT is
>> triggered. Immediately after that, a second interrupt SDHCI_INT_RESPONSE
>> is triggered. Depending on the exact timing, these conditions can
>> trigger the following race problem:
>>
>> 1) The sdhci_cmd_irq top half handles the command as an error. It sets
>>    host->cmd to NULL and host->pending_reset to true.
>> 2) The sdhci_thread_irq bottom half is scheduled next and executes faster
>>    than the second interrupt handler for SDHCI_INT_RESPONSE. It clears
>>    host->pending_reset before the SDHCI_INT_RESPONSE handler runs.
>> 3) The pending interrupt SDHCI_INT_RESPONSE handler gets called, triggering
>>    a code path that prints: "mmc2: Got command interrupt 0x00000001 even
>>    though no command operation was in progress."
>>
>> To solve this issue, we need to clear pending interrupts when resetting
>> host->pending_reset. This ensures that after sdhci_threaded_irq restores
>> interrupts, there are no pending stale interrupts.
>>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>>  drivers/mmc/host/sdhci.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 4b91c9e96635..b91a6076c332 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -3098,6 +3098,10 @@ static bool sdhci_request_done(struct sdhci_host *host)
>>  		sdhci_reset_for(host, REQUEST_ERROR);
>>  
>>  		host->pending_reset = false;
>> +
>> +		/* Clear any pending interrupts after reset */
>> +		sdhci_writel(host, SDHCI_INT_CMD_MASK | SDHCI_INT_DATA_MASK,
>> +			     SDHCI_INT_STATUS);
> 
> According to SDHCI spec, "Software Reset For CMD Line" clears
> "Command Complete" in "Normal Interrupt Status register", so the
> interrupt status should not need to be cleared again.
> 
> Which SDHCI driver is it?
> 

Thank you for your review.

The driver in use is located at drivers/mmc/host/sdhci-of-dwcmshc.c,
and the .compatible string is thead,th1520-dwcmshc.

Based on the specifications, it appears that the specific hardware used in
the LicheePi4A SoC may not be fully compliant with the SDHCI standard.
Therefore, the appropriate solution might be to add additional clearing
code to the th1520_sdhci_reset() function.

>>  	}
>>  
>>  	/*
> 
> 
