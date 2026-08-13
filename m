Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4573FBB6D
	for <linux-mmc@vger.kernel.org>; Thu, 13 Aug 2026 05:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786599279; cv=none; b=Rt8f3rGDq+GAaxmbwXlfkUoD0RyAj3b01gxTbLoARz9hZTYhZSbKQVhCwC6+HN6z2OXnV//VY/1LAACr5e0XzRrrKf0LfIX8aQ7Tcvwqtojg98JOFUZXfa08XWW/P8p1+LDbiTBWek6JdJjvpIOOb/nAQ3EhNsTZHc29pTdoOXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786599279; c=relaxed/simple;
	bh=d+qPrP6oSu2aMxcgbd5QZLwjghoOCkMl7GCAc+Moo/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4CdnF+Cv35LXTbrVCr4RRouUptD37InKkVCPpCC55iE8qJrG8GWY8noWlW2fA/JR1608lmDuC+ttgViM8Nz7pXO9Pi9abfnkjd25EignLxUm2KPUIIJ4YNKEse2lmI8MPv0OC29jwfO1kRlLiOxzF2Hi8fjRk2qGXzCFMrwj+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcUNmA+A; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcUNmA+A"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso23867545ad.1
        for <linux-mmc@vger.kernel.org>; Wed, 12 Aug 2026 22:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786599273; x=1787204073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R9jEpSymG16S90LWBY9Z/OiKp+TcgWzc+6zLqoEqqxY=;
        b=UcUNmA+AOgQYdnIx60JqzkDLof6PZm6H+Ni0biiyiaPre4UCKn2iB3mqdsOI/kxujx
         i6Oa3QOFsMJupqPOwVAyHmAXonxrEOl35ZckiYX1KkHVdZblGnTJBAcT1PPaiBM22RJn
         Q8gz7HjVPrq8+4VYsGTKxQq64/NkR03QBRklNA/HJlzR5UcMIvjJ/gkCb8OWieL6NoHe
         8rGTLyj1Vo2diXujeOutrDqlYTOApnE4alan+SvODjzI8LRW0lLnTQx9q3r5606rHGXB
         OUgDGjKgHyfFV+ruGpPbUTdxd3LO2hQbMIQU9Up4vKuB4RNWL5Kjm9yjTHNbIYv3jPG/
         fM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786599273; x=1787204073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R9jEpSymG16S90LWBY9Z/OiKp+TcgWzc+6zLqoEqqxY=;
        b=Zpl1sulTXUl36pGOAqYqdMAlqfyHE41G7wx3Ic11lYP6YMCSNns0IZu3Ltx9zon46W
         mp9Yo3PpK7oAU1RbnyeaBfPF3F9PlXamJsvCCyrrF0NsG/i7vdEwbk8ODddrdcWkbT8C
         Ds7iGIP5uhiU7Xg0ggth94aX0sK+V1TlXulRilTeALPXX+apOVRdZp38jpOmOaL8vG9Q
         gaRFKPZ/cnXDwIwIq3dyCVOQj4VYGcR+TiQ/FyOl/T82KjgonSwpH7Qgl9QdNAkfL23r
         XsuzF299OYdx+sZqXuJ+RWjzDmokhBVndnd87RiHIIxQfplIcBqZXr+z1QC0gSmNSy2W
         bSyA==
X-Forwarded-Encrypted: i=1; AHgh+Ro8OaQ/zb90AoCEGGoEUQZaAjAJTifCLWL0BgRJdOjMcpDwaxzO6vriSs5ktTtxNIDLt0147OvTESw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBidXPAbpy8c44t5fs0lqha7oUBYp+td1ipgZ6SGs7GedVVB3k
	albnKpCMZcnhAnIWt2jbAEEgicYO2QcfZ/md/sAguqtNt8NEE4aTuB+x
X-Gm-Gg: AR+sD12N8NrBbekLyBrGFSdPas+96IF7NtuR1KISvhF7PX8Ij2p7WY7Vq6CX+OSY5kx
	VBUuSgzBW3CvfmmItbQAzmqN7QxDQorH9DNb5jJNi3RyT2yf4sVEzqAVr2rur/R9LLWeD6ghB1g
	qJDfBHD7X1WGanHp4YkuHYKESAmZ4E8mO4SUqLNGgebvcptadM3kEvw1Tgc8w0lizrUAyV719T9
	O3bd6CpiL8I9ZIG7coqS9yyoaYsxrRBwzPhvbZPPd/rj59SBuYfEGP3nGsmymcrDEUqJlvHqN7a
	To8nowQM6uW7hkSniks+E3EUrGGVeGjsSKMKy1OHo1nd8BS3Wa0d8ukEkXDUxKhdpBuk3ihLl1M
	RJstCaDGmDA0qaqHqte1Bgvaen6yb1rL1fpVYbhmyEOpha2gIsPA7RV3b7QzZS3U/08TKLxDVWE
	LrKvZ+Ha4fanbBLcb/MpueMRsetAFIMNCZMLWvGH6s6VsgHVvs+hOuU5MNkU2yTSAcHnaauNSLB
	uBPOkSzpJL9grWAfpzsr6OGju4P6mpv7CctLwn+rgqkge9MIEE0AgyBAQo4hQe0T9B1QQx4qGLx
	IlLi0TBBfFIqxHs=
X-Received: by 2002:a17:90b:52cf:b0:38e:9e9d:9209 with SMTP id 98e67ed59e1d1-3931e278f94mr3672086a91.17.1786599272978;
        Wed, 12 Aug 2026 22:34:32 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931d872ec5sm594734a91.0.2026.08.12.22.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 22:34:32 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Ulf Hansson <ulfh@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v2 3/3] mmc: davinci: Handle optional IRQ return value correctly
Date: Thu, 13 Aug 2026 12:34:04 +0700
Message-ID: <20260813053404.21553-4-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813053404.21553-1-phucduc.bui@gmail.com>
References: <20260813053404.21553-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

host->sdio_irq is assigned from platform_get_irq_optional(), which
returns a positive IRQ number on success or a negative error code on
failure. Therefore, 0 is not a possible return value from this API.

Check for a positive IRQ number before requesting the SDIO IRQ instead
of treating zero as a valid IRQ.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/mmc/host/davinci_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 773577a10512..c503e5f5c886 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1303,7 +1303,7 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 	if (ret)
 		goto mmc_add_host_fail;
 
-	if (host->sdio_irq >= 0) {
+	if (host->sdio_irq > 0) {
 		ret = devm_request_irq(&pdev->dev, host->sdio_irq,
 				       mmc_davinci_sdio_irq, 0,
 				       mmc_hostname(mmc), host);
-- 
2.43.0

