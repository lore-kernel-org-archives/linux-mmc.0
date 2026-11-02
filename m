Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793586428;
	b=C9DHVhKOkxw5Skc0pfNtMZXHNRZbPO8UKnjxPE++O7l+Yefaqje/QAHKIbnGd6v20A3b
	 rHYTQ1e5IIylw7KVKlOzhoAzSBp7BPnGJ21KmbU5keVHI7GX1WcZdiLenoFjkZBX/yCdq
	 kyDWAuMW9arjVw1SXCQu71l6gdbGMwO+dbY24pJXY6RkbtsIz7mpM5mF5odX3P6T1u3EZ
	 xmdaXpzZcW1XMQB9Xt8Kn0uF1idnmEYJg2vmUu/Lf6+wGBTigtmHLMHkt5pNeG9Sw9oF+
	 X+o3TFgPnJ2TYRqQMCF8j4mU4PT2rgcSOqVCuldfHSbJGD+EaYifOSDHSYiRv56zktA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793586428;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=GZEW/MmY82jQQYdO3E3Xfw7aPj7RpvhSNTPlFqAChjs=;
	b=RAp1sDOpNZ0nGXb/OcC0DDYSDccWp2qGEnaO6GI7fD07A0TE1QEtUksBCKcj05tcPFhc
	 xemXjOhJV3VgZqWf8qcxmJdyb8TFlIgnG61UPrcq3+vg41hBMfIotYexGTc4PqYCahVh3
	 aHYtv3h7mMmb96etekS1DAF0EVwBs/IvYUwvPOJXpWhnFDuA995Y5j0ZmoPJTVJhzf+Sm
	 ZeUQOoPra4uuQs9ysH3U7VOyaZuJeqmgIUM1hf8pXY3kEyoMQ/6+kJCfEK2rHVHwXh6nY
	 B5gMbJ6l4yYuZ15+wEyriJjV/FZgicjIk8xFE48h1RimEX/YlO7TRoAhTL6k+HSG/1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eqpmrxFh;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF04C606A326
	for <linux-mmc@vger.kernel.org>; Mon,  2 Nov 2026 02:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF04C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eqpmrxFh
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e95bd1c14cso22686275ad.2
        for <linux-mmc@vger.kernel.org>; Sun, 01 Nov 2026 18:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793586427; x=1794191227; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GZEW/MmY82jQQYdO3E3Xfw7aPj7RpvhSNTPlFqAChjs=;
        b=eqpmrxFh5fkChLzNWZQS1veije0e4rlHljA6UhV6PYnc95OjyAVS6xm5LJ+5S4Eo80
         tDlMR5m+xYm1kbAbz+KwPMdK7M+xyJohJ5XefVZOegpKSJ2V9hHZ1kl4qElLRHaXf0kd
         8pjOPWHpSxYZwBuXfhZKclK2fOu/+cJYWLuAztxONmd8xFMLw8qifkawkh9xfqkA2WhV
         jsZ56isTwKkJuXF9gAoYTpYKkYFZ1rD7dYIaL6cgA6JFNoRH05UUY0QBlMAQJ4DBwRqX
         FpBchyp1eshIo5gniChmkrcO/mPGrnUh8TJ/ipUa+xE5sayahW9vskMlEaUw1oKmCGLQ
         dQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793586427; x=1794191227;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GZEW/MmY82jQQYdO3E3Xfw7aPj7RpvhSNTPlFqAChjs=;
        b=ZRODSWSt2tNtXmlXwnKa8awaTVqTiD6e2+kBIwXa0qkVG3Vm+FAnhn62D5ce//L1qv
         9waWSr6HkGHmJBUK1SUDk0ZCai9lDp1tbYbtUYn8PzzECGLjH1RBriKA2V3f5A4krqCs
         HFMKj0k2qpIj+A55Xm+tdIJR5M5GGWJGbt9ToSGnEIx8aLd/hze1XrOiJn6ChSFfhsVr
         IFcsEJaeL3R82lGK7Cvs9ayGSwlS6b9lgq2xV9HtG9hGvr739JQ4XNdALsbGY8e9+Fj3
         pQEs/hCRtmKeuk6k1HomuxxzpenYv7+mP+5NoRIgZTCTGqVBN6SresV7XO5YTXBy/slL
         iCCw==
