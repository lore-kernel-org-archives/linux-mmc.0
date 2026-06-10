Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AC053E0B
	for <linux-mmc@vger.kernel.org>; Wed, 10 Jun 2026 22:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781128889; cv=pass; b=PbdpopBa1MYlPdd/8n7w4Bx75E24Ez88IKU2P+6G+1El7zua9IOtF6vzb/1WeBXpufxjUMCp687Y2IJgeaB1VBDuIrtJiBPdrJ3rY+Y2J4NxIUOLILxK4WZBzJMWK5udb7rax8iFGPRhoqGMUAip3NkAMNYsh11Xqr+aPJR9aeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781128889; c=relaxed/simple;
	bh=IsdSQKv7tgAjlb47q049+cE+VaLyC2eCAZsAHaGva50=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EU1lje4kVqjjIqGE3I1NIYDyAWke42/9AnnvLA4JF3oQGOcH9zEctJypNi6GJ7F4UEmboHr4vAc0T+5zKCQMSNAiW5DB3EGaPxYKM/HUpBf4eEQES8I7F520RpYKu74hHkS2Qtyoj66rSwnAceQKjiCY8vV92XMd+YGI6bd5XBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlpX+5NQ; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlpX+5NQ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0c3543590so49289305ad.2
        for <linux-mmc@vger.kernel.org>; Wed, 10 Jun 2026 15:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781128887; cv=none;
        d=google.com; s=arc-20240605;
        b=STeaTDDImJA1seReDsX2rCQ9YvtlSLQNqb7GeEAFUvfAXH9jgMozNqCBr2Bnqi7BzK
         4OSrLjoJT/t8dygnvXG+Vs87U1xXMSWl6Pm68IEOy8VTRRW+iIe2PFLSQowyBXg4PCkh
         3eyxx1TUJu3bw0UIhHHVMBhUoUFvDEZ/j6xZhEn41WVbVE9SybzFmN44OUXiOqrVRrna
         5UZTA5yDcs6sT/zjUy/C/4qOdrGtuPbVMyaLYnjhzGkAuXorF8zLxdhyeN6syPSITrTP
         qzGKwlLSxasjTq/kSvZX3VsIgTKpUV0gK6myeqlKTQZls0PiLRqkpOazQfgmja6ZRiXh
         lX2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=h0Dmle5MeuP1yPXjVcDAVWMlS5lDrlFusVKexEqhKFY=;
        fh=+rw5yx+mgbXMdOQ/82m2gan0lqUuSraOyct33CXe9yM=;
        b=JswwYZaHQahgOzdXjnJzfgpxoWXUCGlVGyHKa8vgoiUMvHljqf6mTTYq2NbM92Z6Ue
         OvioqIKxwg1dVvELkCqPf8YBguuvirkiAej0620BdNE/0uRwor8J/yG22ponFvqszOiW
         IYchwxUqSgdSnGJtVZnx9e6dbqUrASr8KOXY5GkPlG5+Aly7r8CPoQidlyy4V195/swP
         EhEI01CS2h3eyUvKWtgA4DqudVmoII3irmGlkcD6tP1t95eKUi1LwI8d2dV7XrKSBj5y
         BqZRDAoKbK8rXacEf1LCEaexSKvWqY5kdyhCX5p4TDdbUSZRJkmE6hKrZNMNL3omjTVU
         4JcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781128887; x=1781733687; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h0Dmle5MeuP1yPXjVcDAVWMlS5lDrlFusVKexEqhKFY=;
        b=MlpX+5NQzSUvk3dE6c/WRi9vK5vho5+wT40BJHwd5KzzpUhrkFGVfHGcGO8C9kiG1C
         g5p17dDEOeR9/k4vBcqwbGmQehW2bZ5/mCHHqnbn96eQJcWSPdXP84UeaxHk4rmJOXoy
         NyZviFe09IVMdfRu3/jM972B0Fl2lEgFs7RWhjraMRs/M4syIp7h3o4bdqZ2Nb9A/1pm
         AIhqyJojDRMd/IK8IuRxErLxIHNaItuUAyRRmeaw8adAUXR4c+gzBMBo6/6Jj7T4PTIA
         3JTmIDkNBnKdCRj8/OtcWOSmsom2qx8/qRrsr32Jn8W5yBMljjuF2UyKHccAOREL68GN
         Mcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781128887; x=1781733687;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h0Dmle5MeuP1yPXjVcDAVWMlS5lDrlFusVKexEqhKFY=;
        b=IR8m+ia6y1CUhMuYdL7XENLP4iYaHawC4EVjeWjc5sV7qxea2O56oq7oXoY6gOrcna
         /LKkitZkmUQUxI9xwqKnF+LwBv1z6cQ8KvGOBe92TFddJSWsIqr14WYARKgoM28JT76z
         2zAq79Fh3x5MvW/l60Ts+jcY6k10sihZYVol494eTqTG6VQdj8YKNmT0hb6UO7SSqG1L
         F8QaMn9NS+NAu6UsiKAXxsS8lxfcwMfKJz4m0ClDUgQUNHIR2hanISBQm4MILkBp9rVa
         xdh7jjk0LuL3AgggvwgwL7PWIFwctcAr915ZJXE5dBGK4cW4u/0czeUtm2BadCwdIYzn
         mHng==
