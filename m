Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C000B375AC3
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 23:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773100507; cv=none; b=XQ30fX6sOcWqoptwRiagOtEY6YgDAG+j4SY3MnrYZx/fktIXKHhMvHRcRkOY1AVUMb+JLPF3R/m2kS/8m2ZyjW9Yhdtbyl2Zn1/949Hu4jH7l3k+9tCfWV5HEqoxdcz5ZJ41f2FMOK7PNP452wmAi7fPj+nJ9zCx1rw3VKwnN/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773100507; c=relaxed/simple;
	bh=6Vofe/6ZWdzfe1bQhwcok7tc5hua1lVSK0g1U2J3b8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=My9Qo3NkBxiN9m6kkA4EI13zbzwjfDFc6FTQbt/KYpOQrU69c9AZT9NXmabARGziDU+swww6XImNqwVhIrXxAIb0axlvdU/95UQb2Qujfu1JchObPhnFBAX7RjxYf0ByShsXyir8lo9IVEWGBx3V5C53NlYJl9HaeVj62i6uxns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9358dd7f79so968358166b.1
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 16:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773100504; x=1773705304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wUJ62UzriDRExITrg9iBzNvEWYzDINBTrPfASD/nLws=;
        b=KjfXqZM+HXqZK+IZZ1fD76/5daf3xrs0d70AE9vUvNauYECCa/Klfcuzl+DS3ELHXt
         GZIu+CeFWiMkrULLI0orhDg8vBB1mJvRo+ARvhn7qa5nT2ri57KAII9hEYTLL6VwlvG6
         MrEhu+RyliNlJaLpFKA96cveKWp8S+DMLvgcSDWSSBfvbBmXEHaTxPuXl8Lot+cLqkm+
         lM8DcnwheM8uwSIOGRzWO/KTZXwXDv9faksBbjCjGpg+YBSq+nvrFl5FPPHgSoDhuRxJ
         UELze+Aq2TeUt179Su3oFLCvbAhAfjcJFwjYtIJ3dthgxGZsU9MEtpsUZlGwF0qvbdaA
         1OIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGDnr9J2/RWDhbdbBR3cyAoi5b7npjsre1G1sTbMBVfkUhKlpV7FA3gEo3GZyPkegclfHg/xY4Nrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdhG23v3gjWhfbVA4AdLRAWS6L4+f5chdF6mr2DvblWHg7ZShh
	0WinilMsViWM8xj3MptaaQiZxP5yIc4l7wcZrCmbc0Fi3lh6ePL0FKOaEFBEWi4SVV4=
X-Gm-Gg: ATEYQzxlvHB5Yeg6C8ixFeuYq3xxzdRf6BcGOcSDygTQUPr9YTZ/Wcj7U25U7NMJwqD
	11+iPbB1whMej8tAxWKtby1F/zUbRs4dbgFeKUP8jhBn+B0qjf6R65E+rcVgMkiSKzd9SV9PYx+
	mpra+qpnDgEmRVJTtB21MCjD5UTDx5IAytlCM/kL6IgHz2UF2/JwAOcaa4jkGyoC3PSgPKuQGoj
	6qR7hQOmQMhGkzgHBIEEVAESlQ4iddSLCF4VjLNHIVcw4iiAi3XCtTikXPFnq19YMRvhtew2soz
	16RTlVAlrpSevi6246ogjd4jIJUUyGo3a9R/3XFw0MpfLz2QX5uXW0OrzKSNSuTQrrdswQ1MgWm
	E7QipnUVMRFr8Mn+T50c4jt/RLLs+6DomX57fJwX3F1YNnmUPJ2AO9ihO97iggKiTrwA2op6tYB
	dXkQBE3thuEgbeDWMdUpGbsiatEE3FetSb17zZjBvZhhAzNyka0+GcPeM=
