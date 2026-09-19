Received: from mail-oi2-f26.google.com (mail-oi2-f26.google.com [74.125.231.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D04391E77
	for <linux-mmc@vger.kernel.org>; Sat, 19 Sep 2026 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789819099; cv=pass; b=g2+6Y6rFzTRyHK0DmKT2zK8HDKJVreCs6SDrmwioOZkE/A0o0Kg6a7CKjt9HJDVAiKsgCpw+YeVuqVBFlcYa/1LgGsf9l4GvNv+g2zwbQn4ABw45lb0+txepTolqlCngSu4ccOOKxzDcSNeI04OBi6ejW2TmwvYJHhNeGDlbaEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789819099; c=relaxed/simple;
	bh=XbtXTzRAYW02KXholcw2ASApYBFb0BJqI8KGXi9eFzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+HBYFno19slXiQH6RdZrPbC442jXSI9LS/E/F6bwxVvx3CP6CdUH0D4jQ1QsO6ciT1uf56uAG0ATMYCO092U7RQrj3gEPdG755Y3nksjFNg28jDNDDuZ6GlMqHmmN/lQevMK0pDiOPOcvyFFoQLorQeV3VSEzpez4OEAML6py4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qUUEP0MT; arc=pass smtp.client-ip=74.125.231.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qUUEP0MT"
Received: by mail-oi2-f26.google.com with SMTP id 46e09a7af769-80a18990c76so1185237a34.2
        for <linux-mmc@vger.kernel.org>; Sat, 19 Sep 2026 04:58:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789819097; cv=none;
        d=google.com; s=arc-20260327;
        b=MOAxh2pt3FY91UmGSAZNW6Pmv8wkLoR9RXKR52DV9HFF7VLyt+O4cQX1Y4Htnwzcb7
         V6bLaiAS04bAWPDdl+fpsPOcLBtaUMlKHKgbGun2GR/+t5QBuxjROBqR8T5zGtJpXZ7u
         XVlaBBu9NdhGqxZha0FVG8ppeQ/Fo2CriZi4Dch7ntwmnq+Xrdm/HoUvuw8+HZiQOyAE
         PvmU99a+JsfvJugn6olKqH0dzS8RQL+Gyxe8FfHyVVpx6afxfv2d9LWpMurqQgREChg2
         aoW7pACuJl50dqTNJ7Qf5RSUGH28bI0rVkIUJTcysk1QgiJDwb65qTYrxD2sNYy+zlHO
         BVvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ud3FeOiOvyS8WWg6t16DeAqz++YfSh94BtVybhYysAU=;
        fh=gH1q6WTXIrxc3qVe283u0rzvXvcln1jY9x7fdHrPmYE=;
        b=g39rXW4398iCQk+6MJpRrEP56B1soWtX7bkYY5rlSAiA/INVZ0fn9Elbw0JDC8JQ3d
         zYcCDUSwk/imiV0ZQ5C7guq/fjXc30junyVVAu+IlkrsyI7F/zIfXtI+f3tiSaT/8MxC
         RiwifmePQaCxSmwIp+TWbAjoKNuh9LgP130nlKgvnHsAJP+mdXBQImdjPKuQzRSFM0Zq
         82pksvZvCUW+f6XO59J4LpkIe2+uD+Un6TTt8cWHoPyWDceqsz+o63ncivS295qM1S5X
         veJLH6IJKLvwdPvKGq9HkGd2La1Pa22vxN6uhRAS+Y8IIft+MTyXUCDCyKwZkltBxRzd
         TdMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789819097; x=1790423897; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ud3FeOiOvyS8WWg6t16DeAqz++YfSh94BtVybhYysAU=;
        b=qUUEP0MTwrU7oXS/DiUBaJTuIiyvZQEpf1ND3OTFPviB12MxddCifYrLA3LrjS13Y7
         LwMcP+alakVZqZE9s6p0xb1IidKBj+yfanTrh8nwWhX7hbOlpxvC3bFD0ityurVfvmVN
         OivAjYJPCbobJhlq28NsvsFRRWGcgxLRRgYYP/JlgbxqpNHK+YWCia3fAxZiGfHxePyL
         jLYlzSTmu2D6XKng+OJMA2L1nvXZoI7ctuU1N0M+YdzKrFY+8dGvBYSDDKjUksZzzdtw
         mZBBRBCe2w6Dx8VDM/uXzuE53ueL1Mt7+VI37vU38C7SDHKdSOuwZPZI14CzMuAwLR8A
         OGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789819097; x=1790423897;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ud3FeOiOvyS8WWg6t16DeAqz++YfSh94BtVybhYysAU=;
        b=s+o8eB1cYn0FRUCtIEC7rWgeBIctZDehg3Xc2tuf0458hDviPJIAPiQXlAFgDMQpjD
         W6LRv2Pqp8I0EV3EFg8HBdf6c0NEgxBhJ87hSx6b7xc1+BUb/S+uJ09LBremB8x2fKrT
         s0+yFcOMn1VXphEP6SnV3Ff+0i6vvoI/rLXatL74lASYbiV/ecetZsEbMR21TezXa4eF
         IT2rajLe24m1T2X9cwJ9VryCk2jLRqA3AnGd8HPQ3qNSmI1doeRetEzIV32zPByVsHNk
         cy8sHw9ywhwiCr0amxN8tlaRY84n51VEpMv6I+C/bUUuArry6LktLAi+87DNEn3FugTC
         wLDA==
X-Forwarded-Encrypted: i=1; AKwUvBzqmfheFjJxdp/Hq0Lkwp4vrXXOT6fEj1c6jKXZvf9URDSgTfxcvoNxsT1SuheQLt1KoHSc9Vz6lss=@vger.kernel.org
X-Gm-Message-State: AFuF++nXweVvKJhUM3xcXxBplEBokiD4M/A5yGVulzYQxdRIc6WFsr30
	fH2cA3l6ZcY7qiZnfC20grGhwvu8Vs/SdEOQ4Gb/c/R04hxrLT+6bt65Jcav1zQr6RPVwYBe0Ow
	GcHD+wLJgPyV48LVFtOmFBQok9YO3BC8=
X-Gm-Gg: AYBFou2ktYFpyu3UO/XnCsuhyDBC20gzJKG/6iMMuyGGLBoKLmGZ17TVJKrpC1/MjwX
	5RwzGdaJ5eEE9GcSg/g0K1+kiX9eEhuvoRQmZCSjitljoN46Oh1DNPACCa0xdZMU9/etzdCPpsX
	m58vPdf/VV3AUKAfp6W5m7J2X832oRNEbhA5ITbAF1RrssF21CtDn9cVV0gEn+FezIl+/rHJZHQ
	1n5jrMgyLOVQc+fNeebQaBcXr+vL3J0I+c2kPjzM7gljzGX1nxzNtEmGd/OQubYpArZa3VAB1my
	poQCjtM9/uNheml96I/TP3p2mhyGn/QsCS6s/jB7hi7yYWU/6REON+NzG6QYxOMFA0+gmu0Dq1U
	VyyD69MhjaXdgcJqKJrrok2oLtMLyg+QFb64rvQ==
X-Received: by 2002:a05:6830:442b:b0:806:1728:aed9 with SMTP id
 46e09a7af769-80ddff5b5e3mr6811507a34.5.1789819097212; Sat, 19 Sep 2026
 04:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-07-k3-sdhci-fix-v1-6-b15c5d0f64fd@kernel.org>
 <20260907155300.1411173-1-alan.tseng.cs@gmail.com> <CABdCQ=Mi3M8vGCYjURicNWy-Bh22qN199jOdHA5rEfTzui2b_A@mail.gmail.com>
In-Reply-To: <CABdCQ=Mi3M8vGCYjURicNWy-Bh22qN199jOdHA5rEfTzui2b_A@mail.gmail.com>
From: alan <alan.tseng.cs@gmail.com>
Date: Sat, 19 Sep 2026 19:58:05 +0800
X-Gm-Features: AcwNN1UZXEwsL9Pov5f9xi5w8glGlreCvMt_9qTwCiXunjbXeU4yHhZxeZNHtl4
Message-ID: <CACwt7EYh9+MZHC7Qn910iOxvnjd42u_NoSX3+YpjQCxCxtY=6Q@mail.gmail.com>
Subject: Re: [PATCH 6/7] mmc: sdhci-of-k1: Improve RX tuning window
To: Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: dlan@kernel.org, adrian.hunter@intel.com, ulfh@kernel.org, 
	long.wan@linux.spacemit.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 15, 2026, Iker Pedrosa wrote:
> A jump from a minimum window size of 3 to 50 delay codes is quite dramatic.
> Could you clarify how 50 was chosen? Is there a specific hardware specification,
> phy datasheet recommendation, or test dataset across multiple boards that
> justifies this exact number?

50 is not my number; Yixun would need to answer where it comes from. What
I can add is what the vendor driver does. In SpacemiT's sdhci-of-k1x.c
(bianbu linux-6.6), the defaults when DT says nothing are:

  #define RX_TUNING_WINDOW_THRESHOLD 80
  #define RX_TUNING_DLINE_REG 0x09

The Jupiter DT overrides both together: spacemit,rx_dline_reg = <0> and
spacemit,rx_tuning_limit = <50>. So 50 is what the vendor pairs with the
finer delay-line step, not a standalone default. That makes the 5/7 ->
6/7 dependency concrete rather than theoretical.

I also need to correct what I said earlier. The current driver already
centres on the widest passing window; the "< 3" check only decides when
to give up with -EIO. Raising it to 50 does not change which window is
selected, only whether tuning fails. The 1- and 5-code windows I reported
were never the widest in their boot (the widest was 74 or more each
time), so they do not show the old threshold picking a bad window.

On the form: spacemit,sdhci.yaml has no such property, so a DT knob
would need a binding change. A compile-time default, with DT override
if the binding maintainers accept it, still seems the lower-risk option.

Thanks,
Hung-Chun
