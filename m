Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50902AEE1
	for <linux-mmc@vger.kernel.org>; Sat, 22 Nov 2025 07:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763795091; cv=none; b=rwCH69OdLv0tF7HxZYCv4FA1JxmEACvYSJde/gZX3oUA/Zo5KxbQbqXqJZ2n0jboXXe2sGoZQ1LS7SLXpW+dloxgIDJh328pQOCMhlYRrAcTd0RNXM941GSLrQ3ay9JhHaIfPFpxMqZyKalQggM5lKbp60Bg10gAlXBDjOGDNYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763795091; c=relaxed/simple;
	bh=TUcKMwlo/F6aquaMxdIjTpQ88IDiMhtKBob6ZvZUZd0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DIyy4VePxHZ+MMtGBOtAam8N+nOknZJRXRNAM5TDNeIu/3hc13Pu4445ZswdCDChHtlbINa6Oq0NW7KwcuVjkpoqqXQlUm7Wh4StfzVGUdR9fwFrtfV3C957Vllfq9J+WY0EAm5Z+KLKxB1FtAQF1NLLPR0vCTSbxbW4dVxVuEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADPN8tkk; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADPN8tkk"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so24120445e9.1
        for <linux-mmc@vger.kernel.org>; Fri, 21 Nov 2025 23:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763795088; x=1764399888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7+HYBCvtLbzcg783N7MNpZNx6BpqLxSeHKCcakAKBZY=;
        b=ADPN8tkkvwK4Ad5dSg16uuViuQ1sFxGNZ8ySE0GDYkkqCfme8DMpBAUMEo1XuOJRgv
         CX+rHU8cDNOkFHef24mMNm4b2EgAE7M86tOdAqxf226BK1O1dhsm9uqWGDzvZZaAOrHC
         TNJoEg9+btMSQt9nzo3NSR5WGuNzDh9xqr7iD8a0fJ0YQgOc5uQCnOYWnak97RuV6+Cv
         P4EMf5VCIn0wlnPf2bFUX3VKHKvFGQ6AvSYnYUigwW4T6DacGomGia5eeugymsXc4M7O
         ULBJRRTB1ViXlYm5N/52rFHSKmWzKQPPdukhDVkZCLNG3zmAUxWwMZ/uYxj1iVmllv+y
         jxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763795088; x=1764399888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+HYBCvtLbzcg783N7MNpZNx6BpqLxSeHKCcakAKBZY=;
        b=jO8UDLyJtn56BvplpkmFV2pU2GPWp0uP3xMn3r8EK7gl7sTQdgRcFq0cUX7U2XFzw+
         +KUw7MGtSx38WXvRoOSr0ow5pMP4h2OxoWYj8/dB+X5aH4sZQtAagyVpwB1BAkP7bQUQ
         f+JgC805CKPklnLEfhitPEyqmp/wQb10kIPuy/buvjLv9elDzUNiclRWWp5WbBU4X9fE
         7uQ7ef2+ZQSjK/DA6nir23xlSUlCrgiuDzLD00VbFQIlYsrJI66HYCEdTyvZTTMn6VSp
         uhfRLfzY+OsxyMrqombXGBHAAV8H8ankTIZfH5Vs/cneefgt7nv16NYM4AL5zWV2UowT
         rzxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXENai8qnpgJDEPjgUxOFPZPTR0NTxvhQ8RV9yLx+gW5BDg7rpTetv85czIHRSsSToekyrdUnPzzeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWZJcfUlJcP/exaRCkcTxD93Jam1yeNCcUm1FfPvtSB5XFqI6i
	B6MG2fc5FOdxSLrDAdAJs1sWPNFzJcJd47Q9VueAmiEB7STJFwZuSCyD
X-Gm-Gg: ASbGncvefihkCl9VxNqlmaD5p2oXJ2zpkTnwMLAzfzCRX+bW16d9HA/di3s2RfC5ds3
	661ER1RPomPftTddykwu15w7AF+gt69Hp4PcQbYIpryFaKpDbDfHu0RkKBHE1KfEfgWLI10ZIWN
	WFVVUPyvSSeZvy4HjhLVYmqxVmXeOPPzNhlVajyo3dCAiUDiQaewLteGK6GKS1Akk9XNhuLOJpa
	M7pexUlbhkL4uJkazhnTsNKv+N1k20fGYQRgbG0UDYA+GXs14Vnoxz24SEFYQNtLhBw9p//KQc+
	CSc+w8Wj7c0LXgODaV9h6xQvFJ+7geLrtnlI37KbkIIl3B2F9/0OseTXcbLQB9nQZ8eJPCTN4da
	19GkjIPWpU+2OfD+MTMcirzw1CLkd5BESyINwoqFHMTTKlF/ce3OMjwdcVP8nwtWreq6gJRh147
	8LFvz0wlHZk4FNAPMBfBd6ddDEWUU+TF39ENu0ycDi4WI1BFkXuN7t1WkfjHIPkpb7eQBtfAJk
X-Google-Smtp-Source: AGHT+IEItnyECXYDPxMnTFFsCprWbZuCxtx8TXL7mGc7W0hDXDFNV+sF5NCdJZkSwqz0cWPjcu9HXw==
X-Received: by 2002:a05:600c:4ed2:b0:477:9cdb:e32e with SMTP id 5b1f17b1804b1-477c017d7ddmr40121385e9.9.1763795087763;
        Fri, 21 Nov 2025 23:04:47 -0800 (PST)
Received: from avri-office.sdcorp.global.sandisk.com ([129.253.242.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9d198a0sm104914505e9.1.2025.11.21.23.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 23:04:47 -0800 (PST)
From: Avri Altman <avri.altman@gmail.com>
X-Google-Original-From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH 0/2] mmc: core: Extend manufacturing date beyond 2025
Date: Sat, 22 Nov 2025 09:04:40 +0200
Message-Id: <20251122070442.111690-1-avri.altman@sandisk.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ulf,

This patch series addresses the upcoming exhaustion of the eMMC
manufacturing date (MDT) year field, which is limited to a 4-bit value
in the CID register. Under the current standard (EXT_CSD_REV=8), the
representable years end in 2025.

The first patch implements the recently approved JEDEC standard update
for EXT_CSD_REV=9. This update rolls over the 4-bit year codes to cover
a new 16-year period, extending the range up to 2038.

The second patch introduces a quirk to handle vendor-specific behavior.
Some eMMC vendors are not yet updating their devices to EXT_CSD_REV=9
but still need to report manufacturing dates for 2026 and beyond. These
devices re-purpose the year codes for 2010-2012 to represent 2026-2028.

Thanks,
Avri

Avri Altman (2):
  mmc: core: Adjust MDT beyond 2025
  mmc: core: Add quirk for broken manufacturing date

 drivers/mmc/core/card.h   |  5 +++++
 drivers/mmc/core/mmc.c    | 12 ++++++++++++
 drivers/mmc/core/quirks.h |  3 +++
 include/linux/mmc/card.h  |  1 +
 4 files changed, 21 insertions(+)

-- 
2.34.1

