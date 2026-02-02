Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283C310F1
	for <linux-mmc@vger.kernel.org>; Mon,  2 Feb 2026 12:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770035557; cv=pass; b=HvCqxe3Fn4zJGqIN+agzdvbUTWPT3ongo7vWgjuVXgeBjvKm/mPAdzBn8QlxyPMukyerofXLlbYaaTXJpP9/pSKvZrcCzFECNoVqNzjc/J+AogxeZxkupsUuGzJkLkTC31UAiLH1Hk7TZ7jBP+KFdDTC2uoNBAZKV6pOQV8uv88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770035557; c=relaxed/simple;
	bh=d0HcHCcX7ZcxfXUAAangZ8LpoMPhPzrZqprdOyx9y6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QskwsPbcP6lZSih5HzEhLg8DLpfb6xB282EKt4NxZwcSqEwBj/h2Cn8q9L1Ry6t7m/0XdgK+SDuYCfIu+3PX+uXr7yv3VpXXLZiounbu90d/FJql/WGaz9BWTAPgbqN+OfzdSNMeWFoNSsAwozhIReu5P+7w8v+Kci/ZQhIAnLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cQmsNzGS; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cQmsNzGS"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59dd4bec4ecso4933570e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 02 Feb 2026 04:32:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770035554; cv=none;
        d=google.com; s=arc-20240605;
        b=XqwovMMVFhEWyep1d8dtsaAItQ7BK8cojkKth8+hxKnwG/fC385lCbsQJwa5JSSf5k
         3/9Wq2mLK8TBEo32LIIk9VgFyAwp7hHDZLcciI10PRvY9DnNY1tadcef0TZNa0nDT0t5
         zzbg+hgeaZJtVsOuthRiGf25/eqlL1zWl2L+PUysD0fbE08lvmW5oKfgHq3hUJXZ25vS
         eJFokNDqJrSJQujOJkjMaMC7a45qg5wYVpYaqJjeR2UQnFYuAsa2h1Z84dMQDHs/nePJ
         jJUKbJ9jryOSvx+y0NJ8T0gwvpnZqUEPSOBYpGhxkmi5neuJrAiBMiOCxDs/kST+yPEZ
         JM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=e2wrmcXOkZtxUwZafya0CjcOvGB4Uv103SUJihP6UaA=;
        fh=2iKz3AqYxwGck4acAtQJ6/208mwqzO+86tu6uoAL4Eg=;
        b=DOwQKCu0r0buuOu5+tK8Jl8dQLKz4pulLCc3AcPP2IwWxIlViMmuWWJszfgIeJZM9e
         SirAPhQFKTsKaCyVTdWJdNlTGjCSDYresJW0ZN7pZaWStHOgVyqn+saUm0p/HgycUPlI
         iqz53Qq+8QyIbobpB/yxh/BFWXngQO6KYoRuHAt0wDZ+278lE/zWYKHnRJjLfkUB3c8P
         E5UPdp1IgTbIp79ZsjmQdWLsXEWmifwp42q7wKC0DI/ay2h3Ng5JF55i3+wVOGOTddN8
         +bexAdMfGhAdYKVNxz5/9iPt772m0RC9lQdLu5eLaIAyCI+j1E7hcXFgb/+WWbjABSRg
         nYCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770035554; x=1770640354; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e2wrmcXOkZtxUwZafya0CjcOvGB4Uv103SUJihP6UaA=;
        b=cQmsNzGSokoKR1GkFJfoOHzHpS58oRwg9Bn0VjI5uff/oUAvR8rIv6HwZGuMgj4913
         RrVPtOqOCPRSNvCxSRhckll1yFcRGNm31NeBTgLNNP9Lvsu4j2iIFoMMwFNBSfniD5Tt
         fAahepHWyhvDeqLwUFcq5lqxzdww2aCtIoyN59agHdueUWNf3mLWh3WO4vaXYbMpaXU7
         F8rVkNQjnGbQWASKyVeKfTrVrIl0yRKr511e0pOF9cpTCl3rS94HfagGRXrj3YBTQdgQ
         TifSw2Yd31xLWSVAnxrIt5nMTZOQl79K0J+glHh3Xx5q2oIreMr5L91SXHYPB5RhRIwT
         L3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770035554; x=1770640354;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2wrmcXOkZtxUwZafya0CjcOvGB4Uv103SUJihP6UaA=;
        b=qauyuJtc3/d368VPaUI+5W0hREFUzKwgn96IjE7GGxb04apxpGCsUCvv7kAjfKAwp5
         DfLg+QlIaRTy1bX6wOQ8sBRY6HPrPVgRnrf0gllZqVcfiub8BqwdSje9/ELWw0KlarGV
         /vj3aeF/kse8XBzwaEAeBB+xz6ptQaYafEbTeIpPMtHTWFS+wiMSF5hhbcqQakodeok4
         0X406dG+jTONx8zphtHTYwFqwCqK+Wo9aUGqfJkUfliZsUwetdk4NoiMJIKi4Z8xptQa
         p5tRHS/zqfP4rRpX+99CEicVfsJe54+C43h9uhFyVQbRBadbQahYWM3fN8QUD5aV5zNy
         CeyA==
