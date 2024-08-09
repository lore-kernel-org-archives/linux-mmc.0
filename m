Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0829516DED2;
	Fri,  9 Aug 2024 23:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723244558; cv=none; b=gPoS4WxqJtsvmRE/LAy+zh5GMHZsYwT9AqmXQ4XriuIRvVt8q+P+OcJH9G8sddktBgm/7uoG8vRNFoYEjxJI3yA4QXsjgOJ+kMMge8lQs0obRG2Ao4EAAWUG5dubbwWdsvttWnheortbFu9aOzSvdL8ZugQCiNvty5T/FNPHcpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723244558; c=relaxed/simple;
	bh=yw1mImiPrjqLQht4OtSvNd0TeQGoObVDJhFgu2dtlzE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nd2iPFKcoaqBMno7RJ++QOf40cHPaNgtDtjDq+V58a+8Kw+V0Ah322m0e3OivOXWjgrjzUmhWVHUDwqkThkA64CDhhpern7h7mPbEB4AevjiKhwB9Z33MuyUz+BcT0T92HJaFwGImvcWarl/YCSOckr5vfOVrvmQku63UeuP5/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3q/Cr2U; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3q/Cr2U"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36bd70f6522so1345482f8f.1;
        Fri, 09 Aug 2024 16:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723244555; x=1723849355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mH3iAq1TAeBK36lg95WliQsOcKLSEbditM8M8e4wTwE=;
        b=K3q/Cr2U2i/+4BWQLT7P2GIIb4FKAoPnGQcj7TmQNhZvxWM5+fkghEaNfPCtPzcjoK
         0m2OxSB2JwKZqWU4mUsSPS9lhweC1flWvhD9atNcsmDS6Exb/bhFjXeFihY4KdUDElQ8
         4sJyAyxeoaHHWPkh9RiMe3O2QrkZ94b/KsasoU/gPX7cDFgLgI/gNoomrN68kdCQcsIf
         9WLxNQO3Bx40kix5hRT7fE06S74+9sWgesng+UnQd7H4sD8zhcCd9B526Vpfq3d7i1oz
         Q1e44sIS59+L6i9aGGv5P3zM+qOPDlsHtaHpKNGK9IUTWd+wN0+Ia0lfC20hVdaCwzeo
         c4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723244555; x=1723849355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mH3iAq1TAeBK36lg95WliQsOcKLSEbditM8M8e4wTwE=;
        b=sAhOrEzPDxjAkvs5ozAASu6Jjcn+BCy5Uv+pE7XQ9R+Z3yjVqDhSwF3PZ2x6/kQ/VL
         Nw0PEUKnMTE3lZH7cQXJmr23PX96bHsOCfzp7Z5XEYb4LiFa9f5nz93IEe6lgXaA13qW
         KMj1raQVF00bHOM1nf1VtsNmHrcgqGZWCCVwUNTYSfXOTs/3AYPC6DS2ifdgt4k7B8kC
         JIxpOXd8S3X1kD6Kmlxmoq2O2dvmjJLdyAxpUODQjHq8ZdKsiIHmddnWug2+lzXn5PQE
         UrYipDNHli7v4J7bp0ydOhAmNdOwVB25WxxmeOAaGHev09dcHqhKlRaIOAS/zPb7wish
         yyZA==
X-Forwarded-Encrypted: i=1; AJvYcCULQcBGv3okUDNnVggJuGU0MPLtNLEi+cf4tyfeAei9smlQE1AQ941BP1+SCLV0vtC+HgAtpLMgsKgYPEyYT8IToBK82j14gUR9gHB5AdqVLSmlCulNMO/oOZr6YiTB1WsVUzhkqtJDDIkjvj7Y85thrH5AIxfbCl1DD7S/mUcqexQZUg==
X-Gm-Message-State: AOJu0YzZ1GjDmPVRg+hYOftXu6X+nJv4IjEju9Vf9bHX+sV0n/XpunWX
	P3sAyU+WKcU+HEmcWhdCRG8tuhRTukuuKIeG/1NkXL9JPyGj5nsW
X-Google-Smtp-Source: AGHT+IEYUgoe/HmhkLHhfaXC3TnoDjBeLv9p7ql+4nY9eg91VGbHZYMA1St4QZZjnSafD8UlbLFHsQ==
X-Received: by 2002:adf:e98d:0:b0:367:91d8:a1d2 with SMTP id ffacd0b85a97d-36d5e7fa63fmr2252440f8f.30.1723244555242;
        Fri, 09 Aug 2024 16:02:35 -0700 (PDT)
Received: from localhost.localdomain (host-87-10-253-138.retail.telecomitalia.it. [87.10.253.138])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-429c75044a8sm7987485e9.9.2024.08.09.16.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 16:02:34 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Joern Engel <joern@lazybastard.org>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Saravana Kannan <saravanak@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH v4 5/7] of: also export of_update_property
Date: Fri,  9 Aug 2024 19:21:03 +0200
Message-ID: <20240809172106.25892-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240809172106.25892-1-ansuelsmth@gmail.com>
References: <20240809172106.25892-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to how is done for of_add_property and of_remove_property, also
export of_update_property to permit kmod to use this additional function
and correctly update entry in DT.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/of/base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 20603d3c9931..b2d523cf4925 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1746,6 +1746,7 @@ int of_update_property(struct device_node *np, struct property *newprop)
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(of_update_property);
 
 static void of_alias_add(struct alias_prop *ap, struct device_node *np,
 			 int id, const char *stem, int stem_len)
-- 
2.45.2

