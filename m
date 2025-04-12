Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB599190468;
	Sat, 12 Apr 2025 13:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744464020; cv=none; b=FsmxgytMByZ+XbATtxl2Y28yr0SPVRbW7BihjiwfHrnePXwOLHN1CEdOLtwxvEJRDFVgqaeUFlmVmmL2Z+qRY+oNYBnxNfnk0GXNaLP0Qr+DS4+ZyiM42tYwq4VcuESSda8X+MJydBqv/BN5h6KjfNuxbKLDs/o+MSR+IZy2Lbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744464020; c=relaxed/simple;
	bh=dx4pXrCL6WF6xs1Z7rH/KV9GDs6+4aaLKxuLLw63nDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8hCXcEMWA60aL4q7JKNN2MZ4lKJzXlXA/U7VyqG5vpGuVXPLoSyasrl4UZnOfuw64szo56rEQOJhR2vFrkSqkPmx1wvRv2/mAsjpCcd91JE/KtYiPfPyHEcrae0Fh2IUwIKUBTWY2ReIlq91sRU79XmYrtxJ+OEH5Z/ZrhteOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8/R0PRc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8/R0PRc"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22409077c06so40198605ad.1;
        Sat, 12 Apr 2025 06:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744464018; x=1745068818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uP33+7PRmS4oJ2D1UnGQ8VItHy/+Gg/hnjlqLaempys=;
        b=H8/R0PRc/oYbvE+dwN+UZJ8++QVKkjWDCNGP4bBS/UctSZ4Z+HjH0aB7U3YRlZi21H
         TmaBa/QACdcLY9m/r9I8nkDYekis8V1eM9xceuBPL2VFS0UAg4BlaprBCiT6J1FvycpM
         V58ETjZUS3ZHcmLPc1LbYsbyFP4aiwy1XRb9tfW0d9Cor89NilyGgEyqH17BMUsYvUyo
         EkHE8pLgfwDwHvGTHXVKDBQNf0SRcb/CpuA7kb9ZW85UD9vTRFLxEyC/PW0t0VCfMsfH
         l6XKEjHSQrj67HbYDbZpC3w+Ih5kCDhuZYiKz/igjJEkV4+tdX3ov6o+xpbOuzqJjyOG
         Fr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744464018; x=1745068818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uP33+7PRmS4oJ2D1UnGQ8VItHy/+Gg/hnjlqLaempys=;
        b=gkpQ67JRfcvXipwYny5CJ3rlI3CJnHLwqo5EWU19tUYxvusCF9hOeVPYiihOBgPb6x
         GMyemYMHjH0Ie5VgYBTdAm68KuA7V8TyxTgM0uyHNT1noLbiFuarHnSe4AKJjAxW1nkx
         8ZLwpDwoa47XFsHwgertlCL9tjq+mgsJa17guHiTifqq/QRvyprKM0B7HaLPWqc8cx7t
         sd6jdr/gVHUxv4QWxfYXMFAo0pCR8X82V2J20beLWOjZsnR1I1xJO9xnE/PD1t2lTS0A
         V4gyjBbPpjBFiqTA8tvjojASdPAQc2a77avYBW7dfLtygPRTgx31hhFYSnBkF/6WJbXe
         SrsA==
X-Forwarded-Encrypted: i=1; AJvYcCVPuEJyKLG9FOu5kHaAmjs0QSosYmrzvOjbBqLtIprEoo/n0gNBITDICEj0TKsNENRkjL2wWYxomeDj@vger.kernel.org, AJvYcCXSA6Tbm5EVPvCxGUra9Dd3lBsZ2WHzicFQE+MUhwAmnoydgwWpHmSsJg4cuOI1rJyIkhU9qxdnnxdRyOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Rz/TFT2YOmJ60wXDyvA+VOy8AHT5VOJ8PSsQAojrMhXyjCGr
	x4ag26RNs+WcvoTtyDWjU/PIX18J3eGhjGLz2fSdQoI1SnV33Y2zJ1pGibXI
X-Gm-Gg: ASbGncvLLnjY2ma8zhq8xc5agpG+Gb3f5Lpdk/3QEzFFt/CdUPFPsso+kXo3ctfkuLn
	h+5//wm20W39xJYcQFWZ4SwfQ/tw8gQ1uDwEdky2iJ+cWywhIfrDwHcjBtLYyWqMjq5lq2tmifT
	dJPXjt4cuRO6qMkL3d15oDg1PHSawt/v2XQ8XN9daEhAVSm3pidX/Aj5axJk+2Mj41QKGZrEHRG
	xHibe2HF6Zv6tQ6ko16qtVXkS7OmKDZs0MtnhYdvAaDeQaHNIoGYVBUKJ/MYoYYRGLkVRxV+jyQ
	XwgdaUPAJqEYeQ2WtqoSHD9hl1qPUi6493tcmFZO
X-Google-Smtp-Source: AGHT+IEW/j+fkahXhVyvC5rfpcwM14BS/S5BDIbhgvg54bjaxj1uJKaNvJsGnehpHAEtLGKffdPYKA==
X-Received: by 2002:a17:903:1c3:b0:223:5ace:eccf with SMTP id d9443c01a7336-22bea4bd7cemr81796825ad.25.1744464018010;
        Sat, 12 Apr 2025 06:20:18 -0700 (PDT)
Received: from hiago-nb ([2804:1b3:a7c3:a964:39d6:b67a:f7ea:283c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c993a7sm67203975ad.146.2025.04.12.06.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 06:20:17 -0700 (PDT)
Date: Sat, 12 Apr 2025 10:20:12 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Judith Mendez <jm@ti.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Josua Mayer <josua@solid-run.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Moteen Shah <m-shah@ti.com>,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: Re: [PATCH 0/2] Fix V1P8_SIGNAL_ENA and HIGH_SPEED_ENA
Message-ID: <20250412132012.xpjywokcpztb4jg4@hiago-nb>
References: <20250407222702.2199047-1-jm@ti.com>
 <20250411130354.dc3sv3e7ruekkhkp@hiago-nb>
 <d8e45e50-f0eb-41d0-9c50-56147eaf262a@ti.com>
 <20250411194813.c4ft2uxgdiuza5cm@hiago-nb>
 <5f36ec5d-bb31-4b6c-aa4e-4ec48cb1d067@ti.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f36ec5d-bb31-4b6c-aa4e-4ec48cb1d067@ti.com>

Hi Judith,

On Fri, Apr 11, 2025 at 04:55:39PM -0500, Judith Mendez wrote:
> Actually this was one of the previous implementations, I should have that
> original patch somewhere. My understanding was that we do not like adding
> new DT properties if we can find a way to apply the quirk in the driver.

Got it, makes sense. This will work fine with eMMC, but for the SD card
I am not seeing other option. Maybe we could use both implementations?

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 4e1156a2f1b8..db8ee66e76d8 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -888,7 +888,7 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,

        /* Suppress V1P8_SIGNAL_ENA for eMMC */
        device_property_read_u32(dev, "bus-width", &bus_width);
-       if (bus_width == BUS_WIDTH_8)
+       if (bus_width == BUS_WIDTH_8 || device_property_read_bool(dev, "ti,suppress-v1p8-ena"))
                sdhci_am654->quirks |= SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA;

So the driver applies the quirk for eMMC and we set the DT property for
SD card. Not sure which one is the best, but maybe it is another option.
Let's see what Adrian also thinks about that.

> 
> If this implementation flies with the maintainers, then we can go back to DT
> property implementation.
> 
> Adrian, is this fine with you?
> 
> ~ Judith

Cheers,
Hiago.
