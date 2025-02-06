Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E3D22FF38
	for <linux-mmc@vger.kernel.org>; Thu,  6 Feb 2025 22:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879794; cv=none; b=fPSf0RN23OyvrRR9KXsjA/9KLXgeh+prArbXOnoOHBrXgxJc1mkmvcoyAL2UZ21pbmXVnFzcEtcn8ZLhDwvjJPjPmUWEDIvdE5UEXtBRJQFKKbo44C5qsagcQmc2pGGMAepvbr/CmBwUeuHvKNtUld6ShFvz60eZAuyIKb1nVTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879794; c=relaxed/simple;
	bh=9F+k0wZtD3XTper5h4ap0UH/G+LeC9jHiWwbpGPjdZ0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=QxguhiIa3zMLsjB7qnp1rucnZ+llGtQI/buHBothwjnnc+iitE97zIqJCewacKJ6COgovbCTKosVVIrkCh8ZKdyHAfpp91icLPVuOxW0hbaTUKzL9yNNbjEWmam7DiVjmEW3f+iIDP4eGnOwjxaZ0ws+2ZA7SIR9KuV7lNkAxzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Irz+q56R; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Irz+q56R"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-71e3f291ad6so1012263a34.0
        for <linux-mmc@vger.kernel.org>; Thu, 06 Feb 2025 14:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738879792; x=1739484592; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKLOHtlnFeDc2mupUeHKGP84WLv0obwYAIFvImFlmgg=;
        b=Irz+q56RoF8aEbs9kLpy5UlcvZTNxHQS9AiMxCdMT6kbSH2xKLnjcxt0Vch/KN2FS8
         3QWcdd9UpKd+EH4IcRmw4cBm8J51Z3jOhXJprz6UF6MK/4aFMHIth8AA7gYETkkcjbPh
         JXC8jcahsWVvLUR1HsZN26XOEvq7wGgs4177g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738879792; x=1739484592;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bKLOHtlnFeDc2mupUeHKGP84WLv0obwYAIFvImFlmgg=;
        b=Bmi39o86uJmkqNdufELYwiGwIsY/RfnsGWj+nNC8xMECeaYmROL4mIfU10/54sCq3s
         iCGAauUMY9sPXTZb11PuYGsMdoxudb6JET17AeEFSkpQrtmC5lAYB/UJUYcMLMacHSU/
         hAIeXFQ9v5NL5SsI3Wrbt2NT+ufqYWgrDQjQ/E2/2K73yx1DiWW9bJGerpoJvauXqSED
         WTVsnM1ImvXytBKEv0AtILVq/qVdjDFdaZcTfqYoXB9SqgGRyXAzUZfeKlnb+sq5q0tH
         tCTyVlucocs+ixsNzg1MyFlFNdFJ4tFHjBjzk8+dLTMGqXdksmXNTHcyRGPW/2Y4/oD6
         PuEA==
X-Forwarded-Encrypted: i=1; AJvYcCVsEIzuyIm8m7IckSVSAEDLrTnGx6vlc59hZek+fY9lukvoe4ByaYxL9pr4YJNS7XFmEw10T5vlkbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnRYZuIpSFTS61QH+c56f2nzi22T0XznOxMxpKUWGhLN8KtgWu
	aDaoNmn6DJHyxYGem6+2DG1tLofe67O6GD7Bd6s9g6XLelrNhn+r3r1jOvN65A==
X-Gm-Gg: ASbGncsDUfoJlRNFPYF1fBSO7C3FN43inzn0Oj5uAm6FI1k3MIHhC99WbDkbZ5SAF/8
	Qc9t8tYKwKXhg1bHeZx3u69kKOjL0rvJk9/SjT4oIj45ca9O9VFiVFiOYLrXir7umNE0zLp2U1z
	oOkvHqNQvo6aP3uzPZEnMnsIIbVe+GNOMvfO0NssxtaB8rcVn89p987V73N4kb9JX4qPCfwQqO5
	Byeswa9QwszTZ+LLaSvv3SgjTfw9iPQ35PZXvHablrnK5A5rbp/4N5/3CSAeLCJfiJ88+A6DPkR
	rdG6SsoH8Wgu02TnAQgthznBzV6MJ0xCtDpDxKqxMsvftG6LwPA=
X-Google-Smtp-Source: AGHT+IEHe1IPoheKKxZVoNH3Y4DP7iwCSU+DV5NShn+FO80wEUB6babC+pZZtSNlZsFF7OFhthUckw==
X-Received: by 2002:a05:6830:6501:b0:71d:eb02:bad6 with SMTP id 46e09a7af769-726b87e7d24mr712227a34.13.1738879792140;
        Thu, 06 Feb 2025 14:09:52 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc544cf88esm454109eaf.15.2025.02.06.14.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 14:09:51 -0800 (PST)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: ulf.hansson@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	adrian.hunter@intel.com,
	linux-mmc@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	wsa+renesas@sang-engineering.com
Cc: f.fainelli@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH RFC 0/3] mmc: sdhci-brcmstb: Add rpmb sharing support
Date: Thu,  6 Feb 2025 17:09:37 -0500
Message-Id: <20250206220940.10553-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

This patch set adds support for Broadcom TZOS to read and write to RPMB
partition using synchronized access to the controller hardware.
To achieve this Linux OS and the secure TZOS make use of:
- shared hardware semaphore register
- a set of SDIO shared work registers and
- IPI interrupt registers
The sdio shared work registers indicates next in queue to access the controller
and current agent in the queue. The currently running OS that needs access to
the controller puts itself in its slot of work register and if its next in line
it can try to grab the hardware semaphore and complete its mmc requests.
Next agent queue state is changed under the hardware semaphore lock before it
release it by looking at work slot register. send and receive IPI interrupts
between linux and secure world are used to indicatecompletion of transaction to
the waiting OS. TZOS has its own RPMB driver which accesses partition when it
wants to read/write RPMB frames. Current implementation assumes Linux and TZOS
as the two work agents. 

Change required adding two core mmc_host_ops request_start() and request_done()
to let the host controller driver know when a mmc request starts and ends so
that the access can be synchronized. This has been tested with both the sdhci
and cqhci access. Currently these ops are implemented by the sdhci-brcmstb
controller dirver to acquire and release the hardware semaphore before and
after access. This change to the mmc/core driver does not have any impact to
existing controller drivers.

Posting this path to get comments on the initial implementation.

Todo :
- Provide  hardware smeaphore using the harware spinlock driver framework
- Use IPI send receive interrupt controller driver

Kamal Dasu (3):
  mmc: add request_start() and request_done() mmc ops
  dt-bindings: mmc: brcm,sdhci-brcmstb: Add sdio sharing support
  mmc: sdhci-brcmstb: Add rpmb sharing support in host driver

 .../bindings/mmc/brcm,sdhci-brcmstb.yaml      |  16 +-
 drivers/mmc/core/core.c                       |  14 +-
 drivers/mmc/host/sdhci-brcmstb.c              | 275 +++++++++++++++++-
 include/linux/mmc/host.h                      |   4 +
 4 files changed, 303 insertions(+), 6 deletions(-)

-- 
2.17.1

