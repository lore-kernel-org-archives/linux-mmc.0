Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4512D314D2E
	for <linux-mmc@vger.kernel.org>; Wed, 12 Nov 2025 12:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762949064; cv=none; b=HZxaZvZ6qzZnfkM3hmtlj9T7XZWjZxkEfpsoOiBfr00lJF29v+lBjErKoLQWYb73WhFewV257Gsl7NzWENuobnWkrMdi7cIIg/ha8hsmRZtVZAclQj+M58lqT4GfsmiV8go8Z+Tzf9AM9DA2OR2bhUiriZWEXhwjrwhN1++5PFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762949064; c=relaxed/simple;
	bh=lCTLUo3EENIdyY/tUdPJS6YwDB5f0i02ZxY192BurTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDWZFcV7JEFokYDAt1AgSDugd3VVum8NmCtLmsGeWzLwvmfbICm5R3itp7LdbjXp3uUSbNvWi6PTwNtM4Rvn0dp2N7+T66uV86BYQvZdX5ClC00pSci1wUQgnL+lHRekIJrsVh5tG7VDY7gL3AiZHVYHEtpyKDeg4ezeHrjsdXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KPiKX1yv; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KPiKX1yv"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-787d5555274so7935517b3.1
        for <linux-mmc@vger.kernel.org>; Wed, 12 Nov 2025 04:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762949061; x=1763553861; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ccW/CHx/h+CggUqFu9D4T6PtJEj38i6Wsue2zaP4sjQ=;
        b=KPiKX1yvndfFaa2uFuwnp3KOFOwaGbQOD+pDB5rRGFMH0dW5i0pObA5wuLgrhxpKnf
         nPis+Lybb+ZY9Hu16IqNBMoGWi/uKa9HF6+ueyQG9uJKbgYnRzX24MMesJs5XYozpuq4
         XNTC00YvA4E42zTGMMO8xODFFWDVzfIkwdX025v8mJ09FoBw/rVsRKsg2uwbB2Nw4qL/
         pKZguQ701riKr8UzIY2/R8J22tfCe5TqHx9QTqCzL69VhPryRJrJ1s6AiZohUPxfbjZy
         1Rab+XLsJu3gA/8Ouv4hkzKDhgOnXMUaYvPMfjG5znjA+gAXxq74pTBSGovl/UuYq2oZ
         PQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762949061; x=1763553861;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccW/CHx/h+CggUqFu9D4T6PtJEj38i6Wsue2zaP4sjQ=;
        b=S3xxlGAXR+9xofVGPtK7KOHwfIE2mZa3cpnyWsVYY3udi+gKWskNoOTwR6loaPYbeQ
         zDh9PCNGZUO7SW8TLZF/Evav+1xuWQ5Jt+7DhwdtNxu243/CwOYglmLyHCpnh894NDb3
         J4kjrUWU6jcFn6GB2yY7IDYMCigNGuxHlWRRkwuRjso9aYEENSwOiAFgNK6a1qM3UB09
         uvL0jteI++7ETL/9ZYZ9Uh+m6dl1T3INjpxMgZe9QIIDVe1P7E8qiC1+tTJIXxNnA6bl
         LW/zI+1XAVtF7X6MAWQpanHPQxXQdqGG/H1VpyKTgGS8LutQoV4VG+WUhq7uxISy5tDv
         liYw==
X-Forwarded-Encrypted: i=1; AJvYcCU/F3JgFXzO/27ecS9NFvBqpvxp6stMSWf6dk6vy3WC3LEBSyxIrsaIN7d8N05/R6ojj7aouCHui7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzekZuvF30t5eSK++mCtjH13tZKQu/2mCjCptwK1rDXYPhtQom6
	Rmw50wAoyrZ6RFHKzhI9sNkQO6JhSYuaIgj5ZNk0Yo6QrRqW4AVISQea2RFvclud02uEtR0yHBO
	Cv53NbmDHbBibGpLHkUPzwbq7x2AZRZhhRecqNAjHHg==
