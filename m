Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BB71E5B70
	for <linux-mmc@vger.kernel.org>; Fri, 25 Apr 2025 05:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745557212; cv=none; b=vBWG3yxPwBMLlGv7oCdLir7PJU5QF3uks7Wy86ujmgjTWsNyOqkAGLsdlU7YyWfSmAlk108nb7vlp/+iDTjbCroQYZEDAhFTRPPiK5xnQe6HxFTcbhXXhovmRV8HIDZvHTRctnPGK05edk+BzoTZUd/jkjI+/UbpEfWkFNnpjII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745557212; c=relaxed/simple;
	bh=W4kOptdvhQjpakT4jFsbQJnBRUIFUMWkGl6Hn5f+81M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aaAef7GLZv8udw0B/E7SLadRXDP4INkGQYpfE5d3mDjvuT/E7IEztXDrU6JVvhq5ltNAa7yrIVBSo3QvClkorOy/GecMubZ4sw9sFeMLzqXhliijmkW4YD/l0IfJ12k0iUeTQG5q8nVBCrvLpH+iLd1PHNCYgdxg58kCV5hfy4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=GvHgyWfh; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="GvHgyWfh"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5cded3e2eso2712147a12.0
        for <linux-mmc@vger.kernel.org>; Thu, 24 Apr 2025 22:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1745557209; x=1746162009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zIPB6ylkPkplcEfOnovlaR1VoKUyiTrAhNo1jFlx0k=;
        b=GvHgyWfhaGd+/bgCyL9zmHfGc5f6ilYvneHCUHjFH45CZYCigX2iXrdOHtBuEL8jKH
         mAy8NtputgoX+nlJygUxLauFMhVEAg9sa8GvfV/8v9iG3ktx1b0zGs09GD+6EN9ti4tF
         r1vktxldkdQC3Ts8B5SZ4gQ5WqTWvj4u5mi2bGVcxGv/9blABaY8wvgHcG0CiHtpJ2BZ
         OOPo3IYAoGjdxWmqM8cXKrrfSJJsW+BjbzhUXC0WsoKdP5I7iqJljHFQDPYDETmsmKUX
         jeAdJvI9yu134EL0f35BqQwGP9SbAPqjUKZTMWipxyhSDUC782Zm8DWh42yR0Y6PAbCT
         cATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745557209; x=1746162009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zIPB6ylkPkplcEfOnovlaR1VoKUyiTrAhNo1jFlx0k=;
        b=TZxlAcoatg/G4kYqMbyXoVSWGLz93t5DXeDw2eJCDYWMTu5uKxi70rBpYTCPRaflyO
         4gxqS2hPS9FTHkAkJ56CS3nWTm7wIMQfA23Ckym8BAJn8Y/+gx6qy4OcrHIPi+c1RbjT
         giHhGd+hKwDIpWDMBSPA1tDnCGscGugY52m1YsHRY+OeD/UxE+SzqmNUs99nFt5/D4f6
         Gnjo2L4NxSudTRSeneAP3F93AovDQ9wlth+b1bl0AHsGat0INxCABAT9augOm/fP+t+p
         XzMj6RTzaBKtMUqbs5i06l/xx6GB+RhPzHyqER93VmZfiqU67EGaEwtlLJjw2b2UlIzA
         e2jA==
X-Forwarded-Encrypted: i=1; AJvYcCW915Q3SMptH6QDJRMNCJDaltZQckr2bnKmgHtTPoakGPWwy/rQ3fs2Pkm2S83UH8ywoP4MnbNbLks=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrhSES4Sj8rp+ro7utUWnw355PejK4kcMBFuOJ6iJvOLO06PPI
	rrYSr4mtjMDUrnHYeKk0i/cV5d8F7rjd7yBMutrArV/FcdUxPc3fD+sleyWamy1z6KL9NyS4FVH
	TGuDgFfBwaZenJ3wDRfkI3zt8xykcNp3lzSj1
X-Gm-Gg: ASbGncueHAxhT7nJ+jbeCmMbYpi4oo7MEYCG8G12d/LTB+5V/Dyuf9f5UKyc8jye6wT
	ezziv0JT5S5k2RAWUEePifKjzuZX7Kg8U4JE3zjcu/m+k2HFr7rvMbr2fYjnT0R1fj9e3/5zaf8
	VUJa/f5qKyMZVfi6rTRCvziFHn80nD3Dq30QD1GGAKzfj5rjtO2H6/CqA=
