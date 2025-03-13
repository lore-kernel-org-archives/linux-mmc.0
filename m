Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1907267711
	for <linux-mmc@vger.kernel.org>; Thu, 13 Mar 2025 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741872282; cv=none; b=LVfQc+VKWfLoskV146NOLnqRVa4GZXm0ZYT5Vk//qbvRUG1dHHh7+kCsxwFEu+kRZ/T1vZ97cONM2QNPUL/5P4Mx19H73mvK7MGdO/CPrItv3H02Q4fW5BBkgY+MstoC5AvOZHT5qPqG1bdvXqS8qEWPZsLC8tuGeEtQS6V5x9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741872282; c=relaxed/simple;
	bh=oxBvzwvTrG82n8EJbBWNJ307/ROiMAIN3ZDd1Xbf3ig=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YzWRZj1PSca/MSQUN9uM86aw4iPSSoQUTOKeWfjJEPTIKs7E0GykfTQgcGYxNOqmKtuWyhMsTe4+7vN0aNMCQ2LIucem+T25wrQFQ/bmmQr0q+oKin7NT68qDY+IBZDXZsZ78WXcUlZBzU1t9Y+5bG3NCPr+jyOds+BxMIyGuPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CgRsHjrX; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CgRsHjrX"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-854a682d2b6so57690239f.0
        for <linux-mmc@vger.kernel.org>; Thu, 13 Mar 2025 06:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741872280; x=1742477080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PLsvEgnbim2yotRJtm3RxSyGerYXasNwsqr+/KVpS4=;
        b=CgRsHjrXXRqq4vaPHAcHpS5QmNOKwPbwPx1qON250R6Zi2OYgAUJ+uhFKQuGASSWQm
         rS7BY/yLPqLiuDxkl1/pXv7VWbJ7vDEGxpDH6GcG6/dLYajQjZHTa8KbZ+qumNySbDVQ
         gz6YNnTe5EHVHnU/j+EU4aBDLYuPhD9jw0fqBgZkqKCCOAEfIOt1oGRotT9X1Ju/lCix
         1bBdnCrP7jcTTY79NVlC35F9pvq8RTo3qnAo1c2m5X5xGbeUAbZETRvWLoKC6dh7aE6e
         gLjgAv/qJFO5MTjp5mpC15RwBUcg8FbdNu6RlZel9/kWcHOY+Vi/o8qQR9Lpa2KJ1yXT
         A59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741872280; x=1742477080;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PLsvEgnbim2yotRJtm3RxSyGerYXasNwsqr+/KVpS4=;
        b=OBQTU8Ki+DuVniGuVEuWiFQ/3AvQ75N4c/skECj0kbN0Nanedcmc/raB4LMBgD9sIS
         +dOBiteaDZDMPpfJHhsYAjj46BqPkzOR1aMndiDiGsAihcCZhHFVTLLv1BKZ/SZXLoGz
         WZrElsja6ZRk9RYGNCVeVYyVI2iuRVN3w+p3o7Sm/qQRQV2Dav3vk6QJw86A+z+9rOLO
         RxBlKmkMGkgXUjfrQuPZzhfikYp97tVUgkZPxA1qjWETrSdjsHToAqKM5DuiaYLXLS1Z
         rGAAEI7LjzWQq50Rva1PaIRh/+AaiCkdwG11TWSNSS/H8ePu4LhqyIzTaDhSdZbbQr/k
         RByw==
X-Forwarded-Encrypted: i=1; AJvYcCUFjV43wlvjrbudOFzFk0ec6wqBjAwS25qfqO9lNxi6WtQKItXOIc0M4ftq+ZE5EmTOxOQnMr/vEeY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/JWU2+YRyS3HYAP3YnTdYk1I4ankB3YBaIIIEke5K7a4ebNiJ
	K83e10GIE6rSwLbAwXAezpfwXkf05BS7R4haRJCOVpS7B0EbpDQyGTWAJE8qnhE=
X-Gm-Gg: ASbGnctwYvh9llUHUxq5U91c5C0TKZQcH7OlgkqIqMmLSPaYh2IFEm+qvOiyRy1Qbuu
	rkj5EzqgxC6yodAWkIbEhGz66WSqVuTaqOW7mdcpxzq4WwdEegcDnFJu4oVH5ieX1ShUGoDVmsU
	nxt9H0mTuafYiwRTNb68BBv2tCT5tEcq32dcmQmygQv88vOyzODe/XE5qdb2i762aPt7x4YQjEM
	RtR49FFWTPtaDcRMfBh2GJ4Z1b6qWvDjvBwnk8VJSGy2si1wNeYuHAjFjM+0FcYfni40+adghYc
	ViSV69lvrdNjRVvsvMA5p0J+LRZ1tiKb5MQ=
X-Google-Smtp-Source: AGHT+IEer637uehs/daevOydns9iUer0NF8/Lop3Ui7LDoPjH6cMpb131IF3qkXQqxQNFL57dNEHAg==
X-Received: by 2002:a05:6602:380d:b0:85b:5494:5519 with SMTP id ca18e2360f4ac-85b54946d71mr1891701439f.5.1741872279762;
        Thu, 13 Mar 2025 06:24:39 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85db879e512sm31580739f.28.2025.03.13.06.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 06:24:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
 Jack Wang <jinpu.wang@ionos.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
 Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Richard Weinberger <richard@nod.at>, 
 Zhihao Cheng <chengzhihao1@huawei.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Sven Peter <sven@svenpeter.dev>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>, 
 Chaitanya Kulkarni <kch@nvidia.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Anuj Gupta <anuj20.g@samsung.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, 
 linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
In-Reply-To: <20250313035322.243239-1-anuj20.g@samsung.com>
References: <CGME20250313040150epcas5p347f94dac34fd2946dea51049559ee1de@epcas5p3.samsung.com>
 <20250313035322.243239-1-anuj20.g@samsung.com>
Subject: Re: [PATCH] block: remove unused parameter
Message-Id: <174187227786.18244.14269218969550436496.b4-ty@kernel.dk>
Date: Thu, 13 Mar 2025 07:24:37 -0600
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Thu, 13 Mar 2025 09:23:18 +0530, Anuj Gupta wrote:
> request_queue param is not used by blk_rq_map_sg and __blk_rq_map_sg.
> remove it.
> 
> 

Applied, thanks!

[1/1] block: remove unused parameter
      commit: 61667cb6644f6fb01eb8baa928e381c016b5ed7b

Best regards,
-- 
Jens Axboe