X-Gm-Message-State: AOJu0YxVDpv7tXixMYp9Dqr6UTTsCPrhhCnmBOHqihJHB33Sbmgw9K0Y
	LRH6BXPC9aVaWn/QyZSRY4BKRJpnMGmzhpapNPmudv+wEsvCSx1ZaU9WkIWVpip926cxtzNaaM/
	mx9P6R86kaW7YIc0NpoDv/recMek1JzjMAU5lDB6ddQ==
X-Gm-Gg: AZuq6aKuwfZe55bwUQd6gQ7iMuT+XqalLKNNBc7fMuhijVHa6R+0L742Bd++k+SzDZD
	PMP5BBr8s07hqPx2e3aPifFOk87Re55829DYxto+SddQIU4V/R40WaAygpn5RKJXTcs+eMlkk21
	q4NFlSIYXxUulnhPeFEy8uwmtlWIYB/7dsZUTtdpINngMUl6/CImkpy8PkyikoOlFswcQakp51k
	eSSZHUFfrHelIBOa2bWV3x5tr55K/WPsQVDrUz3TFhmhX24nPCAUNbet59nbpmXM/+EXjDJIYkc
	YGiqR/E=
X-Received: by 2002:a05:6512:3f21:b0:59d:f47c:100d with SMTP id
 2adb3069b0e04-59e1641841emr3677553e87.24.1770035554173; Mon, 02 Feb 2026
 04:32:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131020039.45966-1-enelsonmoore@gmail.com>
In-Reply-To: <20260131020039.45966-1-enelsonmoore@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 2 Feb 2026 13:31:58 +0100
X-Gm-Features: AZwV_QiF2aBrlMZws5ByOVEVeF904Aiwkm6aHYp2T7RELSN667VqyHObuBhL_AI
Message-ID: <CAPDyKFps1oX=aKuUYFbXNQXM3rGtZOwTfgCaiHgDvGOb3qGc5w@mail.gmail.com>
Subject: Re: [PATCH] mmc: remove unnecessary module_init/exit functions
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 31 Jan 2026 at 03:00, Ethan Nelson-Moore <enelsonmoore@gmail.com> wrote:
>
> Three MMC drivers have unnecessary module_init and module_exit functions
> that are empty or just print a message. Remove them. Note that if a
> module_init function exists, a module_exit function must also exist;
> otherwise, the module cannot be unloaded.

The above doesn't mention that omitting the _init/exit and functions
also makes the module unloadable.

I think this should be perfectly fine for these cases, assuming that
we never want to unload the modules as they are pure library
functions. That said, please clarify this in the commit message.

Kind regards
Uffe

>
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>  drivers/mmc/host/dw_mmc.c      | 13 -------------
>  drivers/mmc/host/sdhci-pltfm.c | 13 -------------
>  drivers/mmc/host/sdhci-uhs2.c  | 13 +------------
>  3 files changed, 1 insertion(+), 38 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 9e74b675e92d..613d74d2e946 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3693,19 +3693,6 @@ int dw_mci_runtime_resume(struct device *dev)
>  EXPORT_SYMBOL(dw_mci_runtime_resume);
>  #endif /* CONFIG_PM */
>
> -static int __init dw_mci_init(void)
> -{
> -       pr_info("Synopsys Designware Multimedia Card Interface Driver\n");
> -       return 0;
> -}
> -
> -static void __exit dw_mci_exit(void)
> -{
> -}
> -
> -module_init(dw_mci_init);
> -module_exit(dw_mci_exit);
> -
>  MODULE_DESCRIPTION("DW Multimedia Card Interface driver");
>  MODULE_AUTHOR("NXP Semiconductor VietNam");
>  MODULE_AUTHOR("Imagination Technologies Ltd");
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index 7f6ac636f040..d4fb60c1ef69 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -215,19 +215,6 @@ const struct dev_pm_ops sdhci_pltfm_pmops = {
>  };
>  EXPORT_SYMBOL_GPL(sdhci_pltfm_pmops);
>
> -static int __init sdhci_pltfm_drv_init(void)
> -{
> -       pr_info("sdhci-pltfm: SDHCI platform and OF driver helper\n");
> -
> -       return 0;
> -}
> -module_init(sdhci_pltfm_drv_init);
> -
> -static void __exit sdhci_pltfm_drv_exit(void)
> -{
> -}
> -module_exit(sdhci_pltfm_drv_exit);
> -
>  MODULE_DESCRIPTION("SDHCI platform and OF driver helper");
>  MODULE_AUTHOR("Intel Corporation");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index c459a08d01da..41e49c6cc751 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -1126,7 +1126,7 @@ static irqreturn_t sdhci_uhs2_thread_irq(int irq, void *dev_id)
>
>  /*****************************************************************************\
>   *                                                                           *
> - * Driver init/exit                                                          *
> + * Driver init                                                               *
>   *                                                                           *
>  \*****************************************************************************/
>
> @@ -1138,17 +1138,6 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
>         return 0;
>  }
>
> -static int __init sdhci_uhs2_mod_init(void)
> -{
> -       return 0;
> -}
> -module_init(sdhci_uhs2_mod_init);
> -
> -static void __exit sdhci_uhs2_mod_exit(void)
> -{
> -}
> -module_exit(sdhci_uhs2_mod_exit);
> -
>  /*****************************************************************************\
>   *
>   * Device allocation/registration                                            *
> --
> 2.43.0
>
