Received: from butterfly.birch.relay.mailchannels.net (butterfly.birch.relay.mailchannels.net [23.83.209.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5023815C0;
	Mon, 30 Mar 2026 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863428; cv=pass; b=GCmZAlJPcrC7/OqV0f99ZB3X+++nCvTDjYgXfFBPAdY+gLr2O1DC58syJKH9qrF0JAPjFyWyN/RijV6Q1b8BwT/xblJTZgCCFjOguLQiQYaqCBgMQ9/2KEHFbtZLoNxdIpNMIRxchjVANDDf9uinm0khEXs6j1+GDoV4wnfw/fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863428; c=relaxed/simple;
	bh=gk2yYfqi9gWLyHWm0NhbfKgNvyZrHE//hIikpP5iXEs=;
	h=Message-ID:MIME-Version:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:Date; b=dX3a214R2ELuvvfhMlCBOufSvFRVdMx51oqWgJbXnlQS9plQGPFljIzBrJLtPKKhNfC5irsspvRrIsQ03oAEtOpdr1xfJPwfmK9z8EYpw+4q6aKifE9EWMwW0EuT2qyDaIf6nLlUd+Y06k11shHBYYAlyE19QMSKudWUtC8fuGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com; spf=pass smtp.mailfrom=rootcommit.com; dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b=EsU/fRpB; arc=pass smtp.client-ip=23.83.209.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rootcommit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b="EsU/fRpB"
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id F405A8A2DE6;
	Mon, 30 Mar 2026 09:19:53 +0000 (UTC)
Received: from de-fra-smtpout1.hostinger.io (100-122-165-184.trex-nlb.outbound.svc.cluster.local [100.122.165.184])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id B80098A2893;
	Mon, 30 Mar 2026 09:19:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1774862393;
	b=Ojv4nw/nJ2FlBl7DACVPMLFpgUl3ZMZFtXPXJTa59gkUXwtQXcgS9PoGTpYpVwXiOGgLM7
	PYbLDeijs24UXvtuW4CUM0x1EUkgMjSlGe4u7VFS1oN8YV+Yr0klPUS6BGyErfbP113Wdc
	011i7GqZwVAu1wbTJfzpQXkLm9nhEFJei2m1bGyaZTBcBdtljZWlWjSZY3JKDTUx/0MoCz
	+Ackpwny/+cJZ4qH93UVjY82cJ4xK8PRYfdg7KhLNuOun/aQaWXM67l4/UkLNC0Qtg1RVi
	hOec+jsFzcqm1op9Jx5kJdmnAki6FVNZcZ+48ry7icPb7eOPvFu1Y/SlsQj0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1774862393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=xn8ytO1cIDErWyKt0Aui97W2ei8LosNrt38/Xqsonzc=;
	b=RUp95xcfeT5Z9+ljYt05kwCrTwtBCXfTEkHyH8dGF/ILePW0DugnsFy8Ve6112GsSk9mj+
	4cKXWTvOl9A4ykYVZl00wIg8Tmy69Yj5HKFKsIVguKHvR3Jt1Hc/hhF4PPnyk6LuqByZ46
	i7TiugtxnN1Z3eUV4BfMkcGYzL1hvDcwh5cp5tntzcJ6Q2Srihb4KcxGAkX+WfPEF22W8g
	W/GrtYb4HzdorcQBl9ymFp6v8SpfPYvk2mDGfQ8Aj49j3DHqvGpeKN3LFZM93udYIl9H3m
	zSnAS4ivnT+LI5dPlFL50pW4J/V+D6YYG1LXnFlhpBfG2ukFdL2L6oSpQ5L2/w==
ARC-Authentication-Results: i=1;
	rspamd-7f98bb5847-j2s98;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId:
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Cooperative-Gusty: 181656a42e71f35d_1774862393775_183899981
X-MC-Loop-Signature: 1774862393774:2731040531
X-MC-Ingress-Time: 1774862393774
Received: from de-fra-smtpout1.hostinger.io (de-fra-smtpout1.hostinger.io
 [148.222.55.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.122.165.184 (trex/7.1.5);
	Mon, 30 Mar 2026 09:19:53 +0000
Received: from [IPV6:2001:861:4450:d360:dd36:70ba:d0ec:421] (unknown [IPv6:2001:861:4450:d360:dd36:70ba:d0ec:421])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4fkm0z1Vp2z3x5h;
	Mon, 30 Mar 2026 09:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1774862388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xn8ytO1cIDErWyKt0Aui97W2ei8LosNrt38/Xqsonzc=;
	b=EsU/fRpB4bMNr1MbcjiJcFxFaQrImPdZP8Esq/9JO/3pYYnkpDwzzei3vtoSLw4TGqJ9Q+
	TNmzMMMjaO57rvtNuIeBP58jf00XaB0KWEpAusBlaZBmzNEAzfQsR5LYAusd9T76XwYYYF
	DgAn+A5DSahBLtvY4N6wz/MWQor5m4DCe4Y9rUN2Rr23LyUhJoNvI1cv4mQ9GZQMgvtgbW
	9+ylL8QYrtLYLOWLNwiUWCEReIJiKHjsiUq3B/9DiwyGpCQEVOr4kUAVQFiYT80CH31YR9
	1wNxXYV5rejUx0twMXT9FiqHulqymKbIrDFsa4NYodEO5fakub07vMFEWnQiwQ==
Message-ID: <17eb09e8-280d-4a41-8a8c-8c8287160e97@rootcommit.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@rootcommit.com,
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 Anand Moon <linux.amoon@gmail.com>, Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v5 0/9] riscv: spacemit: enable SD card support with UHS
 modes for OrangePi RV2
To: Iker Pedrosa <ikerpedrosam@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Yixun Lan <dlan@kernel.org>
References: <20260330-orangepi-sd-card-uhs-v5-0-bd853604322d@gmail.com>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
In-Reply-To: <20260330-orangepi-sd-card-uhs-v5-0-bd853604322d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 30 Mar 2026 09:19:47 +0000 (UTC)
X-CM-Envelope: MS4xfAFrx90go/FDvQ2bCCAciVHZL0elbEQjsnIdsRspr6lsybI6rwV23lYlEa2ApzbvkTfe89o15JrIn57IsD7safNPyhyROCHNc3oWDPM8tqByr5qxkPCt N3cQlUyVDJxYfM80eMvfYbsJ1FGwCJ7ejYjJAkAoFJA7FC25rvWdm0IIeAdFGpq8m14+p6O4Eim/8vOdn1M/WK+43lQmNsAlNaknEzm4mRBa9zn/INJ/1PmR VPkeWM0QNjDPNRY8AMEMY9+GQWWf3lUZ+6vWTOuC+R2evMO4JyXUTxNKoKaWeYpo5WGW81yfsiYOYV7lOTGaButPF7e+/zBFx8TbbNu870v4U3d0NCp0ca9j O8LPNwbs9O59fhMxe4CElqmqn7lj69GmTatAWistWMsC1R3PDJYXi7LS3ARNv58JmfSuxhh3Q+rhnnpAiRwwEA8upv3oUsyya3S3/N/J3z5yz29NFy8Tkiyv D4++CwJMR7mJY0sQETdD2XzKvDgfm+q/NU6hO1Tt8B/L039PqEXVVBj5imzVGsoVwvCsOEiY0g5Z9PlfM8XiZXtjXrLuNxvCqor0lrfF2vQJyj0rAnDHHvIH vpTwCGah5jhet9ix3dmQt7FQMl3haN9C12FhnU+3CrFySGdgv6boOmxRgrG4Kw+RfkXpg7Wl+ycoNpH+uPFmhTbFseqWkfKhK9h8CbZsgDxG1ce8yLIJyamv GVZbdVU2Sgm9NifCORf6pVE0vGKKTtPu9AYanBW2z9D943JQovtJOeVZNZCCHAoVritoDEmWW83RPfjUQNWGE3Xp4ir6KWSQsj7xyjZa/+mey9Kxo+M7Jq3B UgbmtygCKATLhIeqPzrji1a+AX7iEzoyDo912b0lJTeZPw2NkIl4x+UFvKWnGUWiVGIHKZHo9/n1PBdt3dLX1A2sPdi7l2OsXhu9/NS41ehwK4/qwaX7fPS+ +ecuYw==
X-CM-Analysis: v=2.4 cv=ALriHGRn c=1 sm=1 tr=0 ts=69ca4033 a=UGNOvlGp38Csz17LMCzH0g==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=d70CFdQeAAAA:8 a=np_wIC4uXEsaGhWusoMA:9 a=QEXdDO2ut3YA:10 a=NcxpMcIZDGm-g932nG_k:22
X-AuthUser: michael.opdenacker@rootcommit.com

Hi Iker

On 3/30/26 10:38 AM, Iker Pedrosa wrote:
> This series enables complete SD card support for the Spacemit K1-based
> OrangePi RV2 board, including UHS (Ultra High Speed) modes for
> high-performance SD card operation.
>
> Background
>
> The Spacemit K1 SoC includes an SDHCI controller capable of supporting
> SD cards up to UHS-I speeds (SDR104 at 208MHz). However, mainline
> currently lacks basic SD controller configuration, SDHCI driver
> enhancements for voltage switching and tuning, and power management
> infrastructure.
>
> Implementation
>
> The series enables SD card support through coordinated layers:
>
> - Hardware infrastructure (patches 1-2): Device tree bindings for voltage
> switching hardware and essential clock infrastructure.
> - SDHCI driver enhancements (patches 3-7): Regulator framework
> integration, pinctrl state switching for voltage domains, AIB register
> programming, and comprehensive SDR tuning support for reliable UHS
> operation.
> - SoC and board integration (patches 8-10): Complete K1 SoC controller
> definitions, PMIC power infrastructure, and OrangePi RV2 board enablement
> with full UHS support.
>
> This transforms the OrangePi RV2 from having no SD card support to full
> UHS-I capability, enabling high-performance storage up to 208MHz.
>
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
> Changes in v5:
> - Document optional pinctrl-names property supporting "default" and
>    "state_uhs" pinctrl states for coordinating pin configuration changes
>    during UHS-I voltage switching.
> - Link to v4: https://lore.kernel.org/r/20260323-orangepi-sd-card-uhs-v4-0-567c9775fd0e@gmail.com


Thanks for the update!
Successfully tested on OrangePi RV2 (on top of mmc-next... doesn't work 
on top of master).

Tested-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>

I'm excited to have this feature in the next kernel.
Cheers
Michael.

-- 
Root Commit
Embedded Linux Training and Consulting
https://rootcommit.com

