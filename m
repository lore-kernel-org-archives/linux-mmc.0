Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDB857C8A
	for <linux-mmc@vger.kernel.org>; Tue, 11 Jun 2024 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124659; cv=none; b=ZW7xy0Je8CAQEmNKfQDZtZhqVlEGWDCzfuVkgxnZpBZxvurewSWiS1B7q/Sz1XVFdZXW1WXTBZyE9YbU2hv1Q/XZzr/MAyw+Oka2rsEc77YGmiQ7cPgEsEOCQOlyrvOHoqqCF5D5j8PCmEeChvg/fP3fRB02npRa3OcrVwuZ6xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124659; c=relaxed/simple;
	bh=2FT/emrK48iE3dx07WXN0ST/iq8T21acuyaCQMRLCLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzvBwb8DUStzyemn6gx/DpFIK3LRE0cbUoD5ICjA3bt3OrgNzeObmRJ1Sr1C1UX3pPROebC/wM8iN7HAqHJnctxdLyMYrf0xPrvWUPAS06vygwcFE/7e5G0uyRLd2Xi5hItlINFIzpX3E5H/67g/CV/VpC41r/e/cZ6N3G0YE08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Zt6ibg/s; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Zt6ibg/s"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-627ea4e0becso64509867b3.0
        for <linux-mmc@vger.kernel.org>; Tue, 11 Jun 2024 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1718124657; x=1718729457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k7qH/Egkqtc5OmSCKcG8suDn1pwScsKWRQ+gioBgKgY=;
        b=Zt6ibg/sXDFPcB1PdqLbi9y9Lq84fI4dtsabAaKnS71DR4ge4yMuB1Z9lS7wA4wHrn
         shpAYklqhBt+02fv/lI70+9yLugOwkE6jd95eVKnaVgZYxsTh2WCsmHTgQ1UVgNRVLal
         wmO5N6RWxwgoiytstIBOrWyQFGmt3N38VbBAgwcFn/bnZiw+iwyuahz+8bpIWwoYMk5k
         XMp/oVXEeglCEkIcBUpukavQm3svwzpoI5LogCeDIIPsZ/TBEY3fH93kounsMrkvv0iU
         qwThWU60dMvFW8JzcIe4TZiEEXk0LdCstA848HdLhK4LdxhwQLIYyB46hHTq4v902MUD
         ZUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718124657; x=1718729457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7qH/Egkqtc5OmSCKcG8suDn1pwScsKWRQ+gioBgKgY=;
        b=DEmfn0xwGr2pZwapv2ch6a1YRUhLgRPmoIIS1cKTSXxJIyQh4uqJdt6seWWhP6b9q1
         6vZ5Ee04ZoLe/iS0q0svtKq1GDgzjpIISTIsVu9RIaS786eDw9QLAGWjnGT0rW0ST7ms
         mT1F4KDx48YjeTN+8hijk4Xto5OKRJekBMi4zorq4VxqJfdQ92iC3LxF79BvouCGs49m
         iX13917a73fyy+7s7UgexbwJzbOpadYEpvLxoQfIxHqeQycf89yaMATdNp/RWOCd19wt
         4ly+dVmgYv2gXUfiOaDzp7etJrpRPdNm1Ux83U6gSoHGHEr8xzQSlY02buJ8zaTgFhop
         +fzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYMBv/rfg5OKuYCgIGt8yQq9Yke/5h2NMA2DguSYwZ2lQQzJZCmDO76V9DDEUxsJxgaKigxSC60TrNV1Z9MRWA9f65ceCvHcu5
X-Gm-Message-State: AOJu0YxQ5yRfl3sN2YuIJOH9Qm1s2rLvLhFCpVQiSOCoD8lZokIFtziA
	ADqvZe5WgoWt2I253j2jDk/d8QaioNC0vhLhz+8x7nbTMe+agtUdiZb6JFfi7Do=
X-Google-Smtp-Source: AGHT+IFLbNcRGoXteJvsvQz9ePKtTqtffGprFSIVvQoC+S7q0aJ0DFFhhqHjAFy+KyUVXYjD8ktBew==
X-Received: by 2002:a0d:d851:0:b0:618:95a3:70b9 with SMTP id 00721157ae682-62cd565129cmr130634777b3.36.1718124656832;
        Tue, 11 Jun 2024 09:50:56 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62ccaef2825sm20935207b3.139.2024.06.11.09.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 09:50:56 -0700 (PDT)
Date: Tue, 11 Jun 2024 12:50:55 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Weinberger <richard@nod.at>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Ming Lei <ming.lei@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org,
	drbd-dev@lists.linbit.com, nbd@other.debian.org,
	linuxppc-dev@lists.ozlabs.org, ceph-devel@vger.kernel.org,
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 09/26] nbd: move setting the cache control flags to
 __nbd_set_size
Message-ID: <20240611165055.GD247672@perftesting>
References: <20240611051929.513387-1-hch@lst.de>
 <20240611051929.513387-10-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611051929.513387-10-hch@lst.de>

On Tue, Jun 11, 2024 at 07:19:09AM +0200, Christoph Hellwig wrote:
> Move setting the cache control flags in nbd in preparation for moving
> these flags into the queue_limits structure.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
