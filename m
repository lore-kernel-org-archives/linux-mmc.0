Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E43157480
	for <linux-mmc@vger.kernel.org>; Tue,  7 Oct 2025 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759845887; cv=none; b=mlujy311tjDmv5UdNDkBdBtSMNYhntaCVzT+VgMjZ91poLMWB0fr+oI4MxBAaUtqciGVJyB9lLfuAIMuR/63kTzOyjgCHl8r/7mANNQT1kr3H0mkJ0ENgDGatrdWFDIKX5z0C1gj2GuaN+VskFsKhhXKKpegf7JvEgpZIQa0gJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759845887; c=relaxed/simple;
	bh=T7xKd6x9LCmTlXtrpXw7Dd+dCv2klQxxhbQjd7jUIls=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p4C7C98VeqGBAC3gDemEp99aOjK0xzgrs+JzaUnCawUn5FLg1LuWe/Zsyou5DmyzdWXGAztBnzFXTHknMzUxf+61cn2pfwmLDZoKrkNEq7CGpyM4QtBd/Ar5AoqwPPQ4DkmXBWElY9uAW0fT6YKo042WROARXx+o+Re6Ok/2F+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SZybQh6I; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SZybQh6I"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-27edcbcd158so82079945ad.3
        for <linux-mmc@vger.kernel.org>; Tue, 07 Oct 2025 07:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759845886; x=1760450686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+9d1ZWb5LY8JAy2gqqVDPFgFUs9C7bdvcAG7+1eQP4=;
        b=XP76BDzc85wtQ+QsdpF2atlbJ1RCBvfpmcrSrmzWH/A+juMcPtQt7CcviYxLAlwbfC
         2VjQ7mUMmoyiWg1w6ZRg/ChvFTAjIjvBGhUocnORV7yB0MqJgiT8WAgAVvQaoYfabPSn
         erRr0zAWfn5LaIoiGvwkbku5HVdeyrtyPZej6Bdhahk1DlM2Udv6CE1eYGFhKWOUh0Nf
         JYiSQqm2uFzSyOEP65sDe5vzDRXPwiElc44WdtyUyK8HQlGa0Meax2Bu2X/ws/HDQM3G
         DhlSSXqWltAiLQT38H81pShdrGVNDaCg3y4+9QNgYteZ3lE7IlxoA0X2Tp+NLf2nRsrA
         CYBw==
X-Forwarded-Encrypted: i=1; AJvYcCXIt9vnD/yeDXMz+WwcRvcFQ3b+cEnuQCeYIcnYfJYlKEeEZIZqxXujseBUX9RJo4Xw1OHyREYVpdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmsiE+ZnnyfaGzqRcDtlV4YqHDXPncZzbykfEjTVN6GQqt00km
	6OSWjez2v5ZWw7fDt/uVxVx4TFmFR1EMV4T7/LHhqmEcyme8gzJ8+MqhJyZGcq/HicfHn6fmWTo
	H0GoaXsM5wDjUkwQQbwOPDzwS+QpdARqq+fhSUK5HkPGkivwHFn/6A+UpiF9UIlv2CcWLma7GB+
	V0mWznaXpU7/CkrzXs8WE8Z3w6GjyeG/gkbgszk9nndyHfhKfLZpVwdF0aHsFKQwgkhovsfnGya
	MbO5MuTwo4m
X-Gm-Gg: ASbGnctmxy8nSvlhABKP8wA2ogTkAm8H9IAdjV12/jWZSjroQ9SrPA6qVhK68ZrDM/j
	3hBv95wNoUi30MAu/PiaqXIaQRUVqcDEUIjuGs2o751YZPDlj7xIlt9JZOLy5WnvDbNwNN2Bzq4
	WrP7I06qWQ51+O+qw2pr0lpADDGvOBsh2LIA5mLC6HtaGxngqrgxy0P+LGv/A4fvOYFAEpx8fmS
	8x4wbZUHaJa6XKfE6pbbOxgRYEnpgjpaBjlVM9Zn62dXVLR8gvubYAUCZxLESiFu1vpN7j9sSCe
	8gPfM1oUItE/msY/Os+6mMWvnA8Mq3VDueX2RyFxjFAzidVIesQEH6y6tVLqvPnKWPhq/DHkFqZ
	WuvjcEijKfruH/0VAJmMCRH05IJ+IkYN6zIP5bDK3z06LCgdR7eKWfPyC5M6AVnktrLe7scmF0z
	ae2f9J
