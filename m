Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A984418E1F
	for <linux-mmc@vger.kernel.org>; Wed, 19 Nov 2025 01:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763517489; cv=none; b=gdceuhz488hrYQfeBTDtwBRwELO9+djQq+1waaF61HdThoyxZ3iM4bRFiVNZJTJvGneNnJ2MUkhNQpWSwSoAAbryFgfEjWWp3fO7WdZ/v4ct9hq+xS7ESx+s4SUtPDqOnmO9yF/qTw1+LQ8FeRCNSEs4fTh3TOBdN0Vu3mzyXzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763517489; c=relaxed/simple;
	bh=4dXkbgTrOJisFHsSBgNJhRTK7DMc0gtNO7KfaAUbx54=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=m7OxkRm3bsHFD67a0xQtcSkPQZ9P5HOW1UqknphZfBsbutajIo1jIsuEDi2tSSNAkaNJfZDfFh/T5SqQeFFi+8vVGVlLWWuIv2Y66+tHkBaX6MtEqwZTHN8vmKo7ML8zYmXtxk8shFO3g4Pdep6wd7b4MVFKFHQeqio0nN7xxks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fN8wHwKN; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fN8wHwKN"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-882475d8851so65354086d6.2
        for <linux-mmc@vger.kernel.org>; Tue, 18 Nov 2025 17:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763517484; x=1764122284; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4dXkbgTrOJisFHsSBgNJhRTK7DMc0gtNO7KfaAUbx54=;
        b=fN8wHwKN+wlS2uvTW9BIVNFkbqJSHs+ISrRAZByUKshdY/UmK+8Hwjr+nGT9V44Sd4
         cPlS95uf9a+QPbAEvsPgDB7CBj0XI/2eFLS0jeFQjSh9kKynGGJn9KzndOP2Xir61xYZ
         srhjmvqFssgL2xnZe36WB31n7lRiuQjp8+VxDowhDXnHx8P2uHrZeSHdiR3sbW6vSUgd
         p3FBTMJBpvUsAxOC9g8frChXCBGbnQ3zFZ+l+LG0oujACkc6ecEMCzfS8woxLw+Yyabg
         aeZgmzoSiFlq3E/5JEfiY9i2n9b+R9rWLjWCP+v/GrUepO7/QELOZVySDd4l+6LeYG1K
         nK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763517484; x=1764122284;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4dXkbgTrOJisFHsSBgNJhRTK7DMc0gtNO7KfaAUbx54=;
        b=pThmg+76clq5dkd34tEe2auJVJEN0M5taAKyHP9QZ9haet958nAN34X0xzCOFFZWft
         bhgoLuWdnqj7GjRXpJQAQ7NF2kulBIiAJbEEnqQjBt9EuuzQf/1WGMtDpZLUg0dWHv/N
         HdrAKHyZw2y11i46NForRyQMu9cnMhf5FXwU4z7U3/yhD6bCiSR2RGul2pOhEt3FhjVH
         3G5ADyFOLicKhOTmgKSkW/0dcjVq1s6vMn46ZFBKX6xn/GFAuUiMxmAgOaJGEwJ4XZZF
         mP3AZFk6mMK44rO8Zu1wfWuQIob71m6Ym/WVpzYobGEdQHlMkxxQQruwYjczuu12JtIm
         VWJQ==
X-Gm-Message-State: AOJu0YyZ2SUIZ2Y5nuynb0z6KjeajRfJlk0Prav1doSBkbhQIByhMh/Z
	dT74lWLpZtRcMY06/r/1k3j3n7+KnwXbeffIpplLH9D7Jb7b0hfU0NNfFGA0U1knc9DIWqk3zQy
	x2YIpMXtewhEhHo3LpHdj1VL75yoqha8Eln1F
X-Gm-Gg: ASbGncsztkyYElq+I+nSHHXJEGADMJN0QtvdZl+R3qR9CUCQHRZi7n+yNvpzCLhh6rE
	LcbzAaw9seqWt2np/9VjA16aN9h+XACs65uHBZbBZsUbUsdL/GRek3K1hH170yUjAfEKI80uJhk
	T5FcXs9AQe76oDwKfmvIjSdhEEsLIFpRhDoWxFzbRJQAMNDH82NTxZkOno9Wglc/zhqCOo+SsK9
	Vce7OW4Jtj6S3SB2uBShPFX8LJcsJA7WCm+pehv7T4R3r5JR31DD9psIYWra7RrTIFosw==
X-Google-Smtp-Source: AGHT+IH8xHKV9okEjBQjI+s9d44eCHLkGS8pMnrpe8e96fX/bdNJ7oFnteEF4fA8kazH0g9BSxz04h62gJB9+nO4EnY=
X-Received: by 2002:a05:6214:d43:b0:880:1fb9:a30a with SMTP id
 6a1803df08f44-8845fc3e0a7mr11790846d6.3.1763517484295; Tue, 18 Nov 2025
 17:58:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: R Rapp1321 <rrapp1321@gmail.com>
Date: Tue, 18 Nov 2025 19:57:52 -0600
X-Gm-Features: AWmQ_blMPWjva9JuA798QhvT7nRc07ohM421XL-XGU5DfaBN3Dvs6b-vamlVuBg
Message-ID: <CADQ69Q6MZYbWh2gV8LfPG80gK2etyhGkjFvZ26+r5gzSbLxwaQ@mail.gmail.com>
Subject: Issue enabling Secure Write Protect mode
To: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
I have an eMMC that I have keyed. I am trying to enable Secure Write Protect.
If I do this:
./mmc rpmb secure-wp-enable /dev/mmcblk0 /dev/mmcblk0rpmb key File

Then do:
./mmc rpmb secure-wp-en-read /dev/mmcblk0 /dev/mmcblk0rpmb key File

This returns:
SECURE_WP_MODE_ENABLE 0X00
SECURE_WP_MODE_CONFIG 0X00

I believe I need to get SECURE_WP_MODE_ENABLE set to 1.

What am I missing?

Thanks for the help!
Rob Rapp
