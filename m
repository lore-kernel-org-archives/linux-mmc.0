Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204C02882D3
	for <linux-mmc@vger.kernel.org>; Tue, 30 Dec 2025 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767108839; cv=none; b=lB6mBCbdsFqua9Xq4kObbWRDaQ2v47gd9/fBfzZ6PV8WNNyBHPmg8EK+lNRfCoMwJhylNSpmge4qhGGjVcOkuumC+kcy2GgimnNAM3Jx8Of6/FAgpi1yN7Zl7OYZgEnU+ht6LYsTZSO2qcop+c+JFUKeToatjQcnNzVIyh/nKjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767108839; c=relaxed/simple;
	bh=SGpR6lvYNkXWoIHvSOyJ2xPG4f+jR1DGYNBACFYVO8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAykilkQ1q2YRDCusV7kOmLoNo1uJquvOEPL4uI3+1NJ6O2LRo9hTXMjl0owRvMpgqo7vixZmNT4js2VDVXNuumh114vY/2FkgkR7Jh7MIX1/vUAI1PDeJIm/u1hNEQCldku/PhmHN483Yxbdc2JIpFd18r9EuTUKzzmEhkp6cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GiCF1Fkk; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GiCF1Fkk"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-37a3d86b773so79595671fa.0
        for <linux-mmc@vger.kernel.org>; Tue, 30 Dec 2025 07:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767108835; x=1767713635; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V6eg1Uu2/A8yMuy6RywYGumxXCYpFTWzZoQ/ScGnj6M=;
        b=GiCF1FkkIYy8RHPyPphH3YDolEchMCEehMAcmxmnfC2DzM5CQzjRcS8zHIxLi8S2Sa
         x//eGqhLNJSDrTo98JI0SbzAfv/gWlbD/MJzTACOZkUIIcHy+3ftUKu6Css74HVN4T3k
         4CU51yrEI0/KMKEqn4en9ioSazYpxgc7/gB+dJXEzobv3ezpWwBXq0FPz07zDrZcqssh
         KdcDTfIALhXz78a/i+hhYqkkwJnAJ3rAuSk0ayX0XsHNGDhxRNIR6B+j5ko6m1y63U34
         JGMW1eYuCVI8CohX6fImnNAr1qdQdxHoJwLaRIISgXsw2D0JqRkQ44gFKKvX9lljo4+f
         lqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767108835; x=1767713635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6eg1Uu2/A8yMuy6RywYGumxXCYpFTWzZoQ/ScGnj6M=;
        b=M1PhJgMuOKbk2JfjRASlCTfBolfLs3b0NWv80KIKemRfh7+g21glSvOTA4YAb/n7x1
         hUIeOnTyjEwWWqtzToaeEa3ZZiaf9nOXcCcFVhhhHDs/avt/B40sMfGB2SzwFADovjEx
         hxx90DQNQ91th/2qR7iuF0QlLc+VbknQ8DK2qVCe394OXMF4JOliXWZWEDv4kEWJ3szS
         adEkZoMa+/E2r3rkTcwipJekd3VOJrNzSbDaYcniYyiQQb88ktkFhO6nL6h+27CjC6ga
         65XiK8mcKFVc8lMn08hgGTUAwAJS48mpUFfZ40RQJboUYxVQjEqSeVjTZddoTkLkojPY
         x79Q==
X-Gm-Message-State: AOJu0Yxw+bJRtSK0MLJtSXoelXHNXh8CyjxeqnNp1VNlUfgWKltDiexX
	UDt/XaWalY6rYLvKIEJuEKXuPcQkl3ffDFmdy7Hd82jLQAjl67o3lq7hAWu15PbDzSJ/qlMzy7y
	Ad3a4A7hzDhYQC7jQPSGtRfjKzpx1tknfLB03AYaJNtjMA2rYumxl
X-Gm-Gg: AY/fxX652EkPCtnzIAe76SummqnbtishJ0PaN0cmlwqezBi6aP5LaUSkQRdg3SaUr4F
	Kz7wJpT7XnY/3YafQYpkHIMbYmiJCNOnX5Z9JGk9sEIQkVQIUUbg9buuvYLmmXBK0MGqD5CkeuU
	JzWgPIzDud+WXWvoDYtAXHmoeFyGsrE1lEs29cnh2EfYyGJiuzJA+YWryTXPHdB8LWg69T5oMu+
	h4pW0YrAERlnLs6iFHB/+LhBDIy1t3kBwxlNAD4CqJbj8M4WZvpecKb7yQfWByWzeeSwW4v
X-Google-Smtp-Source: AGHT+IEvSaQC02s51RrDnA6K2nAprQB/4CnzoUKsTXSvYPvPKZsyKL8PeQXu3CeVttcPTnGBExo4A5m/528mGiA1xwc=
X-Received: by 2002:a05:651c:544:b0:37b:95ee:f605 with SMTP id
 38308e7fff4ca-381215af948mr121534711fa.10.1767108835048; Tue, 30 Dec 2025
 07:33:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221081207.4724-1-avri.altman@gmail.com>
In-Reply-To: <20251221081207.4724-1-avri.altman@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 30 Dec 2025 16:33:18 +0100
X-Gm-Features: AQt7F2ooXilDSKXvZcguBeAP4bYFcKcX6vUrBDPGfqVWdzWm4KXZJld95YCxu7o
Message-ID: <CAPDyKFrHeeywqjYmJ-eUgKex2fZ427oqBuqym=aT9Yc2rOzqXQ@mail.gmail.com>
Subject: Re: [PATCH] mmc-utils: recognize ext_csd_rev 9
To: avri.altman@gmail.com
Cc: linux-mmc@vger.kernel.org, Avri Altman <avri.altman@sandisk.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 21 Dec 2025 at 09:12, <avri.altman@gmail.com> wrote:
>
> From: Avri Altman <avri.altman@sandisk.com>
>
> JEDEC JESD84-B51B, released in September 2025, increments the Extended
> CSD Revision (EXT_CSD_REV) index to 9.  Thus, update the `read_extcsd`
> command to recognize this new revision value.
>
> Signed-off-by: Avri Altman <avri.altman@sandisk.com>

Applied for mmc-utils master, thanks!

Kind regards
Uffe


> ---
>  mmc_cmds.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 5990502..fbf8e7d 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -1524,6 +1524,7 @@ int do_read_extcsd(int nargs, char **argv)
>         ext_csd_rev = ext_csd[EXT_CSD_REV];
>
>         switch (ext_csd_rev) {
> +       case 9:
>         case 8:
>                 str = "5.1";
>                 break;
> --
> 2.34.1
>
