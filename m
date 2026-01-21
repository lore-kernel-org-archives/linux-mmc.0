Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95872C21E6
	for <linux-mmc@vger.kernel.org>; Wed, 21 Jan 2026 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007310; cv=pass; b=LxBohm1yit8nqXHEK3c1cK9KGjUbKah9/WHtBork2Pju/JAiO8HMdAZvsbnGxoOa96Nb6cddngamfGw9TXVF6hguxILlx+zmgIc79YdI+Jy83J+/V9gEsrHvctJbDVudzWZFkPeUzLNGYouXo7E1xhc88r6YKTRLgekjhKcRzAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007310; c=relaxed/simple;
	bh=dGTkOkT9E2FQ6oeznFE2rinSZVNAj7EqmVbxpgBI3dY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yaf96frXGyxOKQUKkYuAMZlmaaUj7QXL6C606hrfGCxgdLYaJGRPzFV8Lj0ZLHbucGbEGSc14n4PhUpgXZtW5vlqPbwDGhSdoVO8pToUOsHkBRQ/KOTgTJ71O2QIn9FMwnnuEe5n+GSWQe7M+P5PCppYa1SfB/0e+H7MoCbTit8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FsWIBNRP; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FsWIBNRP"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59b30275e69so8407230e87.1
        for <linux-mmc@vger.kernel.org>; Wed, 21 Jan 2026 06:55:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769007306; cv=none;
        d=google.com; s=arc-20240605;
        b=G9h3zYGEXpIG8kRH5by98UbDIHGW+25xcsZBdKkI8GMO/oVdZ3drFf9FsieR+P3HB/
         ITvr/t4WgYBmOmfBtJcn7k1/p/ilViX/6q8FOfI3jkteu2r1aYY5ZRK299V9Eb3o1YDJ
         7uoOK+tYTFbEp0rMqalMns1maczcqndBP8+viErsoGZ4NoP26jzjdpTqVprgXby27rBM
         sG+hy8FdjArRnoK8mXmRZYCVl/0m4q52P4ZS1TQmEOlSfyFqVKshWWnPe9AqGP+RihZD
         aChVx5zjWsy0VPfgIDhH5/dhuDALobJcmFsQEQjxbfVftHKw7KbZ3HoQvvDDwDVZvoxk
         LE2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=v9aLt0x7ySxnVedjh644CuYYTkGyrGOwlPb9hRw8WNo=;
        fh=KoqGztwngR6PdGJ8Zdpt0AM+vckyLe3HVZe+rn0KKvw=;
        b=WTwlOXRhC8/A9QBSg7/eLUaSwRmzxeyJvjYRMCtKaVabZXRpE/XifMtFosd8+KlsXO
         Yxw72/AP7Jb1LnFUnwt/JzjdTuQ0NoPatBSl1xV6ptX9JwKm9KbRmWpZmZ5NNn5SHANP
         ELU6EiWk3Q0PYdteAF5GJDq4hhJqTie41Yn0PHT5TBphTJj5ZBqCBdbjyd6YvwqRxtXm
         STLetOp7AlpxmkDUeSl8Dl2kmLox8GLg35s6mEAhZh52M23Dd59mlhE6oG3kLK7J5PxM
         FRNVDfNd/tKKYZ1xpJSEtF5A5Cdttg+erBNZnhPm0xTY8elihtVtOMUEyP7kp0kx1C+0
         F6aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769007306; x=1769612106; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v9aLt0x7ySxnVedjh644CuYYTkGyrGOwlPb9hRw8WNo=;
        b=FsWIBNRP58PDzVOfqlZ1ysC9UCjEBpOTw0xZIiWUAbMtH07KfYc2N9TwZ5N2Kp+zEN
         vjwSxtwIxrPdUtJo0rCuKC0xjwcf6bXGemIr7GbiCBdryW3r+KureobXA4gFEl/+M6fb
         +M6/kLgQfJQEofauRBYmdXx11F3gbGf/VkWxUzQmb7lbNtmwOkO/jKbBkpaulafue0uX
         BT/zpCQ+yHKTu9tbrMQSAlUlFIOtnxA4Xsl7zh+5qkwUtPaIX0vzUPUBJ7GlyBsiUcdT
         UvDW6O/UEmG6HUn5UbWcZey0UM8iCZfFEDGkBOAH915AV8DyJ1iQ80qZp6t8dhKCJOE+
         CMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769007306; x=1769612106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9aLt0x7ySxnVedjh644CuYYTkGyrGOwlPb9hRw8WNo=;
        b=C+7CmhY1Mu8hNf7Wq8qHlUKCylHDo2bJ5WQsO5OnLAQTReYKvwRhMZqZWtCXYnB2QZ
         jGQtFv1lZclgpnAXL1hNhTP0Y9UJoJEWtE7mOnaAcM4XeL/GQkFYEXej7jh1tFlWSi7c
         vHQ/J5DN7w3tK9/w1x54a4/qLpK44JbI7ctlocARb0xKYjgunMyfa8m9qyqtSZXSi/P2
         54HXNgnwVNX7tHbWv4Pfe/Myi/yScfONsc8J/+UD2EjlW0a72cMWtZPTZJ59hzElwHEd
         EeOL++BijqX8H0eA51xPqqsgjfkYz04UlZcgtkyXoHDhhfh9qPKgospu1jm5P+SFJCny
         JG7A==