X-Google-Smtp-Source: AGHT+IGwMs+I8dH7Q+4SLQd8kQ/vCQHlw4/hHCto77XPbyZ48Dp6AbNza/o8UWjKqoqovcwKeeweOALHhosgFFxrLf4=
X-Received: by 2002:a17:907:f509:b0:aca:c532:cf07 with SMTP id
 a640c23a62f3a-ace711655e5mr71297566b.35.1745557208721; Thu, 24 Apr 2025
 22:00:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKh1g556YvHE9eib3WJG+mBHyyr88rxYSbNUHxpFYsUHcdOoUg@mail.gmail.com>
 <fb21ad0b-b45f-4636-9d74-1e758c3b2879@arm.com> <CAKh1g55ErQRRsJSe6zEmp6mT6nAhEP_Br+HA8x5RvUa4B=4ERA@mail.gmail.com>
 <2343cad4-89aa-48c6-86e7-0c8847ecfe60@arm.com>
In-Reply-To: <2343cad4-89aa-48c6-86e7-0c8847ecfe60@arm.com>
From: Prasad Koya <prasad@arista.com>
Date: Thu, 24 Apr 2025 21:59:56 -0700
X-Gm-Features: ATxdqUHyYhtRhW-kdfxJArO_vUwfCkXtD30oYkUShDbWWsPkjx-xTpfFW0aB6oY
Message-ID: <CAKh1g54=F286nv6zA4UTJeXfxhgNxBLata54ict99ibneBZdcQ@mail.gmail.com>
Subject: Re: eMMC timeout reproduction. Can I send a block of data from the
 host to the card with invalid CRC?
To: Christian Loehle <christian.loehle@arm.com>
Cc: Baptiste Covolato <baptiste@arista.com>, Sushrut Shirole <sushrut@arista.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Christian.

I tried CMD25 with a different block size (mrq->data->blksz =3D 514) and
I can see that the command was rejected with -EILSEQ (data->error =3D
-84). But the card wasn't stuck. After the command was rejected, I see
that the driver is sending CMD12 to signal the card the end of write.
I see this comment in sdhci.c. Is CMD25 called an "open-ended
multiblock transfer"?

1291     /*
1292      * Need to send CMD12 if -
1293      * a) open-ended multiblock transfer (no CMD23)
1294      * b) error in multiblock transfer
1295      */
1296     if (data->stop &&
1297         (data->error ||
1298          !data->mrq->sbc)) {
:
1308         } else {
1309             /* Avoid triggering warning in sdhci_send_command() */
1310             host->cmd =3D NULL;
1311             sdhci_send_command(host, data->stop);
1312         }

Here are my emmc traces:

            bash-10454 [000] ....  6902.122069: mmc_request_start:
mmc0: start struct mmc_request[0000000001eb0468]: cmd_opcode=3D25
cmd_arg=3D0x3a0000 cmd_flags=3D0x35 cmd_retries=3D0 stop_opcode=3D12
stop_arg=3D0x0 stop_flags=3D0x1d stop_retries=3D0 sbc_opcode=3D0 sbc_arg=3D=
0x0
sbc_flags=3D0x0 sbc_retires=3D0 blocks=3D17 block_size=3D1719
blk_addr=3D15433700 data_flags=3D0x100 tag=3D0 can_retune=3D0 doing_retune=
=3D0
retune_now=3D0 need_retune=3D0 hold_retune=3D1 retune_period=3D0
   rs:main Q:Reg-3221  [000] ..s.  6902.125240: mmc_request_done:
mmc0: end struct mmc_request[0000000001eb0468]: cmd_opcode=3D25
cmd_err=3D0 cmd_resp=3D0x900 0x0 0x0 0x0 cmd_retries=3D0 stop_opcode=3D12
stop_err=3D0 stop_resp=3D0xc00 0x0 0x0 0x0 stop_retries=3D0 sbc_opcode=3D0
sbc_err=3D0 sbc_resp=3D0x0 0x0 0x0 0x0 sbc_retries=3D0 bytes_xfered=3D0
data_err=3D-84 tag=3D0 can_retune=3D0 doing_retune=3D0 retune_now=3D0
need_retune=3D0 hold_retune=3D1 retune_period=3D0
            bash-10454 [000] ....  6902.126438: mmc_request_start:
mmc0: start struct mmc_request[000000001c8ae402]: cmd_opcode=3D13
cmd_arg=3D0x10000 cmd_flags=3D0x15 cmd_retries=3D0 stop_opcode=3D0
stop_arg=3D0x0 stop_flags=3D0x0 stop_retries=3D0 sbc_opcode=3D0 sbc_arg=3D0=
x0
sbc_flags=3D0x0 sbc_retires=3D0 blocks=3D0 block_size=3D0 blk_addr=3D0
data_flags=3D0x0 tag=3D0 can_retune=3D0 doing_retune=3D0 retune_now=3D0
need_retune=3D0 hold_retune=3D1 retune_period=3D0
            bash-10454 [000] ..s1  6902.126911: mmc_request_done:
