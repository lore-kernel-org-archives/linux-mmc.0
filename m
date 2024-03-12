Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6786996F
	for <linux-mmc@vger.kernel.org>; Tue, 12 Mar 2024 08:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710230481; cv=none; b=BVK566iqru9jrVbbotN3Lt9/kHAYVenwL1JHsIRFJ+HqUYPzYYaXLL/6g0HzBwwbf/wCh2wdQBVfqgclgx2fe60F6qxfhPb0dLAqKjQkYegh5w6NWefkXwX9hK7ONYXKyFMbPeUXffp4laPNYA2VMNXXSKw/X3hk4hqa6EfLOlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710230481; c=relaxed/simple;
	bh=jmiIQfHmPQPon9ilSfreIRwvw67I1geOxUdSl+sVCAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGsItV9C13nvgfPQchuciSx5nlihjsX1k/PAmwsNR3o6Nyhm8G9CfePQATURrfCBJqEED3D54AsnJK03xE5gy/CvGWOo8zjwRDaSYlaB7vHif+Cwu2rXWlb2yP4PIElihcLyZpNEZXj6XJYImtuCvNjNAR/vouDtwtBTEf65nAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nhq0c/M+; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nhq0c/M+"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-22200c78d4fso691859fac.1
        for <linux-mmc@vger.kernel.org>; Tue, 12 Mar 2024 01:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710230478; x=1710835278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdPhVHuK00Ik+wii1zI7tStAkb0cVTNtBVjSjSAqx74=;
        b=Nhq0c/M+dWeVZh24S75UX6vDJJM7/uu3650LC4htshrPBVh3EOEXTIZCk1lxyXAA/i
         CqMa/z9uE/iP134uh+MO1p/GqGD8d1nDwAmpilnaefZnxNuHXcv3gdbLAdVqzO2apM8w
         +V/Or/dfp+j7ZckJc1Lj5Tj7NCp3R6++P7Wz8Opt98A5JAeAxp7LXsUl3IlNKTBRzQIv
         mfmTUKNvtLg5/DCccUt/gytHTXJDJBdiRHZe+N5JiPtyoNNXbsDXzt/cSR54Ku1Qgmvw
         dj4QQBz9ixipHEZi+fNa0aTjIRppj9VqLLlbMbm1ISI0+0mj9crm/3l5cJDHEdNN3RfJ
         hRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710230478; x=1710835278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdPhVHuK00Ik+wii1zI7tStAkb0cVTNtBVjSjSAqx74=;
        b=nQuiI3ZejJgpvJpbDXM5KP9ZbBUSAXgmAi22H8S7oyc+pBWO3yXiv48MOJRNQNtfBA
         Xoviu2xfkU9fgzrDBbUTNirknapAv1NH8IFPtWI01Um0ko1BhY+RG+MubBVMtxHK0MEG
         tK9nEfbmm5A6FR8f918upoTc7uEZlcOYXfmrCzmGtjMLNWHFByqyRaeBCygFpPU9oXG9
         Hq938WSaL1/hcbTPNDsS638n6xJJX6pI9hZC/8Uzg1JDnfSiWfu23EskWXaTh2FvGSrT
         WynbFLE04912QSEafFTWHrCJx4hwDsw3E8ikMfCcGft1hYnwnxWlMPwLRiLclirirf0A
         akag==
X-Forwarded-Encrypted: i=1; AJvYcCXObeylzJMnMNwE5WvjpC/ERstSwIylYgX6uL8tWtzLu2AuXItPb5WSLP4ZVlcnPCtLQ1wSOPB2+Pn0Zbzgij/EXwg3XktjwvYv
X-Gm-Message-State: AOJu0YxbnNM8nL8gKo1C4b8TE/Ulx0IS0+qkW4L/ssScrtDsaxy2TAbq
	pwspj3Z1jFdWHwpxFqFM+2siNGidH1juKeI2UJMy9uWfgqFO+MuwXs+O09joL9+6ZTCdqdYQeWu
	X4lLrgIHLveffQ4mEIW1LweWCDbY7ed37eV5e9Q==
