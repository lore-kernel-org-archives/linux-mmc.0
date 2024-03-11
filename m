Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3C0446B5
	for <linux-mmc@vger.kernel.org>; Mon, 11 Mar 2024 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170408; cv=none; b=a58C5BTBBbbxmZo0SwaEPbw/uVKPCcdoDCBwLgwW6o5Ham81Qg3JltXeEs7/92rHu9qXPC9DSJPg+1fLhoyBvKkbIeYvOUsY7jsfHTI0crEuQ1JG1sPdegFWmawG08ev5Rgv+Vx3tF+LDbA8hy4RLh/st5XRkiadDseqmJ2kvhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170408; c=relaxed/simple;
	bh=NX+V4UC0mBy9I9N9GLpOBTgMyVV1/M4GBTU/aZbDnFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZW2MXjtxHUB5vfCD/Ee0l4qnFvz6H71iNdAlRUJoGjFi/apQlA7ZanOsuFTlYVQWSOLbInj2wSIh5wgWcYhrma74ExkP6syTePtmkNKQOM2mKC88RzJq4c4MmX9bJ6Ktu95V+TC5xCkXWScJNTk4D0UOubCI2KQQzKGtM2XWLOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AQO8G9UT; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AQO8G9UT"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-22002fbbd6bso2304140fac.3
        for <linux-mmc@vger.kernel.org>; Mon, 11 Mar 2024 08:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710170405; x=1710775205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BDkUFVhpJjN5rYl1kaI+wgnsf9RR3qUxhf02oLZLKA=;
        b=AQO8G9UTICNYrdHD+BP0OrZqKOFvqK3afh1XKXJxIiYHM76IEabKtxeVLJmfRQtOvm
         k88lSQ6iCEdpV+5mD45GSGDS7Hba1bvZpO3r1HnvU/sbfwz6+oKT3BiANSlTfyeTkdty
         ag4p8W4QBxgWSj5mZDU6scHThoPM2g6Ld6QzMBeCoZqADSri9QFI0Xn+tm+hzVYVep+k
         ae/ua4uo07gKgoe0rEX5qYv23D121LHkBl4RKTNJBm6OEeV/F0Oce1v291jlimwR13Gt
         Bsw1Z461i5tQ1tfBhRXQuVWEfGcfnQJ5fJH+QXjju0I4c56hvwk53mPzkuwkhI3nm979
         c14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710170405; x=1710775205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BDkUFVhpJjN5rYl1kaI+wgnsf9RR3qUxhf02oLZLKA=;
        b=YHXCM8rL8JGWgaLOSYC66PlFhXoZ6zSiSYUU0pyr7gND2GEOPA8H78knttT14PJlAd
         Czt9klQDeOO/6QFAeylIAC4tYYyHkLx9bHAORYyqkXOtdyQxY2S/BeVl9PQKr6FnKSOo
         sg0jXQVkfm0HQMtqipkWkgAkpI9VNSUhRi08AmDRdMoxtvhuhuc503WMsVN1GsOkyI99
         3E+zOn23iGJnu6egmmZmakU7SbWQdpjRAjUq1bxeBC6Xw7LyflFTCFRnbI61UV4zivu9
         M/q/x5PB0KvZoZQr504ShLL7lqPnm0lJ29DFmDGqtQWjOc0jQM/j5eKeTdNeA4bcwx/L
         /JPA==
X-Forwarded-Encrypted: i=1; AJvYcCX3QsCuaWSxXlRPcFyRrfTFA7YDO/WMtkmEEmafPVXAq+sLo9vLrZcaiH7nkVR5gCMKJS50YVf2J4B7ibtebZEBi6CZJ2f87eoV
X-Gm-Message-State: AOJu0YwJGaC/8DGc2AAI+pXE4c8KI3vG/PExs1b1FfZp7rclCA164Dso
	0QOCr+1Ex/zOF3wwWTNc9n/oUJPLhIITKbBlxcLN676tsJKtuXiyjbnH/AyYBGqXhH5v39qPzMh
	abaC2K7O4RnoLROFTk5e01k1ZuoRPStDWnq97/g==