X-Forwarded-Encrypted: i=1; AKwUvBxbukwocJlWVuPbchvboIyQ1MWmehZ3eyjgxLLKIqdeu6yhHKtupDSxBu5PLVpgZiH9TU6SAa7iTac=@vger.kernel.org
X-Gm-Message-State: APuU4Z+o5xY854Qsv6UJrm9O1i5lLc77fKYAOTUC+nsrfSjH767ukkeP
	oXI7KF9X0RszgBFNIH8RKk+f/6QXvEYXGNOYfYJPAwFvaThLbdcDmixM
X-Gm-Gg: AYBFou3aS8bIj6LeAmBhZ1PCFLWABD6f+xkF8Toqpy0+nsXcW2CumOLvM4g3ADsjlko
	66KyHf1R+694fs2HmQt4T838rW4oSaKjkLVPLrhHWA0e0fj/Wx0KWeLvF8uB//VyZKqjPdlTQXv
	m896umdTe+GAKdO3auHj72V5+3cciuLoBDpJa6vCNxt9qP+HUFmcJYHrScTh8neCBhQRvYV7ZQv
	Hgrf5uUnRva39DIdh7qZ77BBWpSs3Fa9DZYU3+uyATqYsnhJTc8bK/i4JlKxuf3qeLKbRGMkin+
	KWWoSeStRiy2n28wHNa8LmCgGWQeNt5pW5WufMBnlpcknY1WQZPt27FWyzzPwIX18rsALFQAu4t
	1nzlqC5TZ9u8vcQyQM1CxSvNGx2gpiYzu42CDs3tgBIXQR7+01t0fRsbVsuwfNaUzlIcL0DY5Yk
	OAaAGGb/daon9CfFuET6VqaAyJSLZlEDkmOZE1dV9vA20QChJQMGEmJfJmTnlCbTxh7OWRr5ix2
	1+Q6s3oayjH30ktK00GKWIs1iJPgrRlUU/jLLg6PPJtTFadBepYVfqD6KFPsdqHkFwM/5I6nk/k
	yCCcTfBAqUXZ8qjEqE0DIns/r7/pLs1DgdkiJ6pNrIhhjWY=
X-Received: by 2002:a17:903:1b0e:b0:2e9:3dd0:c8d with SMTP id d9443c01a7336-2eb36493f7dmr89884315ad.14.1793586427266;
        Sun, 01 Nov 2026 18:27:07 -0800 (PST)
Received: from ubuntu24.vpn.host.chaitin.net ([124.77.157.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39052ec9sm20759805ad.6.2026.11.01.18.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 18:27:06 -0800 (PST)
From: BeaCox <0xbeac@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	BeaCox <0xbeac@gmail.com>
Subject: Re: [RFC PATCH] mmc: dw_mmc: disable bh_work and stop timers on remove
Date: Mon,  2 Nov 2026 10:26:44 +0800
Message-ID: <20261102022644.49510-1-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e206aa41-fc3c-45fd-8653-b9a65cffe0ad@rock-chips.com>
References: <20261101063719.88570-1-0xbeac@gmail.com> <e206aa41-fc3c-45fd-8653-b9a65cffe0ad@rock-chips.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Shawn,

Thanks for the review and for checking the history.  You are right on
both points.

dw_mci_remove() never called tasklet_kill(), so the race goes back to
the original driver (f95f3850f7a9); 921c87ba3893 only replaced
tasklet_schedule() with queue_work().  I have replaced the Fixes tag
accordingly.

I have also split the fix in two, since the two parts have different
lifetimes:

  1/2 drains bh_work.  This is the long-standing race and the patch
      applies to 6.11 and later, where the bh_work form exists; it is
      marked Cc: stable # 6.11+.
  2/2 cancels the watchdog timer.  That code is new in 7.4
      (ce0043b9a302), so there is nothing to backport it to.

The code is otherwise unchanged.  v2 follows shortly.

If you would rather keep it as a single patch without the stable tag,
just let me know and I will squash them.

Thanks,
BeaCox