X-Google-Smtp-Source: AGHT+IH/1UwsPNFktP/N+kyw9p8reuj4dFgLEdipJhas4oqzk93R3Zzx5XmJxVAKtA8HYt7E0Z1UPeAPorw6S/BfTgI=
X-Received: by 2002:a05:6870:8a0c:b0:221:a881:df51 with SMTP id
 p12-20020a0568708a0c00b00221a881df51mr9183368oaq.44.1710230478051; Tue, 12
 Mar 2024 01:01:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129092535.3278-1-avri.altman@wdc.com> <CAPDyKFqsyp=isawJKH0Q7Qqxqtkx=gmPZru9NnK-ndV20VRmFA@mail.gmail.com>
 <Ze8OXcCA_BCN2MVE@nuoska> <DM6PR04MB65751092AB94DDC87FE9505EFC242@DM6PR04MB6575.namprd04.prod.outlook.com>
 <Ze8eYFW4yZKcWxdo@nuoska> <CAHUa44Eptk+Mvf+vWReCACq6DLCSry0wT2U4aewq==4Q2Z1HCA@mail.gmail.com>
 <Ze8mICZ_22mV4jGQ@nuoska> <DM6PR04MB657544B8D60209776E674156FC242@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB657544B8D60209776E674156FC242@DM6PR04MB6575.namprd04.prod.outlook.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 12 Mar 2024 09:01:06 +0100
