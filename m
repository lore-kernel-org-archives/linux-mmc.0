Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3F544C69
	for <linux-mmc@vger.kernel.org>; Mon, 11 Mar 2024 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710171687; cv=none; b=DOUPgWklIbzQfrziEz6LptQcmMZCcUNSR7lFGRj/8fuG0RrBQ2UsaVg5jyVNBRMjdAn0b7a19iXpgRjjLAzbNm525t29/nf0WWnMnz35fGn8pPFVpiqsMkoAs+OOJLqDHUo548zu8C3QRODGlIO8WAUTZ+Vp0i4NZUTm5x1hRE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710171687; c=relaxed/simple;
	bh=YsVgJCoby8c40JQseQkyJGy722GUzthOTHAAjnTiyzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCgRZy8cz4ECVGDQIAFNtUgNNfkA3h1NgVBrA7BkOis/gBGpAKMHfOG9x0A7Vq7WYSryiRwiSTAxF0KjfZKchLI/V5PNETtYB7JepznpN4d09DOKDHU26oc95HvEqTMLV7x6m/blULmpttwoh+8JQ+uALb5/xj2Rl5F08H7S9VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E7GVZsk1; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E7GVZsk1"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d3b93e992aso37551721fa.1
        for <linux-mmc@vger.kernel.org>; Mon, 11 Mar 2024 08:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710171683; x=1710776483; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OYIGADC9lSAgHpn5nSQVehLdSxWRne/erAYBqoEQpXI=;
        b=E7GVZsk1gxjpCRfY7KL3L0QTgQK/nYWy+ArxpwYCNponO61LbtEad3hQN+tpUMm4OC
         bZDcBfwEExfptDALuYXi4Y5jAruVrN9Y7RSL7/MB1ZTysSVvGJoiud4i2vNi7+YMJyuh
         muGql/AXH+2UUK4zSXv/TmtoEIy5EVnLnGbSn5vNnI8XW4176baNhevQCZBeMAUq01Jh
         8Vlj70EMkFmvc24WS/eraXUmCTQmgAZF3FDutT2sYkO7FesHCgY55FKlSyzlmY8D3e93
         3Cqm4T2+518GH6PCpphmrbZxDgo67PbR7FLsrTQJRLAuaezJb99d74EMUZFV3LEMJFI5
         8d5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710171683; x=1710776483;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OYIGADC9lSAgHpn5nSQVehLdSxWRne/erAYBqoEQpXI=;
        b=ZI6VNPFSh9VKcfTwjBBKGVwFAUZgbua0EV2krTWxhl5zGUZntOoK85n2c7BiOqowCQ
         jaAmm6g6RfaW7asbVkWJ/uJjdQA6VP1WPE0crTOG+P9s7/ARJH7DVlSE/aTfOcNuMeRV
         idJTsajiTYrqA4U8mHdJVQkD5BcxeNS2ygJy57M4NL7v3C7FIhcpNdMGnEMM0dKHbqJh
         9NTp/JccyslhtXsQ9scC3CYBTTCz2VislQRsieHZZFx6ttBCEyXw0k8POYK2Bqh/hgc4
         mx3/CCWzvN7pgBTuv45F/fYTwavdiTwNeNnXZWhIGFrbg8aU6RqJw+ofac08e1uhfrlK
         c1Vw==
X-Forwarded-Encrypted: i=1; AJvYcCW2NeYmXmoId8W0dFQl97Oe3mR6bEv6aV787XZir8yoZOI+db8lV/qTpPNBJKSpAHx1QNIyDKVkbtRa5DOGnqPXln512aOG8HaU
X-Gm-Message-State: AOJu0Yx8S/tc71pRmj/oxwDC8nauVZz9R2P0iOjja2tNGtXL6GSyPPMN
	HJE471OjMDgCb1YHbbJbI4LuS0zi5s21Lp1z12pGUBHkW/ldkebqIcN8KS9JAkU=
X-Google-Smtp-Source: AGHT+IExZcYIYpaW1F/fmpslyhE5qek6Afz7ssJVPSqLSWAdOFtBO+ZGvSc2TkQORGPpQGM7vX6SgA==
X-Received: by 2002:a2e:9b8d:0:b0:2d3:7d71:b3a1 with SMTP id z13-20020a2e9b8d000000b002d37d71b3a1mr4040422lji.53.1710171682980;
        Mon, 11 Mar 2024 08:41:22 -0700 (PDT)
