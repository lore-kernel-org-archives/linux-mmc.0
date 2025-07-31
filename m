Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142491C32;
	Thu, 31 Jul 2025 06:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753945083; cv=none; b=HntXCxb7qMt+r1J9cw+F9pkcMT8L4N3A89MqjnqGbsGlZaPlcqO2ne2lWzlgT9neToKIAokBUqMifXLKpXpSUcdUwwKf1lK8rOlH9Ly7VDj98vHoBnNnyoHl35fZTzLbZHJCNJJmL3yIriclNClxx6blo8Np93ljciFIKntRebs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753945083; c=relaxed/simple;
	bh=iGPD/TNw35rf8JU9VX4CkNhrD6g8GVDuImcE3tqW9qw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eBFBSFzFlYw+HCynLPMNX/MNpLgc69Lq7OYPD6Q6fn1RvTqdRV5UvFrRirsZv00wBo89h704/EnwmcXlMduiexuUuS86FFDTdNGOW1Zr3NjqYNiyrcHsVYhDFXXuAptciXfXp5coJ7EvpOYClDXcmO7jWcRizXmM5X8EXr9nJDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVi3Sipq; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVi3Sipq"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-313154270bbso104012a91.2;
        Wed, 30 Jul 2025 23:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753945080; x=1754549880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6dlh8XwGy1SjyENdbge1bkKF4yxVkK/f97ED5kL60Ho=;
        b=DVi3Sipqbx9paDd5BHXbn0B7+8WDXgSV9M9A/7gTfTPBxQCqb63hSuJJrwXkygnXN8
         35WWHiaN2s1ClpjDXDqaUa0Z7Rg1kOQIKaI2qdJxR3vaTyIlB8kk6smlXjn9hdO2eNVT
         zklE1OiTZGb+bcYHPMnL/+NdKfxz61KA6FiAvTQ8OY8dfKDdaw81zOui7Gj1DfdgqcXi
         C6ibY6BtZ7XurAVBR+wg1NN5YKTVCySj4uRbO6D22VXDJHFnhFn3jQuiipEbt79dNZfc
         Mfz5adamvaZnvJdiQ3hpVVILCPwGstyRhiP/i3l2sGwxUcIQpaqk5rRW0o67P1wH5P9d
         PX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753945080; x=1754549880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6dlh8XwGy1SjyENdbge1bkKF4yxVkK/f97ED5kL60Ho=;
        b=omm94n3MV/C2ZywXxvfPd96lAEfD8XU9oi3kaG3BIwOKMIt6eC2xb/IbPNEPb/6cXL
         oFyof4xJv8AFz+Qsv0EQh0StG40H7e0JfEMcwE/jbtkllb+2Qr5ET5EUf4OZ6oSRHfqG
         n3+ehBiyV6xLLMVUkNFvXxNDl4oM/kbL/YBIhcvJ1uEFUoRCId3L93DHYjo42sId6yXy
         qerx/+WPLXs5Q+NLCzqGEBgmA35dEjnApcukHGq+fMHdODJPuQpM+4o8Pm66ff55gFaN
         zsYDMkPezP0McQbN0nQo+9ZXH8WFAXvNIc4BnlHQDZ/DHhJvrqcybQohl40ZwAFZvfmL
         LPpw==
X-Forwarded-Encrypted: i=1; AJvYcCUlSRyJqmRAEfchqoyesHyvJGRRsibDoULjO6n9lt+iQtV3eM648v/npmtSYse95pUQUW8jmBxuYp3+4tI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFdIKLCFOYolR72v+0CHp6cFlRZ3MsXHyAiISI2M6XuPmPXqSF
	jNGqN80Rg9Ht8tJcyTlT9KLNDF1bdr6/Qf3qM4fJqUGvCugl3SpnkQAV
