Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20292080C5
	for <linux-mmc@vger.kernel.org>; Thu,  6 Mar 2025 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741252581; cv=none; b=P0rexdx+UddGbMhO4mYErOkC/XfGVfVcEoOrsTXWmJoNgKb4WbHdzWULVFCnAnHJxtMoC64qa3VUbVq3E9oVA+myhFFqNIFHAaK3KubIxFuS8ffDNFknCEf3g65f6415avexlSHe2HFLLWg1zAtC+AVJ0XjIWJ3Xc7SAhp1RyGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741252581; c=relaxed/simple;
	bh=ez7fXHbcJGYq2SnIqFCwWZQdodHUT0BjextfpLy9HLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uR1d8yUwBZvZUebESeakNi5CRlcrNwYzn0dd+uhcFPuT1mUcIjc3nWPQRlSd8AMfUCGkjQRuSzm1uyoSe+QQWS8eYKhbGZU9N8hAP+31Zt37C2NBjQ0hO8wWbnHfOUClO9t1IHof2011ydAx6uGCCUB+Ssdsd3MyFmIECy1XaiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=odWYKnCV; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="odWYKnCV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1741252570;
 bh=U6wIo8sTMBr3RbRnbR8Rzc/ze/1O+F9622aQgZcZWCQ=;
 b=odWYKnCVGaDPms2yTTGriGNTt27y6M/lLAyJTmNvD+xpvmcC63VS49U0KvMiCcArwIoOxVRHr
 jM4XbYdz14+0p48RCGTwEWHSWZvJ9tg9GtyLzFGG6p7Yz+MQUGDrrsgSDNKn6pC0XYUeZHwJluN
 pCKNDt+NItX+LhKgRgsvPSkhM+eo+OSgc+PNLwq0PeeO2zayn5axD37tSnbts6mwciooNkvEWtB
 4ndSk1mTisFVNUE4QHbrMpBLcKnxrTQsLPnlQUwSSH2HAKjkCFMEmOMA2oUTjwk4kUu6X1nCigj
 sF03y5g3XjnbQUqvK9WRgIBWyCgOCfSqK7U5m6q30yZg==
X-Forward-Email-ID: 67c967d67c40f20919024cb4
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <ccd8be6a-c8d4-407b-906a-e4788a365775@kwiboo.se>
Date: Thu, 6 Mar 2025 10:16:00 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] rockchip: Add support for onboard eMMC on Radxa E20C
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-rockchip@lists.infradead.org
References: <20250305214108.1327208-1-jonas@kwiboo.se>
 <20250306090001.113127-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250306090001.113127-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Chukun,

On 2025-03-06 10:00, Chukun Pan wrote:
> Hi,
> 
>> Driver changes to use different delay and tap num is needed to be able
>> to support HS400 modes, something for a future series. With this HS200
>> mode should work:
> 
> I have tried HS200 mode on other rk3528 boards and it works fine,
> so can we enable HS200 mode for Radxa E20C first?

The host controller already report the HS200 mode, and as shown in cover
letter HS200 mode is being enabled/used with this series.

However, the driver must use different tap/delay num for HS400(ES) modes.
At top of [1] there is a commit that changes to use same tap/delay num
as vendor kernel and what I have tested worked in U-Boot. That commit
needs to be re-worked before it is ready. Also see [2] for pending work
before I plan to complete before moving on to the dwcmshc driver.

[1] https://github.com/Kwiboo/linux-rockchip/commits/next-20250227-rk3528-rk3506/
[2] https://github.com/Kwiboo/linux-rockchip/commits/next-20250305-rk3528/

Regards,
Jonas

> 
> Thanks,
> Chukun
> 

