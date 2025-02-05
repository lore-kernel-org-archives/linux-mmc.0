Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475721FF618
	for <linux-mmc@vger.kernel.org>; Wed,  5 Feb 2025 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738779913; cv=none; b=ac8lvaTQp6BOm1joYmlYTCiTMJNndgUiES+bVyWU5nu2XcNTvm5zW5QqoeZZkmRKt2vE3UFUlePTQk7pNrMti4wUB4wXvBSUCn0h7dcULlLMstWKCGPlFDkbXGiMX95IjzXK06wgoyS2/lARN6yxvElSDdXyZOv7lIADOi/fy1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738779913; c=relaxed/simple;
	bh=ZdA7bh9rzruSlgHNNoE7wa2pdXLi0UvHRksKN1CzMOo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=r+GsgarhirmfLk+nWbO0t8Y7YAqPm+wSWuRQnVGk46mf/xLOEgO2kcKdX/304U9neCO3PET0CcI1bRM7pWTXPZShht6+zbUW/SHhFEBFijK6IUiZIXR4ohxSFJ9h6H8ZzDU0hk7GwgORHSuM9DZLB1Tmw1WrkfQwz72tKdZOFEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EojSAorx; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EojSAorx"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21c2f1b610dso3249975ad.0
        for <linux-mmc@vger.kernel.org>; Wed, 05 Feb 2025 10:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738779910; x=1739384710; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdA7bh9rzruSlgHNNoE7wa2pdXLi0UvHRksKN1CzMOo=;
        b=EojSAorxHLEJh18HfhrABETvoTaf0bKXwOv3mJg8hhNsL1rh9iiTPasyCDl8Kjksvp
         5lVIZB7+jG3Hn9lz10XnEeQANPI8hMQvbUGwwjZTD/ugJWF7FGtt4bStocsMS4F5sVCU
         23e3vKgcYxq7YPRmbI4O0P/6/PlqdagIf/TUQuykPM/IqHB9PsQa8DCtbfcbJQ/CWjs5
         5QEeCrko25eW53HXYLjIRpYauH/3A2gPeUp9mpzw9EtYDUqKKllEeRCYkUMK9KN98uXb
         Uyr3z54umMmdmvYiyg9XqaDlNdXA5QssZkdJHrlwcR5yoYIebbCo5A3gILqX1bTH50JQ
         MsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738779910; x=1739384710;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZdA7bh9rzruSlgHNNoE7wa2pdXLi0UvHRksKN1CzMOo=;
        b=l3zhF64VTJhvSc5ylNm0UvoQX+ZPSwQ1L8Cd4FRi95vZO+Zaaqsue4Pnh8cX3i5YM9
         yJmD5hFexpiiT2BA7LHHV8ibcEXwixNUL3nvQVrhdS4fAqMFEqwSvtHS65+KKaXjXkwN
         YUInkkwaaqTRr5t+vIPNiix2D20xWEN0zvPtgkwBrvz8747s/e8QBbNsHlXxEJDZamXj
         qZNmiehutEGw4GepdbTXl3Qq+0yVOUbs+9WZy43eU+mrStV3LCgNxSXwstIXEbk7prG6
         PihMb/UP2jzPhf4+c3ZUeWJCaVljykKSYZ4FmCIIa2a7UTGPTAN71bhoepTGPTyRTUVD
         BEOA==
X-Gm-Message-State: AOJu0Yz6Oc4FO4VC7IkEhdN68PjL6K4T1WErN92/d290T1r168bHU5fF
	4D1vgwfJN+IpR/WWbRO5s003LsembUvNTzZ3uT7VpcCFtBnCkmQiMmBT/JG3HZXJZ/ht3xBSrtS
	xKgviKZFWkzrptAl0GpiQI4sRZAVbElq72FQ=
X-Gm-Gg: ASbGnctVmxqhKcWVEEYyrdlrrU2FtMe/vaNY6dhi7L+RuJ8kfgfK45sCb7uIXW8RbQn
	UjxjkqMWcd6ahGi19E+gKnyMIbLJDcKMlC4Y5qwU75NjsWjaR7QK5vZwm7kKtlnzSc98+W80Rik
	3GkoUh71RpaViL/64uo/JIOhasm2FalQ==
X-Google-Smtp-Source: AGHT+IFVMsTy/D7+/vgjEchDuGxNZAazcsxFYnwW7beWUjkIkSM6cTRfGAKa/VlnI3SEr4vt1VWkQrjUG5ujf2FWEdg=
X-Received: by 2002:a05:6a00:3393:b0:725:973f:9d53 with SMTP id
 d2e1a72fcca58-730351ead83mr5695711b3a.15.1738779909961; Wed, 05 Feb 2025
 10:25:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rudraksha Gupta <guptarud@gmail.com>
Date: Wed, 5 Feb 2025 10:24:32 -0800
X-Gm-Features: AWEUYZkDe7g6j_DDwovPOTuqzLvNJLfrw7GkYV8VFIV6wJDQ6EX1pWZc_f8cy9g
Message-ID: <CABhZbsXgNN22cukU8CA3UPBQRyqE5XYZ1D=eSUPZgoV8n6aWpQ@mail.gmail.com>
Subject: [Help Needed] MMC Stops Working When A Lot of Writes Happen
To: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello all,



Trying to mainline my device and my device hangs in the initramfs:
pastebin.com/qGbfFGUt

Turns out it=E2=80=99s the MMC. small writes are fine, but big ones hang th=
e
system: pastebin.com/Tkx7Bw0q

Any suggestions on how to debug this issue? The downstream kernel works fin=
e:
- https://codeberg.org/LogicalErzor/Android_Kernel_Samsung_D2/src/commit/0d=
be2b56847b304d30b809dfd08ba3b4a61d9af8/arch/arm/configs/cyanogen_expressatt=
_defconfig
- https://gitlab.postmarketos.org/postmarketOS/pmaports/-/blob/master/devic=
e/archived/linux-samsung-expressatt-downstream/APKBUILD?ref_type=3Dheads



Thanks, Rudraksha
