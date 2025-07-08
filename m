Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABE82BD59C
	for <linux-mmc@vger.kernel.org>; Tue,  8 Jul 2025 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751962893; cv=none; b=K4URbvrRNGoLtyZzKiFz71CT3HkaW9DIBLUSeUMzXdYA+3y3njsYGYgovfE0uCJuOPUeGknNS8i6/JN1fNgZHx77682pMUOsGD1PQQ8PLxyeT/k/9n35xP49G2TiXF8FBYn8Swh4JBeACTUP2X1NUDoiGy5qX1gxqIi0giQZ7G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751962893; c=relaxed/simple;
	bh=DbXEByP/T/fakFCC8LGNuWseL/5FRc/uy+x2zcGPVwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g0W1uHrLNMlewCt1bfv5kL4CLTeB8Py5uP4pK+mUEtmAv3r+LVZp/FIkgEZ2qJH0IrqCTmHTegBfFysKbD5GkFrhX1uinKx6woIprXHXiR/UIXiKZrenYNABlUUQWCbfqJ4O4k6dZDF/MmWkqLYkmSGPhZIceOIaOYu4qgMpID4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5XETE9Z; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5XETE9Z"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a6d77b43c9so3714775f8f.3
        for <linux-mmc@vger.kernel.org>; Tue, 08 Jul 2025 01:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751962890; x=1752567690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nmtPFRVvDvxivlkJIiMhDLlX66iVczgIpJusPbWJiiQ=;
        b=m5XETE9ZO6YussKaC/AomLGpVg6jnwjFs165PaaN1av+k6ReFJqAYIm7A7XpuDVWHQ
         lwsART4RYe8F16NfceZyuMuMI/HLe8GT8iW7O7p7TY68rvo+GkfDAyT0PKM3XeN+Z8UN
         nFrq/7LSHkVQHhg9Gb1752l/j0Ycy4GaGUXfqJtg0ypB2jwM0ELihEaXdXLuRirFo/b7
         7SyNtn3cpxWYKdkRWeKllqi/EmjwY6vviGczmkhic8XXPwbTC47lR7g7hDUYzcsaqP4V
         HruvDN1iYqpvkYhugeHHZt2qv2Y8dqfA2JJjNBozj8ECn/oCRFUeZubZ1hILHzAVDOuy
         79lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751962890; x=1752567690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nmtPFRVvDvxivlkJIiMhDLlX66iVczgIpJusPbWJiiQ=;
        b=M5nW6HrNBEevIy6pTJE3rSxp6QEBSLREu2wz1HKM90H7MZhbaJaSgSkRtj0VTgAkKZ
         xK9kxnm+AnBppmpyv1ZnOc4pHnckCnD+/3uVtNF++3mre4P1Ai351ct4kEZjygLWOYB8
         G2ndSxlK8Q1UAAK5aZGuCcz42Sw4LqXzSym2Jf5KCz3tfoimugUT5XZQ0f2RSYdVFHTj
         XwX5kW+UT3LNXP928agbKweqE+wcb4kFFRGceQS32mMv09Is9X0Uberf2hNnFYg87qiQ
         DxMSdh9gHc+tpSjozBfkZUJ+muEPSSpDePbYQ2EHeLXvY6MJDdBVOGKItMyEa9pE/XOM
         NCww==
X-Gm-Message-State: AOJu0YzQ1ZKybbxng5c4vDsoM7s+5kk8VhzVuquo0kDrJ/YvC7ybG85k
	SMNIDulPu9iKmJcQ0Qm3687RdmUO+jOQXaClk3EYNcqppyj/zNxkROiIoGXisw==
X-Gm-Gg: ASbGncug8N3oHTvrbJqozXbxyvN07RRF7/XH4ksJH429fPCDE1ztWQ0PziuLgPZFPiT
	x1L+G1tpxtgJAbXIu3slCIymejOrJbwF76ixLz9ysVYKwZyludQWTQRhvY54HqGe/qC/r482FHq
	OsmRAvqwMvGF9k3RAh76joQBACjTws6Xnn+QENM6TR/KfKiWWPfaJS1la/gKejcguXvO3ZuL3H5
	mYyd0o25e98cU6fxmbtbRP9e3qq4UFhUEIVGo7D7+28dtrU7e57oCspuNbmzMcUarZ9p78uia0s
	jUnb0Ns2aEwm9JuOUx/WSUvoxAx1AnnMKUXI5Z//Yzt5sVQg5pDW6+1MjYwL7j0ZIyoUcwvmXbq
	X3RBOHNMukfRjJfGfZjKcuXGlgw5ucQ6a8ykMu9SFNa4=
X-Google-Smtp-Source: AGHT+IFvrH0NNl+HF4GvkZUzRXinAsBNrgZ2+wakVK+VeJW4fuzyGGPNVgKTqoAUEYW/AtVrEsyCdg==
X-Received: by 2002:a05:6000:2012:b0:3a4:c713:7d8 with SMTP id ffacd0b85a97d-3b4964fa642mr11376329f8f.16.1751962890194;
        Tue, 08 Jul 2025 01:21:30 -0700 (PDT)
Received: from mdionisio-OptiPlex-7070.powersoft.it (srvsp.powersoft.it. [93.146.228.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd4938f4sm14296585e9.19.2025.07.08.01.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 01:21:29 -0700 (PDT)
From: Michele Dionisio <michele.dionisio@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	michele.dionisio@gmail.com
Subject: [PATCH 0/1] mmc-utils: add ability to flush optional eMMC cache
Date: Tue,  8 Jul 2025 10:21:04 +0200
Message-ID: <20250708082105.160653-1-michele.dionisio@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

eMMC 5.0 introduce command to flush cache. Linux Kernel support it, so it can be nice to have this 
feature also in mmc-utils.

I would appreciate any comments on the usefulness of the change and a review.

Regards
Michele

Michele Dionisio (1):
  mmc-utils: add ability to flush optional eMMC cache

 man/mmc.1  |  4 ++++
 mmc.c      |  5 +++++
 mmc.h      |  1 +
 mmc_cmds.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |  1 +
 5 files changed, 61 insertions(+)

-- 
2.43.0

