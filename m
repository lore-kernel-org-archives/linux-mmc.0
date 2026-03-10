Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625243A545E
	for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2026 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158222; cv=pass; b=bfbpsN8Zr0NdLqGrTqLpahDGN3KY1JgsmWGn9upPykYg5K/nj7fdhUbJiVJwUub4Q8v3mvvzhPQI+hTHAXVF4lyrRrwya4ey6a9IfE3ACCw971aHlxW332v4O7vzsp//6/J/uKUZuzLf3Jj9f+LGf6ob+sg/h95a9vwIO4tYcGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158222; c=relaxed/simple;
	bh=aZ3QAAiJWKfJPFdOqgfaghwjaxM2wYZxCugoj3b5jMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPkAb/94uLgk4gbGKSDaRZ+Rd+OMDdLEg4DaNPuurwEj1ZPeBJdMNvVb89TrYqHBKVxstHW8HFi/lABZvMpDWtsE8r583CUD2/8lkIAI1uawYSdZxmvkNUM3BKCc+RnvPR5695got8dJ9/1tXiMqful+cEUUaU89Y5bioScHhHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GDcXq3rA; arc=pass smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GDcXq3rA"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-40947c81b31so670371fac.1
        for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2026 08:57:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773158220; cv=none;
        d=google.com; s=arc-20240605;
        b=J1LR0xjIMMOh2JD4/ZHU5hsKAq/IuWdiIqP4LSvP+Lmjow3zWfwSSamhQQrwZy1Bvs
         EaofFdPrD0PuQjoOPEXe87OXE1AKOyrm6FPFXR4yFixevQ8uB3cq+txO+grhWJzzrfsm
         wgtAW34oX9E0jxSsEvPw/nFLgQ9XLTUUGjPYqc8qIFyleIB7xodfWVWsittUSJNMGI45
         xfmxHjHQq0WAzLPoST5KVepjJBOJLPFW8Yk+i9X3jpnivLa/wxWmeBm0VEokYsi3+7tP
         U8vEBKHAigXa4LM4sWpwRmrn/lI8mOuXjvFLmVyOhG2DkfcgpHSyEgIStGYQjUJbRdN8
         PiIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k0ZfmdoKETAu32CUc6DaYZn/AQfT5ZtxxhfQJEgADr8=;
        fh=BJj8V2o7kwiKgF+xCfm+WLh3nE5vnX6Q+88Sf4myEr4=;
        b=RWAVf9EujxZvvBqRYRO97SYpVvFo9gitOgdGhMn0kQkBh4mbwCE6h9ROYEnQicYw4T
         gmfqimAaO1CnEABXWk0qijI/YgyuUg6coHd3h0dIhH+EspDw5ZiGb1xBTYm2V8jS9Ics
         A6cRTPZtVfMcqREg4YJhbiYdJlz3ke/AmdadnkCuX0aIuuRE+0Eahtbs/bD2LqHqKgYO
         PYWr1Lu4VkPQ0XXzxHEC4rZXzQWrQh57ZDUAchcVb5kAu9hU9EfCd88kWiaI/G0osVOn
         u72i2giKw/AnYiRPNGoe8vBkzy5QV693aN2r4T1U/vIjKetVNqSnsKLdIkFedOKAeLWI
         /7Rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1773158220; x=1773763020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0ZfmdoKETAu32CUc6DaYZn/AQfT5ZtxxhfQJEgADr8=;
        b=GDcXq3rAFXxU75wmb/baSS7kiq0Izs5ejpXTDlbCCEsFiSK6DqqnEAU29+gk6XyvJN
         JBs7A9dqq5gzucsJqNvHNVQbGnfIIF+KocmycQSy0I5MZCKILwnemDU00m0Ar6BCqyuq
         tGmYt1NEgfI8jCXLIl/ba/3AtU9Xo4zxEg3L0gdRZcGbw3FvaoNK6pspAHnxopkco+bY
         qoCfG56sB2p8qkc2AWoSip5aFK7nSj6mNaktw3/6pC3HO36XgFyO0/3nMx5Phg76syp8
         HzXabqqwOoZ2HxVDyUFdPPzvKY4jImNKwXTh72ab6DjQbq/5uMW5P/gFN6OkVjWRNwQp
         Lvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773158220; x=1773763020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k0ZfmdoKETAu32CUc6DaYZn/AQfT5ZtxxhfQJEgADr8=;
        b=uwafU02f7VpHflwTzFJTIXcvI9roj8H0xvypMSqky4u/azQQIdJ9CN/Z+8ycTjdefJ
         c5ov20z19nUuPJ7Qru2wm2WPR2oEwNVcyyvr2nihKnvLGg3lZN5/fTd+GvWNdmDioBpS
         ZBtmONs719bA3XFO6/PcmRp3ayIwk7zlbIlCv1ttU663w54nJP99SGD1h/nRa2BJOZ5G
         hu+nru0hoQfuE7qwLesmcLmKNjdG9dV9JAfiZRMs6rk6dlwgL8pdSXTgoPsq3iWY3lun
         cXEES/7MyYcmrspLyEUddRnSx6ytismRhc0PjpR2PgbyG7Q/L4LUGiiIHU7dnRyrGrxW
         IegQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFXhAkE4xtkCo0LQK2/s2dELePe3sgFxG9kuKJL1Qw4v7ZQBEmwJysnkh1nQZ7fvm3k76/kwttWzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdW/+pvZuYEd3sp9HoAA/1sHp5vXuReHIHIkRYKCKx23DlqPGZ
	GgcJeLGJfJR2hf4aKphB//ksxUJH1tAsrqOA9ZhJMA3WBJbeavCIWb4YQXVcvmCm4RY5rnxrK2r
	xypj+AEI9e3Ppu+xI6tExl4sgK5xjVH16+oOcij2JSw==
