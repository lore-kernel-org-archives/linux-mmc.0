Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD7E3793D7
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 23:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773100739; cv=none; b=r7UKf+zps3DRWsIyoHMpPMv6eML34GSrXrBej22YuZE8qzYnyHe/2ksPycdX62iAe895hzRfoXa0OJiNKUGdjL/0HV0HTT7C75RKFAw19KlFLfuQ0i5qpKgIh+k85ONMdWENJFWiKQBghAl5DYTFg5Zr5mUxxBWVyN+PTMk1SUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773100739; c=relaxed/simple;
	bh=40Mlp2c6INEworHVA8B/tjgxxnGjEAtQ2cBtMbRWvDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L1DwTv16QzJt9mvM+qKFBQViX9ftXNxlVK/vD2TDECy7Dg20pmcKlWmqM2xPj0jltze8jS/coc0umrWYTULpN40xUY4JbszZp03V+nRxmBM2sDYTvrjqgeDAdDZ1SUFjriB40Rt4BY0P1ju9KtiK0nUacZOTnLlZAin7AzKedUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b966a7b1908so325584266b.1
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 16:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773100736; x=1773705536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oe74yVewJW4EdL4NdMuEiANgmdgDMqRgsPaxoV9IVrk=;
        b=EI+a/yEFaCvm9booOQDwN0FGITp9lD6YqAOHkT7pjkFLR8Ou2Kg9UKbsn2iShNl/kA
         UgjD82CoG9IDfAsbtFSTbi4u9P+lKicQKSfO3bY+nL+ZQXa26qGsWH/DNamoLqcKIAab
         ajdYQ5tmobUnKBX85gNLulITWfpUWLDk1kGUKO7669Iy6oAXmtvCoPpygW38eNmVzseD
         4D4yKTrBxVb5KtRksECWfG0qcSVxqZkxfjAnwAa11dIztYynd9DRmrH+WMWfg+DPgHQC
         HDC4FhW97xQJVlJXKwfe1wBC9ewsYi3PiOzRYMQQZ8qRI5BRzvSSfi8QyzYNl7grMpkX
         mWDA==
X-Forwarded-Encrypted: i=1; AJvYcCXg0Kb8GartTByehUCPtg9Vy5C8e4LmpSTQa54f3/80V+PHADPJPpXZdSAuI8hIwRWChG3Pl5aOtxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ7RlK4joOF0uP/s29pTTOwgUNaDi2uyOYlqx3AzFwZIrO4l3u
	oXApS3SDfUKMR19j0LyiztTDFdbvvBJwJTF5gE/AIyzQXrN5JMXWolujjkB3qI6TN9M=
X-Gm-Gg: ATEYQzxVRp/jTYEGh0bimJCXbBplnhHVQmI0AkmuRJwRuZdmxm2PNS5/1KKXTlGyQlI
	4KR0ufitM++Gr/JImJ2IyolGinJtwxR9nRne+7SA7XlDaicjvWF1QApQGOxLsFBgToczqpXNRbB
	QeyvA0TovAnlbM/iLAvh5KCQTBOS5B2BSuC+LQkGY7KLIDUC0B6w2ErZ90SonD0rTaHOVN3a42Q
	jPqNY4slBUCWTCmkT28zfj2yiqyf+KP0nKtyFP2VuqSg7zij3V6sxYV8OKwaNUb8gJxtd+5urxF
	uGJnId+457xwpocmTkDQipcCwC0eb6W8ebD9uuqwcjHbs/cBwlm42Q087UYsSVKR0D2IJ4NZke3
	nKWBKMjrTJVqXK5I+vplV9tA7p3QI2E/Sb/j3vsmg+APUToCE1c6EWn3stTtotlfzAS4D96YkhE
	vyrWLTSdgsA+oqyDf+30zHxR02iySL0tEBIC3zA2uIr2wCg9z9SERw6vA=
