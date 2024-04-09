Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0398614B
	for <linux-mmc@vger.kernel.org>; Tue,  9 Apr 2024 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664015; cv=none; b=dK7Df0GHgLkZJPaUwlFspigPcfrggUNI877cWKuquvbkOkeWirKvktKAVy+/QKOKfCuBHgpvJtV54N7P8S9sNvS+wbruU+v6VOuxJbtvv3tfi0CaT/6U5eD9R3zXYCzIdQYwxmoDkY7huC7z9J+lJ67TNmVgfqB3MP1mjAYpCYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664015; c=relaxed/simple;
	bh=kSsCJ+neyaD9aFL/tH+VGrh65tQwOtpkOJUoXxdZRIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qIRSx8sC/67c5KN2OOKhEUGeFRGRQ1LkhnPGentF9XGv+HxfVFbFXEShyVf4obc24WuL57vJbRkES+hUJnGO6skCctL30ltNvos7LYcC9I2Om+GoCJd1JwdUgbL7yCJpjh87dZHErqQG/3nIPxnM4WF3ISWUPcy3aWra4vP3eLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SxtNfeMn; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SxtNfeMn"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6ea23720da9so427565a34.2
        for <linux-mmc@vger.kernel.org>; Tue, 09 Apr 2024 05:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712664013; x=1713268813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g57FLG2DYtjB7l2/AdccliiuJIB7I5F3g9Z2XQHJM60=;
        b=SxtNfeMnx8ugip7seohFAs3z+mqBfWay0QS0SA7zoPBf839XfoWfRF7gqhcc8MRDLN
         QNsdbbp+qIogI/Zc3sYP/hLzZfi6z20FHVkB7XcnrGJ22fyAjGpYGrHV3VXyhKn1LIol
         97dBRxJbf4MXaptisSg1+KyUq8wf7zwiz5ppIlVLbLPXIpXy0QQkTBG5DMOjLlooOpAB
         GdJiRZAsvwviKvdBcvCqvxBtQfVw69OnBZRuo8QkP9O4sHTBQie2VPKjcrqx0rvsgrdb
         GCg0V6bSQTC/SVFvKX4MKuIMT2H1/lrwk42c3aMb56mOcMWFpRDhSG2XX8l8nxBnMKjI
         oHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712664013; x=1713268813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g57FLG2DYtjB7l2/AdccliiuJIB7I5F3g9Z2XQHJM60=;
        b=gPb95We4zaaU2lmorlCHB3NvWzqHeKqiCn0HGC4QeaGb6zIymWE66PKWfEbb9tdUOk
         CHVvQgC0ASgMiD/H83QGi37nuWNZIF4nRX2qdGHFj39KhUQdKeUpRT7/d0VWfxo7gjQk
         Y3K+MatsR3rsR3MmyCKdFywD1fYdXRE0ONdceuYHBnFonbC95jDXSFokFW2FmSiEnB7x
         h4SOKgPkB7+4XTMrbOSZ5JNrmMRocoCGJt5jqBrWdc1lcbkAxY000cSCCKCD2qP2kL+I
         gP2g4xJDGyrGbH66XyHeSLhNjAihs3/L/fOWjSHt20bhwjKgEVZ0apqETJcM8gh0Un5l
         zEXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnZF6/G8H0Owq3u3m4pN3t2CzzUnrwd58d+l/tEiksBvGva9Henzr56z15/wJqq5q4L76yGNAI8txm84O6UBSW3XDMvWMJI+AG
X-Gm-Message-State: AOJu0YzTteaXt+iaHWOcmawChlSSzghZpI+xs50xIRMM0sL+aP4sye0o
	mzkzxG121mwM7DgN11IVKQ1vJB6wpLssVi5/sc+uPUV7SdPkNaGx8ZiYL8saEkXlmw33h61EMdD
	T6aW+QkysBJCKPRp0HMTob9OnSwRFmBKwyvjlBA==
X-Google-Smtp-Source: AGHT+IE3c2YTtnw4w6o839yJoZUr2rWNziP6CqA0KFHn0n5VcRiKCHbRofYfnpb6PovupHKtTrD7cYlAEoCdrliikBE=
X-Received: by 2002:a05:6808:14a:b0:3c5:f35b:163a with SMTP id
 h10-20020a056808014a00b003c5f35b163amr5649657oie.22.1712664012608; Tue, 09
 Apr 2024 05:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405115318.904143-1-jens.wiklander@linaro.org>
 <20240405115318.904143-3-jens.wiklander@linaro.org> <DM6PR04MB657580885C16AE4F5743357EFC022@DM6PR04MB6575.namprd04.prod.outlook.com>
 <PH7PR11MB76050B745987B7169C8EDA0EE5022@PH7PR11MB7605.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB76050B745987B7169C8EDA0EE5022@PH7PR11MB7605.namprd11.prod.outlook.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 9 Apr 2024 14:00:01 +0200