X-Gm-Gg: ASbGnctcgIaBiJRBHF7XYI1VGtwsIGFeDc4mmCKgU5pbpwhbPg0vGpVShdv2ftedM3J
	XFYI6o046aztTV1R29oEEfXIdByQG3qgMT2RGABe2FmGTreq+1VCX0C0uhrGbwO7R9cATS840gi
	1b7o2Fer4YBRDXXqBp6TDkaawID3eWdJ/srtv0PqFYTytywtY7WmpP4eOHucVt34SXCnGUT4ktE
	kkOdIuSI5LUG2coqYL5a84a3hboHMjQ9VKradAyf5MiAtE017MfKXFA+36S/w==
X-Google-Smtp-Source: AGHT+IH/UL074xgx6oYYsB9r3fimitKG1NIAXLSBgxB+N+QwyoPjQbv+8K8TbfNgKkSOSXoL5wsNl1ZmxBI592Dx5ZM=
X-Received: by 2002:a05:690c:5687:b0:786:7475:b838 with SMTP id
 00721157ae682-78813723ee7mr16909267b3.68.1762949061124; Wed, 12 Nov 2025
 04:04:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1762933460-204066-1-git-send-email-shawn.lin@rock-chips.com> <1762933460-204066-2-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1762933460-204066-2-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Nov 2025 13:03:44 +0100
X-Gm-Features: AWmQ_bknUUU6UANIHKVHBX_7_8_dLzyvPpfTvekBOPONV1Re2VrbZaJ_TJl1waw
Message-ID: <CAPDyKFqAwP=SDrQ_umkYk0qA50rVt=WJ5giDt8mt+RyBSCQDpQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-of-dwcmshc: reduce CIT for better performance
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Asutosh Das <quic_asutoshd@quicinc.com>, Ritesh Harjani <ritesh.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"

+ cqhci maintainers (Adrian, Asutosh, Ritesh)

On Wed, 12 Nov 2025 at 08:44, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> CQHCI_SSC1.CIT indicates to the CQE the polling period to use for
> periodic SEND_QUEUE_STATUS (CMD13) polling. Some eMMCs have only one
> hardware queue, and CMD13 can only query one slot at a time for data
> transmission, which cannot be processed in parallel. Modifying the
> CMD13 query interval can increase the query frequency and improve
> random write performance.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

No strong opinion on this, but I looped in the cqhci maintainers to
allow them to chime in.

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/cqhci.h            | 1 +
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 5 +++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
> index ce189a1..3668856 100644
> --- a/drivers/mmc/host/cqhci.h
> +++ b/drivers/mmc/host/cqhci.h
> @@ -93,6 +93,7 @@
>  /* send status config 1 */
>  #define CQHCI_SSC1                     0x40
>  #define CQHCI_SSC1_CBC_MASK            GENMASK(19, 16)
> +#define CQHCI_SSC1_CIT_MASK            GENMASK(15, 0)
>
>  /* send status config 2 */
>  #define CQHCI_SSC2                     0x44
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index e276a4e..cad5165 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -631,6 +631,11 @@ static void rk35xx_sdhci_cqe_pre_enable(struct mmc_host *mmc)
>         struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
>         u32 reg;
>
> +       /* Set Send Status Command Idle Timer to 10.66us (256 * 1 / 24) */
> +       reg = sdhci_readl(host, dwc_priv->vendor_specific_area2 + CQHCI_SSC1);
> +       reg = (reg & ~CQHCI_SSC1_CIT_MASK) | 0x0100;
> +       sdhci_writel(host, reg, dwc_priv->vendor_specific_area2 + CQHCI_SSC1);
> +
>         reg = sdhci_readl(host, dwc_priv->vendor_specific_area2 + CQHCI_CFG);
>         reg |= CQHCI_ENABLE;
>         sdhci_writel(host, reg, dwc_priv->vendor_specific_area2 + CQHCI_CFG);
> --
> 2.7.4
>