X-Received: by 2002:a17:906:fe4c:b0:b87:17df:4d65 with SMTP id a640c23a62f3a-b942dfbd5f9mr768419266b.51.1773100504029;
        Mon, 09 Mar 2026 16:55:04 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9439cffe9esm378495966b.43.2026.03.09.16.55.03
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 16:55:03 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439ce3605ecso3532030f8f.0
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 16:55:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWbFGuVDGOwx6MFnptZwhWqNbwivNj6+9AAD5CvY3wlxX8PGS26CYeUs4znwFFsKDJk2gwNyz6OUj0=@vger.kernel.org
X-Received: by 2002:a05:6000:144b:b0:439:ac33:5082 with SMTP id
 ffacd0b85a97d-439da66b72cmr23928350f8f.26.1773100503051; Mon, 09 Mar 2026
 16:55:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309062840.2937858-2-iam@sung-woo.kim> <CADUfDZorSQCVtQyfjBuaziwG2Jo28yZiiqLKbp9PkFFw-9VgfQ@mail.gmail.com>
In-Reply-To: <CADUfDZorSQCVtQyfjBuaziwG2Jo28yZiiqLKbp9PkFFw-9VgfQ@mail.gmail.com>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Mon, 9 Mar 2026 19:54:47 -0400
X-Gmail-Original-Message-ID: <CAJNyHp+i3M_ko7rhgTz=nxP=MZYM3oQf3L-y=7YnhnRyeUxayA@mail.gmail.com>
X-Gm-Features: AaiRm53vE5uEinTHUYE1aa6bIvdkwyOpz0dn9fOlsjLR4PN8Z_3w05vllGJ47mw
Message-ID: <CAJNyHp+i3M_ko7rhgTz=nxP=MZYM3oQf3L-y=7YnhnRyeUxayA@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: nvme: Fix general protection fault in nvme_setup_descriptor_pools()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, 
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, 
	Ulf Hansson <ulf.hansson@linaro.org>, Richard Weinberger <richard@nod.at>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Chao Shi <cshi008@fiu.edu>, 
	Weidong Zhu <weizhu@fiu.edu>, Dave Tian <daveti@purdue.edu>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@other.debian.org, linux-mmc@vger.kernel.org, 
	linux-mtd@lists.infradead.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 11:31=E2=80=AFAM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Sun, Mar 8, 2026 at 11:30=E2=80=AFPM Sungwoo Kim <iam@sung-woo.kim> wr=
ote:
> >
> > The numa_node can be < 0 since NUMA_NO_NODE =3D -1. However,
> > struct blk_mq_hw_ctx{} defines numa_node as unsigned int. As a result,
> > numa_node is set to UINT_MAX for NUMA_NO_NODE in blk_mq_alloc_hctx().
>
> The node argument to blk_mq_alloc_hctx() comes from
> blk_mq_alloc_and_init_hctx(), which is called by
> blk_mq_alloc_and_init_hctx() with int node =3D blk_mq_get_hctx_node(set,
> i). node =3D NUMA_NO_NODE would suggest that blk_mq_hw_queue_to_node()
> doesn't find any CPU affinitized to the queue. Is that even possible?

Thanks for your review, Celeb.

blk_mq_hw_queue_to_node() can return NUMA_NO_NODE if the device queues
exceed the
number of CPUs. Afterward, it is adjusted on the caller side to
numa_node =3D set->numa_node.

set->numa_node can still be NUMA_NO_NODE if CONFIG_NUMA=3Dn (trivial) or
pcibus_to_node() returns NUMA_NO_NODE if ACPI doesn't provide
proximity information.
But I'm not sure if this is usual in the real machines. We found the
crash in QEMU.

> >  static struct nvme_descriptor_pools *
> > -nvme_setup_descriptor_pools(struct nvme_dev *dev, unsigned numa_node)
> > +nvme_setup_descriptor_pools(struct nvme_dev *dev, int numa_node)
> >  {
> > -       struct nvme_descriptor_pools *pools =3D &dev->descriptor_pools[=
numa_node];
> > +       struct nvme_descriptor_pools *pools;
> >         size_t small_align =3D NVME_SMALL_POOL_SIZE;
> >
> > +       if (numa_node =3D=3D NUMA_NO_NODE)
> > +               pools =3D &dev->descriptor_pools[numa_node_id()];
> > +       else
> > +               pools =3D &dev->descriptor_pools[numa_node];
>
> Simpler: if (numa_node =3D=3D NUMA_NO_NODE) numa_node =3D numa_node_id();
>

Thanks, I will modify it in V2.

Sungwoo.