Message-ID: <CAHUa44EfLjZkeS0HFTf4gvBiwZj3682t0JSWx_=rb9xfagbWLQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mmc: block: register RPMB partition with the RPMB subsystem
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: Avri Altman <Avri.Altman@wdc.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>, 
	Sumit Garg <sumit.garg@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Bart Van Assche <bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Usyskin, Alexander" <alexander.usyskin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 5:31=E2=80=AFPM Winkler, Tomas <tomas.winkler@intel.=
com> wrote:
>
> >
> >
> > > +
> > > +#define RPMB_PROGRAM_KEY       0x1    /* Program RPMB Authentication
> > You expect the key to be already programmed - so you don't really need =
this
> > operation?
> Depends in what manufacturing flow you program the device,  second I beli=
eve in the original series was also a simulation device,
> This is important as the real device can be programmed only once.

This isn't strictly needed, this is the only "nice to have" feature
I've kept because it's easy enough and can be useful. I can remove it
if it's important.

> >
> > > Key */
> > > +#define RPMB_GET_WRITE_COUNTER 0x2    /* Read RPMB write counter
> > */
> > > +#define RPMB_WRITE_DATA        0x3    /* Write data to RPMB partitio=
n */
> > > +#define RPMB_READ_DATA         0x4    /* Read data from RPMB partiti=
on
> > */
> > > +#define RPMB_RESULT_READ       0x5    /* Read result request  (Inter=
nal)
> > */
> > > +
> > >  static DEFINE_MUTEX(block_mutex);
> > >
> > >  /*
> > > @@ -163,6 +205,7 @@ struct mmc_rpmb_data {
> > >         int id;
> > >         unsigned int part_index;
> > >         struct mmc_blk_data *md;
> > > +       struct rpmb_dev *rdev;
> > >         struct list_head node;
> > >  };
> > >
> > > @@ -2672,7 +2715,6 @@ static int mmc_rpmb_chrdev_open(struct inode
> > > *inode, struct file *filp)
> > >
> > >         get_device(&rpmb->dev);
> > >         filp->private_data =3D rpmb;
> > > -       mmc_blk_get(rpmb->md->disk);
> > Maybe add a comment that this has moved to mmc_blk_alloc_rpmb_part?
> > For those who will look for it.

Such a comment seems odd. Those looking for mmc_blk_get() should be
able to find it easily. I'll add the comment if it's important.

> >
> > >
> > >         return nonseekable_open(inode, filp);  } @@ -2682,7 +2724,6 @=
@
> > > static int mmc_rpmb_chrdev_release(struct inode *inode, struct file *=
filp)
> > >         struct mmc_rpmb_data *rpmb =3D container_of(inode->i_cdev,
> > >                                                   struct
> > > mmc_rpmb_data, chrdev);
> > >
> > > -       mmc_blk_put(rpmb->md);
> > Ditto.

See my answer above.

> >
> > >         put_device(&rpmb->dev);
> > >
> > >         return 0;
> > > @@ -2703,10 +2744,157 @@ static void
> > > mmc_blk_rpmb_device_release(struct
> > > device *dev)  {
> > >         struct mmc_rpmb_data *rpmb =3D dev_get_drvdata(dev);
> > >
> > > +       rpmb_dev_unregister(rpmb->rdev);
> > > +       mmc_blk_put(rpmb->md);
> > >         ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
> > >         kfree(rpmb);
> > >  }
> > >
> > > +static void free_idata(struct mmc_blk_ioc_data **idata, unsigned int
> > > +cmd_count) {
> > > +       unsigned int n;
> > > +
> > > +       for (n =3D 0; n < cmd_count; n++)
> > > +               kfree(idata[n]);
> > > +       kfree(idata);
> > > +}
> > > +
> > > +static struct mmc_blk_ioc_data **alloc_idata(struct mmc_rpmb_data
> > *rpmb,
> > > +                                            unsigned int cmd_count) =
{
> > > +       struct mmc_blk_ioc_data **idata;
> > > +       unsigned int n;
> > > +
> > > +       idata =3D kcalloc(cmd_count, sizeof(*idata), GFP_KERNEL);
> > > +       if (!idata)
> > > +               return NULL;
> > > +
> > > +       for (n =3D 0; n < cmd_count; n++) {
> > > +               idata[n] =3D kcalloc(1, sizeof(**idata), GFP_KERNEL);
> > > +               if (!idata[n]) {
> > > +                       free_idata(idata, n);
> > > +                       return NULL;
> > > +               }
> > > +               idata[n]->rpmb =3D rpmb;
> > > +       }
> > > +
> > > +       return idata;
> > > +}
> > > +
> > > +static void set_idata(struct mmc_blk_ioc_data *idata, u32 opcode,
> > > +                     int write_flag, u8 *buf, unsigned int buf_bytes=
) {
> > > +       idata->ic.opcode =3D opcode;
> > > +       idata->ic.flags =3D MMC_RSP_R1 | MMC_CMD_ADTC;
> > > +       idata->ic.write_flag =3D write_flag;
> > > +       idata->ic.blksz =3D sizeof(struct rpmb_frame);
> > blksz =3D 512, so maybe add a compile-time check on sizeof(struct
> > rpmb_frame)?

That makes sense, I'll add it.

> >
> > > +       idata->ic.blocks =3D buf_bytes /  idata->ic.blksz;
> > > +       idata->buf =3D buf;
> > > +       idata->buf_bytes =3D buf_bytes;
> > > +}
> > > +
> > > +static int mmc_route_rpmb_frames(struct device *dev, u8 *req,
> > > +                                unsigned int req_len, u8 *resp,
> > > +                                unsigned int resp_len) {
> > > +       struct rpmb_frame *frm =3D (struct rpmb_frame *)req;
> > > +       struct mmc_rpmb_data *rpmb =3D dev_get_drvdata(dev);
> > > +       struct mmc_blk_data *md =3D rpmb->md;
> > > +       struct mmc_blk_ioc_data **idata;
> > > +       unsigned int cmd_count;
> > > +       struct request *rq;
> > > +       u16 req_type;
> > > +       bool write;
> > > +       int ret;
> > > +
> > > +       if (IS_ERR(md->queue.card))
> > > +               return PTR_ERR(md->queue.card);
> > > +
> > > +       if (req_len < sizeof(*frm))
> > > +               return -EINVAL;
> > > +
> > > +       req_type =3D be16_to_cpu(frm->req_resp);
> > > +       switch (req_type) {
> > > +       case RPMB_PROGRAM_KEY:
> > > +               if (req_len !=3D sizeof(struct rpmb_frame) ||
> > > +                   resp_len !=3D sizeof(struct rpmb_frame))
> > > +                       return -EINVAL;
> > > +               write =3D true;
> > > +               break;
> > > +       case RPMB_GET_WRITE_COUNTER:
> > > +               if (req_len !=3D sizeof(struct rpmb_frame) ||
> > > +                   resp_len !=3D sizeof(struct rpmb_frame))
> > > +                       return -EINVAL;
> > > +               write =3D false;
> > > +               break;
> > > +       case RPMB_WRITE_DATA:
> > > +               if (req_len % sizeof(struct rpmb_frame) ||
> > > +                   resp_len !=3D sizeof(struct rpmb_frame))
> > > +                       return -EINVAL;
> > > +               write =3D true;
> > > +               break;
> > > +       case RPMB_READ_DATA:
> > > +               if (req_len !=3D sizeof(struct rpmb_frame) ||
> > > +                   resp_len % sizeof(struct rpmb_frame))
> > > +                       return -EINVAL;
> > > +               write =3D false;
> > > +               break;
> > > +       default:
> > > +               return -EINVAL;
> > > +       }
> > Looks like the above input validation section can be reduced to is
> > RPMB_WRITE_DATA and default?

RPMB_GET_WRITE_COUNTER and RPMB_READ_DATA have different checks for resp_le=
n.

> >
> > > +
> > > +       if (write)
> > > +               cmd_count =3D 3;
> > > +       else
> > > +               cmd_count =3D 2;
> > > +
> > > +       idata =3D alloc_idata(rpmb, cmd_count);
> > > +       if (!idata)
> > > +               return -ENOMEM;
> > > +
> > > +       if (write) {
> > > +               struct rpmb_frame *frm =3D (struct rpmb_frame *)resp;
> > > +
> > > +               /* Send write request frame(s) */
> > > +               set_idata(idata[0], MMC_WRITE_MULTIPLE_BLOCK,
> > > +                         1 | MMC_CMD23_ARG_REL_WR, req, req_len);
> > > +
> > > +               /* Send result request frame */
> > > +               memset(frm, 0, sizeof(*frm));
> > > +               frm->req_resp =3D cpu_to_be16(RPMB_RESULT_READ);
> > > +               set_idata(idata[1], MMC_WRITE_MULTIPLE_BLOCK, 1, resp=
,
> > > +                         resp_len);
> > > +
> > > +               /* Read response frame */
> > > +               set_idata(idata[2], MMC_READ_MULTIPLE_BLOCK, 0, resp,
> > > resp_len);
> > It is confusing to me that your response is holding 2 frame types:
> > The status frame and the response frame.
> Refer to the spec.
>
> >
> >
> > > +       } else {
> > > +               /* Send write request frame(s) */
> > > +               set_idata(idata[0], MMC_WRITE_MULTIPLE_BLOCK, 1, req,
> > > + req_len);
> > > +
> > > +               /* Read response frame */
> > > +               set_idata(idata[1], MMC_READ_MULTIPLE_BLOCK, 0, resp,
> > > resp_len);
> > > +       }
> > > +
> > > +       rq =3D blk_mq_alloc_request(md->queue.queue, REQ_OP_DRV_OUT,
> > 0);
> > > +       if (IS_ERR(rq)) {
> > > +               ret =3D PTR_ERR(rq);
> > > +               goto out;
> > > +       }
> > > +
> > > +       req_to_mmc_queue_req(rq)->drv_op =3D
> > MMC_DRV_OP_IOCTL_RPMB;
> > > +       req_to_mmc_queue_req(rq)->drv_op_result =3D -EIO;
> > > +       req_to_mmc_queue_req(rq)->drv_op_data =3D idata;
> > > +       req_to_mmc_queue_req(rq)->ioc_count =3D cmd_count;
> > Maybe have an additional struct mmc_queue_req *mq_rq =3D
> > req_to_mmc_queue_req(rq);

