Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794993213;
	b=c7dcsuyGxieSmOZ13xthL7W1n9YTdSuLvLI0d4nCDS6m1MhNwaHY9OTibHHvFmRm7O4w
	 y0t1Le2z12sX6K9Q9qerWz3OQNcuRGuy6L296TIsbzc45a6+QofHgJmwADJNBiftJLEYj
	 sBUQjj71NdyZbb9ni8LF6qkfav5bobMtqdnJy+VMK8V45Y1U1aZjnjXILOx/VmvfpX9SP
	 yJeW9uLhtwJ6ATpsEzE3JUoKuWdmOCK/85DRGq5Mbuk3STvK5tm+4hAXq9cOlty8b6zl6
	 6nEDNOT3uoDTHua3xO/mISvOCIuEfzEoWo6+OM+IGXzuQnpO/8j8KdDNuicXYeoBgkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993213;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bxGcwAbKwaNTQzjeV9MHB4wwSLCCyf5n2YQi0nGHaFw=;
	b=r6mKYQ02iceuG60E7mXHhbipbwUByMRw6hChHrLKzFmJhOKsvABmD+R5aQHHCGpbNOjb
	 +Q34tfvjAVo2SH6TCo9Fg528YVth2CuZP2XVARyD+SIV0iP1sjSdcOuXOosy4Ae5fWCV1
	 VMnWQPbFKFxvHfqNP0rcfIQjCeDQzYl0Sfr/81mvuP0oe3uc9bp435/JF8YBKHtM7Q743
	 nJrhfLfVN6uz4hlysGgZTJLSE4JATnAPsPLIlb7m/yYYbTWjHH8tdnASQfKbmmd8Ka0ah
	 72nb04Nu2LMlHSD47O9omsvhJX9elB6l1szvTYng67ic2GVine5DE3GPr2oiI8F0n/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EJ4JpYQx;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E345C606A898
	for <linux-mmc@vger.kernel.org>; Wed, 18 Nov 2026 09:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E345C606A898
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EJ4JpYQx
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e3b22e971so317059f8f.0
        for <linux-mmc@vger.kernel.org>; Wed, 18 Nov 2026 01:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794993211; x=1795598011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bxGcwAbKwaNTQzjeV9MHB4wwSLCCyf5n2YQi0nGHaFw=;
        b=EJ4JpYQxImF2683BNSNESrjgbGsWqtKaUQDO9aSOZM+4tUCQoJlW4gJCnj5ApFlMRh
         hjsz1zzXSO8639LMHAUjviGw3SnFOrS9DTWHd+Zj91U+pUW9adVKRNEFBaE8Y/5iEFdd
         W4XXwVE+tdX4twRY2ys4pSQDC6sDYArq07Dpovw2BywaM/xvHPn0JiNWfE9pi9UXXG5L
         xt2gQnnXPXXaRzIHm38J5kL1aDbf+EBbPN2qWo/dzMbpnjKJjWTsYiCCZe/wkdhPu02f
         GUT83P1Cste7ZskoOigVIAefSHwxuPBoShK1eaGQ4VhLdgfXVkDnHVwIl6IiRsNbufh7
         B6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794993211; x=1795598011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bxGcwAbKwaNTQzjeV9MHB4wwSLCCyf5n2YQi0nGHaFw=;
        b=jENBJHjjB9j/ex0aa2g6kHm4IQqRlunHPjEwFTrrrfl1JpN8jHwMlXTqXTs7SkN0f3
         s3yUZprOcMVhMrnpT2Zrjd9cy++wT84n72wDs0mbLTNV1aWE0F+TvLLzXAs0x2vaL9H7
         afTVhW2Ka3dLeTlNLELFkLlecs0QxUbUOpBeJcf7eU6V8d5qKeFJC7zIpSGGBcnzSrlE
         Oz5wsH5nZVCT3E0+IjuxjlifuzjEW8/nx1yBh3M+/5z82U2jiqQQK6PomCcB0bN5O14B
         KHH6OnS9+1+6kW3yQUHUK2ihwUNXlOD9yhL/DkhbFPRGnpo5+v949KA3tTKMPMiwgNy/
         HLGQ==