mmc0: end struct mmc_request[000000001c8ae402]: cmd_opcode=3D13
cmd_err=3D0 cmd_resp=3D0x900 0x0 0x0 0x0 cmd_retries=3D0 stop_opcode=3D0
stop_err=3D0 stop_resp=3D0x0 0x0 0x0 0x0 stop_retries=3D0 sbc_opcode=3D0
sbc_err=3D0 sbc_resp=3D0x0 0x0 0x0 0x0 sbc_retries=3D0 bytes_xfered=3D0
data_err=3D0 tag=3D0 can_retune=3D0 doing_retune=3D0 retune_now=3D0
need_retune=3D0 hold_retune=3D1 retune_period=3D0

For our customers, something from the host to the card gets the card
stuck. The status returned at that point is 0xe00. After CMD25 and
CMD12 that took 10s each to timeout, all subsequent commands from the
host fail immediately with -110 error.

Is there any other forum where I can post such questions. I'm a newbie
to the driver. I'm looking at the JEDEC spec and trying to figure out
the implementation.

Thanks.


On Tue, Apr 22, 2025 at 2:54=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 4/22/25 18:37, Prasad Koya wrote:
> > Hi Christian
> >
> > Thanks for going over and replying.
> >
> > I couldn't find any ioctl() that changed host's block size in the 6.14
> > tree. We are using 5.10 kernel.
>
> Works on any kernel since a long time.
> You can find a caller instance in mmc-utils: mmc_cmds.c, the field is
> called blksz, if you've already familiarized yourself with the test
> module I'd say don't bother though.
>
> >
> > I did try mmc_test module so I can modify an existing test case and
> > make it a simple one. Hacking this module, I could call CMD16 via
> > mmc_test_set_blksize() and set the block size to 514 (0x202). Below
> > are the eMMC traces for this test. A CMD16, followed by CMD25 with
> > data, stop opcode and then CMD13. The multi-block write seems to go
> > fine.
>
> Sorry, misunderstanding here. I meant changing the blocksize of the
> transfer for the host *without* letting the card know (by issuing CMD16).
> So leave out the CMD16 part and you should achieve what you want.
>
> >
> >             bash-3958  [001] .... 34861.450688: mmc_request_start:
> > mmc0: start struct mmc_request[00000000fe878338]: cmd_opcode=3D16
> > cmd_arg=3D0x202 cmd_flags=3D0x95 cmd_retries=3D5 stop_opcode=3D0 stop_a=
rg=3D0x0
> > stop_flags=3D0x0 stop_retries=3D0 sbc_opcode=3D0 sbc_arg=3D0x0 sbc_flag=
s=3D0x0
> > sbc_retires=3D0 blocks=3D0 block_size=3D0 blk_addr=3D0 data_flags=3D0x0=
 tag=3D0