X-Google-Smtp-Source: AGHT+IE+6GTvwe2Mw5uTGXtDMbH5p9LiKKPpZWmO+9bJLKCJmBEJjKcndwDb+L055nPbr8JRSzwnSMg0nZoW3wn1zyc=
X-Received: by 2002:a05:6870:15c8:b0:221:67:ca2a with SMTP id
 k8-20020a05687015c800b002210067ca2amr7388689oad.46.1710170405197; Mon, 11 Mar
 2024 08:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129092535.3278-1-avri.altman@wdc.com> <CAPDyKFqsyp=isawJKH0Q7Qqxqtkx=gmPZru9NnK-ndV20VRmFA@mail.gmail.com>
 <Ze8OXcCA_BCN2MVE@nuoska> <DM6PR04MB65751092AB94DDC87FE9505EFC242@DM6PR04MB6575.namprd04.prod.outlook.com>
 <Ze8eYFW4yZKcWxdo@nuoska>
In-Reply-To: <Ze8eYFW4yZKcWxdo@nuoska>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 11 Mar 2024 16:19:54 +0100
Message-ID: <CAHUa44Eptk+Mvf+vWReCACq6DLCSry0wT2U4aewq==4Q2Z1HCA@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: core: Use mrq.sbc in close-ended ffu
To: Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: Avri Altman <Avri.Altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Daniil Lunev <dlunev@google.com>, Asutosh Das <quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 4:08=E2=80=AFPM Mikko Rapeli <mikko.rapeli@linaro.o=
rg> wrote:
>
> Hi,
>
> Adding Jens from OP-TEE.
>
> On Mon, Mar 11, 2024 at 02:55:01PM +0000, Avri Altman wrote:
> > > On Thu, Nov 30, 2023 at 11:36:10AM +0100, Ulf Hansson wrote:
> > > > On Wed, 29 Nov 2023 at 10:25, Avri Altman <avri.altman@wdc.com> wro=
te:
> > > > >
> > > > > Field Firmware Update (ffu) may use close-ended or open ended seq=
uence.
> > > > > Each such sequence is comprised of a write commands enclosed betw=
een
> > > > > 2 switch commands - to and from ffu mode. So for the close-ended
> > > > > case, it will be: cmd6->cmd23-cmd25-cmd6.
> > > > >
> > > > > Some host controllers however, get confused when multi-block rw i=
s
> > > > > sent without sbc, and may generate auto-cmd12 which breaks the ff=
u
> > > sequence.
> > > > > I encountered  this issue while testing fwupd
> > > > > (github.com/fwupd/fwupd) on HP Chromebook x2, a qualcomm based QC=
-
> > > 7c, code name - strongbad.
> > > > >
> > > > > Instead of a quirk, or hooking the request function of the msm op=
s,
> > > > > it would be better to fix the ioctl handling and make it use mrq.=
sbc
> > > > > instead of issuing SET_BLOCK_COUNT separately.
> > > > >
> > > > > Signed-off-by: Avri Altman <avri.altman@wdc.com>
> > > >
> > > > Applied for next (to get it tested a bit more) and by adding a stab=
le
> > > > tag, thanks!
> > >
> > > This change is causing RPMB breakage in 6.6.13 and also 6.6.20. rockp=
i4b and
> > > synquacer arm64 boards with u-boot, optee 4.1.0 and firmware TPM (fTP=
M) fail
> > > to access RPMB via kernel and tee-supplicant 4.1.0.
> > >
> > > More details in https://bugzilla.kernel.org/show_bug.cgi?id=3D218587
> > >
> > > I've tried to identify what exactly is going wrong but failed so far.=
 Reverting this
> > > changes is the only working solution so far. This also triggered a ke=
rnel crash on
> > > error path https://bugzilla.kernel.org/show_bug.cgi?id=3D218542 which=
 is now
> > > fixed/queued.
> > >
> > > If you have any hints how to debug this further or patches to try, I'=
d be happy to
> > > try those out.
> > I don't know nothing about tpm nor the ftpm.
> > The above patch is scanning command sequences sent via MMC_IOC_MULTI_CM=
D,
> > looking for pairs of CMD23->CMD25 or CMD23->CMD18,
> > drops the CMD23 and build one instead in __mmc_blk_ioctl_cmd as the mrq=
.sbc.
> > AFAIK user-space utils, e.g. mmc-utils count on the mmc driver to provi=
de SBC when accessing rpmb,
> > so their multi-ioctl sequences does not include CMD23, hence does not a=
ffected by this code.
> >
> > Looking in the strace included, I tried to find where MMC_IOC_MULTI_CMD=
 is sent.
