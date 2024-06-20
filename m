Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39111AF69F
	for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718896510; cv=none; b=ldRE97g8CYZWU5eBefbUYQnlNCWDA2YmxOgQXs1LO91sjLL8vQ3hnuoeU0e00l/FfgocTZ/STg6NkKOC9DAA6N1ar9oXExpAC/fw5s/OrGOf+2Y9Otef5Vuf1sb0TK5XdHZ8+0JIKuSMe8H2Dh+K9/uLTF25cDHEogRf+SgGi+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718896510; c=relaxed/simple;
	bh=5Q/LpKrUMj+GUjNr8uJX9NrB7ftIKjmvK0bIMUhG1Ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OPdus592T1vXQSojEQLWFM/s/coMaWIuMQqnMrbynI/N+cnsV/F8L6ZfUhdXeGM2IDryNMfMyJnyuHCwdf1JN+A2Y5Lv20AESZq/aVNjZxQAC/hzRz3TB3S6pKVtZtCxppY7d9lVESc4XtwwVUVv9HMRWajnmtNNBAJcbR2PPrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xcnz6bUD; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xcnz6bUD"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e02b571b0f6so1019866276.0
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 08:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718896508; x=1719501308; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oQ3hQpFuCPYzLWdutsMgbuUg6a0Fha9AA84QwPaK5uY=;
        b=Xcnz6bUDzWdVsS0gJZrLwJ+65vsKIoZf7D4NWpY7cVtH3Scj8Co2ZWS+Ug1QjgEgYd
         KVOjPRz1dkrOohZr2sQujOsy+Efo0w9DH8Oq/3LWPOYUf0ePEJ5zXP9Vv4P6UIDCSTnK
         O/zlxHEY9FxO460Lob46edRXxRDX2wI/eoWZf+lTNxIW5Lz+HBPn1ZjYM+smVVVYgrJ3
         GmyDiYyccAbrMqCUBCHivMqPOSnzMK5L8VUBRIGusOWN52weObmlTUbaRWdVU2DnD46Y
         MpsgT3R2fCmEqTT/59uPn4AVS92W9xLIBwVI7wCW1t8Cw+I78SUo/mRPBBmfoxbz760D
         /xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718896508; x=1719501308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQ3hQpFuCPYzLWdutsMgbuUg6a0Fha9AA84QwPaK5uY=;
        b=oMm96qAVcX9+pDF9+e3vEkmYiNwAsQE51dRW8b8BftQUWNB5rLlanFLfkvt7nvgqsH
         mO8QYwzNcLSA8w0WVdtqEyPdvqgIN6OFcSBEYejLx+8HfqfThEsYp43jmzvNncpvqOeJ
         gujJhJML39ABJd2Sahf49huNdakmygKIDkc3q0jfueCd/56l+6Kw50slIa8X9i72bZnN
         JOT/5AU4X3i+CaiOP/8enW2IOZriZ/IUkB/tuoFaM4c68s9xc/IgasCfEgGJEU6JAPdE
         VXZUqcR1vscODkV+wrOO5Gui5BRay0FPsZO7dhzmWfVI8tc0HwiohmVyAhTbi10OGNrQ
         j/tw==
X-Gm-Message-State: AOJu0Yy/lRWjsV2rJhXXvojHcI2ZFGeujFKjyR7g3e0AZ9MJsR7JGpbk
	TMDfZDss+LZRyoehMDwbKHSIVI1RM8ub7FOq3XdenAFiHfOng/KEWpxAGGZfqGwDBUp0FrGVcxK
	OEJfQKZMU3u6ELvtxWYxhnALQAuhg5A1TOvkJ0w==
X-Google-Smtp-Source: AGHT+IH31WgoBCCpm5woVrfLqL1e/LJK9K76SKyVZJ09Zf4BxcOjwXO5mscGmc6M/wBxmSb0YUwqQL104AasuKVJINY=
X-Received: by 2002:a25:dbd1:0:b0:dff:4a3:2ded with SMTP id
 3f1490d57ef6-e02be13f445mr5996480276.22.1718896507961; Thu, 20 Jun 2024
 08:15:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614080051.4005-1-adrian.hunter@intel.com>
In-Reply-To: <20240614080051.4005-1-adrian.hunter@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 20 Jun 2024 17:14:32 +0200
Message-ID: <CAPDyKFpU9_=B4MKvdR+aFOm+jMUm9Jw-wLnqvCXKR=5csKH9nA@mail.gmail.com>
Subject: Re: [PATCH 0/3] mmc: sdhci: Tidy-up write-protect handling
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Jun 2024 at 10:01, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Hi
>
> There seemed to be some issues with sdhci write-protect handling,
> although no reports of them actually being hit.  Here are 3 little
> patches to tidy things up a bit.
>
>
> Adrian Hunter (3):
>       mmc: sdhci: Do not invert write-protect twice
>       mmc: sdhci: Do not lock spinlock around mmc_gpio_get_ro()
>       mmc: sdhci: Eliminate SDHCI_QUIRK_UNSTABLE_RO_DETECT
>
>  drivers/mmc/host/sdhci-pci-core.c | 27 ++++++++++++++++----
>  drivers/mmc/host/sdhci.c          | 54 ++++++++++++++-------------------------
>  drivers/mmc/host/sdhci.h          |  3 +--
>  3 files changed, 42 insertions(+), 42 deletions(-)
>

Patch 1 and patch2 applied for fixes, patch3 for next, thanks!

Kind regards
Uffe
