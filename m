Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72F521CC62
	for <linux-mmc@vger.kernel.org>; Thu, 26 Jun 2025 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750932628; cv=none; b=oqSmqmSlvo6ERBLhQddeNrei0hpokQPGYPK3cqG7+eLEVLr+Tqw7oxU0z+Z+JL077tejlbdJ5K1R+H+zzZ8SR3aOWt8QUNQpN1lPXDwzyoRNuE6Pk7cIbScr/Fm2XXBKP1yYeAP4rbr7ZqjCDjm1u+r4l0wDnGHHnG2NWoMLQ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750932628; c=relaxed/simple;
	bh=mTReFY4X9Z9dRGyijPTvB56XprW2ok8QiEzlUtOLIt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=df6gMfY4RMGzP57h3AXxKV/3u1ohZA12bM5yKmrMsPcmQOmMvknRVPdr4j0KA/LiBI8eQdZr1HGHsejsXNGO7zyMT31EX8EeBrx0lPG+Prk+LlYHJmHVN9zPsj31LDOgeeGNtMl/DAXz+On7PS28W6LP+Q9jpnJtARj0anmpXzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=OYO+hwoT; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="OYO+hwoT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1750932622; x=1751537422; i=markus.elfring@web.de;
	bh=mTReFY4X9Z9dRGyijPTvB56XprW2ok8QiEzlUtOLIt4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OYO+hwoTBJS7wNRX9HN4PZdT89JCkEO4nlNJ5ow9SG+gt/xvn4Rk2G5Ksitq8jhS
	 mQxeOIMUQJuCF4vCT+hGckDNATsfvQn2gyRaHq1Z4iClMH/IXyggK3pqWctIJR6Cu
	 z8GDCnrNo86UYMv++w1VdvQgqjKl+IFafspz8kKV20dhve3LbK8hDpxmsWex7JCW1
	 eJ8iIF25zdRG9aFgDFN1eYBtNYgy5KDzng4Y8UJpBDHAS4HQ5Yy5EtCNymDRjYUDH
	 R81QocuBFGCi8zp8Eh6PN0I2unAlvWh0+Y8mHHey4mC9oxf7GDYp3NQRse8wVIoWj
	 EGohlius/XLD2aUXxQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.202]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MwR4R-1ulA0u49W1-010Xc9; Thu, 26
 Jun 2025 12:10:22 +0200
Message-ID: <b68f945f-7f86-4f8c-9fac-5b115a83d3c6@web.de>
Date: Thu, 26 Jun 2025 12:10:20 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mmc-utils: Completion of error handling
To: Avri Altman <Avri.Altman@sandisk.com>, linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>
References: <f1bcf11f-817d-4a57-8084-fd1e1e5c5140@web.de>
 <PH7PR16MB619651DAF605B93FE8E839A7E57AA@PH7PR16MB6196.namprd16.prod.outlook.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <PH7PR16MB619651DAF605B93FE8E839A7E57AA@PH7PR16MB6196.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:7VSbOhqtRgw7n0EhiJGHuxQq/y7mEbF5xh12W9FilBT8BjpjTzn
 t/bNfx/JQQMlC4mUAAV6HQWP6rSUgAHUnFlRotrsl2AUmMJqE3VYc8Dd9qkBW0sQWjfWSR/
 PvodzatCgFfXUwFoaA5sUodRk6fxXKK705BBCogGPjyPiLh6+OBInBVsrcNq0aLWPtDDI+z
 ZDHGbHsceIiW4/8/DSUtA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X9n44bmsNrw=;1c2DWCpWi9QF6qUzKZJnf8CP9/z
 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
 WXFyk8p4/+g==

>> I have taken also another look at implementation details.
> Also? I am lacking some context here.

I am just another code reviewer here.


>> Thus I have noticed that the error detection is incomplete so far.

Various source code analysis tools can point remaining open issues out.


>> How do you think about to add more error handling for return values from
>> functions like printf() (for example)?
>> https://git.kernel.org/pub/scm/utils/mmc/mmc-
>> utils.git/tree/mmc.c?h=v1.0#n515
> You are most welcome to send your patches over.

Several software design options can be clarified accordingly.


> We can discuss your ideas over the code.
How will chances evolve to benefit any more also from the means of
aspect-oriented software development?
https://en.wikipedia.org/wiki/Aspect-oriented_programming

Regards,
Markus
