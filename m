Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C057F41C7F;
	Wed, 16 Oct 2024 02:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729046558; cv=none; b=QhWIU+EQTP+NkY1O/5TTmy0TwDRfi8+s7C4ImIt0pw6HGOSDmSp5C4qRu9ChsrkbfBF0pD4PwDbqNa0LNUto313PqyJJpOjH9HvP0mZuddNWmVykh42VTJnLzzSr+rQ+1ATDVU7O7uA5C13XLGZm8wV+HG1Tu7U1YrzNezzyNcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729046558; c=relaxed/simple;
	bh=G/JtQuCECjkO51gTaClS0eG2y82hqp4W0SSjj9mq/NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRKqdp2obpIxI2ZE7hLJLmFk35mwf4zUTK4eDgnxFGuWoZr6wenIxfmDnPutfM3egcxPmcmFYBwXXqAQNelvE8PGs/zuI9vaiOsxyGsJ8CyrEqlKKGymK38zKlzpN7ApjCFBbEaqnZxONZYX/oSZ2pF4cif0Q7l2YBSB7dqX5Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFU6ChOp; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFU6ChOp"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea12e0dc7aso3921339a12.3;
        Tue, 15 Oct 2024 19:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729046556; x=1729651356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkuhZA7XRKcZ4xcnxKDKV2Soi5p6GouCmDFIo/OmyP0=;
        b=PFU6ChOpb6TAL2pw4LpEADMgDarOayMIqZFPVljH6aS+KffbQbJHR+DEquZHsbc5hC
         SLW9zN8R+reGiQKMcx815xw2RsT1mf8XQGvVNiM9rpNKhQ6/2dKkMdSujtNpNMX6WB3k
         HnT5eIUrwoLVaFKAi7uMtiCsIDlXqlgoXbeQGUFlezt4LNkbG1QrZPfCPFeiztYU/WvP
         fNVHbXPYtgtTkpOeXYzE58xRewx7s8SB618orOUIEmcFYPKcjh4q34R+JWRm6d8fniYz
         zKtQ8OH3KmYiftdkuSTBe3VO/72L3ySmD3Mr57xrXsPvN0UaCobwuI8hNLpMOgu8jO28
         N61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729046556; x=1729651356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkuhZA7XRKcZ4xcnxKDKV2Soi5p6GouCmDFIo/OmyP0=;
        b=SHUkYLiX7usnvabs0dFWrDRF4VyerBEJMK2A8yaUiIclUH+ybnbA0wcRSj9M64QMka
         Ob1TJ3vUjtd5K4Dor+hvy4POGlGY58MzUlhDpBxUdRCEb9aIEEmRK1aE8bykKfyrGTg8
         DhSruU9eXv7RRJGrkzGe0IJnDOFM1FPeO4YXwiS4H7lgdi2AQAEK2gTYmIz5a1zEAlL1
         bdvNTA+zSQc9fOI9IQ8Sho7KngSJP1REIK2UlWWX1D+fDNF7E8y3gl2lLlx/c80D8Ngu
         HmLAa0AmOjdwqxOC1owz5M3s6rLp6Tp+gtqGOhha+cFBXHLYDhlzCeyrvWeb/mN/vDRz
         K+Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWOmodyInEayGg2eEmkESKRopP3n8wPZSx/BRpFdNKwGWiaiIbOLyT084dsT6UEexkt0ITO3LAgqiys@vger.kernel.org, AJvYcCXFj13rmLqJZ7y5n2pounXEdmbRHtuovu1wC0/5oRPOc0he+xGVhm1r0uJCRqufZ4UoUB9SM09jkmLu6ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YymaUMxbSu8blU2fC7F3ppY24FH7tuRvhcqwDC8zhXcLOZ7znyb
	DeRH4BRiczMOr5opR6Tdd8tpDUuVLLNowrjSwUZc+SM1whe144AY
X-Google-Smtp-Source: AGHT+IGsd6Cj/A0WVB346ToGc4O0T5GRReooiah2nFAch3rEmJoCdddwwJmXz80tiE6kmNFsObecAQ==
X-Received: by 2002:a17:902:dad2:b0:20c:7be3:2832 with SMTP id d9443c01a7336-20cbb1ae2f7mr156976845ad.31.1729046555959;
        Tue, 15 Oct 2024 19:42:35 -0700 (PDT)
Received: from arch-pc.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17fa5d55sm19353215ad.109.2024.10.15.19.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 19:42:35 -0700 (PDT)
From: Ben Chuang <benchuanggli@gmail.com>
To: g.gottleuber@tuxedocomputers.com
Cc: benchuanggli@gmail.com,
	adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	victor.shih@genesyslogic.com.tw,
	Lucas.Lai@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ben.chuang@genesyslogic.com.tw,
	ggo@tuxedocomputers.com,
	cs@tuxedo.de
