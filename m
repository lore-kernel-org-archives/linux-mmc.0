Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6612C34FF70
	for <linux-mmc@vger.kernel.org>; Thu, 22 Jan 2026 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769104654; cv=pass; b=NEcyw6e8QNljWOVq2B52AEVkV4KRZehrWHzIkR3AOnQg0krZGfVj2oIpJI2sVkJ4s/8NBoMJJaQS8KZ6AK3SgQeKh9GR4qrGQFgD4dURv/d9vAwTEH/mqvV0Ekt7X/JaBfR/k9B1RlV6UoWew3Cu+ccawIKNF8ifJBq9sVLJYEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769104654; c=relaxed/simple;
	bh=0POlBa0UTGezdktalln9j2394hGy+9DBf2ukGhPgf1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghp9rO+ZDEkGFxlKsL+YagDmVNybmiQlcksFJrprhQLYNxOjNw8M0UMafOfwMGjcB9YETtlNYXZyDIUdzg6Sm2WJyNXfiB7/5ysXC8J9TQes8L/ZuRGaZ5dL3dYBQYM2Xdp0JEgUsthm9Z53RzbgliOH/WHhyTFmozsSjhVUh+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jp4l/s+B; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jp4l/s+B"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-382fb275271so11712881fa.0
        for <linux-mmc@vger.kernel.org>; Thu, 22 Jan 2026 09:57:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769104648; cv=none;
        d=google.com; s=arc-20240605;
        b=lAccwDkIQSWSzOz0/6DWHIoXZ0ghM6yS3tZlwj45xKM+LEMxonNOzr1n8LP3smoG+h
         GDxN56DuqEM7E4D99uVdVqKwLXgDKOKeVg9pCgvQXSVRaDSolEWDvLyaruAWmu0H0bVT
         +IyAkPazCWaVrAv2M6++dSrKRCtqqBVmNZGAZt0wkRqCT/kEWMhEjGB515kvCaxEzlYI
         BM93/NgbCMCVamWkBK8vq//Q/ysRR15acpvDYHGtcJ7kJD/NJRIZZRB8jCqkxqM/rZZW
         oIuewjawfOJOCXMLCOHIvo8aE+5+ZbhUHB2AibDgYqGT7ESgQUUdJs4MriiEQNidYpTQ
         2NOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=c7QdTTZOAbBFUV1tuDQ7n6tnFSDuaPCGEcq3P9Hqy5M=;
        fh=f/qgV3muor5rG+O94zVE6OQmUMK4skoUBVO2XAUG6ow=;
        b=UXQs9gBq09XqTTBWNvs9AtRLWgV92GFgRNJlraXkXUWVn5vHZhy5mdWEJRa67fWkzp
         MoxLwIC5yIWi4Ie6S5Lb2Qrj3RDAhLaA2A9hYlvd5tnxIEj6MkaCNXLDW9awxfZaIzW4
         1rFYijydo1wI1mEt4R6vAOAqxLTrE1gZAiqmOZfkTMqv1hbmdGcMqg85iZ5w5F6+GPOn
         bioIglOdrOTgT/xBSZpaCoHWOsivHc3HbXHX52SltcOxquLpj1nQmxa6fTQ5CIfgndZM
         ckg5RoRzJUUVaXT0lOvSvnDuSpakQghX1PeZUQLhxgkQfi14esSxv9k/zH7iLzCDpLhi
         vN7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769104648; x=1769709448; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c7QdTTZOAbBFUV1tuDQ7n6tnFSDuaPCGEcq3P9Hqy5M=;
        b=jp4l/s+Bk9AOd2A0FVln1cwiQWZUgzoOOqAazTSjWQwRKitdvWaKZ2/T7EnToZawwU
         7mmLmO0LeR5znrn2S0KDh1vk285uR4NG+A8kfnLN4JpdsaC0B53jkpC8lHZLCKgu8y0I
         HaIc/tUKRFCJU48aYOlrkgTcpdFYUe+h5fcd8f/LMdsGlicHRfE+bwgxQm9X5Jpxay2S
         EB6V+8OWij0qd9jVWvcufpEngvH7D7HZyKnLr3P8QmwOQUp/FUepKdlw0cxrrdJUWKub
         iJJ0YW04OVJicQWpyeZTdxmdWGoKNbcKlw+0QeYKLXsv2jI619759v8zC8futDTrgvM5
         cnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769104648; x=1769709448;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7QdTTZOAbBFUV1tuDQ7n6tnFSDuaPCGEcq3P9Hqy5M=;
        b=egheakiwIkKBqYHcAv2cwVtvAll/7zWwhvw2jazr7pP++MhTIoAdOU32nLFZmbUC48
         zeyzofyVFXKydVXKk0WNoKg4IdoHcqBQoaAYMOb0/5B/BQNGiE7hdz6ifLi1ouMde16T
         LDxAv+RV5PegIwYHEy/JfbP2ySLSJ4BexyUqt1s5rtcde32K5sGUtuN25jLDfmph4YvD
         rXKIznCpXYHAws68bRGY9I0DW7j7Wa1cMRVotC3BByRFqAEkEjQpTsHS5XY6scoEcI9e
         5/zCVXjQuLXeuy/VzFZ6I3EWK3woWHDuZrA4PqgevjDNs0ar6pB4DqEgkTaomvZwipeM
         Stgw==
