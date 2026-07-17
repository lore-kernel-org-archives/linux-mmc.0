Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1048C3AA50A
	for <linux-mmc@vger.kernel.org>; Fri, 17 Jul 2026 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784289191; cv=none; b=F0wQY8v2FN8SwUNDQWHT9c95n21sSTzBx11EkIKnuNCoLQsK8QpnXwcMJwKIExb4qxhicQb6Hc+RwjTarbWeqcNeCAHQj0fp+jlT5gFHakQOayBGx91c2A0+O3hk6bbN/RCSB0IldzkDFfSMi0hUDvla8S8mkFw/T/QWa7eyTY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784289191; c=relaxed/simple;
	bh=wXG5LQXJ07OroDz+CuOeRV0aSjihJMOZsDY7ckx3LY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KydzDEXw728t/QTZMf3wywsPF7g82/l3nOUW6KwR6Fn/Jq1OhLGigO/nFo6x7xNhcgwh/fqw3i8Wtr0O9boGRJdc4/Kp+CsKTnDBGuy8aGnj81eLeoDm6EDvpqfEWAEwABBoNeW3qrNACTbWX41iIxRurT7MDrkjz67pPGgoxqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeP61THJ; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeP61THJ"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6a375ba035eso2448008eaf.3
        for <linux-mmc@vger.kernel.org>; Fri, 17 Jul 2026 04:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784289186; x=1784893986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8IQ4rZYCXmoKGNhUGfrKCmINcJDQqtVyHwlnRNnG6X4=;
        b=MeP61THJpcaXnEN+F8v6ccsCIwN4z/NnxHN4RoN12itgPjbmo02mze1ryPQcm5TnCo
         l2VwHpBl2kyBxspNRtnZC1UWmWOK30oYQjCuCA24+b3qdr7ZLhIQ7Ms0J6gzxYlMk2xJ
         f/5sWUqaT7XxbI/tUJkJCSHZ3Trk+8cikLOEMAsXU/+gCpswjj3X9mkbmUmjNZZfw7ya
         6+OJ0oQTJstkqQ1i13u40sn3t4Q3a2/XXzncSSFGEGSvz9lMdcbrzHZryt9rZDShJNhg
         DswIMypaaz8uJR3cPHcea2os7G+QGiugMHWwm6agttreexXRJAbC6SJrWEArdCdYeMnP
         xyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784289186; x=1784893986;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8IQ4rZYCXmoKGNhUGfrKCmINcJDQqtVyHwlnRNnG6X4=;
        b=pXg1av4f9r3zOjfxIS9B/k5346Mj2cOMSXfFIe3eZi1rqSx+3X9/fcNEnf/JS/a9ul
         dTtnYpSnGpwW5UNERHeQc84D42Dh2yGuh4FkeMkKBHB0aXezUZnZvNsjwXWnGkdazadU
         WLe7zGEpk5eLKh9sggaT2vOdfs6fkxRsCrOlQV/F7Po9fPIay6hLJBkyjDIQLVstYq3n
         3UaNFQEtn695I54DlGswuz+Fr1LtL/AfxXOGV3WZjsrRe+CV61UGoe5k6VT5s01TZaER
         To+jdqmeXZfNJdvBMsahAc3JC/NNa6NK+saHZ3P7w+cEfKJJqB1sMX5r6XC0P+/fOTJh
         8BiQ==
X-Forwarded-Encrypted: i=1; AHgh+RpjQv3QXCFcNqDR2rxr2dwoQvIkU/ixMT7SfIbCPLXBj5p/BqKhteCIZSkWBnUDHZ14Lb1KamHWeqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys6K7AIE2HEVE+6SiShd7FZ2lozk67Sxd6fhxqmEO9egvP7WtK
	pmjW20jaV6wK5I1nJJfjE9QhYzyZ+ur2u0PSgEeY9Tiv4MDMF4JcDizb
X-Gm-Gg: AfdE7clNCNlEcBmdQb5rgVAHtuWNDgXG1dQQuFkmOtjFdqTG6olqRA1O6OiuVomFG86
	+nsvUBoHyWx0nKwZD+IA1yh0yLFpp1ojlqFA9HC5JjFI4w4vxVwHszn+KNKYr5iRFzw+mHnNEc3
	SL42Oz2umKjIgfCJ+uFNEmX/OZWxl4191CaGCKhZaG1nO7ERgJjwcstkZ1GLMQk55zxc3TLa1ZL
	IAOfcy4/SnY3Ax2onKQwEpoNXgRAEbzBFV4ZHYQHNUvAacITU96o5QFBNMZgw4UJ1/HdFBLSAFF
	ACPFN6gmMjhuznSAZOfcxqZ6kb9/abQvte8Ekcx95rsAZVrQ2wW2+qcrPBCc6Ddfe13MjpPsaUL
	EzzG9BIrzPJsKfzlSlZvz8XVwxAhHLlG/O3aajEcglXaZo83+vQLYNBRfE1graNdL0aBEaA==
X-Received: by 2002:a05:6820:1621:b0:6a1:805b:5288 with SMTP id 006d021491bc7-6a53688627amr895125eaf.33.1784289186437;
        Fri, 17 Jul 2026 04:53:06 -0700 (PDT)
Received: from localhost ([74.80.182.90])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a516bb70c0sm1151776eaf.3.2026.07.17.04.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 04:53:04 -0700 (PDT)
Date: Fri, 17 Jul 2026 14:52:58 +0300
From: Dan Carpenter <error27@gmail.com>
To: "Luke Wang (OSS)" <ziniu.wang_1@oss.nxp.com>
Cc: "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"ulfh@kernel.org" <ulfh@kernel.org>,
	Bough Chen <haibo.chen@nxp.com>, Frank Li <frank.li@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	dl-S32 <S32@nxp.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"harshit.m.mogalapalli@oracle.com" <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH v7 8/8] mmc: sdhci-esdhc-imx: fix resume error handling
Message-ID: <aloXmhWN5QsqNcxM@stanley.mountain>
References: <20260715071818.272318-1-ziniu.wang_1@oss.nxp.com>
 <20260715071818.272318-9-ziniu.wang_1@oss.nxp.com>
 <aln_pFNqL8495Y_a@stanley.mountain>
 <AM7PR04MB6870A9E6138EC8F7C8B23E53EDC62@AM7PR04MB6870.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM7PR04MB6870A9E6138EC8F7C8B23E53EDC62@AM7PR04MB6870.eurprd04.prod.outlook.com>

Oh, heh.  I missed the entire point of the patch...  It should have
just been:

	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		return ret;

Another way to silence the Sashiko warning about missing cleanup if
mmc_gpio_set_cd_wake() failed would be to add a comment.

	ret = mmc_gpio_set_cd_wake(host->mmc, false);
	if (ret) {
		/* Just leak. It's fine. This path is impossible in 2026. */
		return ret;
	}

The other change was unrelated.

regards,
dan carpenter