Subject: Re: [RFC PATCH 1/1] mmc: sdhci-pci-gli: fix x86/S0ix SoCs suspend for GL9767
Date: Wed, 16 Oct 2024 10:39:50 +0800
Message-ID: <20241016023947.134179-4-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: 4a517433-d105-4e2b-86f8-335e7c537d10@tuxedocomputers.com
References: 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: benchuanggli@gmail.com

[Resend email format, Sorry.]

Hi Georg and Christoffer,

On Tue, Oct 15, 2024 at 8:47 PM Georg Gottleuber <g.gottleuber@tuxedocomputers.com> wrote:
>
> Adapt commit 1202d617e3d04c ("mmc: sdhci-pci-gli: fix LPM negotiation
> so x86/S0ix SoCs can suspend") also for GL9767 card reader.
>
> This patch was written without specs or deeper knowledge of PCI sleep
> states. Tests show that S0ix is reached and a lower power consumption
> when suspended (6 watts vs 1.2 watts for TUXEDO InfinityBook Pro Gen9
> Intel).
>
> The function of the card reader appears to be normal.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219284
> Co-developed-by: Christoffer Sandberg <cs@tuxedo.de>
> Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
> Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
Maybe need a Fixes: f3a5b56c1286 ("mmc: sdhci-pci-gli: Add Genesys Logic GL9767 support")

> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 65 +++++++++++++++++++++++++++++++-
>  1 file changed, 64 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c
> b/drivers/mmc/host/sdhci-pci-gli.c
> index 0f81586a19df..40f43f5cd5c7 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -1205,6 +1205,32 @@ static void
> gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot,
>         pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
>  }
>
> +static void gl9767_set_low_power_negotiation(struct sdhci_pci_slot *slot,
> +                                            bool enable)
> +{
> +       struct pci_dev *pdev = slot->chip->pdev;
> +       u32 value;
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_VHS, &value);
> +       value &= ~GLI_9767_VHS_REV;
> +       value |= FIELD_PREP(GLI_9767_VHS_REV, GLI_9767_VHS_REV_W);
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_VHS, value);
Maybe replace it with gl9767_vhs_write().
There are two functions gl9767_vhs_write()/gl9767_vhs_read() and they should be
meant to be Vendor Header Space (VHS) writable/readable.

> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
> +
> +       if (enable)
> +               value &= ~PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> +       else
> +               value |= PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> +
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_VHS, &value);
> +       value &= ~GLI_9767_VHS_REV;
> +       value |= FIELD_PREP(GLI_9767_VHS_REV, GLI_9767_VHS_REV_R);
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_VHS, value);
Maybe replace it with gl9767_vhs_read().


> +}
> +
>  static void sdhci_set_gl9763e_signaling(struct sdhci_host *host,
>                                         unsigned int timing)
>  {
> @@ -1470,6 +1496,42 @@ static int gl9763e_suspend(struct sdhci_pci_chip
> *chip)
>         gl9763e_set_low_power_negotiation(slot, false);
>         return ret;
>  }
> +
> +static int gl9767_resume(struct sdhci_pci_chip *chip)
> +{
> +       struct sdhci_pci_slot *slot = chip->slots[0];
> +       int ret;
> +
> +       ret = sdhci_pci_gli_resume(chip);
> +       if (ret)
> +               return ret;
> +
> +       gl9767_set_low_power_negotiation(slot, false);
> +
> +       return 0;
> +}
> +
> +static int gl9767_suspend(struct sdhci_pci_chip *chip)
> +{
> +       struct sdhci_pci_slot *slot = chip->slots[0];
> +       int ret;
> +
> +       /*
> +        * Certain SoCs can suspend only with the bus in low-
> +        * power state, notably x86 SoCs when using S0ix.
> +        * Re-enable LPM negotiation to allow entering L1 state
> +        * and entering system suspend.
> +        */
> +       gl9767_set_low_power_negotiation(slot, true);
> +
> +       ret = sdhci_suspend_host(slot->host);
> +       if (ret) {
> +               gl9767_set_low_power_negotiation(slot, false);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
>  #endif
>
>  static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
> @@ -1605,6 +1667,7 @@ const struct sdhci_pci_fixes sdhci_gl9767 = {
>         .probe_slot     = gli_probe_slot_gl9767,
>         .ops            = &sdhci_gl9767_ops,
>  #ifdef CONFIG_PM_SLEEP
> -       .resume         = sdhci_pci_gli_resume,
> +       .resume         = gl9767_resume,
> +       .suspend        = gl9767_suspend,
>  #endif
>  };
> --
> 2.34.1
>
Bugzilla wrote that this issue only happens on Intel models, right? 
How do you confirm the status of L1/L1SS, measuring PCIe link state via hardware or software?
Thanks.

Best regards,
Ben Chuang