Message-ID: <CAHUa44E9qgFrdORQ4zdnHdqb1Dpo8ODk1ioquXNe8tJA86fWrA@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: core: Use mrq.sbc in close-ended ffu
To: Avri Altman <Avri.Altman@wdc.com>
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Daniil Lunev <dlunev@google.com>, Asutosh Das <quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 8:25=E2=80=AFPM Avri Altman <Avri.Altman@wdc.com> w=
rote:
>
> >
> > Hi,
> >
> > On Mon, Mar 11, 2024 at 04:19:54PM +0100, Jens Wiklander wrote:
> > > On Mon, Mar 11, 2024 at 4:08=E2=80=AFPM Mikko Rapeli <mikko.rapeli@li=
naro.org>
> > wrote:
> > > >
> > > > Hi,
> > > >
> > > > Adding Jens from OP-TEE.
> > > >
> > > > On Mon, Mar 11, 2024 at 02:55:01PM +0000, Avri Altman wrote:
> > > > > > On Thu, Nov 30, 2023 at 11:36:10AM +0100, Ulf Hansson wrote:
> > > > > > > On Wed, 29 Nov 2023 at 10:25, Avri Altman <avri.altman@wdc.co=
m>
> > wrote:
> > > > > > > >
> > > > > > > > Field Firmware Update (ffu) may use close-ended or open end=
ed
> > sequence.
> > > > > > > > Each such sequence is comprised of a write commands enclose=
d
> > > > > > > > between
> > > > > > > > 2 switch commands - to and from ffu mode. So for the
> > > > > > > > close-ended case, it will be: cmd6->cmd23-cmd25-cmd6.
> > > > > > > >
> > > > > > > > Some host controllers however, get confused when multi-bloc=
k
> > > > > > > > rw is sent without sbc, and may generate auto-cmd12 which
> > > > > > > > breaks the ffu
> > > > > > sequence.
> > > > > > > > I encountered  this issue while testing fwupd
> > > > > > > > (github.com/fwupd/fwupd) on HP Chromebook x2, a qualcomm
> > > > > > > > based QC-
> > > > > > 7c, code name - strongbad.
> > > > > > > >
> > > > > > > > Instead of a quirk, or hooking the request function of the
> > > > > > > > msm ops, it would be better to fix the ioctl handling and
> > > > > > > > make it use mrq.sbc instead of issuing SET_BLOCK_COUNT
> > separately.
> > > > > > > >
> > > > > > > > Signed-off-by: Avri Altman <avri.altman@wdc.com>
> > > > > > >
> > > > > > > Applied for next (to get it tested a bit more) and by adding =
a
> > > > > > > stable tag, thanks!
> > > > > >
> > > > > > This change is causing RPMB breakage in 6.6.13 and also 6.6.20.
> > > > > > rockpi4b and synquacer arm64 boards with u-boot, optee 4.1.0 an=
d
> > > > > > firmware TPM (fTPM) fail to access RPMB via kernel and tee-supp=
licant
> > 4.1.0.
> > > > > >
> > > > > > More details in
> > > > > > https://bugzilla.kernel.org/show_bug.cgi?id=3D218587
> > > > > >
> > > > > > I've tried to identify what exactly is going wrong but failed s=
o
> > > > > > far. Reverting this changes is the only working solution so far=
.
> > > > > > This also triggered a kernel crash on error path
> > > > > > https://bugzilla.kernel.org/show_bug.cgi?id=3D218542 which is n=
ow
> > fixed/queued.
> > > > > >
> > > > > > If you have any hints how to debug this further or patches to
> > > > > > try, I'd be happy to try those out.
> > > > > I don't know nothing about tpm nor the ftpm.
> > > > > The above patch is scanning command sequences sent via
> > > > > MMC_IOC_MULTI_CMD, looking for pairs of CMD23->CMD25 or
> > > > > CMD23->CMD18, drops the CMD23 and build one instead in
> > __mmc_blk_ioctl_cmd as the mrq.sbc.
> > > > > AFAIK user-space utils, e.g. mmc-utils count on the mmc driver to
> > > > > provide SBC when accessing rpmb, so their multi-ioctl sequences d=
oes not
> > include CMD23, hence does not affected by this code.
> > > > >
> > > > > Looking in the strace included, I tried to find where
> > MMC_IOC_MULTI_CMD is sent.
> > > > > There are 8 such ioctl calls.
> > > > > I guess the tee supplicant sources are unavailable, But it looks
> > > > > like 2 simultaneous threads are trying to access the rpmb partiti=
on - which
> > is forbidden.
> > > > > Opening /dev/mmcblk0rpmb from user space is exclusive, so I am no=
t
> > sure how even this is possible.
> > > >
> > > > tee-supplicant sources are available from
> > > > https://github.com/OP-TEE/optee_client
> > > > and specifically
> > > > https://github.com/OP-TEE/optee_client/blob/master/tee-supplicant/s=
r
> > > > c/rpmb.c#L893
> > > > for MMC_IOC_MULTI_CMD.
> I see no issue with this code.
> Moreover, Since it doesn't contains any CMD23 it shouldn't interact with =
the above patch.
>
> > > >
> > > > Interesting if there are two threads trying to access RPMB at the
> > > > same time. Any comments here from Jens? I would have expected kerne=
l
> > > > to keep RPMB access exclusive for a single user.
> > >
> > > tee-supplicant is multithreaded, but OP-TEE in the secure world has a
> > > global mutex to protect against concurrent access to RPMB. From the
> > > secure world point of view, it's needed to manage the write counter,
> > > but obviously, it has other side effects.
> > > See for instance rpmb_fs_open() at
> > > https://github.com/OP-TEE/optee_os/blob/master/core/tee/tee_rpmb_fs.c=
#
> > > L2953, it's the same for all the other functions accessing RPMB.
> >
> > Thanks. From what I gather from strace log output in
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D218587
> > is that indeed two threads send the commands but they share the same fi=
le
> > descriptor number 6 and also use mutex to make access exclusive:
> >
> > [pid   162] 00:00:15 openat(AT_FDCWD, "/dev/mmcblk0rpmb", O_RDWR) =3D 6
> > [pid   162] 00:00:15 ioctl(6, MMC_IOC_MULTI_CMD, 0xffffb4000b70) =3D 0
> > ...
> > [pid   159] 00:00:15 ioctl(6, MMC_IOC_MULTI_CMD, 0xaaaac5a084b0) =3D 0
> > ...
> > [pid   159] 00:00:15 ioctl(6, MMC_IOC_MULTI_CMD, 0xaaaac5a085d0) =3D 0
> > ...
> > [pid   162] 00:00:15 ioctl(6, MMC_IOC_MULTI_CMD, 0xffffb4000cc0) =3D 0
> > ...
> > [pid   159] 00:00:15 ioctl(6, MMC_IOC_MULTI_CMD, 0xaaaac5a086c0) =3D 0
> > ...
> > [pid   159] 00:00:15 ioctl(6, MMC_IOC_MULTI_CMD, 0xaaaac5a087e0) =3D 0
> > ...
> > [pid   159] 00:00:16 ioctl(6, MMC_IOC_MULTI_CMD, 0xaaaac5a08900) =3D 0
> > ...
> > [pid   162] 00:00:16 ioctl(6, MMC_IOC_MULTI_CMD, 0xffffb4000e40) =3D 0
> > ...
> > [pid   162] 00:00:16 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168,
> > buf_ptr=3D{func=3D0, num_params=3D5,
> > params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE|TEE_IOCTL_PARAM_ATT
> > R_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE},
> > {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE},
> > {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE},
> > {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]}E/TC:? 0
> > E/TC:? 0 TA panicked with code 0xffff0000
> > E/LD:  Status of TA bc50d971-d4c9-42c4-82cb-343fb7f37896
> > E/LD:   arch: aarch64
> > E/LD:  region  0: va 0x40005000 pa 0x3061b000 size 0x002000 flags rw-s =
(ldelf)
> > E/LD:  region  1: va 0x40007000 pa 0x3061d000 size 0x008000 flags r-xs =
(ldelf)
> > E/LD:  region  2: va 0x4000f000 pa 0x30625000 size 0x001000 flags rw-s =
(ldelf)
> > E/LD:  region  3: va 0x40010000 pa 0x30626000 size 0x004000 flags rw-s =
(ldelf)
> > E/LD:  region  4: va 0x40014000 pa 0x3062a000 size 0x001000 flags r--s
> > E/LD:  region  5: va 0x40015000 pa 0x306b2000 size 0x011000 flags rw-s =
(stack)
> > E/LD:  region  6: va 0x40026000 pa 0xe6bb4000 size 0x002000 flags rw--
> > (param)
> > E/LD:  region  7: va 0x4005b000 pa 0x00001000 size 0x068000 flags r-xs =
[0]
> > E/LD:  region  8: va 0x400c3000 pa 0x00069000 size 0x01f000 flags rw-s =
[0]
> > E/LD:   [0] bc50d971-d4c9-42c4-82cb-343fb7f37896 @ 0x4005b000
> > E/LD:  Call stack:
> > E/LD:   0x4009901c
> > E/LD:   0x4005bb40
> > E/LD:   0x4005c1b8
> > E/LD:   0x4007af3c
> > E/LD:   0x40093fc0
> > E/LD:   0x4005ca2c
> > E/LD:   0x4009f1f4
> > E/LD:   0x40094170
> > [   16.187823] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke
> > error: 0xffff3024
> > [   16.188548] tpm tpm0: tpm_try_transmit: send(): error -53212
> >
> > I presume with strace logging tee-supplicant runs a lot slower due to l=
ogging on
> > serial console too so output is a bit mixed.
> >
> > Without strace the fTPM trusted application crash seems to happen
> > immediately after "modprobe tpm_ftpm_tee". The TA side crash traces poi=
nt to
> > problems accessing data in secure storage, in RPMB via optee, kernel op=
tee
> > driver and userspace tee-supplicant.
> I noticed that the code is accessing RPMB as part of fat read? Is this so=
mething that can explain the above contention?