X-Received: by 2002:a17:907:3e11:b0:b96:ecc3:7823 with SMTP id a640c23a62f3a-b96ecc3a3bdmr384291966b.14.1773100736091;
        Mon, 09 Mar 2026 16:58:56 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942f15c40esm449267166b.46.2026.03.09.16.58.50
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 16:58:52 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439c5b40f60so5124896f8f.0
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 16:58:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWw7Hgy9VfbXmWzsXpEMPL8UhJZQ1DRmtUBdAIgL3LLqm93iW8Ae/nSzhhjzZbmoep0L/60ZU3HFsU=@vger.kernel.org
X-Received: by 2002:adf:f4cb:0:b0:439:df33:827f with SMTP id
 ffacd0b85a97d-439df33828emr14050045f8f.10.1773100730271; Mon, 09 Mar 2026
 16:58:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309062840.2937858-2-iam@sung-woo.kim> <202603090911.0DdOwjTR-lkp@intel.com>
 <CADUfDZqBZWwy+6XOde_aZTwLisRP8j5qRqB6X_EJJPr+wmdGZQ@mail.gmail.com>
In-Reply-To: <CADUfDZqBZWwy+6XOde_aZTwLisRP8j5qRqB6X_EJJPr+wmdGZQ@mail.gmail.com>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Mon, 9 Mar 2026 19:58:34 -0400
X-Gmail-Original-Message-ID: <CAJNyHp+a8FqB7Y8DobMxKOn9KAQXH0KvHTRgTjFuMppneSznvw@mail.gmail.com>
X-Gm-Features: AaiRm50FODLuR7mIvmUavdQJgpvkliqN2c7Myo_nPa5e2Uo34ON5h-NAjYa6-ys
Message-ID: <CAJNyHp+a8FqB7Y8DobMxKOn9KAQXH0KvHTRgTjFuMppneSznvw@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: nvme: Fix general protection fault in nvme_setup_descriptor_pools()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: kernel test robot <lkp@intel.com>, Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, 
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, 
	Ulf Hansson <ulf.hansson@linaro.org>, Richard Weinberger <richard@nod.at>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, oe-kbuild-all@lists.linux.dev, 
	Chao Shi <cshi008@fiu.edu>, Weidong Zhu <weizhu@fiu.edu>, Dave Tian <daveti@purdue.edu>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nbd@other.debian.org, linux-mmc@vger.kernel.org, 
	linux-mtd@lists.infradead.org, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 11:31=E2=80=AFAM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Mon, Mar 9, 2026 at 1:42=E2=80=AFAM kernel test robot <lkp@intel.com> =
wrote:
> >
> > Hi Sungwoo,
> >
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on axboe/for-next]
> > [also build test ERROR on device-mapper-dm/for-next linus/master v6.16-=
rc1 next-20260306]
> > [cannot apply to linux-nvme/for-next]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Sungwoo-Kim/blk-=
mq-nvme-Fix-general-protection-fault-in-nvme_setup_descriptor_pools/2026030=
9-143107
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git=
 for-next
> > patch link:    https://lore.kernel.org/r/20260309062840.2937858-2-iam%4=
0sung-woo.kim
> > patch subject: [PATCH] blk-mq: nvme: Fix general protection fault in nv=
me_setup_descriptor_pools()
> > config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/2=
0260309/202603090911.0DdOwjTR-lkp@intel.com/config)
> > compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87=
f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> > rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20260309/202603090911.0DdOwjTR-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202603090911.0DdOwjTR-l=
kp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> > >> error[E0308]: mismatched types
> >    --> rust/kernel/block/mq/operations.rs:274:28
> >    |
> >    274 |         init_request: Some(Self::init_request_callback),
> >    |                       ---- ^^^^^^^^^^^^^^^^^^^^^^^^^^^ expected fn=
 pointer, found fn item
> >    |                       |
> >    |                       arguments to this enum variant are incorrect
> >    |
> >    =3D note: expected fn pointer `unsafe extern "C" fn(_, _, _, i32) ->=
 _`
> >    found fn item `unsafe extern "C" fn(_, _, _, u32) -> _ {block::mq::o=
perations::OperationsVTable::<T>::init_request_callback}`
> >    help: the type constructed contains `unsafe extern "C" fn(*mut bindi=
ngs::blk_mq_tag_set, *mut bindings::request, u32, u32) -> i32 {block::mq::o=
perations::OperationsVTable::<T>::init_request_callback}` due to the type o=
f the argument passed
>
> Looks like the type of _numa_node in the signature of
> init_request_callback() needs to be updated accordingly from c_uint to
> c_int.
>
> Best,
> Caleb

I will change it in V2, thanks.
Also, I may need to split the patches by driver as the cc list explodes.

Sungwoo
