Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7317623EAB2
	for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 01:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773192132; cv=none; b=KuZ6blaE6pqruCVuJHy0RjfZM8KDejVhp/TFvDtc3GJ222imh2E4k7r2Pwm6Huz/acpJoELGoZ23RUr7A4MQATTA6TXfLsLVCGT1s44P09eH79JJ4rswGESjEtQPIwcDRW4jGpunwExednvQQsQXw4RTnMP/7ad1I4XDreAqN9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773192132; c=relaxed/simple;
	bh=/oF/doq6oyWwDTCyW1l4hS1E5POtzgyvQYrb/7hmVZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j4FlpYaarce3BIAYfLHMKMARJr9ubkHCcf4uSRyYi3HN/NLFhzBY1WWR+YArIso9Ida2zq4jzQQ1dYcKhWNUFU/R5cyqGxL6JWhiOObolEgau8N9+vvr5CaVt5UK04qhi0Y2mVSWKywkZ6Uruj/wUIsC4LFQdSwiQqVsErkmCXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-660d77cacc2so1108824a12.1
        for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2026 18:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773192130; x=1773796930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/oF/doq6oyWwDTCyW1l4hS1E5POtzgyvQYrb/7hmVZg=;
        b=ddIXAhBQR0wownjnY4vAZ1TcLvAfj5h71VIY01en5YxZOEYpt+lZgGqf3XIRwuF9+r
         ek2klS5ugv2q92zgQNqa0b6+QOL4yPjYCw8D4YjM0Y64KYPhN4E0RzWSjFI9AknSnwx6
         Xwg4sTlvJE7IZsjyFkZ7kHzpElLsEzOY7nf+UjonhcUmWaiV4+rgxomau1uPwmxWihDf
         ELIWhvmYN5cuFTZj+Bq3coFLvPI7wboiq5GaFt6trs0fSu+2q+g31dkh7Q+VwkhRCY2R
         rs2By8I6YtcrleDUITdzxFED3EXgtwTNTf4oWTima5v4jBNxDrJxbNtqxzvtqGVc/zYM
         sAkg==
X-Forwarded-Encrypted: i=1; AJvYcCW3ayxQFixwZt/ZEC07cDgznlF02dF8a4Dirv6BLq6l68FfbGoRMBs7gnI8z70oJpTN/X2w0Yabbxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPu8fk4idfeQ/VvXwUnKy7coxa5S0LbuNd6jhov1naI6zfT67L
	PDESwXSLg5Kvb69flcbV0eOBP+ftKvbq1B81mpp7NeyjuaO/Er3WT/ci1gCI3fpkJRWEWQ==
X-Gm-Gg: ATEYQzy65QJXVkXtJfTHIdmomKa9fhJ9QRjjYOkykB2Kn6wSXCCqNfmFWFwDsCkR/Ch
	gVS06wI2l+CcG7d1tlGNG7IoVAWl2d9FGP8l7seIDDGET7jWe2P3jzxaXf9cGfZaITwGNu0Kj5L
	pOOsjewnIeaA/kux4Ts30drP0sTy9/bUA5aTnIYzlbtEOPuuVOlSMGf7sr1TnTo4SyzlMtIU7Vb
	L2fb1eM4GOeeWP+AqsYLZV2407ITrDNclMAZPZXITHs4zh1e8jFw2wiCYrOeXxyVu1UKTwKCbiJ
	GxGH17H4VmZBJaBQDaSt5p/cD19nK13W8auoHhWPBvQrJ7Px5zQ2hCcnc+FB0CbVbjdhtOm93X0
	VyrchvGDvIN8q04DHbePE2W/UZgmnSQBaNp/8XVMshzvB+C53adCd7K8CcYgAdoXLKQqP8iHh8p
	wpTAkWy9j8WXPjcEg3nIOhaYmc8BYdul7d+iI+1qlv8HMKCFwrLQEOCKc=
