Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5935127FD49
	for <linux-mmc@vger.kernel.org>; Mon, 23 Feb 2026 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856005; cv=pass; b=bzuoddcsjggRWkJIWdl8dq289Ds2ZDAtML0q/Pmaucoc3wMiQJ9GTU9n1+fbIzk+hVGahCKrMkVd1YkiOlxZ3ncuer88UkaqVYUMoHjaGK3aMDm1vMuzEHxGLFwTlpoPcbq3/ieV/uHvok4XvoNhfBaZnBsSKD0DO/X/T+d++oQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856005; c=relaxed/simple;
	bh=aQEi/nClq5VhzXumqoN6qeqQyByr/wYDGG65P6LDKWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JeEw7YQX+vgt7LwKFIHH8eXqjTjq8cfMetslfu1IrmJFPFaQMTWMImtvdbWrVjNCIcz7mWwVCLiuV0M0V2AGqMWYeDz2sVVZyQE2yhVFYtIu9xIteK6CuUoUTDgsi8fhFdf55pybkARXrK1HsDC5pZjjyEhvDurYacuY08dP5hQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V6o1fJi8; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V6o1fJi8"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59f855fd0d9so4453167e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 23 Feb 2026 06:13:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771856002; cv=none;
        d=google.com; s=arc-20240605;
        b=NNdoyKrEgnOidQg2VgZk4y69BgxRfPzOWNTczYPnQ3DRVXVJSIvdKICOYEwcpfk1SF
         OMtbBrHMeg9AtRT7NMjdJ1swA0YJjI3Jr48x0q/TNA/ll7IXgp0yULIgLiWSMmNitSsL
         u2b3R9LwWLakhUG0yIYfoMNSWm8V6XE88H7FJGraRpSiPJey/dJrkdn+oXIRq7oV4uYI
         ZIBK2smPfla4RitWajY10/lkFUVUQ4qKROcDABi/sh1FOz/LzF95nKfMTI5zUPq3yj/l
         zcaWgtaBi1RtbaMWW6AiGOxKvjMmd2N8YXFiyvTdKuI1KqeybQr4FOTF6pKj7fqyGcXS
         3EDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YNxD/Z3IluamBwe64LfeEH01xfNv6iJF9NdYczpsBD8=;
        fh=2iKz3AqYxwGck4acAtQJ6/208mwqzO+86tu6uoAL4Eg=;
        b=HAQumD43Fp/upaz7VrLjdXHxU21a7vWgk3ffSThSjwD1F7eyuO4gPZ5RxptEmc7Uun
         rQOBICpYy8EG1Y8EYlSB38Jw+pqP/qsawPUrTv4CSuyfcJ4caVuZgnp9JrQijq8aFaxr
         d2KSdyWCDg2EcIbRVeKtpkYfN35AIgY9VQjITYKMTNZOezBvChzXVG9WF3pAoTInMRcI
         Ew8IpoSxXCJzTe/x7VIMHJNvuG3+uMoWVFYzmAOPQPxbhWmRijYp/e1E3h9GBVhIvG2Z
         7aBRHALg/6t2JE1zinwxmQ/LGRn3yHJbAVr57Y7KRv9zzrO5OpDUp6Eohy4P2Gbz9D97
         iXfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771856002; x=1772460802; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YNxD/Z3IluamBwe64LfeEH01xfNv6iJF9NdYczpsBD8=;
        b=V6o1fJi8gdiapZNr3sTHyGmEKUgcS2i9zhfphnk2DkZv6A/yHioQ0aaE3qSb8QYGOn
         fsKRL2KWrPI/DO/O70+leUijBq4xUG+W4vhbjqNXY3cyK9jS3x33vSkyppouMdVVOEUU
         9wuprq7T5nW4X3wNyfhAWCsF+NRuQlZCk2Uh5fzy2tkIErRLKNXhpVw7obfh1aAJBSzM
         wbKDC9KX/z0QaAaiuLUbzftDBTk6OQugKov0S8kd9BV3HyG2Cs/+QebZOcZlrJR+tX4v
         Y7ZqJv+rvMkoTsB6bgoaxKvEpYlZOMX2hAw86n0FZbP4p8eZNwUXO7J2xTsu1GdCPlHW
         BcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771856002; x=1772460802;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNxD/Z3IluamBwe64LfeEH01xfNv6iJF9NdYczpsBD8=;
        b=tEijBiFPy4/IjK7U+Y7FQpFLXLRgc7MknW4uyiY2OcTrVNw1e+q4UaNOOd6sykR5BN
         zw2z5WC/uD/bTFL6vdDg/JKb9SIgCBXnAkJShf1LIi2BJ1xnalJYxb3wUZ4s6qqMQ12P
         WreSmPC6lNS92ES/Rx5tqN1TzB23QqioY07ewp0QNTlh8SPFrwcnmWGDsUc71cI/+U1i
         l22+2Q85RhtrltYGJPfFBJjtkLS9UsQiwZPz2Q9z7B8jQ9I7rS88jHmU7yZ+gHY61Lie
         7GbHhkFRpUG9M5KnJ6udy0+bf0mzxZtBFv+upCcIVTCb8Ju/nTpJEhcDMxM4tkCQbIsd
         i/6Q==
X-Gm-Message-State: AOJu0YyQvoI5H41C0wgFsdGSgOObvB1WIqlqYkg20nKHknqKiMmC8jt9
	sxulQCusC15Crhi+T9UTm09eqU8T9ZSCuTTx5omPjBKahhCKTkopOtJKgYUhn+9u7Nmh1T+zcd7
	iEW12zPHBOQvjt1VdPH+z9OgxCS1ZIZ7aWC02HPzfSA==
X-Gm-Gg: AZuq6aItH7oLEe2tOMKrJyaGv9wnlhLwpDUW67hFLH66IgJ7E5LRej6HVh48/MDkWYc
	pU6RHJAH8UA69/IMu4A7PbgH2kvo/bHIiEUz/5KRq3fZYhmTK3C39UW7rmaQT/r4mV7BL7Sg621
	CmSFKroJr7ZPS8JGf0j7cnXFHLGlrPiutx/u85hd7htZjGXVcAL510XQYu8CUHsiif+vleKrlz1
	DeP4oSspNg4V8kjBgXOX1ld4EkAmq8vh7K5PAxU3Izz9pGnbTSunx++8DOdwL50THcKXAURfbSb
	ByL954Yv
X-Received: by 2002:a05:6512:108f:b0:59f:7ccd:fe96 with SMTP id
 2adb3069b0e04-5a0ed8a04d6mr3145165e87.28.1771856002368; Mon, 23 Feb 2026
 06:13:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131020039.45966-1-enelsonmoore@gmail.com>
In-Reply-To: <20260131020039.45966-1-enelsonmoore@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Feb 2026 15:12:44 +0100
X-Gm-Features: AaiRm53kzEKNio3z8CYOK6Sa3_KgIq_3DS0l3tX-v3RhP4go2Y-PAav4isGyVC8
Message-ID: <CAPDyKFq99PBdfO9HZOJOj4suUF6kdSm5A0jhJShmRUxh09SCvA@mail.gmail.com>
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
>
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


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