> > There are 8 such ioctl calls.
> > I guess the tee supplicant sources are unavailable,
> > But it looks like 2 simultaneous threads are trying to access the rpmb =
partition - which is forbidden.
> > Opening /dev/mmcblk0rpmb from user space is exclusive, so I am not sure=
 how even this is possible.
>
> tee-supplicant sources are available from https://github.com/OP-TEE/optee=
_client
> and specifically https://github.com/OP-TEE/optee_client/blob/master/tee-s=
upplicant/src/rpmb.c#L893
> for MMC_IOC_MULTI_CMD.
>
> Interesting if there are two threads trying to access RPMB at the same ti=
me. Any
> comments here from Jens? I would have expected kernel to keep RPMB access
> exclusive for a single user.

tee-supplicant is multithreaded, but OP-TEE in the secure world has a
global mutex to protect against concurrent access to RPMB. From the
secure world point of view, it's needed to manage the write counter,
but obviously, it has other side effects.
See for instance rpmb_fs_open() at
https://github.com/OP-TEE/optee_os/blob/master/core/tee/tee_rpmb_fs.c#L2953=
,
it's the same for all the other functions accessing RPMB.

Cheers,
Jens

>
> Cheers,
>
> -Mikko
>
> > I can try and help you debug this - you can contact me offline.
> >
> > Thanks,
> > Avri
> >
> > >
> > > Cheers,
> > >
> > > -Mikko
> > >
> > > > Kind regards
> > > > Uffe
> > > >
> > > >
> > > > > ---
> > > > >
> > > > > Changelog:
> > > > > v3--v4:
> > > > >         check sbc.error as well
> > > > > v2--v3:
> > > > >         Adopt Adrian's proposal
> > > > > v1--v2:
> > > > >         remove redundant reference of reliable write
> > > > > ---
> > > > >  drivers/mmc/core/block.c | 46
> > > > > +++++++++++++++++++++++++++++++++++++---
> > > > >  1 file changed, 43 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > > > > index f9a5cffa64b1..892e74e611a0 100644
> > > > > --- a/drivers/mmc/core/block.c
> > > > > +++ b/drivers/mmc/core/block.c
> > > > > @@ -400,6 +400,10 @@ struct mmc_blk_ioc_data {
> > > > >         struct mmc_ioc_cmd ic;
> > > > >         unsigned char *buf;
> > > > >         u64 buf_bytes;
> > > > > +       unsigned int flags;
> > > > > +#define MMC_BLK_IOC_DROP       BIT(0)  /* drop this mrq */
> > > > > +#define MMC_BLK_IOC_SBC        BIT(1)  /* use mrq.sbc */
> > > > > +
> > > > >         struct mmc_rpmb_data *rpmb;
> > > > >  };
> > > > >
> > > > > @@ -465,7 +469,7 @@ static int mmc_blk_ioctl_copy_to_user(struct
> > > > > mmc_ioc_cmd __user *ic_ptr,  }
> > > > >
> > > > >  static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct
> > > mmc_blk_data *md,
> > > > > -                              struct mmc_blk_ioc_data *idata)
> > > > > +                              struct mmc_blk_ioc_data **idatas, =
int
> > > > > + i)
> > > > >  {
> > > > >         struct mmc_command cmd =3D {}, sbc =3D {};
> > > > >         struct mmc_data data =3D {};
> > > > > @@ -475,10 +479,18 @@ static int __mmc_blk_ioctl_cmd(struct
> > > mmc_card *card, struct mmc_blk_data *md,
> > > > >         unsigned int busy_timeout_ms;
> > > > >         int err;
> > > > >         unsigned int target_part;
> > > > > +       struct mmc_blk_ioc_data *idata =3D idatas[i];
> > > > > +       struct mmc_blk_ioc_data *prev_idata =3D NULL;
> > > > >
> > > > >         if (!card || !md || !idata)
> > > > >                 return -EINVAL;
> > > > >
> > > > > +       if (idata->flags & MMC_BLK_IOC_DROP)
> > > > > +               return 0;
> > > > > +
> > > > > +       if (idata->flags & MMC_BLK_IOC_SBC)
> > > > > +               prev_idata =3D idatas[i - 1];
> > > > > +
> > > > >         /*
> > > > >          * The RPMB accesses comes in from the character device, =
so we
> > > > >          * need to target these explicitly. Else we just target t=
he
> > > > > @@ -532,7 +544,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_car=
d
> > > *card, struct mmc_blk_data *md,
> > > > >                         return err;
> > > > >         }
> > > > >
> > > > > -       if (idata->rpmb) {
> > > > > +       if (idata->rpmb || prev_idata) {
> > > > >                 sbc.opcode =3D MMC_SET_BLOCK_COUNT;
> > > > >                 /*
> > > > >                  * We don't do any blockcount validation because =
the
> > > > > max size @@ -540,6 +552,8 @@ static int __mmc_blk_ioctl_cmd(struc=
t
> > > mmc_card *card, struct mmc_blk_data *md,
> > > > >                  * 'Reliable Write' bit here.
> > > > >                  */
> > > > >                 sbc.arg =3D data.blocks | (idata->ic.write_flag &
> > > > > BIT(31));
> > > > > +               if (prev_idata)
> > > > > +                       sbc.arg =3D prev_idata->ic.arg;
> > > > >                 sbc.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
> > > > >                 mrq.sbc =3D &sbc;
> > > > >         }
> > > > > @@ -557,6 +571,15 @@ static int __mmc_blk_ioctl_cmd(struct mmc_ca=
rd
> > > *card, struct mmc_blk_data *md,
> > > > >         mmc_wait_for_req(card->host, &mrq);
> > > > >         memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
> > > > >
> > > > > +       if (prev_idata) {
> > > > > +               memcpy(&prev_idata->ic.response, sbc.resp, sizeof=
(sbc.resp));
> > > > > +               if (sbc.error) {
> > > > > +                       dev_err(mmc_dev(card->host), "%s: sbc err=
or %d\n",
> > > > > +                                                       __func__,=
 sbc.error);
> > > > > +                       return sbc.error;
> > > > > +               }
> > > > > +       }
> > > > > +
> > > > >         if (cmd.error) {
> > > > >                 dev_err(mmc_dev(card->host), "%s: cmd error %d\n"=
,
> > > > >                                                 __func__,
> > > > > cmd.error); @@ -1032,6 +1055,20 @@ static inline void
> > > mmc_blk_reset_success(struct mmc_blk_data *md, int type)
> > > > >         md->reset_done &=3D ~type;
> > > > >  }
> > > > >
> > > > > +static void mmc_blk_check_sbc(struct mmc_queue_req *mq_rq) {
> > > > > +       struct mmc_blk_ioc_data **idata =3D mq_rq->drv_op_data;
> > > > > +       int i;
> > > > > +
> > > > > +       for (i =3D 1; i < mq_rq->ioc_count; i++) {
> > > > > +               if (idata[i - 1]->ic.opcode =3D=3D MMC_SET_BLOCK_=
COUNT &&
> > > > > +                   mmc_op_multi(idata[i]->ic.opcode)) {
> > > > > +                       idata[i - 1]->flags |=3D MMC_BLK_IOC_DROP=
;
> > > > > +                       idata[i]->flags |=3D MMC_BLK_IOC_SBC;
> > > > > +               }
> > > > > +       }
> > > > > +}
> > > > > +
> > > > >  /*
> > > > >   * The non-block commands come back from the block layer after i=
t queued
> > > it and
> > > > >   * processed it with all other requests and then they get issued=
 in
> > > > > this @@ -1059,11 +1096,14 @@ static void mmc_blk_issue_drv_op(str=
uct
> > > mmc_queue *mq, struct request *req)
> > > > >                         if (ret)
> > > > >                                 break;
> > > > >                 }
> > > > > +
> > > > > +               mmc_blk_check_sbc(mq_rq);
> > > > > +
> > > > >                 fallthrough;
> > > > >         case MMC_DRV_OP_IOCTL_RPMB:
> > > > >                 idata =3D mq_rq->drv_op_data;
> > > > >                 for (i =3D 0, ret =3D 0; i < mq_rq->ioc_count; i+=
+) {
> > > > > -                       ret =3D __mmc_blk_ioctl_cmd(card, md, ida=
ta[i]);
> > > > > +                       ret =3D __mmc_blk_ioctl_cmd(card, md, ida=
ta,
> > > > > + i);
> > > > >                         if (ret)
> > > > >                                 break;
> > > > >                 }
> > > > > --
> > > > > 2.42.0
> > > > >