X-Forwarded-Encrypted: i=1; AFNElJ8SmFkExtwFgPPfFpnMyK5zQ5mSQAFv6nQ1TijcaFj0a626dQObI4IupZPC0o+pB0JMvmKrH5DBJQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2GwmdTlbtU8pmInGE1qKhWd1n5pq7zjzXgCOo5LudHvh1IPC1
	h2kDop1TKIpv+hf30DdA7zFql81EfAdA/EHRB5t+c4lpBJOfdpkWFrB+7IOqzJdgo+TzZSf2AbG
	/TlrLO/CPsaQ5VKE5iLu+uT6rsi9O801C4T0xhiw=
X-Gm-Gg: Acq92OERIgeqhPf3042PkJlylxbn4pba8ow5euG7W75akoXTh+6yIoYx5vK4yKTnRM5
	mKt57iUrS2PseXUqX3gMgp7XXPnsFCQZRt6JhtQqRpbXMTcQcYoSZJiDYIHHhzdJwDq5JJlyOJx
	HMVhwJ7Yoipc0YTj5rdpuUiu61v6kdT7wSnPHG04wHct0fpw0EDih/RjUyBc8OZ+YEh2ZD/m10H
	WnPWYzH+Rsn/nYR1Qanx5CGUJgiuik5iTVV/5VuIaOpW2w7By5yrGYGCF5SXPxFHBvrjKv4DZqV
	CrlmnApmRjDkfwk=
X-Received: by 2002:a17:903:138a:b0:2c0:a9b3:bdc6 with SMTP id
 d9443c01a7336-2c1e80f9214mr284349325ad.30.1781128887315; Wed, 10 Jun 2026
 15:01:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Enzo <enzo.adriano.code@gmail.com>
Date: Wed, 10 Jun 2026 18:01:15 -0400
X-Gm-Features: AVVi8CfxAHDyBqNO0Ys_rdLGOZmuKmThiL3y1SJyB19d0A7iTcl0mFxuFzIXLu0
Message-ID: <CAHWUu5EzER1mEmMpOeMgQN_ynW0my-TM2UGt808mjEe4dY-vkg@mail.gmail.com>
Subject: sunxi-mmc: A733 IDMAC stuck in descriptor rea
To: Ulf Hansson <ulfh@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On A733/SUN60IW2, SDMMC0 works with PIO reads but normal IDMAC does not
fetch the first descriptor.

This is on a Radxa Cubie A7S, testing Linux v7.1-rc6-gabc8d07b0a63.

The failing transfer is a single 8-block CMD18.  After starting IDMAC:

    IDST = 0x00004000
    CHDA = DLBA
    CBDA = 0
    CBCR = 0x400
    BBCR = 0
    descriptor OWN is still set

The descriptor memory is unchanged after syncing for CPU, so this looks
like the controller never reads descriptor word 0.

I have already checked the obvious descriptor/DMA cases: 4K descriptor
size, shifted descriptor/data addresses, descriptor memory below 4G,
coherent vs streaming descriptors, and the normal-IDMAC 64-bit DMA mask
used by the vendor tree.

Is there an A733-specific clock/reset, MBUS/NSI, firewall, or firmware
handoff bit needed before SDMMC0 IDMAC can access memory?

I can send the full boot log and instrumented dmesg if useful.

Thanks for your time,

Enzo Adriano
enzo.adriano.code@gmail.com
