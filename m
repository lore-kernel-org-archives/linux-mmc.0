Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD8A48097E
	for <linux-mmc@vger.kernel.org>; Wed, 21 Jan 2026 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769004803; cv=pass; b=TdBF0x0JZabsg38KvoL4EWXWr3+RGWSZVH8dDmqKQLvq77T94dnOPxo/AUZNpv5WmvALhFzsZokGbIm/K95MfMfGDTdeTA12x7v5U8+S6qB2JCnFMvcCQtOxQmUzBnV9AxZbD5/b/trT7OOAc1kNfPYqYuBLgURFb4sUM90cP9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769004803; c=relaxed/simple;
	bh=AG+0W9qVGwr38aOC3Ls4cByXNYR0b7a0ezY0mCq2/UU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lso6R8KC+QyCKJci0AZgm12+Yb/l7aG7qN47vVQDe9uiXghv3UPTbOUX39VOOFEkCcga1YqYiJ6P3Hfec4WJ8r78pXA2CSmwEbtcLF8pTG1PVCXR5GfUEuyGOnVuyjYGSZLrom4i8oFUbvdUyRmXp+4do66MepJueqYMzFvQ1pY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u2GF+l0n; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u2GF+l0n"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59b6df3d6b4so8309706e87.0
        for <linux-mmc@vger.kernel.org>; Wed, 21 Jan 2026 06:13:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769004800; cv=none;
        d=google.com; s=arc-20240605;
        b=hx/XmMF9lIz2gRdczc+XfI0hpPnjem0FxMLlkmtACqiDwhJAyBJhui2bmgA1Qdb965
         6XlT1oNfFZ0endypm7Eszuh5ns+c2Ui94dZfOhLbsCPgd5w0M0nxtZDrzK0ujHRCZTlO
         gbTHUaEnTH2GqIxAtV5dwvMGLpYHRmEX6krLz1qsPk+bjMpG/ukRk+kbb5xg4QHcsRWD
         RrVN2xmuNIthP4w9/Kd3tURx7o/Gbv2f4EAObVfKKD1ibzpbkuOvjp9hHx3V+Blm6UGU
         Jo89ijaEgbe1R5zU0nBGqjhInMEI3V6jCU+I9I/QwmJNtzsqRCsVYNlTBzH6tvdIc5zl
         0Xgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mpQKvRgY7KyDBGILnk2A3cV//dp1xhTaStw0LEU0Drk=;
        fh=qMNjAf54NdlC8OMmh/DVdC90Y9qxfM2CkRk+eFKB7M4=;
        b=FOj34nzLis6AtS0YZunongznBFJeRN1nJevDbu8UyjK24+fHblwiWh51UE07BOU+uD
         fk1a1sYp1hTFwJsUN6UCj0VgLLlbBt7qhDU7KdEUC4SNTJdJn8W6tpfFsvnwFFqqNLnx
         iQVLTiZcoZ26oYa45kcdbPmUvqCsKCk6APhKBqmwwLvgvYE48YJFJKXZXO30mDhnjWux
         /DrSFgclvJUV+jXFvj3HVsE9eKc7JP4cYxbCtX0H+K6GtN2SthjzPb8Rx13iv1/303ni
         Zy4DFyg1ugpkBJw1Z5HQpDjMOVgfGsMH0Gf7G9/p+HTOVN2PiFznVowqv6hTuOKwV+cR
         FZ2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769004800; x=1769609600; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mpQKvRgY7KyDBGILnk2A3cV//dp1xhTaStw0LEU0Drk=;
        b=u2GF+l0nsUeW+1O8ZsCDS8mbWTjDrxkQJDl9WAPjl5DM67+bC+qclRhIMxV7PcYyxP
         K9CJdnJphiE8TKpUPc9XO5U09VhdqRpiYR31ouIz6uJJpMASE8AYVxeJzuvYj5UJWmjI
         /kk025UbIWuLpHUAwCYhx9SEwoEjiYDjT6eFk69FI6VBDWZVvsHSyLlcK1OysWkaFFx0
         fPgMHIs3/mLufjZqEwAaEvcD+MQSfYx06H1C5aMsTEYzyctTTCRrWsSAmG4HumRgJvER
         dW+vVkFS9Sw4UneyMOl6Vo5O33B3gdvMpANgvDr+2av8+tGkn4i1RFU/6zhuz5+VQgAo
         mZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769004800; x=1769609600;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpQKvRgY7KyDBGILnk2A3cV//dp1xhTaStw0LEU0Drk=;
        b=mYmHKb/johrnUryYWguzRh9FCjTDsSNiXQepkJ7IigEng0G2z2EiuAZVfxUdev7u5b
         QYhIazi76AEqLCA+HgLk7FHNuHbusDHTFKz1Le2RTBIU2LT4fipbnHPZU/CoXu2+kHKN
         EQZMdHKGV2BblMVNKOB7+jErQMvuVBgQk/Jry+pCRlpbqY93Uz8YJ8QFWthVETcFxSGH
         cTAAXuxS1ZsnwD4PGf+Rb5YVo/uiGJxznv07DCbFWCfJd+MyTTcPLekYylEZYH+ZD3sI
         CwZpYAiDT/JSk4/rT4aX7GK2NalpqBpjOvoTi51qO9Y4oanU6e4FNnGUVYf4QVSnFgIo
         8Ddw==
