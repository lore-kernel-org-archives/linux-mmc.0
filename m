Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFAF1A4E99
	for <linux-mmc@vger.kernel.org>; Thu,  3 Oct 2024 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971340; cv=none; b=dl5oXK1K40Kmixcx1GNaNzxJgD4ejTL8EXYk9Owj47bG/YNZgD5b2VUnfGMTxr2QBzhlOWfmz2vNqVyBfP/z8qWx5EDJD/8Uu5Hsnx9aoHAEz4degtpZoDxB9jkuJCjwJahLhPwDp+ndMM6tco9lqM+Uo30k9W7jTqxV9I4KYQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971340; c=relaxed/simple;
	bh=esxikKtRX7gSNs8mFwEwyCvA6eaNvdXt14kuHDx68EI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NlB9VQBeCB4E4wEQJoiA3qVNqO7LoRKeVCi9mgoRGq7yCkY9dz8e9g0moD3nbDedrWDiJcm1djnENB8Fx1YaRb0D8nKG7yys9XBrqpkn8haA3oWh2nlg4yBd4AT7VSgWFurnyCHucN54W5AvKqZUJvC41GPmuF/4Tl3ybNIXtJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OmLjYcAt; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OmLjYcAt"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e260b266805so1050537276.0
        for <linux-mmc@vger.kernel.org>; Thu, 03 Oct 2024 09:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727971338; x=1728576138; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lC+RWSv79QsaaoyUTERso7rWQ7bXYgzJz9kup89jGuk=;
        b=OmLjYcAtPrUHTyzvAkwSjj7W8hKiJLp7X+UnbqWxXQeQiph8a2rah/cz8+efYan88E
         uEuX1uMM6Y5YUiBajs6k7EufOc40mX91FTpokyjxpUl9bj+20mBIpqhtzkIGgsZ/S4I7
         7vngFAsWFBctxc4bMwBd7YQfqof3DQrADXuY6gyF/YlDrIE/ixxSBDgL5wyLm3UukLR2
         ATvwYVZVsTdqtXzEup0wibPV2HYWmVjC1XoqJ1GJ1ysjfTmQHzoim40g51Yoj72CGEab
         Lgwr63jic4dwfzOeMNTG8zsyLnuas/lQF5rvbDL9f/pLquSbvxUoWSEXjVG7w6juaV4g
         mvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727971338; x=1728576138;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lC+RWSv79QsaaoyUTERso7rWQ7bXYgzJz9kup89jGuk=;
        b=rCosMenSlB5orlmAhjSjou8XBevMSUQHvASCudKgOsI+AKYCKjOENvJ0kqbiiEtFxc
         tmMhrY5qO0dFDKe4kTl+YFXVq9l5JbWHhLbmguTOZlyxdFDafEFuP1SmuQ0KUCIxlSMz
         Wsq4X4rKVPZ8oGha9Uz+ZE/JNJMWoEVLLbVWA87bghFTTyXmkVNjJkZyPb7/iKCWIhfE
         ONN/GFXUiajvFxoyidm/uyKf2OGdyfzOgUt7XijY0CBWLYGvnPCZNiE4hdRVuSKhDlK7
         G6fO3fGHClX6lMKUdZEpeNreG+VhChwixK7QdgOH2HXqqlkK0/V6WlbdvM08//+sOddW
         UWrw==
X-Gm-Message-State: AOJu0YyP5oFCcaRcVexbfQF8utigYWdv7kwBq51eS27/wFN8BiC69iD2
	WsCS1YPksUOQcVykjm2maNxT/T6jCuvRN/GJ5q0qkoWt19J6QGZqHQ8flgmukxB+wPKkR0N/z91
	YUHVTxmiciKgAYk5ZcTgh5RUnIvQZk7MZF+Ofkg==
X-Google-Smtp-Source: AGHT+IEa4ddK5tjFvLRMyRv3z2fwe6vDK1mSe13ETaa0sbUyhRUE2AjBnwQA/1kbHtcK/+Hm1vyLL/EQK8uZKt0EnDM=
X-Received: by 2002:a05:690c:2b82:b0:6d6:aa50:9267 with SMTP id
 00721157ae682-6e2a30e3e18mr52640837b3.39.1727971337858; Thu, 03 Oct 2024
 09:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908102018.3711527-1-avri.altman@wdc.com> <20240908102018.3711527-3-avri.altman@wdc.com>
In-Reply-To: <20240908102018.3711527-3-avri.altman@wdc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Oct 2024 18:01:41 +0200
Message-ID: <CAPDyKFpZJQ7kGngaUmLfgyKNwhVjjGEuDw96kFBY3s6hXaEJTw@mail.gmail.com>
Subject: Re: [PATCH v7 02/10] mmc: sd: Add Extension memory addressing
To: Avri Altman <avri.altman@wdc.com>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Christian Loehle <christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Sept 2024 at 12:22, Avri Altman <avri.altman@wdc.com> wrote:
>
> SDUC memory addressing spans beyond 2TB and up to 128TB.  Therefore, 38
> bits are required to access the entire memory space of all sectors.
> Those extra 6 bits are to be carried by CMD22 prior of sending
> read/write/erase commands: CMD17, CMD18, CMD24, CMD25, CMD32, and CMD33.
>
> CMD22 will carry the higher order 6 bits, and must precedes any of the
> above commands even if it targets sector < 2TB.
>
> No error related to address or length is indicated in CMD22 but rather
> in the read/write command itself.
>
> Tested-by: Ricky WU <ricky_wu@realtek.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/sd_ops.c | 16 ++++++++++++++++
>  drivers/mmc/core/sd_ops.h |  1 +
>  include/linux/mmc/sd.h    |  3 +++
>  3 files changed, 20 insertions(+)
>
> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> index f93c392040ae..bb83db85a689 100644
> --- a/drivers/mmc/core/sd_ops.c
> +++ b/drivers/mmc/core/sd_ops.c
> @@ -16,6 +16,7 @@
>  #include <linux/mmc/sd.h>
>
>  #include "core.h"
> +#include "card.h"
>  #include "sd_ops.h"
>  #include "mmc_ops.h"
>
> @@ -188,6 +189,21 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
>         return 0;
>  }
>
> +int mmc_send_ext_addr(struct mmc_host *host, u32 addr)
> +{
> +       struct mmc_command cmd = {
> +               .opcode = SD_ADDR_EXT,
> +               .arg = addr,
> +               .flags = MMC_RSP_R1 | MMC_CMD_AC,
> +       };
> +
> +       if (!mmc_card_ult_capacity(host->card))
> +               return 0;
> +
> +       return mmc_wait_for_cmd(host, &cmd, 0);
> +}
> +EXPORT_SYMBOL_GPL(mmc_send_ext_addr);

This doesn't need to be exported as it's only used by the core module.

[...]

Kind regards
Uffe
