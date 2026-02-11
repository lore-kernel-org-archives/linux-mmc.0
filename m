Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF16A2F2910
	for <linux-mmc@vger.kernel.org>; Wed, 11 Feb 2026 11:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770809351; cv=pass; b=uwV8CJtQmnrRI9Bs9/KIdvo3JINzcwA8oqnWXY9KybiFzpzX9K9P+BB36PSEt+8Y12xb7n+xri8Ql1HjPFyDa2wBG4rXojiprJGhQsOHMydNNtiXBSO4IiJKGTcqXiFi0xTFtIfgseKQgKXLOYLs6YCgueNlr8sJO7oQ/Qf2ivI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770809351; c=relaxed/simple;
	bh=EGUPiTXpev+zLBlu8M93A/JJo6S3fmE3b9BiklME2Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMOEQOzXnyJy941KdSNWknGk5SGgaqEViwPZSMZiclAZW31eiNcq30b4+KmQjBvQEywlN0Tczix3FhmhIbm0kbLpAN9jBtpm7dQ10Fy/t6IAEMiTKgLCsjx2MkDGlf5o9TFqIApbo/IS9r64AZsbAUUzkZHHvLsay+9QK4njqqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gmmQNU+o; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gmmQNU+o"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59e6253b16bso226793e87.1
        for <linux-mmc@vger.kernel.org>; Wed, 11 Feb 2026 03:29:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770809348; cv=none;
        d=google.com; s=arc-20240605;
        b=fbT7UWSasLBgjK0yw/BgTSlwOmFTBU0Qk9L7oofo5C6Oki+kNv7d+kgdadfosS9Zs7
         bbODvO2j+f4puVVzyLRzcOGT7zuLXzlgZS5pxBQ/hnalp2xeJ08pqKWYTPrg9NVxanyv
         RNFpinLqkToV7xnBSGm6CXm+oKJp20P9LngW0hQx8oa3BawkzrRqJBkUyHE8lrhOfKyl
         fnTRv9ysugSLaQfgtxrQqWfNSAzBI5svRujE01tnVPGje+ZzUDRCzIswgxTuuMIyVMrx
         kZoz4jkUfSPYJEXSJBP/RN9OEVhXAMAfWa+G6RW4IN8anFh1pFI8hY45ajjsZfqKIbDS
         R8Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tjy3gmDNQcM93H44vc1qsiol7eB5Aw5W93AQGKQ97Wc=;
        fh=mdOAv2BCIXXd1VhHpWMM7V71QzhD+kAop3fToHZbczU=;
        b=hMrtM/awU6+p4Pnf6ZxJu9qeDsgc2BPwLE2LXgYFxXbToxjFxzdmE7QMZZO9sxVywE
         sHNSUm1zN+QDrGyw54+mqjy7obEzrXyFO1nmVVAvLy5pK0iHLMmQRWxYywH5bIxzX7FV
         i/09qNCiD5xfAwLB086k+BFJMvGnTdJclUvXgz0bUSK6GEj04wbvIYUHs3c7QdACq7ma
         I+cvH4Ed3CVbI91tnoUqeuqO5WMFahaOvS25gVM57/4CDyFrV2X77ZyxLcH+1QquWO8k
         4GpNb+6SGu2SysmyqNiDwxYHevfucTFhJ8+tFf9MFSFRLkD8PB80kexAesai5T9rFbHz
         jcIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770809348; x=1771414148; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tjy3gmDNQcM93H44vc1qsiol7eB5Aw5W93AQGKQ97Wc=;
        b=gmmQNU+ovvDe9SE7iR5szNt9ji2qsNo1DiRrcRzR1Q/81BkxFf9imuFISGUUoF7JRQ
         u1ztGIXG0MddeFsQ+TeZEhbHmiXmpEh/w0EaaPKqPST8B4QluHiJTYBKKfWqeSKq3vcH
         OSE0BuXljz6t36evHngVaMOIEU4u70c1hN3sXkfPWks8ehLvI+sW6NUcFjRx4v7cC+pX
         KdWYE3WZAF0/v/nUmb7ztc1w7xrwh0VK8j+5gXd//YUYMXoaJv0A2OVLE7kN+vfctYd3
         IbAD7PgCXlWUdWp+6c8q4oPsC+zJgNvUsADjYjVGSlgs2M3eEvQ/Zs39lOwSu85vS3ZU
         CToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770809348; x=1771414148;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjy3gmDNQcM93H44vc1qsiol7eB5Aw5W93AQGKQ97Wc=;
        b=vXLioz0DHwsC1viHGg2lDTLQa0ZTv4PiwC0hC4+AME8ZYcmbculAX+YUazDwJAlQOq
         GaR8XTqgiIF005ezmVLK13G+S0dyUUNy2GPchaEvnJMebq6ZpUfePpG+irnYxB/vsE5A
         6e10JdLMMBwPGXEdssDoy8K1jusxUCdrPv6en30h12fnHL0I8D+sVTt8YKRLxJmf3U34
         Mo8gwnLPUAVQSw/Lzk6c46ofrOYL4r7WXPtRmVKbOzsYzl+liWLJKMWF9qsv+aaj0+KB
         HJ9VXGb5e08pz/81+HatnZ9DOOvuLP2jJqBA6+TQhq5nx0bYu6GiU7giUZiXwQffybSj
         ginw==
