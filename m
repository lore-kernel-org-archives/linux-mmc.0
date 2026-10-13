Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A221A4F85B6
	for <linux-mmc@vger.kernel.org>; Tue, 13 Oct 2026 12:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894465; cv=none; b=CdAnw0+HwHCIndedZvzAfdbiO+r2uWIChonSvNu2n6vOWll/WbcEASNtDcs+9OZargkuakbQamAMzHGOBcU3lztaD25HMqsRjPtOL+K/YClyxpaC4DrCphUzxLtPHBbTflgtkacdo8BDJkKQHOMQJd7XnhrbaTo39xpqgEOBElA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894465; c=relaxed/simple;
	bh=zQ5+4ylMkV7zI54Lss3PN1OlS39taIPE6dxZocdAmZs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GJz4mvrje2JRXY/FsRIDcgWuvOWrBlqHE/A1UGeQnOwOJR2Mjo8fhErazrBmug1CjFzxcelylEbQyTFk7J/sUK49+MCxUXOzOOkbA+RJUPNVgl3ZR/FcWOrBz3qdPL94NLw+lzhqNq5vJCRmq45e4PufP4/37NP7eEtwqIhlXsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcp7xIp1; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcp7xIp1"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c3156e7705cso471165066b.1
        for <linux-mmc@vger.kernel.org>; Tue, 13 Oct 2026 05:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791894462; x=1792499262; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wMfuPHIBKRtt7D2U1S+lSZH4kD0V5/KNbgrrq+UgAl0=;
        b=gcp7xIp1tI1sMQewdEAeo2hHL7l+MJMRTws0nzpYHelV4ZN3hAphmjDWeRPmtIKKlv
         n7s3Hl8TDkVQcCiK5bVaIJUHbAFNioG0jrIlc5IYzhoVHu3qYZqmVzV7Qq1RQpRam9BA
         mg1zTvmr/xcOASUWx2xhz682VNdBidEa+HMVGnjIKOL+Zy0TxWibH4L//oZNynQ7GUER
         oRS57xADN7aN6iar/HND2oR7h7DH4iF2w7sqtkveV0IOPfdmcVOtrDm+GSqHCmM3LmkB
         kyunxhsT6bQEXP8zd3TpjC+2FEHXb8MGgAlRYPeV0Kf53d/ZXamtQQJq0XWnGm1xqqlX
         oqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791894462; x=1792499262;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wMfuPHIBKRtt7D2U1S+lSZH4kD0V5/KNbgrrq+UgAl0=;
        b=yqS2f4mFr09CGRIeINBN48IM9+gH2ag7nHMlAkZNOOy+btmn4kqa/z6kEvfO8DRMsv
         EHZljnTkhrCQI2qlbVaZn8Wp70JmzIvwjLmT7P5ahqjrTWMnJK3/Yu5WnOPDiTIhE2A1
         PNlKwcG5k2WlsP3GIXawJeRTnsH1PSvX54R0sF+/bvXz9B20j4Zh5sAMf5fANmJpUNxG
         8YEsTLI2UvxRs1GpOQl7RAuDWK4WVTAleQogk4WjBlrVxmw5SsMycCx/yIVFZ/FfDe/O
         kc0Icsy6ovM4fnb5TTPNvRclhnmzr8h0Fx9xE+sM64Z55KltbCKYGz/cA64TT3OAtJ5S
         bS4Q==
X-Forwarded-Encrypted: i=1; AKwUvBzA8INdn1YmzIYkzrd6/wO8qkCGPTtYJ2jK4ggBlGxbgiNp871sACcCsH9b41/oGEMhKrjmc6dOJVM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAkQ5ZI/lIOzOMYhzncF66XoZLDKZGTYd7KGQ+OIiWrrwJSc9U
	yh1dxo0bqkEvQNnqZE6b5ZfPjD6OAzIULJfzl6mUgsYIjVC4fsDnLR7G
X-Gm-Gg: AYBFou32Yea04APcGd6ni8xQ2I4/TXfDIruWhQr41LN2K4KDsOTA5k55pbknbAxWlut
	ah69sy2G2wEJ8vPI1VINFd8/N7Ku9KRrUTSG+Ly15rnlMAJJbxaAkr1o5ROuc9rqG0+mpY2RD5c
	AYSD2kKEdMbZIIaM0yDS+2EqCS2BmlfhkKWzTrBLSzSCp/djL2sRUZCDLlILC+8qSmia2QojO20
	4iUSyT1yKh1utVjxdm3hMwqFU5wuUhWLPoh0H6Fj86EnK+HwcuScpS3KOrVQvk3dya9EMBnJxFs
	YepytzD5H2lnj/BB6AKqFqj5T9rvv56vAthHpx6BMqMw1nlUxLo9bEzq7IRwJkz572Mz+gtN+/e
	PN20beHJMB3+64gnsM06ZznA81dtuEjroKVaO1Aaw+S+cco4uYkk8T5rZ6LE1c0Dc3L3wg9dUvb
	GZHDTJhzHYD+e8C1cVXF/ClaQzY/I8AwwKgMbyEdZOx/0OJeI0lzhfgWvkvo8HPz9CByOtkEJaR
	vYag+2SiA==
X-Received: by 2002:a17:907:3d89:b0:c2a:fd39:f23b with SMTP id a640c23a62f3a-c31aa00e119mr1216678266b.24.1791894461702;
        Tue, 13 Oct 2026 05:27:41 -0700 (PDT)
Received: from foxbook (bez186.neoplus.adsl.tpnet.pl. [83.28.37.186])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31d8510ce1sm518041066b.19.2026.10.13.05.27.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Oct 2026 05:27:41 -0700 (PDT)
Date: Tue, 13 Oct 2026 14:27:37 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Sean Rhodes <sean@starlabs.systems>
Cc: Ulf Hansson <ulfh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Ricky Wu
 <ricky_wu@realtek.com>, Lee Jones <lee@kernel.org>, Roger Tseng
 <rogerable@realtek.com>, Dan Carpenter <error27@gmail.com>, Jisheng Zhang
 <jszhang@kernel.org>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] misc: rtsx_usb: avoid USB I/O in runtime
 autosuspend
Message-ID: <20261013142737.7b10a5b0.michal.pecio@gmail.com>
In-Reply-To: <CABtds-3t+ECCPeFShq__iNa9niRAge=WOED4cHtNZAFVw6kPzw@mail.gmail.com>
References: <cover.1783352430.git.sean@starlabs.systems>
	<7acac70a471452a6ccf23b7ccc557f3c3861e0ad.1783352430.git.sean@starlabs.systems>
	<20261005103011.03175826.michal.pecio@gmail.com>
	<CABtds-3t+ECCPeFShq__iNa9niRAge=WOED4cHtNZAFVw6kPzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 22:34:14 +0100, Sean Rhodes wrote:
> > How is the driver supposed to detect card insertion after the last
> > poll but before the reader goes to suspend and can issue remote
> > wakeup?
> 
> The reader uses remote wake; what hardware are you testing on?

I have a card reader with RTS5178 and a simple SD slot, no tray.

Remote wake doesn't work when the reader is not suspended, so before
suspending we used to check one last time that no new card has been
inserted. This made sense.

Any delay between the last time the reader is polled (by anyone, for
any reason) and actually placed in suspend is a time when a new card
can be inserted and completely undetected, forever.

Regards,
Michal
