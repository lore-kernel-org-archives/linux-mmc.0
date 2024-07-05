Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F5C1758D
	for <linux-mmc@vger.kernel.org>; Fri,  5 Jul 2024 06:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720161914; cv=none; b=HBr12ikwt1nIznl2ZcOeXWHsdCedGYUFWdizrvQhAO/Zp+I2l7Z+Fyyj3rYRfY6SxTbOkeRJnQQLL6+jH0tOi304/RUmbxlY9J5/I2hnUCW8VfpngpAyz5Y0UHjuz372TRac/z7fctLG0FBK+CvDfMXyol0ksH+AfK5MUG+JBXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720161914; c=relaxed/simple;
	bh=IhnKrOA3nn2uuXOCOairsFb4QDe1aUX2Np2DBVQalsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bNncTA9qoiamghlQzoTsLWHdB/mkocrYxWuqFjc8X0kkj145POKfO+OrpG+729P16EV6El3T4ckXX5JppF2qjJoTlall+h9WFw7qCjPGVBbOiaCw7twMTvUq0hB7sdUZKCddUnYW1jlVbdnw+yJiifHXVaRTfC/139nfJ9V5Zsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Pq2PGOxN; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Pq2PGOxN"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52e9d61a4b4so89305e87.3
        for <linux-mmc@vger.kernel.org>; Thu, 04 Jul 2024 23:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1720161910; x=1720766710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RJFwEEs4mSuW4ndjeE4fUMXShMedXXb++Zc5jeXPEB8=;
        b=Pq2PGOxN/I2Wj1xl3Bml6vsctG0blrS0rCLLoZQqLwz+/azFK9Qo5zyPgR8v+KTk8/
         qGpepLrf6kVoAkiPrp2LnGvPLgWYGCc681UOzYH41hNFjv03KlPAj0QmlwkY4lQARH47
         pka/EIOKMPgZfV/xteWCS9aPzmuCGYfA/Ba5PL2DDlI23qQjYo5FJT+SBofrHclQ0Czr
         0RqAObhhIk1ej+vAqlsS3nbB35Uj02G6O4zUpH6iGHSiB2pRSHeHVtJB5RxlobrgwxSB
         +7xT0xtar/b2meUIiftUqMJeL7R9UwDIa9bPLFM1yQn661vFQ1CcWnpDysretC2HmhPi
         MXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720161910; x=1720766710;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJFwEEs4mSuW4ndjeE4fUMXShMedXXb++Zc5jeXPEB8=;
        b=ZHRrcQ0GAD48/InLLt/Fwn2MljSNnmxsR7oxSwg0L5wm+zCX03liPc6o9IQ8jUX8z0
         lbdJ3Pd6VczN0PpXruqtwukhSEKpl3bXTdTVC8T7Y30pV+ZmALOOroIv0jhMU1VhCtXc
         G/nzMwX7cA5Jjdu58/0golQr7BhQzl3dw6Q39piO7WhgLBlY0kXZjqXYCzttIHb0UD9o
         9vlNsUzN856pUoeddAMHO4eLhAznlW5r7ok30xf6+qwnvFvZpdnbWw5b0mjWBendW7VE
         tkP9WO5kqqJU6ZD9X8vkXgeoAFLoz5w9+DFNDsysG4MugHLsfbrMgQ1GWdJrDJBFEeDx
         CeZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/Zcw9U+pzIgFOThW4MTWi1SH4WZjOjBWg60mhMvmOkRWvmFbxFwqGXfucEZBJSB7qGwocyXVtfoInHyXIv6ZIDMlBnuRcU7Hs
X-Gm-Message-State: AOJu0YyiF8rssUiAmUYRYxACxQvz3W34T1BSOlEj9G36MKcCwSNcmFeY
	MKZKdP1QNx9U6xxiST0GuqrdOZ87L21AomHwuwYyH5ChNrYE5J7/oKeFleC5YhQQpAShf9HwoFH
	wmeXc+Xn6
X-Google-Smtp-Source: AGHT+IFGzxQf1NVbK6llMn1tg49wKbuLEtrSOCtYJsBpnxpYrlp0VXtIH5fwqCHfDD+hE7dchwcseg==
X-Received: by 2002:ac2:4115:0:b0:52c:6b51:2e9a with SMTP id 2adb3069b0e04-52ea062998dmr2337124e87.2.1720161910248;
        Thu, 04 Jul 2024 23:45:10 -0700 (PDT)
Received: from [192.168.1.68] (87-52-80-167-dynamic.dk.customer.tdc.net. [87.52.80.167])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7e4deacfsm2471448e87.14.2024.07.04.23.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 23:45:09 -0700 (PDT)
Message-ID: <b4940767-b5ba-477d-98c6-a9671b2bc290@kernel.dk>
Date: Fri, 5 Jul 2024 00:45:08 -0600
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: make secure erase and write zeroes ioctls interruptible as well
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Conrad Meyer <conradmeyer@meta.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20240701165219.1571322-1-hch@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240701165219.1571322-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/24 10:51 AM, Christoph Hellwig wrote:
> Hi all,
> 
> Following discard in the last merge window, this series also makes secure
> erase and discard interruptible by fatal signals.
> 
> The secure erase side is a straight port of the discard support.
> Unfortunately I don't have a way to test it, so I'm adding the eMMC
> maintainer as that is where the support originated so maybe they can
> give it a spin?  (just do a blkdiscard -f -s /dev/<dev> and then Ctrl+C)

In lieu of that, qemu does support mmc it looks like?

Wanted to get this queued up, but would probably be best to have
that tested first.

-- 
Jens Axboe