X-Google-Smtp-Source: AGHT+IGxvNxecOZW6YPBQ8apz/0wTOwPBLIoYFmlpUFFrSgOdWpT6B7CUB8idVHxX4qci7n2SAC4PKORsFWL
X-Received: by 2002:a17:903:1b24:b0:269:874c:4e48 with SMTP id d9443c01a7336-28e9a634362mr211365405ad.47.1759845885616;
        Tue, 07 Oct 2025 07:04:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-28e8d19c7d0sm12435135ad.59.2025.10.07.07.04.45
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Oct 2025 07:04:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-43f7bca47cdso6361215b6e.3
        for <linux-mmc@vger.kernel.org>; Tue, 07 Oct 2025 07:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759845883; x=1760450683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G+9d1ZWb5LY8JAy2gqqVDPFgFUs9C7bdvcAG7+1eQP4=;
        b=SZybQh6IVkzJikDKv1q8U4HJSjI5CVCeDbdZwpRwNIdfpSLDZBqyJN/7BUT5VK1Pj5
         zYgPvc2a7iFSQN5jQ38NUVu1VtjKQtuB13XmEC+ei54nHa53W2mQFFtzwj5YaMBai6Dm
         6ewpaldwTNicfMtfr0EbKJv/C+8EGiDdbMYqg=
X-Forwarded-Encrypted: i=1; AJvYcCXcTRz/La7PwE2M78kd0tUnYbSu7MgyIZfu4mbTUVlNXivSVczZds4g0LrtA0lzxZP4B2Rt3mqK8xg=@vger.kernel.org
X-Received: by 2002:a05:6808:150f:b0:43d:365f:be86 with SMTP id 5614622812f47-43fc1848847mr8223452b6e.33.1759845883182;
        Tue, 07 Oct 2025 07:04:43 -0700 (PDT)
X-Received: by 2002:a05:6808:150f:b0:43d:365f:be86 with SMTP id 5614622812f47-43fc1848847mr8223351b6e.33.1759845882241;
        Tue, 07 Oct 2025 07:04:42 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bae60b67sm142718956d6.9.2025.10.07.07.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 07:04:41 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: andersson@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH v2 0/5] sdhci-brcmstb SD host controller SoC specific enhancements 
Date: Tue,  7 Oct 2025 10:04:28 -0400
Message-Id: <20251007140434.606051-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

sdhci-brcmstb HS200 configuration for BCM72116 and PM register save restore
changes applicable to various SoCs. 

v2 changes:
 - Separate commit for SDIO_CFG register defines that moved
 - Implemented cosmetic changes proposed for initial change for :
     "mmc: sdhci-brcmstb: clear CFG_OP_DLY when using HS200"
 - Moved BCM74371 support in a separate commit    
 - Implemented review comments and reorganized code for :
     "mmc: sdhci-brcmstb: save and restore registers during PM"
 - Added Reviewed-by and Acked-by tags wherever applicable 

Kamal Dasu (5):
  dt-bindings: mmc: Add support for BCM72116 and BCM74371 SD host
    controller
  mmc: sdhci-brcmstb: move SDIO_CFG_CQ_CAPABILITY define
  mmc: sdhci-brcmstb: clear CFG_OP_DLY when using HS200
  mmc: sdhci-brcmstb: Add BCM74371 support
  mmc: sdhci-brcmstb: save and restore registers during PM

 .../bindings/mmc/brcm,sdhci-brcmstb.yaml      |   2 +
 drivers/mmc/host/sdhci-brcmstb.c              | 154 +++++++++++++++++-
 2 files changed, 147 insertions(+), 9 deletions(-)

-- 
2.34.1