Sure, I'll add it.

> >
> > > +       blk_execute_rq(rq, false);
> > > +       ret =3D req_to_mmc_queue_req(rq)->drv_op_result;
> > > +
> > > +       blk_mq_free_request(rq);
> > > +
> > > +out:
> > > +       free_idata(idata, cmd_count);
> > > +       return ret;
> > > +}
> > > +
> > >  static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
> > >                                    struct mmc_blk_data *md,
> > >                                    unsigned int part_index, @@ -2741,=
6
> > > +2929,7 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
> > >         rpmb->dev.release =3D mmc_blk_rpmb_device_release;
> > >         device_initialize(&rpmb->dev);
> > >         dev_set_drvdata(&rpmb->dev, rpmb);
> > > +       mmc_blk_get(md->disk);
> > >         rpmb->md =3D md;
> > >
> > >         cdev_init(&rpmb->chrdev, &mmc_rpmb_fileops); @@ -3002,6
> > > +3191,41 @@ static void mmc_blk_remove_debugfs(struct mmc_card
> > *card,
> > >
> > >  #endif /* CONFIG_DEBUG_FS */
> > >
> > > +static void mmc_blk_rpmb_add(struct mmc_card *card) {
> > > +       struct mmc_blk_data *md =3D dev_get_drvdata(&card->dev);
> > > +       struct mmc_rpmb_data *rpmb;
> > > +       struct rpmb_dev *rdev;
> > > +       unsigned int n;
> > > +       u32 cid[4];
> > > +       struct rpmb_descr descr =3D {
> > > +               .type =3D RPMB_TYPE_EMMC,
> > > +               .route_frames =3D mmc_route_rpmb_frames,
> > > +               .reliable_wr_count =3D card->ext_csd.raw_rpmb_size_mu=
lt,
> > > +               .capacity =3D card->ext_csd.rel_sectors,
> > The capacity is RPMB_SIZE_MULT and also limited to 16MB?

Thanks for noticing this, I'll fix it. Yes, the spec says it's limited to 1=
6MB.

> > And you also need the region size you are writing to.
> > If I get your intention regarding reliable_wr_count, AFAIK, rpmb can be
> > written either as a single, double, or 32 frames.
> > And this should be induced from card->ext_csd.rel_param, and not card-
> > >ext_csd.rel_sectors.
> This may change in the spec since this patch was written it was few years=
 ago.

Thanks, I'll fix it.

> >
> > > +               .dev_id =3D (void *)cid,
> > > +               .dev_id_len =3D sizeof(cid),
> > > +       };
> > > +
> > > +       /*
> > > +        * Provice CID as an octet array. The CID needs to be interpr=
eted
> > > +        * when used as input to derive the RPMB key since some field=
s
> > > +        * will change due to firmware updates.
> > > +        */
> > Not sure how the CID register is related to RPMB?
> > Is this something internal to TEE?
> Yes to identify the device.

+1

Thanks,
Jens

> >
> > > +       for (n =3D 0; n < 4; n++)
> > > +               cid[n] =3D be32_to_cpu(card->raw_cid[n]);
> > > +
> > > +       list_for_each_entry(rpmb, &md->rpmbs, node) {
> > > +               rdev =3D rpmb_dev_register(&rpmb->dev, &descr);
> > > +               if (IS_ERR(rdev)) {
> > > +                       pr_warn("%s: could not register RPMB device\n=
",
> > > +                               dev_name(&rpmb->dev));
> > > +                       continue;
> > > +               }
> > > +               rpmb->rdev =3D rdev;
> > > +       }
> > > +}
> > > +
> >
> > Thanks,
> > Avri