X-Forwarded-Encrypted: i=1; AJvYcCV3wbv4KudorF+V0fv1lgjm5/SDIV8lU0N13g6NsVkMNAEgIeV3EaQgNjvy5zbL8cjVb8XCS/OSDCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7O6iBZp7ear1dRsLnw9Vgha7oHshhZ06UMa4MgpqSrCsgciTK
	LYk3dNGElEsd212y8eMasGq8gDF5UlQ968oOPMBTtyKeIZKEmn0wIQ4ccgx+pjgRiJtqzDa2sg9
	xSJDofth7n2jNMhJT0FH2RZvPlV6HkC3EGUK1uqVK3g==
X-Gm-Gg: AZuq6aJRxrRc2pQWqV9IoHBYGrE06/2pYAAXaFXJPvrlm006H93DBN99b0/Q2hjwpRS
	py6uJksUqF1lOI77mR7k0274w/or271NSbbFi+1zvJC2pP68pgt0KkgybRQH1fBPR0fyvb1iGix
	TDWoafWMFbhXAvyIno+JG+WT70AeiLvqNiuM+cF+M6VXFCThClVPHeDrDdxHWhD0NC1OD5ILGwe
	JM6cyRdye/bWMfDigh5YgpAZbrTW9MletI30YSDtUj+u/zDlfinmEccyUKWgYVDtddwNIhl
X-Received: by 2002:a05:6512:31d0:b0:59d:e383:86b4 with SMTP id
 2adb3069b0e04-59de4912fb9mr44911e87.19.1769104647491; Thu, 22 Jan 2026
 09:57:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20260121070041epcas5p4687d60f28911c7e97497a80adb87232c@epcas5p4.samsung.com>
 <20260121070503.100283-1-ping.gao@samsung.com>
In-Reply-To: <20260121070503.100283-1-ping.gao@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 22 Jan 2026 18:56:51 +0100
X-Gm-Features: AZwV_QjPWRmy6pvaTWHRYWVByQvWHGEDijMDvnFuWlZfUnMuThg6VtqdLTdBlgM
Message-ID: <CAPDyKFpX1+03w_Pa-Z2xRyHcft6nL4pgvKc5GuUbXfWXSk_MeQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: clk: keystone: Fix parameter judgment in clk_prepare
To: "ping.gao" <ping.gao@samsung.com>
Cc: jh80.chung@samsung.com, sebastian.reichel@collabora.com, 
	shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, hy50.seo@samsung.com, kwangwon.min@samsung.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Jan 2026 at 08:00, ping.gao <ping.gao@samsung.com> wrote:
>
>     The clk may return NULL or an ERR_PTR. Don't
>     treat an ERR_PTR as valid.
>
>     for example: biu_clk in dwmmc driver request fail, but it's ERR_PTR, not null , it will panic when call clk_prepare
>     log is below:
>     [  438.400868] [7:   binder:436_2: 4998] Unable to handle kernel paging request at virtual address fffffffffffffffe
>     [  438.400877] [7:   binder:436_2: 4998] Mem abort info:
>     [  438.400881] [7:   binder:436_2: 4998]   ESR = 0x0000000096000005
>     [  438.400887] [7:   binder:436_2: 4998]   EC = 0x25: DABT (current EL), IL = 32 bits
>     [  438.400894] [7:   binder:436_2: 4998]   SET = 0, FnV = 0
>     [  438.400899] [7:   binder:436_2: 4998]   EA = 0, S1PTW = 0
>     [  438.400904] [7:   binder:436_2: 4998]   FSC = 0x05: level 1 translation fault
>     ...
>     [  438.409424] [7:   binder:436_2: 4998] Call trace:
>     [  438.409429] [7:   binder:436_2: 4998]  clk_prepare+0x10/0x24
>     [  438.409439] [7:   binder:436_2: 4998]  dw_mci_runtime_resume+0x50/0x2d8 [dw_mmc_samsung cd210e210975263404c28fc89778f369f8398f0c]
>     [  438.409471] [7:   binder:436_2: 4998]  dw_mci_exynos_runtime_resume+0x18/0x58 [dw_mmc_exynos_samsung 2735a594c7c9c9e8c65b0b87523fbf70dcaabfff]
>     [  438.409496] [7:   binder:436_2: 4998]  pm_generic_runtime_resume+0x40/0x58
>     [  438.409506] [7:   binder:436_2: 4998]  pm_runtime_force_resume+0x9c/0x134
>     [  438.409517] [7:   binder:436_2: 4998]  platform_pm_resume+0x40/0x8c
>     [  438.409529] [7:   binder:436_2: 4998]  dpm_run_callback+0x64/0x230
>     [  438.409540] [7:   binder:436_2: 4998]  __device_resume+0x1d8/0x394
>     [  438.409551] [7:   binder:436_2: 4998]  dpm_resume+0x110/0x2b8
>     [  438.409561] [7:   binder:436_2: 4998]  dpm_resume_end+0x1c/0x38
>     [  438.409570] [7:   binder:436_2: 4998]  suspend_devices_and_enter+0x828/0xab0
>     [  438.409582] [7:   binder:436_2: 4998]  pm_suspend+0x334/0x618
>     [  438.409592] [7:   binder:436_2: 4998]  state_store+0x104/0x144
>     [  438.409601] [7:   binder:436_2: 4998]  kobj_attr_store+0x30/0x48
>     [  438.409610] [7:   binder:436_2: 4998]  sysfs_kf_write+0x54/0x6c
>     [  438.409619] [7:   binder:436_2: 4998]  kernfs_fop_write_iter+0x104/0x1a8
>     [  438.409628] [7:   binder:436_2: 4998]  vfs_write+0x24c/0x2f4
>     [  438.409640] [7:   binder:436_2: 4998]  ksys_write+0x78/0xe8
>     [  438.409652] [7:   binder:436_2: 4998]  __arm64_sys_write+0x1c/0x2c
>     [  438.409664] [7:   binder:436_2: 4998]  invoke_syscall+0x58/0x114
>     [  438.409676] [7:   binder:436_2: 4998]  el0_svc_common+0xac/0xe0
>     [  438.409687] [7:   binder:436_2: 4998]  do_el0_svc+0x1c/0x28
>     [  438.409698] [7:   binder:436_2: 4998]  el0_svc+0x38/0x68
>     [  438.409705] [7:   binder:436_2: 4998]  el0t_64_sync_handler+0x68/0xbc
>     [  438.409712] [7:   binder:436_2: 4998]  el0t_64_sync+0x1a8/0x1ac
>
> Signed-off-by: ping.gao <ping.gao@samsung.com>
> ---
>  drivers/clk/clk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 85d2f2481acf..6d62f69323b5 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1171,7 +1171,7 @@ static int clk_core_prepare_lock(struct clk_core *core)
>   */
>  int clk_prepare(struct clk *clk)
>  {
> -       if (!clk)
> +       if (IS_ERR_OR_NULL(clk))
>                 return 0;
>
>         return clk_core_prepare_lock(clk->core);
> --
> 2.50.1
>

This isn't the solution [1] that we discussed to solve the problem.
Please re-work the code in drivers/mmc/host/dw_mmc.c to use
devm_clk_get_optional() instead.

Moreover, please carefully read
Documentation/process/submitting-patches.rst, before you post anything
again.

Kind regards
Uffe

[1]
https://lore.kernel.org/all/aVp5IMvHKR8CtqSz@venus/