X-Forwarded-Encrypted: i=1; AJvYcCUfe/TFPjLsc6I7YggJVOfbz4H/GQh+7H9iaqSsTIBjkLBcmhfKhBB2r0m3XwiZgCLxYxA4qFYMXMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzflli6YnSaoV8JBv0nh8P6mD9qy+rf1m02kckW6SrEav8+LxHc
	U42s4NUGQKsvXKYxRX3piwSfYbRXnug/SZL5nPCiRs0v8aS43TS8jenPG2ftxn/7u+G2WlmPpHE
	M0PZHx4DmYXBcCXttZ9jp62mswBJk0QlexDM29sxADA==
X-Gm-Gg: AZuq6aI5kVeinUCfAwCFs4qbCSWhgYNymmH+FUWznvN1KEFKAl05JfSRymeGaeNArcb
	1Iw8IGQAZ4GkCD6OzYni943skRhutdMVYjyHb5tBZ3MgRuldD4FsKpmaizW9Kywn1mvcHwE3pED
	2Q56cDmrESNmuotegDoWgd+je0A+AFIELLqc4G7saKxKwTPEug4RL9GmUsrIKwvmgUUD9ivykKU
	5UoK5k4J3udP67vzL/8JvG84vOrIIs51iiHx8t2duD2ll5DAhyjcVHDnGcZZeKE4ea0mMEr
X-Received: by 2002:ac2:4c4b:0:b0:59d:cda0:8b5a with SMTP id
 2adb3069b0e04-59dcda08d1bmr1088455e87.38.1769004799968; Wed, 21 Jan 2026
 06:13:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116121004.1829223-1-neeraj.soni@oss.qualcomm.com>
In-Reply-To: <20260116121004.1829223-1-neeraj.soni@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 21 Jan 2026 15:12:43 +0100
X-Gm-Features: AZwV_QiQKYRr91kx9TDXIAwOBKhi5R2aJ_dWKO8ZHrK0VedTIMBYuurr7hT9wL8
Message-ID: <CAPDyKFrOHqStZbsye9Quk71UGkzUxOkwG9yAGYFVvt+=nMJSyw@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: Avoid reprogram all keys to Inline Crypto Engine
 for MMC runtime suspend resume
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: ebiggers@kernel.org, adrian.hunter@intel.com, quic_dmukhopa@quicinc.com, 
	quic_rampraka@quicinc.com, quic_nitirawa@quicinc.com, 
	quic_sachgupt@quicinc.com, quic_bhaskarv@quicinc.com, 
	quic_gaurkash@quicinc.com, quic_sartgarg@quicinc.com, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Jan 2026 at 13:10, Neeraj Soni <neeraj.soni@oss.qualcomm.com> wrote:
>
> From: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>
>
> Crypto reprogram all keys is called for each MMC runtime
> suspend/resume in current upstream design. If this is implemented
> as a non-interruptible call to TEE for security, the cpu core is
> blocked for execution while this call executes although the crypto
> engine already has the keys. For example, glitches in audio/video
> streaming applications have been observed due to this. Add the flag
> MMC_CAP2_CRYPTO_NO_REPROG as part of host->caps2 to control reprogramming
> keys to crypto engine for socs which dont require this feature.
>
> Signed-off-by: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>
> Co-developed-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> Co-developed-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> Signed-off-by: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>
> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
>
> ---
> Changes in v4:
> - Removed the "CONFIG_MMC_CRYPTO" encapsulation for "MMC_CAP2_CRYPTO" and
>   "MMC_CAP2_CRYPTO_NO_REPROG".
>
> Changes in v3:
> - Renamed MMC_CAP2_DONT_REPROGRAM to MMC_CAP2_CRYPTO_NO_REPROG
>   in the commit message for clarity.
> - Added parentheses around the condition: (host->caps2 & MMC_CAP2_CRYPTO)
>   to improve readability and correctness.
> - Updated the comment associated with MMC_CAP2_CRYPTO_NO_REPROG
>   to better reflect its purpose.
>
> Changes in v2:
> - Renamed MMC_CAP2_DONT_REPROGRAM to MMC_CAP2_CRYPTO_NO_REPROG for
>   improved clarity.
> - Defined MMC_CAP2_CRYPTO_NO_REPROG for MMC targets that do not support
>   a Crypto Engine.
> - Restricted the usage of struct crypto_profile to MMC devices that
>   support a Crypto Engine.
>
> Changes in v1:
> - Addressed the comments from:
>   https://lore.kernel.org/lkml/20241006135530.17363-3-
>   quic_spuppala@quicinc.com/T/#m69c9ab538bd9efd54515646952d0d7d1d7c17690
> - Avoided reprogram of keys for Qualcomm SOCs only.
> - Ensured reprogram of all keys on host controller reset.
> ---
>  drivers/mmc/core/crypto.c    | 2 +-
>  drivers/mmc/host/sdhci-msm.c | 6 ++++++
>  include/linux/mmc/host.h     | 5 +----
>  3 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/crypto.c b/drivers/mmc/core/crypto.c
> index fec4fbf16a5b..a5a90bfc634e 100644
> --- a/drivers/mmc/core/crypto.c
> +++ b/drivers/mmc/core/crypto.c
> @@ -15,7 +15,7 @@
>  void mmc_crypto_set_initial_state(struct mmc_host *host)
>  {
>         /* Reset might clear all keys, so reprogram all the keys. */
> -       if (host->caps2 & MMC_CAP2_CRYPTO)
> +       if ((host->caps2 & MMC_CAP2_CRYPTO) && !(host->caps2 & MMC_CAP2_CRYPTO_NO_REPROG))
>                 blk_crypto_reprogram_all_keys(&host->crypto_profile);

As far as I understand, calling blk_crypto_reprogram_all_keys() would
only be needed for those mmc hosts that lose their corresponding ICE
context during runtime+system suspend, reset and possibly during
->probe().

In other words, calling mmc_crypto_set_initial_state() from
mmc_set_initial_state() looks like it's a mistake, as it has really
nothing to do with the card's initialization, unless I have understood
this wrong!?

That said, I would rather make the mtk-sd and sdhci-msm drivers to
handle this themselves, by explicitly calling
blk_crypto_reprogram_all_keys() when needed - and drop
mmc_crypto_set_initial_state() altogether.

For the sdhci-msm case, it seems like the only case we need to care
about is for the reset.

For mtk-sd I don't know what is needed, but possibly Eric can help out here?

>  }
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 4e5edbf2fc9b..2ccb63dde9c1 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1949,6 +1949,7 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>         }
>
>         mmc->caps2 |= MMC_CAP2_CRYPTO;
> +       mmc->caps2 |= MMC_CAP2_CRYPTO_NO_REPROG;
>         return 0;
>  }
>
> @@ -2526,6 +2527,11 @@ static int sdhci_msm_gcc_reset(struct device *dev, struct sdhci_host *host)
>         usleep_range(200, 210);
>         reset_control_put(reset);
>
> +#ifdef CONFIG_MMC_CRYPTO
> +       if (host->mmc->caps2 & MMC_CAP2_CRYPTO)
> +               blk_crypto_reprogram_all_keys(&host->mmc->crypto_profile);
> +#endif
> +
>         return ret;
>  }
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index e0e2c265e5d1..2fd76f966e24 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -457,12 +457,9 @@ struct mmc_host {
>  #define MMC_CAP2_CQE_DCMD      (1 << 24)       /* CQE can issue a direct command */
>  #define MMC_CAP2_AVOID_3_3V    (1 << 25)       /* Host must negotiate down from 3.3V */
>  #define MMC_CAP2_MERGE_CAPABLE (1 << 26)       /* Host can merge a segment over the segment size */
> -#ifdef CONFIG_MMC_CRYPTO
>  #define MMC_CAP2_CRYPTO                (1 << 27)       /* Host supports inline encryption */
> -#else
> -#define MMC_CAP2_CRYPTO                0
> -#endif
>  #define MMC_CAP2_ALT_GPT_TEGRA (1 << 28)       /* Host with eMMC that has GPT entry at a non-standard location */
> +#define MMC_CAP2_CRYPTO_NO_REPROG (1 << 29)    /* Host handles inline crypto key reprogramming */
>
>         bool                    uhs2_sd_tran;   /* UHS-II flag for SD_TRAN state */
>         bool                    uhs2_app_cmd;   /* UHS-II flag for APP command */
> --
> 2.34.1
>

Kind regards
Uffe
