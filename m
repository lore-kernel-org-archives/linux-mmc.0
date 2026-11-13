Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604312;
	b=2qEn+KrGy/ZfMSHyS0AFe1XcO+JPtu0iOuq7m3P5HO0apB5O4qKLcLgrCET3UtNbdaNc
	 NcZpCZXgYYkkQzmKtwkk6GudN+hkSlMSb8EJYC7qhfKK1PehLSbWJjSF4xlg0nYc2uhNP
	 EoHxhfFXwy85YEZEUNSf2XgUB8pwmQ89sCwHHq4cCe75xz9MZYD0IMhrWHQFR297ZDSum
	 GS9o0XdKc5fVOns5zznmkS7xQAeAFqzqNR45FGziT5d2aCWzbWcJtGjLrYzE/b9C5r6lI
	 w2h+jB9HbxrtbKkFRxKYLw/0lsQ5Sz+RjjLegikGO9bqjqCX4bQGtOLGWHCFDPsOC8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604312;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=7ancN5tYiJUgiK5oPhN0zaXHe/997SRSIfB0LkRBNW4=;
	b=1rhzfLsxtiKLMAh8p7JRC7tcFV/2tIaNFO6zQ63EbzjbspIO55jQZm3MSe0lY3RjFouu
	 EMeFnzQSBbmdP/ZH4fn4VDHF6I/V8hWV+u43MywWZzw57JAK9jk3HDz96cR0DW0ot2wPH
	 b90XsTjXcrYy6uOle5d9B0wsnW4uifBgROawVvAstMkBvAoVm47a0JvSdWyISKPAFiDUS
	 ZW18CB+azrEI27u5bt/tb3qNGNOqD+UH4ajD7UaKOXS5RgYRhu2TUZstcpZF1ETCUkCAa
	 sHkgXYbF1jSF/dd01yOkForGvH6O8eauVd28pREfoFPQJ5prfnADyY4ZW2qKA4OuaAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=cjXyZU42;
	arc=none smtp.remote-ip=209.85.222.98
Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com [209.85.222.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C9560A260F
	for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2026 21:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3C9560A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=cjXyZU42
Received: by mail-ua1-f98.google.com with SMTP id a1e0cc1a2514c-99bf7b97f12so1864926241.0
        for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2026 13:11:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604310; x=1795209110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7ancN5tYiJUgiK5oPhN0zaXHe/997SRSIfB0LkRBNW4=;
        b=la8kqbwItNcb0R3/5LICXgD+6VSwu/ouIgX9mB2exZ74rFSKyXCpc2oXcsj27t3X8Y
         74mIHOu42gr+xJb81DuVUBRaK4xyDOyX80Ttni/txvQZpVMANFn7bi/kqrpvt+vDMeSL
         RVDGshKDFI6Bn1pfgfxdQ8iO2aAy8iaGHJJuPaWq1eH/sk7zkW8+655I/07LK8fL2otW
         StUiQu6xgTtVz41FWVfexiMeVgovODaJ/52nQU0T1At+8y35MCQ7l/B5XHZ2WoUr+M5n
         G1/AFb+yqM8cJAfVWAQ6ZB77VZlb/wH3kqh9ka+bx+NUvcj7mXGUPwf4WwBx8CzONdoO
         R6Aw==
X-Gm-Message-State: APuU4Z91yk6yEGUS0CtGuLG6Ma4wd7ZvQMDawPIvfL+QRRkEHXJhrWGU
	uRRcjgPrn8HV1StikzIXZTrKdwWieZjNT5CLvLEkhJ7LllDN0Kq5Q8GfbTsQ9SyIerIa3sdFOaL
	JW0owH0Cc1j7pUvCdIhxtUlRq7GHfULOHD098/dfayEyIy7HmmRePeMWO7siZNSuAgFV8sPO7B+
	EGZMBJlvhDAAll5zVFN+mghtLmraoTvV67WfwpA7UCcGBPtL+44VBOdrw+dbDeVbhRzyLNFi9uQ
	rM0aSUYKx86
X-Gm-Gg: AYBFou2LvvhnM1Im5ctaHBl6OUKIxQxx1HoqqNmC/r72WouNjDnwf4yvgoju2Xbzl9z
	fpFTU5EXarrIyce7+g8k8o9H52+lJHbmQxwpY+f+AaJAXLK85qlEoFCzcdV+ZBaOO7v+8sFgdf9
	djbfdX2zQzOh6/6CPmGI6jYdbknToqoZgXWehhlSmadr4ACpbA4Q1aG2Pg5mLy8ZsH1+VxbRbQf
	QYrZ3mO2+3ifFpRZWAhg0RQ6poxj3HjMM2fnkSyXOFO5f4Fp4wCgxPw6Uf5QEqqW+GKVrjXlW+h
	ZZCOzNBGCGBxlVy6x1kAVgypcBfPg8zwX6ipIARpH61MOjrWJAecEPMH/AN6qPcZ75Ba98+Tj8b
	K+gjd4JmG/8oBPqunUumwb1a60KUxTyPqJPZNPYBj25lHSmYBWWh7QW4ac/FDgUhLg0K1QyKVc0
	EhNIb24J6KjOwzMmbvmmjVzcu9AZmZ8Wi2/kE=
X-Received: by 2002:a05:6102:6f06:b0:7cb:91a5:7cb1 with SMTP id ada2fe7eead31-7d631800158mr1896025137.39.1794604310500;
        Fri, 13 Nov 2026 13:11:50 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-99c8421b4a9sm569198241.1.2026.11.13.13.11.49
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2026 13:11:50 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91f10c68ccbso35454956d6.1
        for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2026 13:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794604309; x=1795209109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7ancN5tYiJUgiK5oPhN0zaXHe/997SRSIfB0LkRBNW4=;
        b=cjXyZU42wMTtXRQeNgUFYAyvDODb/KnimgEzPqGW47/Mo4oRJz9sCOlia2xAbMRS3j
         3nX+iIyWdHJtZTN6+vgBvmda1s6WUGqxn5lFj1iFbpEuw0yMIwj3CEf3E+nKZcPb8Sig
         7Xt+n0UAm/5btwmbWHd2UsBotCkjxhNjDemvs=
X-Received: by 2002:a05:6214:29e6:b0:91e:9174:1ca3 with SMTP id 6a1803df08f44-91f139767cfmr109619156d6.13.1794604309292;
        Fri, 13 Nov 2026 13:11:49 -0800 (PST)
X-Received: by 2002:a05:6214:29e6:b0:91e:9174:1ca3 with SMTP id 6a1803df08f44-91f139767cfmr109618796d6.13.1794604308681;
        Fri, 13 Nov 2026 13:11:48 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d73206sm29027626d6.25.2026.11.13.13.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 13:11:47 -0800 (PST)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>
Subject: [PATCH v13 4/6] mmc: core: Split sdio_set_host_pm_flags()
Date: Fri, 13 Nov 2026 16:11:41 -0500
Message-Id: <20261113211143.3759154-5-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261113211143.3759154-1-kamal.dasu@broadcom.com>
References: <20261113211143.3759154-1-kamal.dasu@broadcom.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>

To prepare for a subsequent change, let's split up sdio_set_host_pm_flags()
allowing the second part of it to be used as an internal function for the
core.

Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/core/core.c    | 10 ++++++++++
 drivers/mmc/core/core.h    |  1 +
 drivers/mmc/core/sdio_io.c |  7 +------
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 677e445dc48c..6cbb5ee6200c 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1422,6 +1422,16 @@ int mmc_handle_undervoltage(struct mmc_host *host)
 	return host->bus_ops->handle_undervoltage(host);
 }
 