Both reads and writes are protected with the same mutex. I believe
that it's just one operation followed immediately by a second one.
OP-TEE doesn't cache much so we often have to read before writing.

>
> Anyway, it might be helpful turning on the mmc dynamic debug -
> However Vanishingly unlikely, since the rpmb and the mmc device has 2 sep=
arate device nodes,
> Maybe there are 2 concurrent ioctls?

It may be worth trying with a single-threaded tee-supplicant to be
able to rule it out.

> AFAIK it doesn't get synchronized in the driver level.

OK.

Thanks,
Jens

>
> Thanks,
> Avri
> >
> > Cheers,
> >
> > -Mikko
> >
> > > Cheers,
> > > Jens
> > >
> > > >
> > > > Cheers,
> > > >
> > > > -Mikko
> > > >
> > > > > I can try and help you debug this - you can contact me offline.
> > > > >
> > > > > Thanks,
> > > > > Avri
> > > > >
> > > > > >
> > > > > > Cheers,
> > > > > >
> > > > > > -Mikko
> > > > > >
> > > > > > > Kind regards
> > > > > > > Uffe
> > > > > > >
> > > > > > >
> > > > > > > > ---
> > > > > > > >
> > > > > > > > Changelog:
> > > > > > > > v3--v4:
> > > > > > > >         check sbc.error as well
> > > > > > > > v2--v3:
> > > > > > > >         Adopt Adrian's proposal
> > > > > > > > v1--v2:
> > > > > > > >         remove redundant reference of reliable write
> > > > > > > > ---
> > > > > > > >  drivers/mmc/core/block.c | 46
> > > > > > > > +++++++++++++++++++++++++++++++++++++---
> > > > > > > >  1 file changed, 43 insertions(+), 3 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/mmc/core/block.c
> > > > > > > > b/drivers/mmc/core/block.c index f9a5cffa64b1..892e74e611a0
> > > > > > > > 100644
> > > > > > > > --- a/drivers/mmc/core/block.c
> > > > > > > > +++ b/drivers/mmc/core/block.c
> > > > > > > > @@ -400,6 +400,10 @@ struct mmc_blk_ioc_data {
> > > > > > > >         struct mmc_ioc_cmd ic;
> > > > > > > >         unsigned char *buf;
> > > > > > > >         u64 buf_bytes;
> > > > > > > > +       unsigned int flags;
> > > > > > > > +#define MMC_BLK_IOC_DROP       BIT(0)  /* drop this mrq */
> > > > > > > > +#define MMC_BLK_IOC_SBC        BIT(1)  /* use mrq.sbc */
> > > > > > > > +
> > > > > > > >         struct mmc_rpmb_data *rpmb;  };
> > > > > > > >
> > > > > > > > @@ -465,7 +469,7 @@ static int
> > > > > > > > mmc_blk_ioctl_copy_to_user(struct mmc_ioc_cmd __user
> > > > > > > > *ic_ptr,  }
> > > > > > > >
> > > > > > > >  static int __mmc_blk_ioctl_cmd(struct mmc_card *card,
> > > > > > > > struct
> > > > > > mmc_blk_data *md,
> > > > > > > > -                              struct mmc_blk_ioc_data *ida=
ta)
> > > > > > > > +                              struct mmc_blk_ioc_data
> > > > > > > > + **idatas, int
> > > > > > > > + i)
> > > > > > > >  {
> > > > > > > >         struct mmc_command cmd =3D {}, sbc =3D {};
> > > > > > > >         struct mmc_data data =3D {}; @@ -475,10 +479,18 @@
> > > > > > > > static int __mmc_blk_ioctl_cmd(struct
> > > > > > mmc_card *card, struct mmc_blk_data *md,
> > > > > > > >         unsigned int busy_timeout_ms;
> > > > > > > >         int err;
> > > > > > > >         unsigned int target_part;
> > > > > > > > +       struct mmc_blk_ioc_data *idata =3D idatas[i];
> > > > > > > > +       struct mmc_blk_ioc_data *prev_idata =3D NULL;
> > > > > > > >
> > > > > > > >         if (!card || !md || !idata)
> > > > > > > >                 return -EINVAL;
> > > > > > > >
> > > > > > > > +       if (idata->flags & MMC_BLK_IOC_DROP)
> > > > > > > > +               return 0;
> > > > > > > > +
> > > > > > > > +       if (idata->flags & MMC_BLK_IOC_SBC)
> > > > > > > > +               prev_idata =3D idatas[i - 1];
> > > > > > > > +
> > > > > > > >         /*
> > > > > > > >          * The RPMB accesses comes in from the character de=
vice, so
> > we
> > > > > > > >          * need to target these explicitly. Else we just
> > > > > > > > target the @@ -532,7 +544,7 @@ static int
> > > > > > > > __mmc_blk_ioctl_cmd(struct mmc_card
> > > > > > *card, struct mmc_blk_data *md,
> > > > > > > >                         return err;
> > > > > > > >         }
> > > > > > > >
> > > > > > > > -       if (idata->rpmb) {
> > > > > > > > +       if (idata->rpmb || prev_idata) {
> > > > > > > >                 sbc.opcode =3D MMC_SET_BLOCK_COUNT;
> > > > > > > >                 /*
> > > > > > > >                  * We don't do any blockcount validation
> > > > > > > > because the max size @@ -540,6 +552,8 @@ static int
> > > > > > > > __mmc_blk_ioctl_cmd(struct
> > > > > > mmc_card *card, struct mmc_blk_data *md,
> > > > > > > >                  * 'Reliable Write' bit here.
> > > > > > > >                  */
> > > > > > > >                 sbc.arg =3D data.blocks |
> > > > > > > > (idata->ic.write_flag & BIT(31));
> > > > > > > > +               if (prev_idata)
> > > > > > > > +                       sbc.arg =3D prev_idata->ic.arg;
> > > > > > > >                 sbc.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
> > > > > > > >                 mrq.sbc =3D &sbc;
> > > > > > > >         }
> > > > > > > > @@ -557,6 +571,15 @@ static int __mmc_blk_ioctl_cmd(struct
> > > > > > > > mmc_card
> > > > > > *card, struct mmc_blk_data *md,
> > > > > > > >         mmc_wait_for_req(card->host, &mrq);
> > > > > > > >         memcpy(&idata->ic.response, cmd.resp,
> > > > > > > > sizeof(cmd.resp));
> > > > > > > >
> > > > > > > > +       if (prev_idata) {
> > > > > > > > +               memcpy(&prev_idata->ic.response, sbc.resp,
> > sizeof(sbc.resp));
> > > > > > > > +               if (sbc.error) {
> > > > > > > > +                       dev_err(mmc_dev(card->host), "%s: s=
bc error %d\n",
> > > > > > > > +                                                       __f=
unc__, sbc.error);
> > > > > > > > +                       return sbc.error;
> > > > > > > > +               }
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > >         if (cmd.error) {
> > > > > > > >                 dev_err(mmc_dev(card->host), "%s: cmd error=
 %d\n",
> > > > > > > >                                                 __func__,
> > > > > > > > cmd.error); @@ -1032,6 +1055,20 @@ static inline void
> > > > > > mmc_blk_reset_success(struct mmc_blk_data *md, int type)
> > > > > > > >         md->reset_done &=3D ~type;  }
> > > > > > > >
> > > > > > > > +static void mmc_blk_check_sbc(struct mmc_queue_req *mq_rq)=
 {
> > > > > > > > +       struct mmc_blk_ioc_data **idata =3D mq_rq->drv_op_d=
ata;
> > > > > > > > +       int i;
> > > > > > > > +
> > > > > > > > +       for (i =3D 1; i < mq_rq->ioc_count; i++) {
> > > > > > > > +               if (idata[i - 1]->ic.opcode =3D=3D MMC_SET_=
BLOCK_COUNT
> > &&
> > > > > > > > +                   mmc_op_multi(idata[i]->ic.opcode)) {
> > > > > > > > +                       idata[i - 1]->flags |=3D MMC_BLK_IO=
C_DROP;
> > > > > > > > +                       idata[i]->flags |=3D MMC_BLK_IOC_SB=
C;
> > > > > > > > +               }
> > > > > > > > +       }
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  /*
> > > > > > > >   * The non-block commands come back from the block layer
> > > > > > > > after it queued
> > > > > > it and
> > > > > > > >   * processed it with all other requests and then they get
> > > > > > > > issued in this @@ -1059,11 +1096,14 @@ static void
> > > > > > > > mmc_blk_issue_drv_op(struct
> > > > > > mmc_queue *mq, struct request *req)
> > > > > > > >                         if (ret)
> > > > > > > >                                 break;
> > > > > > > >                 }
> > > > > > > > +
> > > > > > > > +               mmc_blk_check_sbc(mq_rq);
> > > > > > > > +
> > > > > > > >                 fallthrough;
> > > > > > > >         case MMC_DRV_OP_IOCTL_RPMB:
> > > > > > > >                 idata =3D mq_rq->drv_op_data;
> > > > > > > >                 for (i =3D 0, ret =3D 0; i < mq_rq->ioc_cou=
nt; i++) {
> > > > > > > > -                       ret =3D __mmc_blk_ioctl_cmd(card, m=
d, idata[i]);
> > > > > > > > +                       ret =3D __mmc_blk_ioctl_cmd(card, m=
d,
> > > > > > > > + idata, i);
> > > > > > > >                         if (ret)
> > > > > > > >                                 break;
> > > > > > > >                 }
> > > > > > > > --
> > > > > > > > 2.42.0
> > > > > > > >