X-Gm-Gg: ASbGncvyHoFJkuyFQLdCAMTILTvEoKQtyyhJf4Vmn3VTibvWkzWCF2GhKrg6X0UQnqO
	9LqC9zmU079I2Awi5vsBxgna7wrbXKU60LJ+iBcYtgjoVQ5ROGZYIlHeNHLRJNM0/UqkdPTX2h1
	x6ua8N/k5hGnydl6XD6Pf8Gp/MNVEGKw7qPXy3+Ps3N+UoY7xpiowXLLV1zlQhtqBmCo6j/56S4
	HC0RmwC5JQLWrOpfe0ptG1+X+52fP5bab6fIi56WCOfficcJGKCNifVGNH+NP+HmOH26fu1bLVR
	UH3yjIjKDQ9mR0fGZG4C/e31Jb+hpIhUMNMMUO5wZ1zm4GOH67EcRVbLPe09CvZbf3XgRpPNHn7
	3DXN2aUzbN6+8/RB9OHAC3XEXWjHH5w==
X-Google-Smtp-Source: AGHT+IH0omocCQWIH5Y6qHj+N3maXQG6SCixN09ykBfExW/iWIwVQrrncwzLhCMgj99E1nAEz3JwUA==
X-Received: by 2002:a17:90b:3c83:b0:31f:69fd:a72b with SMTP id 98e67ed59e1d1-31f69fda784mr5904201a91.29.1753945080184;
        Wed, 30 Jul 2025 23:58:00 -0700 (PDT)
Received: from victorshih.. ([2402:7500:469:65dd:3aa4:3d44:3e04:a6c3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207eca6fdfsm1056736a91.20.2025.07.30.23.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 23:57:59 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	ben.chuang@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V4 0/3] Mask the replay timer timeout of AER for GL9763e
Date: Thu, 31 Jul 2025 14:57:49 +0800
Message-ID: <20250731065752.450231-1-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

These patches add a sdhci_gli_mask_replay_timer_timeout() function
to simplify some of the code and mask the replay timer timeout of AER
for the GL9763e chipset.

Changes in v4 (July. 31, 2025)
* Rebase on latest mmc/next.
* Patch#2: Add new message to the commit message to explain
	   why it has a stable tag.

----------------- original cover letter from v3 -----------------
These patches add a sdhci_gli_mask_replay_timer_timeout() function
to simplify some of the code and mask the replay timer timeout of AER
for the GL9763e chipset.

Changes in v3 (July. 29, 2025)
* Rebase on latest mmc/next.
* Split patch#2 in V2 into patch#2 and patch#3.
* Patch#1: Correct the wrong parameters in the
           sdhci_gli_mask_replay_timer_timeout() function.
           Add new message to the commit message to explain
           why it has a stable tag.
           Add fixes tag to the commit message.
* Patch#2: Add fixes tag to the commit message.
* Patch#3: Add fixes tag to the commit message.

----------------- original cover letter from v2 -----------------
These patches add a sdhci_gli_mask_replay_timer_timeout() function
to simplify some of the code and mask the replay timer timeout of AER
for the GL9763e chipset.

Changes in v2 (July. 25, 2025)
* Rebase on latest mmc/next.
* Patch#1: Add a sdhci_gli_mask_replay_timer_timeout() function
           to simplify some of the code.
* Patch#2: Mask replay timer timeout of AER for the GL9763e.
* Patch#2: Rename the gli_set_gl9763e() to gl9763e_hw_setting()
           for consistency.

----------------- original cover letter from v1 -----------------
Due to a flaw in the hardware design, the GL9763e replay timer frequently
times out when ASPM is enabled. As a result, the warning messages will
often appear in the system log when the system accesses the GL9763e
PCI config. Therefore, the replay timer timeout must be masked.

Changes in v1 (July. 16, 2025)
* Rebase on latest mmc/next.
* Mask replay timer timeout of AER for the GL9763e.

Victor Shih (3):
  mmc: sdhci-pci-gli: Add a new function to simplify the code
  mmc: sdhci-pci-gli: GL9763e: Rename the gli_set_gl9763e() for
    consistency
  mmc: sdhci-pci-gli: GL9763e: Mask the replay timer timeout of AER

 drivers/mmc/host/sdhci-pci-gli.c | 37 ++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 16 deletions(-)

-- 
2.43.0

