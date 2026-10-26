Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793048745;
	b=aEP33mSHDIk8UaX8zX55ZkHmuXdO5slK4Qi8/nAzr5/JIqfsI37tax4z8mhXCiqKiGw2
	 hfSNEDqDgXajCsi0ZY2uar/HB8CQynWneokO5woWRBc6QnguhNdb8s7Bpo8KBH5m6zGIh
	 xkEzPAoO8upHAvJenXYG/BwwgSw5knJBX+IqYaZ9DUrR+NOt+8BnjOgBv4OgP2cvXWL0E
	 gTiAcKouOA9l4KaLq+vn4WnCuLZbyFQDKY7Jq3W+W0eS5BbTYPB6omUkN8X4S9EJvkjaU
	 duS1M4dEc/VOyrQoyf6whJzxO1YMb6L+hALVy9AHzJzu9vH8U7b69TU9MtBcvU8rPLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793048745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rD32K7ekISuMljF5aUzSzqVha+tq2S5F0ssjFpcpNiU=;
	b=z+Qf54lgWgoEwI6/A6TrIcJfr+hcfR3iWPVocfLsL7M6FPGbm7zm8IDbhSeLqpOn5tf8
	 8DV0YDLof0iq7EaLdI5aTgQK0oYSTx5PxqnQM0LEBbQ8VT9gSLWu74BQddB/Q2jFV1ffY
	 8ligZf1n1kGFXCqpufLRBCh49bD//JWa/Q/GBM/nlbjBuTgm5ZVS+fc8QoOQPvG7A1zDe
	 8icSRog5lyrOVEYqxNcToCqnYCIiKJQtXDPLW1XEIaeq3Y2bz9mUuBZltUbyTXn7jngH7
	 hcymvkAZZX2BHdQ1IH/9bM36FUaFs5kjTHyoFlMjkNntyPbtes6+95nIQO2ccJbW5gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b="x/O1osm5";
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3216E606A31B
	for <linux-mmc@vger.kernel.org>; Mon, 26 Oct 2026 21:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3216E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=x/O1osm5
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48c4649b35bso3541077f8f.3
        for <linux-mmc@vger.kernel.org>; Mon, 26 Oct 2026 14:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1793048743; x=1793653543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rD32K7ekISuMljF5aUzSzqVha+tq2S5F0ssjFpcpNiU=;
        b=x/O1osm5M7zxTA9jZpysosF+ofFJypdYJ1I154osDWAjKnFrYbUbVVNIvJGGGKAcC2
         In0OXi44NjS3dGcRnDU0whIn+6EZR/bQz0DDCiPpWnkBnrmwKu+yLlf2i765eSxk7t2+
         IvNVOfNN/tpz7PoFpKap5Zk/YOyaSnEp2YjoSxsu5guic+vpAou1T5ajAGW2TqWBUW+5
         OVp2DSxhu9xgSSBJB7r2mxQrM62IXSAf9i/dahZ0qh8bZ18Sj9L5FnA0JGltkWcSfEnj
         Tl1/BvDhhVig8/XdIUgu3ceScuqAvT1KSRZtHBUSlq5/JzFG3p5V9adFW46sMwtBhNdY
         bEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793048743; x=1793653543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rD32K7ekISuMljF5aUzSzqVha+tq2S5F0ssjFpcpNiU=;
        b=jZITPNSibveJ3LOQ8kvMv85OGbr7ZixjoJ6/AOKNC6U3Mp1sbZVm77RrAij3M8R59t
         Vrpgs1hWTT66vtNGif7fT4E+VR5ICUYzaUY/Vh8FF8Ve40/f50/NFWk/U+fHei9igIEs
         Qg4qJxgcbEgs0hspCxYYc7tfqzpa3nuJ8k1RvApDVTmVbWa1dwFfwM9oPb6maUAMSHMg
         eUxwcfae7hWIumgtqhGuaAKKPuXPvvdlC8qg664528aL5FwEcQAN5W7p517pEf2Zl6Lv
         2xhT54pnQHRJ29iuhq89uc/yqih5p3i7fyds1QTABQJ2Z30nj6R5drJXZEmUU8COMXZJ
         qMAA==
X-Forwarded-Encrypted: i=1; AKwUvBzeWdDDbgGdytobuUVquVgs+IOU4VvRYvh6L/AIe44d61fyd5GmFn1qsUic7ZHG4KCtEkoPCu6wynw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIBadvIt4JtrShBBv5pt8+rCdw1Br44CymSfgDTwk5jmAxeG4fs
	laFtsRhdaOchWwF3/T9ovtMCMMVBgfMK8kjGqvN4Tf0TJTk7QGQMQ2NzgU2uV6osoL4=
X-Gm-Gg: AYBFou1rEOMjAa3IrGyvka4fv5nYvjvUKKJVo+QyZACBHtoq8c5JQ3qP7jBWSw1+Kgt
	ZHRSEvOwkAV8NxmEGWKN+8U5Chgeb19mqr0sraOUBgWJM9CgstipaeCfk49DXhRtpK71Edepnoe
	0HI5JHS2IrZvz9/Md7YIoqSkSo7FiruHt5oFYrMHvs9H4cmVtd3PjrfI7DxD/AvANZLnzokcENI
	2nrGiWKujKMnVX+ln0Vaz4/RhoBMxhjlJoRdSP0biJe40HKBcMBOPWw7D1a/7srE8oAbAro5e6T
	rd4C6DG/b41xak6RTLn4WljJ9uua2L6Wgxho9sqrX+WHXcCCNCRBRIF5eiDwNS5VYJ/IcFdxjOL
	MDZOmlCj75p0z7e4tJrdcKTvAYAhtAp8fDonAH34n9AyEn7tj6DSb3pSygyNC2Lusw9vR4LJdhx
	F1feOrv92rPN1ByItzyl4HDb2sKXQr05n0yXrWR98yGW05d5BrUgdJsDKonlueJa9KYLXZuqFa/
	0bCb/w6sxTWdXdMF7ibkGqiA64RFoO1ND+ttPTkduqvjGe2FDNck/jqVT/M/t2wwmmsrm3EFejj
	rn+1dit9TL/j
X-Received: by 2002:a05:600c:3114:b0:49d:34:420d with SMTP id 5b1f17b1804b1-4a35acc7716mr138556935e9.20.1793048743445;
        Mon, 26 Oct 2026 14:05:43 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:258e:715a:5648:ed59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359ff2189sm258646975e9.1.2026.10.26.14.05.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 14:05:42 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Paul Cercueil <paul@crapouillou.net>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Matt Fleming <matt@console-pimps.org>,
	stable@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: jz4740: Remove the host before resetting the controller
Date: Mon, 26 Oct 2026 22:04:27 +0100
Message-ID: <20261026210427.14728-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <48976ce134e26877200e8e1ef8d3f5c66f4fdcf6.camel@crapouillou.net>
References: <20261026083323.12301-1-olivier@mgcrea.io> <48976ce134e26877200e8e1ef8d3f5c66f4fdcf6.camel@crapouillou.net>
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

Hi Paul,

Right, my miss, adding stable now.

Ulf, could you add

Cc: stable@vger.kernel.org

when applying? Or I can send a v2 with it after -rc1 if you prefer,

Thanks,
Olivier
