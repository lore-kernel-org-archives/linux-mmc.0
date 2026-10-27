Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112013;
	b=dqoyjU/u6y0CGtqaEjWKvYZauwAKizN+lzN1BYTJkxhFrFN6V6+RtbvFYaRwF9a6fEvq
	 wny0RbymqFQCcDnbzm8SQsV+V1XtliPARzTZTu0/msV1w0Y0UHx5Z6poBmDAdfVa1Xqcl
	 hrM6spQxTyTCrogfbKrLKp3lC4fxbAz7sdCZ8QB7USd/YVVSkFn02h3tnTES0N3ukfFJ9
	 uh7O7Aq0BoCmTj+6XpreBwCwGhmd2nIDDLkynrxRHilBoWTcA2K6RsTpLJkfm+ApP3IS1
	 d67HBl8khaBNZPYtZyEkZOxHThTJwbBtayDe61qa2NjwfudjPat8yLa8jY9K5Y3Ncyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112013;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ssGW1Dqn9NQO094E/8Ttr3abz77jsGgzbaDPU8z6CLQ=;
	b=S5t+dc3OkYvc/1SuhAaLm8/ANaMOB7Z23CA+A3LQf9YnSJk7sZxtQ9wyCY/Fo3XCAVnN
	 eWoWDkNA83bAfTlNUgmXH0FnjLRJZpBJ6M8Hlt0qZbuXNfdmIUGp7Yaqfbkr+ZIAWJXxc
	 ViuwKmARW0VAK4Ab8aJfbvTizGs+tlVguyPiQcX+mh+GDQnIpJ1Ba6AIKGzk03eLacmEd
	 EpmZqF9bT8zbTQwgp9JS+7nLA/iLNctbZc3bu+I17s3+arts8mD32hXpqnUCVJeXrd3d7
	 g0Vv+rUsKMK+cetWY3Fk9aXr4pDBwqR4+yV3r7t8yEH2h6vOMkrclUJ3Ojf5du/n/ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j2VJm2rP;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEC7606A31A
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 14:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EEC7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j2VJm2rP
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e47347279so1949638f8f.1
        for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 07:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793112011; x=1793716811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ssGW1Dqn9NQO094E/8Ttr3abz77jsGgzbaDPU8z6CLQ=;
        b=j2VJm2rPL8dKoGJ5IAD837xozfaN1bHUYYeUTo5hq2LnuJZrIJg+KJfxbTv/5cC0hT
         QXcGC/xhuLi33OWTMbx1SrHFI69l2+Oypn8lTDoXNPcn3uzdDkcNDNbpZWA7SckTH98l
         kxKwbPVOtsrU9Whq67KApMl5KY/aJiHpnL0XUY55LyPFxQBVzRMNNg7tQ7tUpeDqnh7q
         9tzcEZ20wdy7TBHddU1djSbtqFou0GVBzzMBitqcWAjWcnx3FImJJs95qAXFO7l6eJvJ
         9sgB1IWutAaejD9a9uLnhotVH3rU6RQJZTwg8pY5Ef3oWQCwCunmqjaM1sBEF6YO5ugv
         shqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793112011; x=1793716811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ssGW1Dqn9NQO094E/8Ttr3abz77jsGgzbaDPU8z6CLQ=;
        b=YoOQImM36LAezrjjEieXsbLFLDbBn64M6FDnaGcUCQRIYYjN9KheVEQXCx9QYxoUq2
         1MJIDJNHqop4u2OliilZJjaEfBiYRaewwkbnVfVkEbk+ztskFkl8J/Fk2inR2PSW982d
         lKctFarqc3N7GfJek2zgVHQ4sVLpoqAyhoSSPS9gc8u/36yaBL8+hERjz0qo0n8/WL08
         x+bCvpuh58L1VnXH2MJF4SoAHIYPzq+kLG9gEezMRyb2OD1cKVP6yoGk6Ok+mNnq/toI
         A9V/vH4CzTTBcPTTvnB5iabKrZaD3jl7cSl+KgUrFC+xupLmjZJ62ptrY+VRjeKZbPZt
         81sw==