> > can_retune=3D0 doing_retune=3D0 retune_now=3D0 need_retune=3D0 hold_ret=
une=3D1
> > retune_period=3D0
> >        in:imklog-2971  [000] ..s. 34861.450737: mmc_request_done:
> > mmc0: end struct mmc_request[00000000fe878338]: cmd_opcode=3D16
> > cmd_err=3D0 cmd_resp=3D0x20000900 0x0 0x0 0x0 cmd_retries=3D5 stop_opco=
de=3D0
> > stop_err=3D0 stop_resp=3D0x0 0x0 0x0 0x0 stop_retries=3D0 sbc_opcode=3D=
0
> > sbc_err=3D0 sbc_resp=3D0x0 0x0 0x0 0x0 sbc_retries=3D0 bytes_xfered=3D0
> > data_err=3D0 tag=3D0 can_retune=3D0 doing_retune=3D0 retune_now=3D0
> > need_retune=3D0 hold_retune=3D1 retune_period=3D0
> >             bash-3958  [001] .... 34861.451064: mmc_request_start:
> > mmc0: start struct mmc_request[00000000c2f30356]: cmd_opcode=3D25
> > cmd_arg=3D0x3a0000 cmd_flags=3D0x35 cmd_retries=3D0 stop_opcode=3D12
> > stop_arg=3D0x0 stop_flags=3D0x1d stop_retries=3D0 sbc_opcode=3D0 sbc_ar=
g=3D0x0
> > sbc_flags=3D0x0 sbc_retires=3D0 blocks=3D128 block_size=3D512 blk_addr=
=3D0
> > data_flags=3D0x100 tag=3D0 can_retune=3D0 doing_retune=3D0 retune_now=
=3D0
> > need_retune=3D0 hold_retune=3D1 retune_period=3D0
> >           <idle>-0     [000] ..s1 34861.456533: mmc_request_done:
> > mmc0: end struct mmc_request[00000000c2f30356]: cmd_opcode=3D25
> > cmd_err=3D0 cmd_resp=3D0x900 0x0 0x0 0x0 cmd_retries=3D0 stop_opcode=3D=
12
> > stop_err=3D0 stop_resp=3D0xc00 0x0 0x0 0x0 stop_retries=3D0 sbc_opcode=
=3D0
> > sbc_err=3D0 sbc_resp=3D0x0 0x0 0x0 0x0 sbc_retries=3D0 bytes_xfered=3D6=
5536
> > data_err=3D0 tag=3D0 can_retune=3D0 doing_retune=3D0 retune_now=3D0
> > need_retune=3D0 hold_retune=3D1 retune_period=3D0
> >             bash-3958  [001] .... 34861.456562: mmc_request_start:
> > mmc0: start struct mmc_request[00000000e93d6161]: cmd_opcode=3D13
> > cmd_arg=3D0x10000 cmd_flags=3D0x15 cmd_retries=3D0 stop_opcode=3D0
> > stop_arg=3D0x0 stop_flags=3D0x0 stop_retries=3D0 sbc_opcode=3D0 sbc_arg=
=3D0x0
> > sbc_flags=3D0x0 sbc_retires=3D0 blocks=3D0 block_size=3D0 blk_addr=3D0
> > data_flags=3D0x0 tag=3D0 can_retune=3D0 doing_retune=3D0 retune_now=3D0
> > need_retune=3D0 hold_retune=3D1 retune_period=3D0
> >    rs:main Q:Reg-2972  [000] ..s. 34861.456688: mmc_request_done:
> > mmc0: end struct mmc_request[00000000e93d6161]: cmd_opcode=3D13
> > cmd_err=3D0 cmd_resp=3D0x900 0x0 0x0 0x0 cmd_retries=3D0 stop_opcode=3D=
0
> > stop_err=3D0 stop_resp=3D0x0 0x0 0x0 0x0 stop_retries=3D0 sbc_opcode=3D=
0
> > sbc_err=3D0 sbc_resp=3D0x0 0x0 0x0 0x0 sbc_retries=3D0 bytes_xfered=3D0
> > data_err=3D0 tag=3D0 can_retune=3D0 doing_retune=3D0 retune_now=3D0
> > need_retune=3D0 hold_retune=3D1 retune_period=3D0
> >
> > What we believe could be happening is an SEU that flips a bit in the
> > data block after the host controller has sent the block on the DAT
> > lines. Card should reject that after CRC mismatch. Does the card
> > reject the command right when it sees a CRC mismatch or does it have
> > to wait till all blocks and CMD12 is sent by the host?
>
> Open writes with CMD25-CMD12 indeed send all blocks until the card
> can signal CRC error.
>
> >
> > Thank you.
> >
> >
> >
> > On Wed, Apr 16, 2025 at 2:13=E2=80=AFAM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> >>
> >> On 4/16/25 01:13, Prasad Koya wrote:
> >>> Hi
> >>>
> >>> We use eMMC as a boot drive. At a random time, maybe a month or an
> >>> year of uptime, we run into an issue where we see the eMMC driver
> >>> prints this in the kernel logs and the drive no longer responds after
> >>> that. We see this issue in the field on linux kernel 4.19.142 and
> >>> 5.10.165. From the SDHCI register dump, it looks like CMD25 ran into =
a
> >>> timeout first. After the first timeout, we see CMD12 in the second
> >>> SDHCI register dump. Status returned by the card at that point in
> >>> card_busy_detect() is 0xE00.
> >>>
> >>> I looked at the recent commits up to 6.15 and I do not see anything
> >>> obvious that addresses issue like below.
> >>>
> >>> We are trying to reproduce the issue in our lab and understand the
> >>> driver code. Is there a way I can send a block of data as part of
> >>> CMD25 with invalid CRC?  Appreciate any pointers.
> >>
> >> CRC is appended by hardware, so it will always be correct.
> >> What you can do though is change the blocksize of the transfer on the
> >> host side (e.g. from 512 to 514 bytes) without changing it using CMD16=
.
> >> The 2 bytes will be latched in as CRC by the card. Of course you won't
> >> see the CRC ACK from the card in that case (as it clashes with the
> >> hardware CRC signal from the host).
> >> You can do all this using the ioctl interface in userspace btw.
>