X-Forwarded-Encrypted: i=1; AL+hErFlsdb5hmgeJBCElH+VsHmr3e9eHTg7mkTf0ws9tzM0j2/4a5G+oEbNzuKy/bzXzK1f54MZLcbQxeY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0Y2Z9uOYdPphC2wg2XvQhA3+GR/3SDUsOlNZMd1V2nkl4uP5v
	/yZCaZfFACbomwj+767Mfx1kkREx7L7YDqHvcnEOEqX09mV5E41shM5/
X-Gm-Gg: AZFdTZdRqzJAA3CLphr1dJoZr8h23FfVAod4cjrdpnp8muL4p6gOGcWHF4GeYLIv+0y
	vScJF/Tg2QxZepCrLdvGhThA3+Ttku+/Ww8n/yHPTojZUAlN/YzLSoZoP6o+6eBZojCmrWx+K/b
	n8ed6VWl+WFVGuE2z3axpD3p+2G3qmK5COF0K7wBv7kD4MDMJGQeciDz/K+gcTG8Yf24mfujLAt
	PkyYI3JY/gWUwR4WzsPtgNFSRcnYNqdc5L6BaWCdXdVxsuTDlhMQ3HHBBE26Kbi4Ll5FoFq9WHA
	4dCIQ0b+r4dDJAa7/yq+5019VmRyMy+yuY0CvCkLoH562fjqADQbWpLOOC1iwdHUTKIR0IO+x4d
	yE5o6iA+wQK+6OaVB6MRbjnhH2j6r3q4CzsNygCDtrmekLrW9F59OdDp+CJ/CYo59l5J0GBofca
	7/aOXZM6mCbLjzWl1oSe0wd5GaKmLd7cLMAHAqIdM14Vq+iNZSuDnFq2qXY/GWlx5hMD/p5xQMP
	8W5/9dK2rV196bvgLdDPJTp3KghqoMC+FjIo0Dzg7V+hJ8sIAmfNWaskR2+R2zM3HDsJNQca6Lh
	TOcMWfKvOcw5qzDXKp3hrahmwzBX8ee6o8lg9/ZzF9r7dIDM5s+hEY4PclpR9uy01NQEKVv+znW
	l5h8vGH6DEXRKBUE6DMRHv4Fvc8NnbCA7OeYXT+xpom/fQBTfGSlKI6Q=
X-Received: by 2002:a05:6000:29c8:b0:491:6c24:65f5 with SMTP id ffacd0b85a97d-4a63984b729mr2543753f8f.17.1794993211077;
        Wed, 18 Nov 2026 01:13:31 -0800 (PST)
Received: from Lord-Beerus.station ([93.146.104.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c406sm3634609f8f.14.2026.11.18.01.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 01:13:30 -0800 (PST)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
X-Google-Original-From: Stefano Radaelli <stefano.r@variscite.com>
To: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: pierluigi.p@variscite.com,
	pitchaiah.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Jeff Chen <jeff.chen_1@nxp.com>,
	Avri Altman <avri.altman@sandisk.com>,
	Hans Zhang <18255117159@163.com>,
	Luke Wang <ziniu.wang_1@nxp.com>
Subject: [PATCH v1 1/1] mmc: core: Add secure erase/trim timing quirk for Kingston MW2816
Date: Wed, 18 Nov 2026 10:13:19 +0100
Message-ID: <20261118091319.8268-1-stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
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

From: Stefano Radaelli <stefano.r@variscite.com>

Apply MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME to Kingston MW2816
eMMC devices with OEM ID 0x0100 to allow larger secure erase requests.

Co-developed-by: Pitchaiah Prakash <pitchaiah.p@variscite.com>
Signed-off-by: Pitchaiah Prakash <pitchaiah.p@variscite.com>
Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
---
 drivers/mmc/core/quirks.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index 98cb680e3ace..b25592d70da3 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -161,6 +161,8 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
 		  MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME),
 	MMC_FIXUP("IB2932", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
 		  MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME),
+	MMC_FIXUP("MW2816", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
+		  MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME),
 
 	END_FIXUP
 };
-- 
2.47.3