X-Gm-Message-State: AOJu0YwnMII9pfu1Jyzzkg41WLlQ+JVuObunLdobN8Uiifz4bmDHwN1X
	1WW3Us62G157PxrQOt9lPqLqEhHuuOSAn/1QKAcEbwBvj/nDf7t7kW7U/faJQjMLqa8RD/FzwLO
	ZMnp3cLAgK8Lxej/vvJdSVOGkZ4uAFXRcnZICIjmNZg==
X-Gm-Gg: AZuq6aILKCSiNzhcS9usBPe3GXyJVmP3XYvavfQ0zqoWUEPGxDGjezh/wKJLs51IObr
	se95KNbtTyTLCzBeCBPUE7YKKqjv7Z7tpLCbl1gtU8z1348/XbNRieYCcRdoyIjjSEZ0Yzc4/8u
	sU+eml109QKbs7co3r5dkCPLdskZQYp99cfocCR3Ad52b6+hGtsB6ueYlX5LJpUsyJmd4ORBVKJ
	5WvQmQ8iXf9mnhuChs2J3UhUB/4Rst5RErDrUt3oZft79fRUUzzCS8biJbz8qNzr0aSrUy1chCS
	A6wWNKQD
X-Received: by 2002:a05:6512:401b:b0:59d:e954:1908 with SMTP id
 2adb3069b0e04-59e5e2421dbmr707613e87.51.1770809347913; Wed, 11 Feb 2026
 03:29:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203012322.20827-1-enelsonmoore@gmail.com>
In-Reply-To: <20260203012322.20827-1-enelsonmoore@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 11 Feb 2026 12:28:32 +0100
X-Gm-Features: AZwV_QjDx5HhFSk0ISSlkpucCVkkxD4KG8rPhLMX7UCYmWopNQglZbXe_j_uUxI
Message-ID: <CAPDyKFoGDJjca6CWzhm0OFps7q=FibXEOTK-6pSS0LLTHqkisw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: remove unnecessary module_init/exit functions
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Feb 2026 at 02:23, Ethan Nelson-Moore <enelsonmoore@gmail.com> wrote:
>
> Three MMC drivers have unnecessary module_init and module_exit
> functions that are empty or just print a message. Drivers that do not
> have module_init or module_exit functions can still be unloaded
> successfully. Remove them.
>

The commit message from v1 was indeed correct, no need to resend. I
will pick the commit message from v1 and apply v2 as soon as we have
rc1.

Kind regards
Uffe

> ---
> Changes from v1:
> Rebase on latest mmc next branch
> Improve commit message
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com> (v1)
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
>
>  drivers/mmc/host/dw_mmc.c      | 13 -------------
>  drivers/mmc/host/sdhci-pltfm.c | 13 -------------
>  drivers/mmc/host/sdhci-uhs2.c  | 13 +------------
>  3 files changed, 1 insertion(+), 38 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index b2ac61f3a8f7..2006ffe7eac7 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3523,19 +3523,6 @@ int dw_mci_runtime_resume(struct device *dev)
>  }
>  EXPORT_SYMBOL(dw_mci_runtime_resume);
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