X-Received: by 2002:a05:6402:35c7:b0:662:e5a6:f090 with SMTP id 4fb4d7f45d1cf-66317fb3cdfmr361027a12.15.1773192129491;
        Tue, 10 Mar 2026 18:22:09 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6631503ca9bsm198168a12.18.2026.03.10.18.22.08
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 18:22:09 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b9423d62cbbso64126966b.1
        for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2026 18:22:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqCUaSpovdgjgCsa760kEZOjkZ9lVmzAlZftccD9J71yokgFbwJcu5tW5zZx9V+wPYk+iP6NrAuhI=@vger.kernel.org
X-Received: by 2002:a5d:5d05:0:b0:439:bb46:7457 with SMTP id
 ffacd0b85a97d-439eff518c7mr10359487f8f.16.1773191708627; Tue, 10 Mar 2026
 18:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309062840.2937858-2-iam@sung-woo.kim> <CADUfDZorSQCVtQyfjBuaziwG2Jo28yZiiqLKbp9PkFFw-9VgfQ@mail.gmail.com>
 <CAJNyHp+i3M_ko7rhgTz=nxP=MZYM3oQf3L-y=7YnhnRyeUxayA@mail.gmail.com> <CADUfDZppWyOOPME0eJbmO1q+qvehxGiCk8Zz_nVxaQk08aukFw@mail.gmail.com>
In-Reply-To: <CADUfDZppWyOOPME0eJbmO1q+qvehxGiCk8Zz_nVxaQk08aukFw@mail.gmail.com>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Tue, 10 Mar 2026 21:14:52 -0400
X-Gmail-Original-Message-ID: <CAJNyHpLU7sTJRtDqTbczTz0iayj-Nm8bPHrPaOcsKVb6nQyw1A@mail.gmail.com>
X-Gm-Features: AaiRm51cz7xo1V1erpi09gKFdY9TTILawmEFCzQE55oadwxdss7qBUImRUPZq3I
Message-ID: <CAJNyHpLU7sTJRtDqTbczTz0iayj-Nm8bPHrPaOcsKVb6nQyw1A@mail.gmail.com>
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

On Tue, Mar 10, 2026 at 11:57=E2=80=AFAM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Mon, Mar 9, 2026 at 4:55=E2=80=AFPM Sungwoo Kim <iam@sung-woo.kim> wro=
te:
> >
> > On Mon, Mar 9, 2026 at 11:31=E2=80=AFAM Caleb Sander Mateos
> > <csander@purestorage.com> wrote:
> > >
> > > On Sun, Mar 8, 2026 at 11:30=E2=80=AFPM Sungwoo Kim <iam@sung-woo.kim=
> wrote:
> > > >
> > > > The numa_node can be < 0 since NUMA_NO_NODE =3D -1. However,
> > > > struct blk_mq_hw_ctx{} defines numa_node as unsigned int. As a resu=
lt,
> > > > numa_node is set to UINT_MAX for NUMA_NO_NODE in blk_mq_alloc_hctx(=
).
> > >
> > > The node argument to blk_mq_alloc_hctx() comes from
> > > blk_mq_alloc_and_init_hctx(), which is called by
> > > blk_mq_alloc_and_init_hctx() with int node =3D blk_mq_get_hctx_node(s=
et,
> > > i). node =3D NUMA_NO_NODE would suggest that blk_mq_hw_queue_to_node(=
)
> > > doesn't find any CPU affinitized to the queue. Is that even possible?
> >
> > Thanks for your review, Celeb.
>
> While I'm flattered you consider me a celebrity, my name is Caleb :)

My apologies, Caleb. I'll be more careful.

>
> >
> > blk_mq_hw_queue_to_node() can return NUMA_NO_NODE if the device queues
> > exceed the
> > number of CPUs. Afterward, it is adjusted on the caller side to
> > numa_node =3D set->numa_node.
>
> I thought the NVMe driver capped the number of queues so every queue
> is affinitized to some CPU (see nvme_max_io_queues()). What am I
> missing?
>
> Best,
> Caleb

You are right, every hw queue should be affinitized. It seems I'm
missing a lot. I'll look into the reasons and get back with V2.

I appreciate your review again.

Sungwoo.