Received: from nuoska (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id c21-20020a2e9495000000b002d42e2e682bsm1000882ljh.34.2024.03.11.08.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 08:41:22 -0700 (PDT)
Date: Mon, 11 Mar 2024 17:41:20 +0200
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Avri Altman <Avri.Altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Daniil Lunev <dlunev@google.com>,
	Asutosh Das <quic_asutoshd@quicinc.com>
Subject: Re: [PATCH v4] mmc: core: Use mrq.sbc in close-ended ffu
Message-ID: <Ze8mICZ_22mV4jGQ@nuoska>
References: <20231129092535.3278-1-avri.altman@wdc.com>
 <CAPDyKFqsyp=isawJKH0Q7Qqxqtkx=gmPZru9NnK-ndV20VRmFA@mail.gmail.com>
 <Ze8OXcCA_BCN2MVE@nuoska>
 <DM6PR04MB65751092AB94DDC87FE9505EFC242@DM6PR04MB6575.namprd04.prod.outlook.com>
 <Ze8eYFW4yZKcWxdo@nuoska>
 <CAHUa44Eptk+Mvf+vWReCACq6DLCSry0wT2U4aewq==4Q2Z1HCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHUa44Eptk+Mvf+vWReCACq6DLCSry0wT2U4aewq==4Q2Z1HCA@mail.gmail.com>

Hi,

On Mon, Mar 11, 2024 at 04:19:54PM +0100, Jens Wiklander wrote:
> On Mon, Mar 11, 2024 at 4:08 PM Mikko Rapeli <mikko.rapeli@linaro.org> wrote:
> >
> > Hi,
> >
> > Adding Jens from OP-TEE.
> >
> > On Mon, Mar 11, 2024 at 02:55:01PM +0000, Avri Altman wrote:
> > > > On Thu, Nov 30, 2023 at 11:36:10AM +0100, Ulf Hansson wrote:
> > > > > On Wed, 29 Nov 2023 at 10:25, Avri Altman <avri.altman@wdc.com> wrote:
> > > > > >
> > > > > > Field Firmware Update (ffu) may use close-ended or open ended sequence.
> > > > > > Each such sequence is comprised of a write commands enclosed between
> > > > > > 2 switch commands - to and from ffu mode. So for the close-ended
> > > > > > case, it will be: cmd6->cmd23-cmd25-cmd6.
> > > > > >
> > > > > > Some host controllers however, get confused when multi-block rw is
> > > > > > sent without sbc, and may generate auto-cmd12 which breaks the ffu
> > > > sequence.
> > > > > > I encountered  this issue while testing fwupd
> > > > > > (github.com/fwupd/fwupd) on HP Chromebook x2, a qualcomm based QC-
> > > > 7c, code name - strongbad.
> > > > > >
> > > > > > Instead of a quirk, or hooking the request function of the msm ops,
> > > > > > it would be better to fix the ioctl handling and make it use mrq.sbc
> > > > > > instead of issuing SET_BLOCK_COUNT separately.
> > > > > >
> > > > > > Signed-off-by: Avri Altman <avri.altman@wdc.com>
> > > > >
> > > > > Applied for next (to get it tested a bit more) and by adding a stable
> > > > > tag, thanks!
> > > >
> > > > This change is causing RPMB breakage in 6.6.13 and also 6.6.20. rockpi4b and
> > > > synquacer arm64 boards with u-boot, optee 4.1.0 and firmware TPM (fTPM) fail
> > > > to access RPMB via kernel and tee-supplicant 4.1.0.
> > > >
> > > > More details in https://bugzilla.kernel.org/show_bug.cgi?id=218587
> > > >
> > > > I've tried to identify what exactly is going wrong but failed so far. Reverting this
> > > > changes is the only working solution so far. This also triggered a kernel crash on
> > > > error path https://bugzilla.kernel.org/show_bug.cgi?id=218542 which is now
> > > > fixed/queued.
> > > >
> > > > If you have any hints how to debug this further or patches to try, I'd be happy to
> > > > try those out.
> > > I don't know nothing about tpm nor the ftpm.
> > > The above patch is scanning command sequences sent via MMC_IOC_MULTI_CMD,
> > > looking for pairs of CMD23->CMD25 or CMD23->CMD18,
> > > drops the CMD23 and build one instead in __mmc_blk_ioctl_cmd as the mrq.sbc.
> > > AFAIK user-space utils, e.g. mmc-utils count on the mmc driver to provide SBC when accessing rpmb,
> > > so their multi-ioctl sequences does not include CMD23, hence does not affected by this code.
> > >
> > > Looking in the strace included, I tried to find where MMC_IOC_MULTI_CMD is sent.
> > > There are 8 such ioctl calls.
> > > I guess the tee supplicant sources are unavailable,
> > > But it looks like 2 simultaneous threads are trying to access the rpmb partition - which is forbidden.
> > > Opening /dev/mmcblk0rpmb from user space is exclusive, so I am not sure how even this is possible.
> >
> > tee-supplicant sources are available from https://github.com/OP-TEE/optee_client
> > and specifically https://github.com/OP-TEE/optee_client/blob/master/tee-supplicant/src/rpmb.c#L893
> > for MMC_IOC_MULTI_CMD.
> >
> > Interesting if there are two threads trying to access RPMB at the same time. Any
> > comments here from Jens? I would have expected kernel to keep RPMB access
> > exclusive for a single user.
> 
> tee-supplicant is multithreaded, but OP-TEE in the secure world has a
> global mutex to protect against concurrent access to RPMB. From the
> secure world point of view, it's needed to manage the write counter,
> but obviously, it has other side effects.
> See for instance rpmb_fs_open() at
> https://github.com/OP-TEE/optee_os/blob/master/core/tee/tee_rpmb_fs.c#L2953,
> it's the same for all the other functions accessing RPMB.

Thanks. From what I gather from strace log output in
https://bugzilla.kernel.org/show_bug.cgi?id=218587
is that indeed two threads send the commands but they share
the same file descriptor number 6 and also use mutex to
make access exclusive:

[pid   162] 00:00:15 openat(AT_FDCWD, "/dev/mmcblk0rpmb", O_RDWR) = 6
[pid   162] 00:00:15 ioctl(6, MMC_IOC_MULTI_CMD, 0xffffb4000b70) = 0
...
[pid   159] 00:00:15 ioctl(6, MMC_IOC_MULTI_CMD, 0xaaaac5a084b0) = 0
...
[pid   159] 00:00:15 ioctl(6, MMC_IOC_MULTI_CMD, 0xaaaac5a085d0) = 0
...
[pid   162] 00:00:15 ioctl(6, MMC_IOC_MULTI_CMD, 0xffffb4000cc0) = 0
...
[pid   159] 00:00:15 ioctl(6, MMC_IOC_MULTI_CMD, 0xaaaac5a086c0) = 0
...
[pid   159] 00:00:15 ioctl(6, MMC_IOC_MULTI_CMD, 0xaaaac5a087e0) = 0
...
[pid   159] 00:00:16 ioctl(6, MMC_IOC_MULTI_CMD, 0xaaaac5a08900) = 0
...
[pid   162] 00:00:16 ioctl(6, MMC_IOC_MULTI_CMD, 0xffffb4000e40) = 0
...
[pid   162] 00:00:16 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=168, buf_ptr={func=0, num_params=5, params=[{attr=TEE_IOCTL_PARAM_ATTR_TYPE_NONE|TEE_IOCTL_PARAM_ATTR_META, a=0, b=0, c=0}, {attr=TEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=TEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=TEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=TEE_IOCTL_PARAM_ATTR_TYPE_NONE}]}E/TC:? 0 
E/TC:? 0 TA panicked with code 0xffff0000
E/LD:  Status of TA bc50d971-d4c9-42c4-82cb-343fb7f37896
E/LD:   arch: aarch64
E/LD:  region  0: va 0x40005000 pa 0x3061b000 size 0x002000 flags rw-s (ldelf)
E/LD:  region  1: va 0x40007000 pa 0x3061d000 size 0x008000 flags r-xs (ldelf)
E/LD:  region  2: va 0x4000f000 pa 0x30625000 size 0x001000 flags rw-s (ldelf)
E/LD:  region  3: va 0x40010000 pa 0x30626000 size 0x004000 flags rw-s (ldelf)
E/LD:  region  4: va 0x40014000 pa 0x3062a000 size 0x001000 flags r--s
E/LD:  region  5: va 0x40015000 pa 0x306b2000 size 0x011000 flags rw-s (stack)
E/LD:  region  6: va 0x40026000 pa 0xe6bb4000 size 0x002000 flags rw-- (param)
E/LD:  region  7: va 0x4005b000 pa 0x00001000 size 0x068000 flags r-xs [0]
E/LD:  region  8: va 0x400c3000 pa 0x00069000 size 0x01f000 flags rw-s [0]
E/LD:   [0] bc50d971-d4c9-42c4-82cb-343fb7f37896 @ 0x4005b000
E/LD:  Call stack:
E/LD:   0x4009901c
E/LD:   0x4005bb40
E/LD:   0x4005c1b8
E/LD:   0x4007af3c
E/LD:   0x40093fc0
E/LD:   0x4005ca2c
E/LD:   0x4009f1f4
E/LD:   0x40094170
[   16.187823] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0xffff3024
[   16.188548] tpm tpm0: tpm_try_transmit: send(): error -53212

I presume with strace logging tee-supplicant runs a lot slower
due to logging on serial console too so output is a bit mixed.

Without strace the fTPM trusted application crash seems to happen
immediately after "modprobe tpm_ftpm_tee". The TA side crash traces
point to problems accessing data in secure storage, in RPMB via optee,
kernel optee driver and userspace tee-supplicant.

Cheers,

-Mikko

> Cheers,
> Jens
> 
> >
> > Cheers,
> >
> > -Mikko
> >
> > > I can try and help you debug this - you can contact me offline.
> > >
> > > Thanks,
> > > Avri
> > >
> > > >
> > > > Cheers,
> > > >
> > > > -Mikko
> > > >
> > > > > Kind regards
> > > > > Uffe
> > > > >
> > > > >
> > > > > > ---
> > > > > >
> > > > > > Changelog:
> > > > > > v3--v4:
> > > > > >         check sbc.error as well
> > > > > > v2--v3:
> > > > > >         Adopt Adrian's proposal
> > > > > > v1--v2:
> > > > > >         remove redundant reference of reliable write
> > > > > > ---
> > > > > >  drivers/mmc/core/block.c | 46
> > > > > > +++++++++++++++++++++++++++++++++++++---
> > > > > >  1 file changed, 43 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > > > > > index f9a5cffa64b1..892e74e611a0 100644
> > > > > > --- a/drivers/mmc/core/block.c
> > > > > > +++ b/drivers/mmc/core/block.c
> > > > > > @@ -400,6 +400,10 @@ struct mmc_blk_ioc_data {
> > > > > >         struct mmc_ioc_cmd ic;
> > > > > >         unsigned char *buf;
> > > > > >         u64 buf_bytes;
> > > > > > +       unsigned int flags;
> > > > > > +#define MMC_BLK_IOC_DROP       BIT(0)  /* drop this mrq */
> > > > > > +#define MMC_BLK_IOC_SBC        BIT(1)  /* use mrq.sbc */
> > > > > > +
> > > > > >         struct mmc_rpmb_data *rpmb;
> > > > > >  };
> > > > > >
> > > > > > @@ -465,7 +469,7 @@ static int mmc_blk_ioctl_copy_to_user(struct
> > > > > > mmc_ioc_cmd __user *ic_ptr,  }
> > > > > >
> > > > > >  static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct
> > > > mmc_blk_data *md,
> > > > > > -                              struct mmc_blk_ioc_data *idata)
> > > > > > +                              struct mmc_blk_ioc_data **idatas, int
> > > > > > + i)
> > > > > >  {
> > > > > >         struct mmc_command cmd = {}, sbc = {};
> > > > > >         struct mmc_data data = {};
> > > > > > @@ -475,10 +479,18 @@ static int __mmc_blk_ioctl_cmd(struct
> > > > mmc_card *card, struct mmc_blk_data *md,
> > > > > >         unsigned int busy_timeout_ms;
> > > > > >         int err;
> > > > > >         unsigned int target_part;
> > > > > > +       struct mmc_blk_ioc_data *idata = idatas[i];
> > > > > > +       struct mmc_blk_ioc_data *prev_idata = NULL;
> > > > > >
> > > > > >         if (!card || !md || !idata)
> > > > > >                 return -EINVAL;
> > > > > >
> > > > > > +       if (idata->flags & MMC_BLK_IOC_DROP)
> > > > > > +               return 0;
> > > > > > +
> > > > > > +       if (idata->flags & MMC_BLK_IOC_SBC)
> > > > > > +               prev_idata = idatas[i - 1];
> > > > > > +
> > > > > >         /*
> > > > > >          * The RPMB accesses comes in from the character device, so we
> > > > > >          * need to target these explicitly. Else we just target the
> > > > > > @@ -532,7 +544,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> > > > *card, struct mmc_blk_data *md,
> > > > > >                         return err;
> > > > > >         }
> > > > > >
> > > > > > -       if (idata->rpmb) {
> > > > > > +       if (idata->rpmb || prev_idata) {
> > > > > >                 sbc.opcode = MMC_SET_BLOCK_COUNT;
> > > > > >                 /*
> > > > > >                  * We don't do any blockcount validation because the
> > > > > > max size @@ -540,6 +552,8 @@ static int __mmc_blk_ioctl_cmd(struct
> > > > mmc_card *card, struct mmc_blk_data *md,
> > > > > >                  * 'Reliable Write' bit here.
> > > > > >                  */
> > > > > >                 sbc.arg = data.blocks | (idata->ic.write_flag &
> > > > > > BIT(31));
> > > > > > +               if (prev_idata)
> > > > > > +                       sbc.arg = prev_idata->ic.arg;
> > > > > >                 sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
> > > > > >                 mrq.sbc = &sbc;
> > > > > >         }
> > > > > > @@ -557,6 +571,15 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> > > > *card, struct mmc_blk_data *md,
> > > > > >         mmc_wait_for_req(card->host, &mrq);
> > > > > >         memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
> > > > > >
> > > > > > +       if (prev_idata) {
> > > > > > +               memcpy(&prev_idata->ic.response, sbc.resp, sizeof(sbc.resp));
> > > > > > +               if (sbc.error) {
> > > > > > +                       dev_err(mmc_dev(card->host), "%s: sbc error %d\n",
> > > > > > +                                                       __func__, sbc.error);
> > > > > > +                       return sbc.error;
> > > > > > +               }
> > > > > > +       }
> > > > > > +
> > > > > >         if (cmd.error) {
> > > > > >                 dev_err(mmc_dev(card->host), "%s: cmd error %d\n",
> > > > > >                                                 __func__,
> > > > > > cmd.error); @@ -1032,6 +1055,20 @@ static inline void
> > > > mmc_blk_reset_success(struct mmc_blk_data *md, int type)
> > > > > >         md->reset_done &= ~type;
> > > > > >  }
> > > > > >
> > > > > > +static void mmc_blk_check_sbc(struct mmc_queue_req *mq_rq) {
> > > > > > +       struct mmc_blk_ioc_data **idata = mq_rq->drv_op_data;
> > > > > > +       int i;
> > > > > > +
> > > > > > +       for (i = 1; i < mq_rq->ioc_count; i++) {
> > > > > > +               if (idata[i - 1]->ic.opcode == MMC_SET_BLOCK_COUNT &&
> > > > > > +                   mmc_op_multi(idata[i]->ic.opcode)) {
> > > > > > +                       idata[i - 1]->flags |= MMC_BLK_IOC_DROP;
> > > > > > +                       idata[i]->flags |= MMC_BLK_IOC_SBC;
> > > > > > +               }
> > > > > > +       }
> > > > > > +}
> > > > > > +
> > > > > >  /*
> > > > > >   * The non-block commands come back from the block layer after it queued
> > > > it and
> > > > > >   * processed it with all other requests and then they get issued in
> > > > > > this @@ -1059,11 +1096,14 @@ static void mmc_blk_issue_drv_op(struct
> > > > mmc_queue *mq, struct request *req)
> > > > > >                         if (ret)
> > > > > >                                 break;
> > > > > >                 }
> > > > > > +
> > > > > > +               mmc_blk_check_sbc(mq_rq);
> > > > > > +
> > > > > >                 fallthrough;
> > > > > >         case MMC_DRV_OP_IOCTL_RPMB:
> > > > > >                 idata = mq_rq->drv_op_data;
> > > > > >                 for (i = 0, ret = 0; i < mq_rq->ioc_count; i++) {
> > > > > > -                       ret = __mmc_blk_ioctl_cmd(card, md, idata[i]);
> > > > > > +                       ret = __mmc_blk_ioctl_cmd(card, md, idata,
> > > > > > + i);
> > > > > >                         if (ret)
> > > > > >                                 break;
> > > > > >                 }
> > > > > > --
> > > > > > 2.42.0
> > > > > >