+int mmc_set_host_pm_flags(struct mmc_host *host, mmc_pm_flag_t flags)
+{
+	if (flags & ~host->pm_caps)
+		return -EINVAL;
+
+	/* function suspend methods are serialized, hence no lock needed */
+	host->pm_flags |= flags;
+	return 0;
+}
+
 /*
  * Assign a mmc bus handler to a host. Only one bus handler may control a
  * host at any given time.
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 9be2875608ce..d3a2ff00b18f 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -64,6 +64,7 @@ int mmc_handle_undervoltage(struct mmc_host *host);
 void mmc_regulator_register_undervoltage_notifier(struct mmc_host *host);
 void mmc_regulator_unregister_undervoltage_notifier(struct mmc_host *host);
 void mmc_undervoltage_workfn(struct work_struct *work);
+int mmc_set_host_pm_flags(struct mmc_host *host, mmc_pm_flag_t flags);
 
 static inline void mmc_delay(unsigned int ms)
 {
diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index 12716ec0e35d..99f857514b63 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -726,12 +726,7 @@ int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags)
 
 	host = func->card->host;
 
-	if (flags & ~host->pm_caps)
-		return -EINVAL;
-
-	/* function suspend methods are serialized, hence no lock needed */
-	host->pm_flags |= flags;
-	return 0;
+	return mmc_set_host_pm_flags(host, flags);
 }
 EXPORT_SYMBOL_GPL(sdio_set_host_pm_flags);
 
