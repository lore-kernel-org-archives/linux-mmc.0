Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4888628FFFB;
	Fri, 23 Jan 2026 14:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769177269; cv=none; b=GxHb6sYC3jwvDirmZMTySMgoKmUOqOI7sYM1SGOIzOyTNLxZbHB+L2j8rXHvdI5qVQsNez8EIwbbO99voMJh18zel/OQkP/RFBwiRxM10ZiOiT34ZYkb85A2yybAiv2vqWGGavqPjQ3YX68xPij8FV1GWZB+c4wnmlaeaZjlETw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769177269; c=relaxed/simple;
	bh=UjxLxOv6k/KKY/E5QC+AXvm93An86ypnEiXwu8GVUZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJDrZPWcPRsfNLI9klgvv0KYlsPrqWb1LLbmJnuEXrYM0uFvJaLRGrYKHue47oILODBW+xnRwhgvErj2qPW/x/+7roI3r997yv+H6TboPCkjubE6Ze7LJNUFdZqEpGNuqtCJaaiEm1kQqml8c/UsA8a+K7ReYYTw+vFlfreO3ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=TQsEYBFT; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="TQsEYBFT"
Received: from mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:9a4b:0:640:e388:0])
	by forward500d.mail.yandex.net (Yandex) with ESMTPS id E1AB5815B5;
	Fri, 23 Jan 2026 17:02:29 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id R2evPXBGAuQ0-B2E7EIxr;
	Fri, 23 Jan 2026 17:02:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1769176949;
	bh=iVP9mAjTPWUl2CV3OnCBzVglVAJt10vV23uAwIopzfo=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=TQsEYBFT4JRWe7u/2F8F49oqiowLRPc+BYMIitzfSVCEsyRf1hQR7uGqodT+QT14Y
	 SVADSS9ih/rBTREDXMUcE6HhFWM2jsHUL1BrlnnK7C9IJl6GCs+qhjqboCKB00hniV
	 e8NgQxhWTKq4SVwvO6SRgZ5jh35dMjmd5soYHgj0=
Authentication-Results: mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
Message-ID: <57e07c9b-b8fe-49b6-9ad5-ef6ba0e763c7@sezginduran.net>
Date: Fri, 23 Jan 2026 17:02:27 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: pxamci: do not complete requests under host spinlock
Content-Language: tr
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260110144432.176015-1-ahmet@sezginduran.net>
 <CAPDyKFq0a9VjRFQsk=kU63ULwHtZqmq5ocBFj5=GfHhBo8F5DA@mail.gmail.com>
 <CAPDyKFrVLmZ=T3VuFmKn=PiVbv65NEhCsQNDV3YyFwp=Uz=EyQ@mail.gmail.com>
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
In-Reply-To: <CAPDyKFrVLmZ=T3VuFmKn=PiVbv65NEhCsQNDV3YyFwp=Uz=EyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/26 2:58 PM, Ulf Hansson wrote:

 > I was too quick here. Is this really a problem that you have tested or
 > just something that you believe is the right thing to do?

The latter. I thought this could be an issue and tried to handle it 
defensively.

 > Other drivers are holding spinlocks too when they call the mmc core to
 > complete requests. In principle it depends on how the host implements
 > locking, whether it's fine or not. For pxamci, I think it should be
 > fine to keep the lock held as the core will only kick a completion
 > variable in this case.
 >
 > That said, I am going to drop this

Got it, thanks for the clarification.

Regards,

Ahmet Sezgin Duran
