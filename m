Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896F91F5608
	for <linux-mmc@vger.kernel.org>; Fri, 14 Mar 2025 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947076; cv=none; b=G/UF4xSovVwWjpLpwCEdVMrAI5EeRh5dXLlfttf+2QasO7TgUrWDR3Z/fhSqnbe8Rdb1U0BoakwdC/FRDzzyyMLmAk057rbNv4JZAcTzZsdILFERAwKqoJL/+QYfmOAxFhZgwAkNTx1+llM3NKnTu4Uuhxl8ZtHrAMkPROf6e4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947076; c=relaxed/simple;
	bh=3ahzH7sLMBPla+F2Y8AvwvjAYSJ5VvM8xfAY5mAjYis=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c2Fy5xiJ5Vo36fFFFGlRix+Sk4Jhi7uEb23m44FeZPscE8Eu4Oou5GHfeubwfG8qkYBpYdLJnTp+AorBU/7ynNEJIldGDGVaHBEGWz71VvWZhJ577eQY/hTDRHh0Mn/K7sNt35Kj+xNKeNHk30vS78Y41Axk1OuQAjt7OrEupNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gOkoCSjL; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gOkoCSjL"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3914aba1ce4so1694694f8f.2
        for <linux-mmc@vger.kernel.org>; Fri, 14 Mar 2025 03:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741947073; x=1742551873; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yaoaIY6mq6HjtY7Y1s7vhYdY4pp2YI7DLVfhzEAcBtQ=;
        b=gOkoCSjLCUWrZCYIPDCFuPq6s46O0vg4d/nytOiZPDRT4J3ICCqWSAfZ/WPR8/yGT5
         TGg4s+e9tunM0nqgtEcR17YMz5PPc+AuwiaefWKJVrZag+J2oH4BAHOf7HD2SY0Wlg62
         YZcTvJXidf5tAPZbjA242Tua4dDNlX9F06ML9wUwcnklDOTGhxGqdZ9jABC+qmBM+Gld
         NoSiV3/XaN6AA5u4vCei+SenXswKKAI+pwJ8VWouTQmdA0X7T4/Pi5aAtBJfwBr/wzr8
         T8uWEBJTq/yetlU5ePGAMnaVnaBy8N1QHJWxouXs+QsOmDBmJ+5A2l6vjGpenDtSxF3H
         bGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741947073; x=1742551873;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yaoaIY6mq6HjtY7Y1s7vhYdY4pp2YI7DLVfhzEAcBtQ=;
        b=TWjxZR9+PL+Vldj5rW6p3JnjGS0HLIouENnqi1PvLzXvEUQDv6Jno2p+//M08sIzDk
         oUeKf6nceeZkAwjRvk7eisl53Ym3LdrN/Ydo6wr194iwHvoxdoXqiIH5OCHeJAOEYWfm
         4Cn9X0FQFI/NUGWDE0GyNzcWO20WwdjNcVAfOWSQpvvbfHKeIwYvCQFUth2j0Mfli4T1
         fmAqoeN8FHXv93dFFAwFxmhM1BD9m/AwFVntjykXq+alm6N3MftlvJBj172usxNbEV6k
         5QQABx2yruyi5H24ZQlyf2qcoFxbovx6q6TlM+DNMcfQLGSL/hsMR/NmwKdszCWGOzeO
         oCew==
X-Forwarded-Encrypted: i=1; AJvYcCVT5TAb1hOf5hkw7jykvkPqnxMPXWomSJUC4m3UlaU7zfUA257IIr+kAtKIsuycjZs2NF1fOM+Kodc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVhFmDsxJ6ySVXUVKUgKp/1eZe/TMFPbxgi67Sf0x/ETLKUBfG
	ebRIq4QKlGMOltuKCcuPP5aTTshFapaVcJip6/ajt0pm2Sea9mprzeBgPZw4rLE=
X-Gm-Gg: ASbGncvEWMLGXFRlgNbHpJwK9sbWY9smNDc/jUxKwiVilLgn4fdrdVmyLUETP20E8H7
	cuZ8DlSBRgTTEmZ1wGUCCQV+cwy01qxixe1mRHy8Vz4PK7I8pENXV8vHxnwOn2esc9mPxeTIF7/
	WdFcO8R0b0cWGFNtewJks646VhjD8DwKvSpM7NywxfGLH37hNCXy+TV+Q3ZyofbYLcRMI1pIqzO
	8aS83CUOKpJDidWQ4OCqe5MdjXyo0BwUqaciYmaId1nyDfgQCjR0uzxnnsAj4G31Kzl7hDPmD/e
	DhsLCqi2TvA+ybfrBhmC3viEIH6biw01GV5WLdrMMvprL66ZGg==
X-Google-Smtp-Source: AGHT+IEZV7Q1QnjasExKNihgSsImAvSjr+KfxLj4uhGOe3kxwV0Balcqir0mcbZRaWbeyfUh4B2wSQ==
X-Received: by 2002:a5d:64cf:0:b0:38f:2efb:b829 with SMTP id ffacd0b85a97d-3971f5113f7mr2060911f8f.50.1741947072761;
        Fri, 14 Mar 2025 03:11:12 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395cb40fa30sm5082312f8f.68.2025.03.14.03.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:11:12 -0700 (PDT)
Date: Fri, 14 Mar 2025 13:11:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] mmc: renesas_sdhi: fix error code in
 renesas_sdhi_probe()
Message-ID: <dc39e555-8ef7-4a39-9253-65bcf3e50c01@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If devm_regulator_register() fails then propagate the error code.  Don't
return success.

Fixes: fae80a99dc03 ("mmc: renesas_sdhi: Add support for RZ/G3E SoC")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/mmc/host/renesas_sdhi_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 396fa2816a15..fa6526be3638 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1178,6 +1178,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		of_node_put(rcfg.of_node);
 		if (IS_ERR(rdev)) {
 			dev_err(dev, "regulator register failed err=%ld", PTR_ERR(rdev));
+			ret = PTR_ERR(rdev);
 			goto efree;
 		}
 		priv->rdev = rdev;
-- 
2.47.2