X-Forwarded-Encrypted: i=1; AKwUvBysIM93I4cZPR6gSSURSgiKCxfQ8hjgh4W244cH03UvG046fcjgEZePcT39VuVt1hlL8WklpZ8hLbU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIsWLOWHsCo6kAHLUgIdODxdqvFw6eKXkuxBmp13DHTXPzPXT4E
	dhieTfSJKnJe9QpiXDoP+jB9TJF0FfZvp8ppRXni1BFlZ1uwZf1RSpGD
X-Gm-Gg: AYBFou1cYuT+//9aKsGCp6fNPJcl1RdJtp3FLX0MePqUxNJVBjIU0Bc5wcDQY8ZPqXF
	2iHWTHFTh4l/2EDxjw4cg3Tsn1jNxH/oeTUxxh7TJFqyy/REAJR1uNd3/LaUfzUhNiH+MgjhEqQ
	lJ2OVo53fuWCbrHH/8LU+WSBwU1+ULHZc+WnX9HjPxfnfA1ZgFsZvG5cc0yk/jAbWCjpMnhDIWp
	F7g99Awnj2hty9TK1dyYn9AD8BwnFCARk8pM/SU31Z6PtcPHrkJZSBnf+CAXdHvZ2x8bhFOYiRE
	cbVFBHxBS0v2xQcy82XvL+wudEFWOu8qiANLfrUrdHIKkZqCSpg6+CihfTCNr1EUFCTLy4F4B3W
	p/M6FB3PG32YhXr90Va53SywzDfIzIB0ihk3bZGgO0NI6MG5LDGcZalHQxhhMsbC6lB2iMJbAy2
	ihfBkYUpRP2ul6Zhqv/ycOS5WhRGodk8YLukyW0HdaC7CEpaS+o62BvqQpQ9oJNU2E/jR51YurL
	ljI7CasF1Xg4Khx6pp0ci9L0fvhHcVV/SEyJqMWWRF3+HwpclYj9e0PBo3Kabw/sB9QeH5diU/Z
	jo9CUzbZM+TVO7nerbAfnICtL/eczicsZ/tkLPehnTYoRSxeXk9O0bbz2wX2
X-Received: by 2002:a05:6000:26d0:b0:487:91e:d8ed with SMTP id ffacd0b85a97d-48e3eb2ceedmr18881590f8f.2.1793112011312;
        Tue, 27 Oct 2026 07:40:11 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it. [93.34.92.187])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb846sm23354151f8f.25.2026.10.27.07.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:40:10 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wenbin Mei <wenbin.mei@mediatek.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2 2/2] mmc: mtk-sd: Add Airoha AN7581 MMC compatible
Date: Tue, 27 Oct 2026 15:40:01 +0100
Message-ID: <20261027144002.10606-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027144002.10606-1-ansuelsmth@gmail.com>
References: <20261027144002.10606-1-ansuelsmth@gmail.com>
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

Add dedicated compatible for Airoha AN7581 SoC that implement a dedicated
MMC controller based on MT7988 with the difference of having a single clock
controlling it.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/mmc/host/mtk-sd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 5b160fdad3f0..736cff2783e2 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -713,6 +713,7 @@ static const struct mtk_mmc_compatible mt8196_compat = {
 };
 
 static const struct of_device_id msdc_of_ids[] = {
+	{ .compatible = "airoha,an7581-mmc", .data = &mt7986_compat},
 	{ .compatible = "mediatek,mt2701-mmc", .data = &mt2701_compat},
 	{ .compatible = "mediatek,mt2712-mmc", .data = &mt2712_compat},
 	{ .compatible = "mediatek,mt6779-mmc", .data = &mt6779_compat},
-- 
2.55.0

