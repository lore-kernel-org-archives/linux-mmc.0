Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDF813B294
	for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372788; cv=none; b=h2jxSg939kwh6GPh3g1RFxqAMA7NMAP25fbx9gZ8i890f/HV/C6+qzdKUZ5cx81TERYkYUJHB9vCzS7/ozm4yxb82Pys44UG/lui8HvVjsPzZFQPUbJVy8g6NplbqUSa+hEIByi5I8knWIG7j3q56ehxRQZe5GGDwBMIFG2FAYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372788; c=relaxed/simple;
	bh=i/F7ZUQC2WibdKQHGCsevnCdGMSfUeGxIYrzHXFi104=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bO1S18amo2vapF/WtGzlfpcrx/L5ao+lTtCSNnhfgjv6nArXPTmdczNCapwbZxwY3gfibuhrAZcSGm8XLKYaodP6aTijvuZWQIVFvCVi6gtaNIt8tjrOIWwn4sTRge3ZVyL+15b9OqfpxEH5dqGUyC31KAlH5heP7VRQ0zLYRA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bQyCNJ30; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bQyCNJ30"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc236729a2bso4128043276.0
        for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 06:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711372785; x=1711977585; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=an1XrIb9VvljrFF0I+tmW7F3KNLXCqH0DCXayAqvq4U=;
        b=bQyCNJ30DbOcHRPpFOr9+TM6deHbOpyirsnMnTG8zx8g2SzQo+LNiczsFp9PCWL54F
         yRifp/qlG0XULwkWiLeO8FCNxwpkAyJ6dYxJWmPENqPp4poM9rYzF3Mxhp43XnU5ULkY
         tjjyjh3nBE2wxvYDoaoBaUYAeOvSZQOusoAjXkVRUfm1QSN/VanxtOb+2vR0KDgiNA/9
         LctGeVPCyP8Q6vLFlBGsJPcz15sAZSNhogHJqUl7+FrKI6/QuI5Ol/0f5IQX1UwHTEDx
         7ZY6o4+96CdHvop62icyxMVPNvXvqtg7e9aSdBk6EY5xERrvyqYLiCiaqFDmdRbLoo3z
         OdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372785; x=1711977585;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=an1XrIb9VvljrFF0I+tmW7F3KNLXCqH0DCXayAqvq4U=;
        b=lvt362Y+8mNR7Bh1cV2mQwuh9eVSAgz804lqTmTQijF5iRkeVMKxjzv/RZitklhvR/
         trgf3SY3sSitK2IYF117AiAYF88p968stByhfMiQW+JIULcDo09quXmkQZ7zbAUVyw40
         50eZkrojfbrUf+AspigI1GFRS/O5QNp/Iu6lg5C5kTbsUMMe+b80Q9c/caaJWCYsPBhJ
         ukGKwssqAt5rURmGEczZwHNuAh3gxBdmkMSKYxboL22wGGPRWaZr2jgU06nVn98SHeGs
         u/My8cxjnz4pDJW+PiM8qnVAnkJA1kPDgSS4GXdA9/zx96jKpInLx2dNjMruvnpSm8bX
         ltNA==
X-Forwarded-Encrypted: i=1; AJvYcCWGkFesYeOvBoz9HQjBOK4XTf7epx4sOcJ3ua9sxzVQwT5HwLfg8HPV+bcJb5puDR8QSiaXkPKB9zu9W+yLi8NapJLA7I72zgKI
X-Gm-Message-State: AOJu0Yx2FSXeRHRMfPnzj8D4Cr+2GtVQFU3v90DnFFyuGfq+V+kyZlpE
	LnB4XRohNYqH0DezpwBKvi4EkH9D2vjLkl5vfiT4fgTz2VD8cUB7hCioVnqApzdu9LhgH+YrbTY
	xdKBzHFLQjLrHZlJybvoILKjbtmNvcfj3PBuOZQ==
X-Google-Smtp-Source: AGHT+IFUMyHdn2LPn/q2Dnx5oB+SnXCwPU31SA3monsIPijGID18Z+XiqEWgW7vMhOAi9lK0th7DKjTMyHLHReWKyCk=
X-Received: by 2002:a25:2d11:0:b0:dc6:cd76:5ddf with SMTP id
 t17-20020a252d11000000b00dc6cd765ddfmr5281307ybt.39.1711372785586; Mon, 25
 Mar 2024 06:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319115932.4108904-1-serghox@gmail.com>
