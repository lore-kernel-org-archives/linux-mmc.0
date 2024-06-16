Received: from speedy.danman.eu (speedy.danman.eu [46.227.180.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA5511185
	for <linux-mmc@vger.kernel.org>; Sun, 16 Jun 2024 18:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.227.180.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718562859; cv=none; b=eK09EUXoOpMTiF53q+L0Sc4h73ud9Avmz/WDNr10lNs9KiIU3sTd3vwNaE2NBamgzVyhGgYVoiACJAI1xp6r6t7MvW3xmELb7O6n1YrjYQS9j1QY3+/+bz9aQxrTeyrGLi8ZslaUNo72OowvaxZjTTA6inhlzgdAdadraZo5OSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718562859; c=relaxed/simple;
	bh=vIoyZQbDIn9AgwpndawDDzqlTclLiY7NEX3kUWqkbrQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=E1/s2tcuC5vjantl9eMAQm/nnN/Z2W1k7corSFlU79t0MqxzqvW5sK2+cbzS9/8cs8jVIm/Yzuv7GwczUM88iNrhZSR6fD5SbUIg4uqq793mwg9HWsQnKrxYhYySsWZjGpijiiyJKaeOxJEqTUOdxEkNFG/vtftr/8Ib9Q7WHEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danman.eu; spf=pass smtp.mailfrom=danman.eu; arc=none smtp.client-ip=46.227.180.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danman.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danman.eu
Received: from mail.danman.eu (localhost [IPv6:::1])
	by speedy.danman.eu (Postfix) with ESMTPA id 5E962240BB3;
	Sun, 16 Jun 2024 20:25:23 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 16 Jun 2024 20:25:23 +0200
From: Daniel Kucera <linux-mmc@danman.eu>
To: Avri Altman <Avri.Altman@wdc.com>
Cc: linux-mmc@vger.kernel.org
Subject: Re: [PATCH v2] mmc-utils: implemented CMD42 locking/unlocking
In-Reply-To: <DM6PR04MB6575AA37CBBB9993DE881F26FCC32@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240531182517.929498-1-linux-mmc@danman.eu>
 <DM6PR04MB65757FCA620263AF74F120A3FCFB2@DM6PR04MB6575.namprd04.prod.outlook.com>
 <DM6PR04MB6575AA37CBBB9993DE881F26FCC32@DM6PR04MB6575.namprd04.prod.outlook.com>
User-Agent: Roundcube Webmail/1.5.0
Message-ID: <f3f50d420e7ee5bad0c85f8158c391ca@danman.eu>
X-Sender: linux-mmc@danman.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2024-06-15 20:59, Avri Altman wrote:
>> Can the above be eliminated by using parse_bin() instead?
> I guess not - because parse_bin() expects a known sequence which isn't
> the case here.

Yes, I was analyzing it but it doesn't fit the use case very well.

Btw, can you advise how to make the kernel patch merged? Shall I ping 
someone?

> 
> Thanks,
> Avri

Thanks,
D.
