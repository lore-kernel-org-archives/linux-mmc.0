Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A1C22F75D
	for <linux-mmc@vger.kernel.org>; Fri,  2 May 2025 10:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746180646; cv=none; b=pSX9cBeLoRIqBwMWXJczzao0T7kMdu9NnSOZ5YRUwXwVtes/FH2twkSkkoo0wW2INa+qcBpLYLv+Z5aGYWNbCDOaBxLgBRNnUmaeDH47p8zInoTZBY2jdNkQbU8w1ZyF+iSpF/J5m6RxUQdKk5XkJtGjxzXYuY33dvnkzMuKdoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746180646; c=relaxed/simple;
	bh=NRaNRwgJw2ySpm1uszh7ucF+STEh9ICx8w3ZI3FGup0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/JihlWabj+bDuOAsrbo8RDl2dHksNhnu53/DD6gpjswKyXwFVeXzXvoNgs4kkmRkqOvHcVAI2PJk2Zo4bzPUAO1DBUbaT8Rryq6ynDHut837/+d9aJfaot5j/Z8YsdtDNRcnJwxdgH+Z0zaSYyPvwD+9tbqIcs51LEzhUAhxqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W4ACSy1f; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W4ACSy1f"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e732fa4e2f1so1842823276.0
        for <linux-mmc@vger.kernel.org>; Fri, 02 May 2025 03:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746180644; x=1746785444; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Oq9tm7apv8HfpkSWn4ynXIbLe4Sy1cFrzADlYd9EguY=;
        b=W4ACSy1fnSwPcGXK2dEV4d+lOUGVD+OC0IhbxX6SqPz4X13uYAGd/4LWmBX24pMT0b
         HVh51EX/xM/9ZentZaFI6MnmlIT7/MXBp9d1BO5enfudOHDMg4Ti80/OYgkj2bEakG7R
         4MEQrDQ7R/h9i/8y5QtCI6ER892X+/szzAEiN8x5rNRUmGjs1ktFmrPbaOfXCD7Ro741
         IZt6l3wZ7ROlSwbAzyLgWElhmVqFUW+EfuxWNY4945p+dcPyIw8okF7/zfNKiuJGFoZJ
         +nQa2PP0Ere4C01gvlEqfyGMFThy1VLGEJpnM/Yf87BmgRpby7Js159Y8kueRKXsWHjc
         09dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746180644; x=1746785444;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oq9tm7apv8HfpkSWn4ynXIbLe4Sy1cFrzADlYd9EguY=;
        b=g5YiLo7nxPn45G3Nd+zxyHrMgW82qjSm9PmX0LQkSutIzl0MCV2xCTnX5xAJj+uJ4V
         acMdWRWdg5T7clTAot3PQtnUBMu63RXo9hWKlPK3cbd8WMfF7p2Ki11Kb2p+z/21UijW
         iBYPwBKT8g57Ob1lq2quNyFsp4Loq0sTe+d7oTtGtl6S9S2yrYK4NmTaTjEKC5ra83rv
         kiwVOGzENGWEHj0fN5kbh2dAXFRJCN5Tq9gxpwYhosY3IqKSanU3W+3IMyqdpOLoIbTf
         ZQD1kocOwKmzi/zpVdqHYgjUeVyRuHcgiypAaOJDhRJ2FOMiVcxuwPOoJ4EXSOHnvGIk
         nOSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBavvJWxerNsrGaIyeV+w9xOFNHNb+hS95qTXl6bSpGos7F44OYlowvPlzQaIzG9r33rXcYElrEE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcMr9oH6BfVx7ga4Yy5bITFEKldnLnwXFeiye+gss9lyIjgIwY
	qsSPzkYhka3Bq64WGndnYWMV5CiFB3HMRneaRGKRiW70lUvtUeNoN1f7bo9lpL+grI7g/fX4ORW
	ccx1wJCoW+6IWTT6+87VcmKvOzS5mIxEHc2tBnRr8Tlf/v+YO
X-Gm-Gg: ASbGncsIHc5jhVTYZIuV2infs161O8VWCM/MVYdcLU/Qvit8stZrT6fMi6G+IVoJw59
	8LLEn2qfb9l1sWPA5xrxLZkq9WZYUxpcYX77vz294R4BaL7TKZHjtRtHQbOYbLgqdQJOW3RRO60
	76b/4jax+sj3QHIErw6/H1QuRAnBvE9OXKWQ==
X-Google-Smtp-Source: AGHT+IF1X45kAsLeG6PaSemMtmpyHeuaIweQnw6Td3Ou//02ohdpFslomOMivlLZaBIyV1eeN+aMHMOr/NSsHT1rGmk=
X-Received: by 2002:a05:690c:6185:b0:703:c6fa:2c30 with SMTP id
 00721157ae682-708ced559f0mr38287527b3.15.1746180643593; Fri, 02 May 2025
 03:10:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501063325.7262-6-wsa+renesas@sang-engineering.com>
In-Reply-To: <20250501063325.7262-6-wsa+renesas@sang-engineering.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 2 May 2025 12:10:07 +0200
X-Gm-Features: ATxdqUHCpPYIkQisGH6-bEULr0pkesX_Fpa5p5kRjxJ8r-5G_t271XrpJ-c-dHY
Message-ID: <CAPDyKFq3AaeWOMiCAvHgxGzhfzume3VeJFFnt-f37h6g1mUo8Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc: add '_can' to capability helpers
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 May 2025 at 08:33, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> As discussed previously [1], some functions also should have '_can'
> included. This series adds that. It was build-tested locally, still
> waiting for buildbot results. Based on mmc/next as of today.
>
> Unlike [1], I changed 'mmc_boot_partition_access' to
> 'mmc_host_can_access_boot' because I find it a lot more descriptive.
> Given that new name, I also did not see a need to rename the capability
> itself.
>
> Looking forward to comments!
>
> [1] https://lore.kernel.org/r/CAPDyKFqxHd85DsUH6eZVyoocTDrvwNu+wTLRBq-jUwDY+2iFTg@mail.gmail.com
>
> Wolfram Sang (4):
>   mmc: rename mmc_host_cmd23() to mmc_host_can_cmd23()
>   mmc: rename mmc_host_done_complete() to mmc_host_can_done_complete()
>   mmc: rename mmc_host_uhs() to mmc_host_can_uhs()
>   mmc: rename mmc_boot_partition_access() to mmc_host_can_access_boot()
>
>  drivers/mmc/core/block.c    | 8 ++++----
>  drivers/mmc/core/host.h     | 8 ++++----
>  drivers/mmc/core/mmc.c      | 4 ++--
>  drivers/mmc/core/mmc_test.c | 4 ++--
>  drivers/mmc/core/sd.c       | 8 ++++----
>  drivers/mmc/core/sdio.c     | 6 +++---
>  6 files changed, 19 insertions(+), 19 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
