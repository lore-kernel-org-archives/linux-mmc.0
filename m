Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795481226;
	b=kwf64acy3auRL5lNCsfYwOHGCFIXQigGLoFLZXeWbKj1eMu51z26LUKnwouFnnu3WJCL
	 KOdvrXK5HDvh5GhAkiwp2B6TCvKdsh3UIQbENyHIsglrSlRRELPV6mwc7U78g6896vEyf
	 HQ4ipvBDuMnzDH8/55Y4yrPofsNcl927M80QSB0dSZd8SHnoxNL08unKNtd2pmXvEFR4O
	 Urnb6Mpqz/yEgKubZqDJcYRj6PUgmcTDmc3PKew+3I+8v4X+C5O9CoRsDRtxzmQhAHYRK
	 K26Hp2JFP19LF2raE9js9/M4ZyjvNdtnZF8cu6p27cjn30r4x1WxnaoWGFbsQ2BJIHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795481226;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=hfDkcdScjmR5OnQwyx+CpjuQq1u0r+eD4cqfOWBR8QE=;
	b=FdDiD8xp8yFdY3yxTjiWNyL+i36D86DQRN18cmVL/IYHvdQEMtkf25YVyR5LvS9CZa01
	 RuTruE3hKbtDkTmlDsSC7IKS34hvZceD+eUWXUVPBsNDBdPb7kbz3J11TTByR2+lqxziO
	 1NvfyKUwDMZVjNyzZiSlj/5alxXzXuXmo41z1YdvE+38h38IAPrJ2gipwv1B1wO7HS/Ed
	 LZ4fRaHuY9LAY9ZBH1dvUQsMNC9DcxVls/Mnf/u+PSnGOK19tTuxlPLijChlc46M0JaKj
	 gyzkrVcuWuq5qKGaTYQBPlTGBcE2YSVWRZVQ3NDhcxWgsxeTMZmaa6Woy0PSrVMeIHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YHZQBJ2B;
	arc=none smtp.remote-ip=95.215.58.131
Received: from mta1.migadu.com (out-131.mta1.migadu.com [95.215.58.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FD2606A31E
	for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2026 00:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04FD2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YHZQBJ2B
X-Envelope-To: linux-mmc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Fyp8l6hfFUyYTD25zBLjTNsYVAuS307sWVF/ZXXhM68=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795481223; v=1; x=1796086023;
 b=YHZQBJ2B4OnRpgHRTKuX43+D6otYMSD57MWSw+kpv1VJzhWLmCET//wcMKL4Cf6L82AQBkRX
 pLD4/nkPoS3XS2uu+VJ19rrrBfNWDb60hvSnpvAAH0+lP3pN39HowaJtVZ+aHY1iiGYqPMXEYce
 1Pw3Qvi6RpNg6lJORToDRIko=
X-Envelope-To: linux-mmc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4e2199bc710f91b8;
	Tue, 24 Nov 2026 00:47:02 +0000
X-Mizu-Trace-ID: 4e2199bc710f91b8
X-Migadu-Flow: FLOW_OUT
Message-ID: <5b7318ff-b41e-45f6-8127-d42eab0dcb67@linux.dev>
Date: Tue, 24 Nov 2026 08:46:54 +0800
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
Cc: shawn.lin@linux.dev, Ulf Hansson <ulfh@kernel.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mmc: dw_mmc: add central watchdog and convert CTO
 onto it
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Shawn Lin <shawn.lin@rock-chips.com>
References: <1787817486-137277-1-git-send-email-shawn.lin@rock-chips.com>
 <1787817486-137277-2-git-send-email-shawn.lin@rock-chips.com>
 <awRdY6Xw5scc5V7-@venus>
From: Shawn Lin <shawn.lin@linux.dev>
In-Reply-To: <awRdY6Xw5scc5V7-@venus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sebastian

在 2026/11/23 星期一 23:57, Sebastian Reichel 写道:
> Hello Shawn,
> 
> On Thu, Aug 27, 2026 at 03:58:03PM +0800, Shawn Lin wrote:
>> +	if (host->wd_events == DW_MCI_WD_DATA_EVENTS) {
>> +		dev_warn(host->dev,
>> +			 "Data timeout, state %d\n", host->state);
> 
> This new warning is now printed during boot on RK3588 and RK3576
> (the other message from here are printed at info level):
> 
> Sige 5 (RK3576):
> [   17.801623] mmc_host mmc2: Bus speed = 198000000Hz (req 200000000Hz, actual 198000000HZ div = 0)
> [   17.820103] dwmmc_rockchip 2a320000.mmc: Data timeout, state 3
> [   17.853679] dwmmc_rockchip 2a320000.mmc: Data timeout, state 3
> [   17.854003] dwmmc_rockchip 2a320000.mmc: Successfully tuned phase to 228
> 
> Rock 5B (RK3588):
> [    3.956249] mmc_host mmc1: Bus speed = 198000000Hz (req 200000000Hz, actual 198000000HZ div = 0)
> [    4.049033] dwmmc_rockchip fe2c0000.mmc: Data timeout, state 3
> [    4.086338] dwmmc_rockchip fe2c0000.mmc: Data timeout, state 3
> [    4.093284] dwmmc_rockchip fe2c0000.mmc: Successfully tuned phase to 102
> 

This's a normal case on Rockchip platform that no interrupt happens
during tuning. Because the driver is seeking valid sample phases,
however, some phases could make the controller hung. So watchdog fires
here. Keeping it as dev_warn() only adds noise to every boot.
Alternatively we could downgrade the message to dev_dbg().

> Greetings,
> 
> -- Sebastian