In-Reply-To: <20240319115932.4108904-1-serghox@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Mar 2024 14:19:10 +0100
Message-ID: <CAPDyKFokNLX8zAr=Cai58UZivt_c63aQXjaLyuPKnzAmQcQhzg@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] mmc: sdhci-of-dwcmshc: Add CQE support
To: Sergey Khimich <serghox@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Jyan Chou <jyanchou@realtek.com>, Asutosh Das <quic_asutoshd@quicinc.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 12:59, Sergey Khimich <serghox@gmail.com> wrote:
>
> Hello!
>
> This is implementation of SDHCI CQE support for sdhci-of-dwcmshc driver.
> For enabling CQE support just set 'supports-cqe' in your DevTree file
> for appropriate mmc node.
>
> Also, while implementing CQE support for the driver, I faced with a problem
> which I will describe below.
> According to the IP block documentation CQE works only with "AMDA-2 only"
> mode which is activated only with v4 mode enabled. I see in dwcmshc_probe()
> function that v4 mode gets enabled only for 'sdhci_dwcmshc_bf3_pdata'
> platform data.
>
> So my question is: is it correct to enable v4 mode for all platform data
> if 'SDHCI_CAN_64BIT_V4' bit is set in hw?
>
> Because I`m afraid that enabling v4 mode for some platforms could break
> them down. On the other hand, if host controller says that it can do v4
> (caps & SDHCI_CAN_64BIT_V4), lets do v4 or disable it manualy by some
> quirk. Anyway - RFC.
>
>
> v2:
>  - Added dwcmshc specific cqe_disable hook to prevent losing
>    in-flight cmd when an ioctl is issued and cqe_disable is called;
>
>  - Added processing 128Mb boundary for the host memory data buffer size
>    and the data buffer. For implementing this processing an extra
>    callback is added to the struct 'sdhci_ops'.
>
>  - Fixed typo.
>
> v3:
>  - Fix warning reported by kernel test robot:
>         | Reported-by: kernel test robot <lkp@intel.com>
>         | Closes: https://lore.kernel.org/oe-kbuild-all/202309270807.VoVn81m6-lkp@intel.com/
>         | Closes: https://lore.kernel.org/oe-kbuild-all/202309300806.dcR19kcE-lkp@intel.com/
>
> v4:
>  - Data reset moved to custom driver tuning hook.
>  - Removed unnecessary dwcmshc_sdhci_cqe_disable() func
>  - Removed unnecessary dwcmshc_cqhci_set_tran_desc. Export and use
>    cqhci_set_tran_desc() instead.
>  - Provide a hook for cqhci_set_tran_desc() instead of cqhci_prep_tran_desc().
>  - Fix typo: int_clok_disable --> int_clock_disable
>
> v5:
>  - Fix warning reported by kernel test robot:
>         | Reported-by: kernel test robot <lkp@intel.com>
>         | Closes: https://lore.kernel.org/oe-kbuild-all/202312301130.itEZhhI5-lkp@intel.com/
>
> v6:
>  - Rebase to master branch
>  - Fix typo;
>  - Fix double blank line;
>  - Add cqhci_suspend() and cqhci_resume() functions
>    to support mmc suspend-to-ram (s2r);
>  - Move reading DWCMSHC_P_VENDOR_AREA2 register under "supports-cqe"
>    condition as not all IPs have that register;
>  - Remove sdhci V4 mode from the list of prerequisites to init cqhci.
>
> v7:
>  - Add disabling MMC_CAP2_CQE and MMC_CAP2_CQE_DCMD caps
>    in case of CQE init fails to prevent problems in suspend/resume
>    functions.
>
> Sergey Khimich (2):
>   mmc: cqhci: Add cqhci set_tran_desc() callback
>   mmc: sdhci-of-dwcmshc: Implement SDHCI CQE support
>
>  drivers/mmc/host/Kconfig            |   1 +
>  drivers/mmc/host/cqhci-core.c       |  11 +-
>  drivers/mmc/host/cqhci.h            |   4 +
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 191 +++++++++++++++++++++++++++-
>  4 files changed, 202 insertions(+), 5 deletions(-)
>

Applied for next and by fixing a minor conflict when applying, thanks!

Kind regards
Uffe