X-Gm-Gg: ATEYQzyPr/s/7+5xcDKKEkH92nPrfjpOt9kfSQbh+YwVr51A7+VSnmYOYyLycEOdIV7
	O1FXRQNxbo07m2XwMP/jmNRIwX0+Ep40DbpzVCWNag4j++MXC9grV3RzkaIbCJL6KrlSp3SBEVo
	FBTtg6dFpfrs8t79CVYoEOREgTGCbEVDaYl3LPrsG4Bge7ZgBhwynzp5C0xb0O0OgBFG5JwyEiL
	nVDvifppbyxPPUOR96dr1BF5UkwPEgevVaQhn19ZOfP4GgCQR2Q1FQ52Z/vuHwQnEKZqT5QYtWT
	Gw2IODuY
X-Received: by 2002:a05:6870:854b:b0:416:3f50:ea2 with SMTP id
 586e51a60fabf-416e45c1dc6mr7199342fac.8.1773158220092; Tue, 10 Mar 2026
 08:57:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309062840.2937858-2-iam@sung-woo.kim> <CADUfDZorSQCVtQyfjBuaziwG2Jo28yZiiqLKbp9PkFFw-9VgfQ@mail.gmail.com>
 <CAJNyHp+i3M_ko7rhgTz=nxP=MZYM3oQf3L-y=7YnhnRyeUxayA@mail.gmail.com>
In-Reply-To: <CAJNyHp+i3M_ko7rhgTz=nxP=MZYM3oQf3L-y=7YnhnRyeUxayA@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 10 Mar 2026 08:56:48 -0700
X-Gm-Features: AaiRm52sHfM1lLReXhJ6K_-eQeuNMsoWbyv4AHit6rY5_ursGYcV9eDpU-ihUic
Message-ID: <CADUfDZppWyOOPME0eJbmO1q+qvehxGiCk8Zz_nVxaQk08aukFw@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: nvme: Fix general protection fault in nvme_setup_descriptor_pools()
To: Sungwoo Kim <iam@sung-woo.kim>
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

On Mon, Mar 9, 2026 at 4:55=E2=80=AFPM Sungwoo Kim <iam@sung-woo.kim> wrote=
:
>
> On Mon, Mar 9, 2026 at 11:31=E2=80=AFAM Caleb Sander Mateos
> <csander@purestorage.com> wrote:
> >
> > On Sun, Mar 8, 2026 at 11:30=E2=80=AFPM Sungwoo Kim <iam@sung-woo.kim> =
wrote:
> > >
> > > The numa_node can be < 0 since NUMA_NO_NODE =3D -1. However,
> > > struct blk_mq_hw_ctx{} defines numa_node as unsigned int. As a result=
,
> > > numa_node is set to UINT_MAX for NUMA_NO_NODE in blk_mq_alloc_hctx().
> >
> > The node argument to blk_mq_alloc_hctx() comes from
> > blk_mq_alloc_and_init_hctx(), which is called by
> > blk_mq_alloc_and_init_hctx() with int node =3D blk_mq_get_hctx_node(set=
,
> > i). node =3D NUMA_NO_NODE would suggest that blk_mq_hw_queue_to_node()
> > doesn't find any CPU affinitized to the queue. Is that even possible?
>
> Thanks for your review, Celeb.

While I'm flattered you consider me a celebrity, my name is Caleb :)

>
> blk_mq_hw_queue_to_node() can return NUMA_NO_NODE if the device queues
> exceed the
> number of CPUs. Afterward, it is adjusted on the caller side to
> numa_node =3D set->numa_node.

I thought the NVMe driver capped the number of queues so every queue
is affinitized to some CPU (see nvme_max_io_queues()). What am I
missing?

Best,
Caleb

>
> set->numa_node can still be NUMA_NO_NODE if CONFIG_NUMA=3Dn (trivial) or
> pcibus_to_node() returns NUMA_NO_NODE if ACPI doesn't provide
> proximity information.
> But I'm not sure if this is usual in the real machines. We found the
> crash in QEMU.
>
> > >  static struct nvme_descriptor_pools *
> > > -nvme_setup_descriptor_pools(struct nvme_dev *dev, unsigned numa_node=
)
> > > +nvme_setup_descriptor_pools(struct nvme_dev *dev, int numa_node)
> > >  {
> > > -       struct nvme_descriptor_pools *pools =3D &dev->descriptor_pool=
s[numa_node];
> > > +       struct nvme_descriptor_pools *pools;
> > >         size_t small_align =3D NVME_SMALL_POOL_SIZE;
> > >
> > > +       if (numa_node =3D=3D NUMA_NO_NODE)
> > > +               pools =3D &dev->descriptor_pools[numa_node_id()];
> > > +       else
> > > +               pools =3D &dev->descriptor_pools[numa_node];
> >
> > Simpler: if (numa_node =3D=3D NUMA_NO_NODE) numa_node =3D numa_node_id(=
);
> >
>
> Thanks, I will modify it in V2.
>
> Sungwoo.