X-Gm-Message-State: AOJu0YzVYwH53HX+GTMEq9qSOCUVV2EBVzM0I6yB8XIkUYxhM2aiJln4
	cV6KjLsEqEvVC8dUVu0fOPQ2RHaT0s5IRpfqXQM0fnOymquYSbrVhH9PWUuWdW213iiU91SIlYm
	WtXevGmT8KyxsZu7ZsB6VR5D4Y+6xbiBhXXkHe5pzGTMaoXgGk4iX
X-Gm-Gg: AZuq6aLs1OdnxTHuq4/C68ZuZde3I6yH/soWkaF9G1DqpEmhmU3vvo5IsU8AXIm8c9K
	cil2kT7eDQU9ATXi2MfgxLQAyxFbB/DS67PVX4HEXOA4fXe6cecPseeG29Pbua9mzcooSK87vqh
	BedA9U3KKqzs9ARDiXxSH8/mtgGPB9YMUJ6Sr4J9pQNgcneiYVyh8V3Cy+ViENrbJuIOa+K0xbc
	1I6EOD/5uPSZwC7WKvy4MhCL2YNUHxcy0qAuYSA8GxQSImtTdyF4Ec4wp6tAIaAMPb4imFP
X-Received: by 2002:a05:6512:239a:b0:598:f1a7:c70d with SMTP id
 2adb3069b0e04-59baffd2823mr6263601e87.38.1769007305392; Wed, 21 Jan 2026
 06:55:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 21 Jan 2026 15:54:28 +0100
X-Gm-Features: AZwV_Qiw2uXYYvrdLovdqdqlnAPyvqCoraS2QoOI05e5ukv3dcsTk8FiMyQUVuw
Message-ID: <CAPDyKFo102Bc_feqzpjR04CFDTDSS-7g97bOv11-L-hGye3Ztg@mail.gmail.com>
Subject: Re: [PATCH v2 0/18] dwmmc cleanup & improve round 2
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Jan 2026 at 03:17, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
>
> Hi Ulf & Jaehoon
>
> This following patch series cleans up and improves the dw_mmc host controller
> driver. The changes are as follows:
>
> - Patch 1 fixes a potential error case.
> - Patches 2-10 refactor the driver by gradually removing the struct dw_mci_board
>   and integrating its members into the core struct dw_mci.
> - Patches 11-14 perform general code cleanup, removing unused macros and improving
>   the dw_mci_get_cd()function.
> - Patch 15 simplifies regulator setup by removing a redundant check before
>   mmc_regulator_set_vqmmc().
> - Patch 16 improves the PCI variant driver (dw_mmc-pci).
> - Patch 17 modernizes power management.
> - The final patch (18) adds Host Software Queue support to the driver,
>   which in testing has improved random I/O performance.
>
> To facilitate review, all the changes are as small as possible.
> Please help reivew them, thanks.
>
>
> Changes in v2:
> - fix compile error
> - rebase
>
> Shawn Lin (18):
>   mmc: dw_mmc: Check return value of dma_ops->init() in resume
>   mmc: dw_mmc: Remove dma_ops from struct dw_mci_board
>   mmc: dw_mmc: Remove SDMMC_INT_ERROR
>   mmc: dw_mmc: Remove assignment of pdata in dw_mci_pltfm_register()
>   mmc: dw_mmc: Remove caps2 and pm_caps from struct dw_mci_board
>   mmc: dw_mmc: Move rstc from struct dw_mci_board to struct dw_mci
>   mmc: dw_mmc: Remove fifo_depth from struct dw_mci_board
>   mmc: dw_mmc: Move detect_delay_ms from struct dw_mci_board to struct
>     dw_mci
>   mmc: dw_mmc: Remove bus_hz from struct dw_mci_board
>   mmc: dw_mmc: Remove struct dw_mci_board
>   mmc: dw_mmc: Remove redundant struct mmc_data forward declaration
>   mmc: dw_mmc: Remove DW_MCI_SEND_STATUS and DW_MCI_RECV_STATUS macros
>   mmc: dw_mmc: Improve dw_mci_get_cd()
>   mmc: dw_mmc: Remove unused register access macros
>   mmc: dw_mmc: Remove check before calling mmc_regulator_set_vqmmc()
>   mmc: dw_mmc-pci: Use BAR_2 and pcim_iomap_region()
>   mmc: dw_mmc-pltfm: use modern PM macros
>   mmc: dw_mmc: Implement Host Software Queue support
>
>  drivers/mmc/host/Kconfig            |   1 +
>  drivers/mmc/host/dw_mmc-bluefield.c |   2 +-
>  drivers/mmc/host/dw_mmc-k3.c        |  17 +---
>  drivers/mmc/host/dw_mmc-pci.c       |  30 +++---
>  drivers/mmc/host/dw_mmc-pltfm.c     |   5 +-
>  drivers/mmc/host/dw_mmc-rockchip.c  |   7 +-
>  drivers/mmc/host/dw_mmc.c           | 197 ++++++++++++++++--------------------
>  drivers/mmc/host/dw_mmc.h           |  75 +++-----------
>  8 files changed, 121 insertions(+), 213 deletions(-)
>
> --
> 2.7.4
>

The series applied for next, thanks!

Kind regards
Uffe
