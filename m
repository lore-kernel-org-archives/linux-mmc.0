Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3AE16DC28
	for <linux-mmc@vger.kernel.org>; Tue, 29 Apr 2025 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745952818; cv=none; b=Qp3wq63FdOErKXWnAdv9LI/HY95vnQYEfAo/zps6/k3OlVFqBkTlbtDZmzSykH8iz2NVDd/i4KH5XSI/9mkWZi6xcZGLHT017BSN1xvEF/FsB03s3Heq8raaS7PKTDAm/RinnxCyoPkuozcIQ+fbJX/d5lrRn9fL6Xo62ZuX/Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745952818; c=relaxed/simple;
	bh=phqhYsC/NA3aijR0CofUeD9eIZAA2zAmzV5twxq2qPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GwocdbvSJw8Ski5zvFkZy7amsGpGBvZjqvHZ6NVTvmwLbKRPczFLinDo1xvuYfm0V9xKV3eX6+xeUTYEQgWIK0rgV9hUu1pnPL8p3KjxFR3k2vpcByjlPhbsEALQZWhT6UpRoRxqpW5KdAy/kRdqs+47RiEwa52w0fYjAv6f9iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=TzOzhkA0; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="TzOzhkA0"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so11257629a12.0
        for <linux-mmc@vger.kernel.org>; Tue, 29 Apr 2025 11:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1745952814; x=1746557614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2w4emmnjAWEbZtouRsXSxdlOvdPUxmKFA7RhIv61GoU=;
        b=TzOzhkA0f2RuJoZd6gzgFDwEMuZS/7nYOWMni5iJg9G8Mn8W0sqx9k+ZPalY+ITfUv
         6ARmY9t9mopJgbiESwxa1yLSdZi+IYhg+FIueogjuop3/kDhphIrajNSW3tYB1rvNN/I
         DOa8l/LQLvllJY+10BCK/69MsavS1a3qU7TRUI73yNQJ3BcFxzJTU5UtvrhjzsqFTk/e
         ekmoRKpTO3Pad98P1jUBF5wr6uNL7Lg1bSxF6yI5uvYd+111glfld40RUJl6f1shOqxk
         FLKIwyxd5OTg1x6gDuYLSC+v6ok/lWhVC+D6GHskJTKlaBZzbhjV4edy5sxeUG557DUF
         ixPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745952814; x=1746557614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2w4emmnjAWEbZtouRsXSxdlOvdPUxmKFA7RhIv61GoU=;
        b=xFrC0l9dCJgadg9jN4bh+0/8pLFLPfgIxgxzFpbYsuUCx7nXmSKVze3XwUnvIEb937
         VbHt1c420medgVjaXz9WxrfMfPR2KtMhVmlvACuAI4By5Yuc2mOMKJEqVxHBw4zz8TIP
         8Hwhh/QJuU1rJYeFC8+8ECYi8i7W1o+Hmnr8/vUjms6ly2zuE2h6SNms9EsncL/0w8ii
         FDDmpheKpxDKEehvrtBAeNfbJx9Sl1ymlXiNVD/zzmM1kBtocOPonpURTsg/c37YrUO1
         NUPnN1u2BbN6ZS4hBClllXxANuDhDy7kRZ6W/SLTrw7cjD6Y7UMzcdvpdT8hs7236FHU
         af2g==
X-Forwarded-Encrypted: i=1; AJvYcCXqDDrbwkdWDf8+2IwItapeH3rR8WDxuJV//i1EpdFYyxaNmD1xJ0ku5M/GoErzm9cck85mFuhCQB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvqInO09XgBlcAHpcur/JR/JC1Yyjw0O+eKkKEJuhfMUSVjokU
	K42wUVh0l6ivliquzlvayVK4r7+2ccchqbFb87aKP9JsnXsRjOjDrC8AYf72uPo5JWWrCxqHmXP
	ILjQN3GuwpjMR5KL/PqFAK8Karxt9dEJ4QLbF
X-Gm-Gg: ASbGncta6YntkEv0HJk7meUdhTxv6rQw8WAWOMUulwGkO32a7tzGCBICbWS17Wp3+0K
	puptQMrZeqb+dEoy46VGUlqb6D5xJT1ZmKIHsiBNhgCQU7bErEmqG10j5VadMKnJmsVp5XLJE/P
	TXnI3KOAqx4678G9B86e9Dha0YBAJyjstr9GlDBZxEjs9Mn5B+VsgCaQ==
X-Google-Smtp-Source: AGHT+IHnMBUYbfhixLRD5NHcsewRajJiNtIaQn4M0zQ9m7dVuSYHw4is62FSjAFo6gFtdfWYLE8dVHuITDHymk1E5cQ=
X-Received: by 2002:a17:906:f583:b0:abf:6d24:10bb with SMTP id
 a640c23a62f3a-acedc7002f6mr43733466b.44.1745952813978; Tue, 29 Apr 2025
 11:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKh1g556YvHE9eib3WJG+mBHyyr88rxYSbNUHxpFYsUHcdOoUg@mail.gmail.com>
 <fb21ad0b-b45f-4636-9d74-1e758c3b2879@arm.com> <CAKh1g55ErQRRsJSe6zEmp6mT6nAhEP_Br+HA8x5RvUa4B=4ERA@mail.gmail.com>
 <2343cad4-89aa-48c6-86e7-0c8847ecfe60@arm.com> <CAKh1g54=F286nv6zA4UTJeXfxhgNxBLata54ict99ibneBZdcQ@mail.gmail.com>
 <a013b589-3288-429f-a1e7-84501afa63a5@arm.com>
In-Reply-To: <a013b589-3288-429f-a1e7-84501afa63a5@arm.com>
From: Prasad Koya <prasad@arista.com>
Date: Tue, 29 Apr 2025 11:53:22 -0700
X-Gm-Features: ATxdqUFKjwgogoxEbNwHIRrIm0Ntl2HgrtaVN34T7kOkqGc_qSDqY21IJfsxk54
Message-ID: <CAKh1g55LMAd9CVgZBiBCbHKu8+bJPt4D6B1aHsoa+rg0cE3ytg@mail.gmail.com>
Subject: Re: eMMC timeout reproduction. Can I send a block of data from the
 host to the card with invalid CRC?
To: Christian Loehle <christian.loehle@arm.com>
Cc: Baptiste Covolato <baptiste@arista.com>, Sushrut Shirole <sushrut@arista.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks.

mmc_test module sets CMD23 for both CMD24 and CMD25.

I ran into something weird, which we also saw in the field is a CMD25
with block count as 0.

Here are the kernel logs from the field:

[Sat Mar 29 01:31:07 2025] mmc0: Timeout waiting for hardware interrupt.
[Sat Mar 29 01:31:07 2025] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D SDHCI REGISTER
DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[Sat Mar 29 01:31:07 2025] mmc0: sdhci: Sys addr:  0xd3c01000 |
Version:  0x00001002
[Sat Mar 29 01:31:07 2025] mmc0: sdhci: Blk size:  0x00007200 | Blk
cnt:  0x00000000
[Sat Mar 29 01:31:07 2025] mmc0: sdhci: Argument:  0x0045d1a8 | Trn
mode: 0x00000023
[Sat Mar 29 01:31:07 2025] mmc0: sdhci: Present:   0x01ef0006 | Host
ctl: 0x00000007
[Sat Mar 29 01:31:07 2025] mmc0: sdhci: Power:     0x0000000f | Blk
gap:  0x00000000
[Sat Mar 29 01:31:07 2025] mmc0: sdhci: Wake-up:   0x00000000 | Clock:
   0x00000207
[Sat Mar 29 01:31:07 2025] mmc0: sdhci: Timeout:   0x0000000e | Int
stat: 0x00000000
[Sat Mar 29 01:31:07 2025] mmc0: sdhci: Int enab:  0x02ff008b | Sig
enab: 0x02ff008b
[Sat Mar 29 01:31:07 2025] mmc0: sdhci: ACmd stat: 0x00000000 | Slot
int: 0x000000ff
[Sat Mar 29 01:31:08 2025] mmc0: sdhci: Caps:      0x75fec8b2 |
Caps_1:   0x00002501
[Sat Mar 29 01:31:08 2025] mmc0: sdhci: Cmd:       0x0000193a | Max
curr: 0x00c80064
[Sat Mar 29 01:31:08 2025] mmc0: sdhci: Resp[0]:   0x00000900 |
Resp[1]:  0xffffffff
[Sat Mar 29 01:31:08 2025] mmc0: sdhci: Resp[2]:   0x320f5903 |
Resp[3]:  0x00d04f01
[Sat Mar 29 01:31:08 2025] mmc0: sdhci: Host ctl2: 0x00000000
[Sat Mar 29 01:31:08 2025] mmc0: sdhci:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[Sat Mar 29 01:31:10 2025] sdhci-pci 0000:00:14.7: Card stuck in wrong
state! card_busy_detect status: 0xe00
[Sat Mar 29 01:31:10 2025] mmc0: cache flush error -110
[Sat Mar 29 01:31:11 2025] mmc0: tried to HW reset card, got error -110

If I send a CMD25 with data->blocks as 0 and with the same 'Argument:'
value above for cmd->arg, I get a 10s timeout. I see that the cmd->arg
is the "device address" or the logical block address as seen by the
kernel.

Subsequent commands are failing with cmd->err as -110. CMD13 result
comes with resp as 0x400d00. I see that the irq count for the sdhci
controller goes up by 1 for each of these commands. Does it mean that
the host controller knows the state of the card and does not forward
the commands to the card?

Below are the eMMC traces on my box with CMD25 and above 'Argument:'
or dev_addr value:

            bash-3281  [000] .... 77826.075030: mmc_request_start:
mmc0: start struct mmc_request[00000000e720518c]: cmd_opcode=3D25
cmd_arg=3D0x45d1a8 cmd_flags=3D0x35 cmd_retries=3D0 stop_opcode=3D0
stop_arg=3D0x0 stop_flags=3D0x0 stop_retries=3D0 sbc_opcode=3D0 sbc_arg=3D0=
x0
sbc_flags=3D0x0 sbc_retires=3D0 blocks=3D0 block_size=3D512 blk_addr=3D0
data_flags=3D0x100 tag=3D0 can_retune=3D0 doing_retune=3D0 retune_now=3D0
need_retune=3D0 hold_retune=3D1 retune_period=3D0
            bash-3281  [000] ..s1 77826.076781: mmc_request_done:
mmc0: end struct mmc_request[00000000e720518c]: cmd_opcode=3D25
cmd_err=3D-110 cmd_resp=3D0x0 0x0 0x0 0x0 cmd_retries=3D0 stop_opcode=3D0
stop_err=3D0 stop_resp=3D0x0 0x0 0x0 0x0 stop_retries=3D0 sbc_opcode=3D0
sbc_err=3D0 sbc_resp=3D0x0 0x0 0x0 0x0 sbc_retries=3D0 bytes_xfered=3D0
data_err=3D0 tag=3D0 can_retune=3D0 doing_retune=3D0 retune_now=3D0
need_retune=3D0 hold_retune=3D1 retune_period=3D0
            bash-3281  [000] .... 77826.076841: mmc_request_start:
mmc0: start struct mmc_request[00000000e8466c12]: cmd_opcode=3D13
cmd_arg=3D0x10000 cmd_flags=3D0x15 cmd_retries=3D0 stop_opcode=3D0
stop_arg=3D0x0 stop_flags=3D0x0 stop_retries=3D0 sbc_opcode=3D0 sbc_arg=3D0=
x0
sbc_flags=3D0x0 sbc_retires=3D0 blocks=3D0 block_size=3D0 blk_addr=3D0
data_flags=3D0x0 tag=3D0 can_retune=3D0 doing_retune=3D0 retune_now=3D0
need_retune=3D0 hold_retune=3D1 retune_period=3D0
            bash-3281  [000] ..s. 77826.076879: mmc_request_done:
mmc0: end struct mmc_request[00000000e8466c12]: cmd_opcode=3D13
cmd_err=3D0 cmd_resp=3D0x400d00 0x0 0x0 0x0 cmd_retries=3D0 stop_opcode=3D0
stop_err=3D0 stop_resp=3D0x0 0x0 0x0 0x0 stop_retries=3D0 sbc_opcode=3D0
sbc_err=3D0 sbc_resp=3D0x0 0x0 0x0 0x0 sbc_retries=3D0 bytes_xfered=3D0
data_err=3D0 tag=3D0 can_retune=3D0 doing_retune=3D0 retune_now=3D0
need_retune=3D0 hold_retune=3D1 retune_period=3D0

Resetting the controller by the reset test (number 45) gets the
controller out of that state.

We are following up with the card vendor as well.

In what situations would the kernel frame up a CMD25 with 0 blocks?
Why does the controller or the card not like the dev_addr in the
cmd->arg field?

Thank you.


On Fri, Apr 25, 2025 at 1:38=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 4/25/25 05:59, Prasad Koya wrote:
> > Thanks Christian.
> >
> > I tried CMD25 with a different block size (mrq->data->blksz =3D 514) an=
d
> > I can see that the command was rejected with -EILSEQ (data->error =3D
> > -84). But the card wasn't stuck. After the command was rejected, I see
> > that the driver is sending CMD12 to signal the card the end of write.
> > I see this comment in sdhci.c. Is CMD25 called an "open-ended
> > multiblock transfer"?
>
> Yes indeed that's how that works.
> IIUC your hypothesis was "card gets stuck in busy when CMD25 data was sen=
t
> with an invalid CRC"? That hypothesis you can now reject. (For open-ended
> CMD25 anyway, you can also try CMD23+CMD25 and CMD24 writes).
>
> >
> > 1291     /*
> > 1292      * Need to send CMD12 if -
> > 1293      * a) open-ended multiblock transfer (no CMD23)
> > 1294      * b) error in multiblock transfer
> > 1295      */
> > 1296     if (data->stop &&
> > 1297         (data->error ||
> > 1298          !data->mrq->sbc)) {
> > :
> > 1308         } else {
> > 1309             /* Avoid triggering warning in sdhci_send_command() */
> > 1310             host->cmd =3D NULL;
> > 1311             sdhci_send_command(host, data->stop);
> > 1312         }
> >
> > Here are my emmc traces:
> >
> >             bash-10454 [000] ....  6902.122069: mmc_request_start:
> > mmc0: start struct mmc_request[0000000001eb0468]: cmd_opcode=3D25
> > cmd_arg=3D0x3a0000 cmd_flags=3D0x35 cmd_retries=3D0 stop_opcode=3D12
> > stop_arg=3D0x0 stop_flags=3D0x1d stop_retries=3D0 sbc_opcode=3D0 sbc_ar=
g=3D0x0
> > sbc_flags=3D0x0 sbc_retires=3D0 blocks=3D17 block_size=3D1719
> > blk_addr=3D15433700 data_flags=3D0x100 tag=3D0 can_retune=3D0 doing_ret=
une=3D0
> > retune_now=3D0 need_retune=3D0 hold_retune=3D1 retune_period=3D0
> >    rs:main Q:Reg-3221  [000] ..s.  6902.125240: mmc_request_done:
> > mmc0: end struct mmc_request[0000000001eb0468]: cmd_opcode=3D25
> > cmd_err=3D0 cmd_resp=3D0x900 0x0 0x0 0x0 cmd_retries=3D0 stop_opcode=3D=
12
> > stop_err=3D0 stop_resp=3D0xc00 0x0 0x0 0x0 stop_retries=3D0 sbc_opcode=
=3D0
> > sbc_err=3D0 sbc_resp=3D0x0 0x0 0x0 0x0 sbc_retries=3D0 bytes_xfered=3D0
> > data_err=3D-84 tag=3D0 can_retune=3D0 doing_retune=3D0 retune_now=3D0
> > need_retune=3D0 hold_retune=3D1 retune_period=3D0
> >             bash-10454 [000] ....  6902.126438: mmc_request_start:
> > mmc0: start struct mmc_request[000000001c8ae402]: cmd_opcode=3D13
> > cmd_arg=3D0x10000 cmd_flags=3D0x15 cmd_retries=3D0 stop_opcode=3D0
> > stop_arg=3D0x0 stop_flags=3D0x0 stop_retries=3D0 sbc_opcode=3D0 sbc_arg=
=3D0x0
> > sbc_flags=3D0x0 sbc_retires=3D0 blocks=3D0 block_size=3D0 blk_addr=3D0
> > data_flags=3D0x0 tag=3D0 can_retune=3D0 doing_retune=3D0 retune_now=3D0
> > need_retune=3D0 hold_retune=3D1 retune_period=3D0
> >             bash-10454 [000] ..s1  6902.126911: mmc_request_done:
> > mmc0: end struct mmc_request[000000001c8ae402]: cmd_opcode=3D13
> > cmd_err=3D0 cmd_resp=3D0x900 0x0 0x0 0x0 cmd_retries=3D0 stop_opcode=3D=
0
> > stop_err=3D0 stop_resp=3D0x0 0x0 0x0 0x0 stop_retries=3D0 sbc_opcode=3D=
0
> > sbc_err=3D0 sbc_resp=3D0x0 0x0 0x0 0x0 sbc_retries=3D0 bytes_xfered=3D0
> > data_err=3D0 tag=3D0 can_retune=3D0 doing_retune=3D0 retune_now=3D0
> > need_retune=3D0 hold_retune=3D1 retune_period=3D0
> >
> > For our customers, something from the host to the card gets the card
> > stuck. The status returned at that point is 0xe00. After CMD25 and
> > CMD12 that took 10s each to timeout, all subsequent commands from the
> > host fail immediately with -110 error.
>
> If the card is in busy it wont accept any new commands, so that's in
> line. The only question is why is it stuck in busy? (The spec
> mandates maximum busy times, they are sometimes violated by some card
> vendors (especially SD cards), but nothing on the order of 10s should be
> observed.)
> Have you contacted the card vendor about this? I don't see any hint
> on wrongdoing of the host here.
>
>
> > Is there any other forum where I can post such questions. I'm a newbie
> > to the driver. I'm looking at the JEDEC spec and trying to figure out
> > the implementation.
>
> Not that I'm aware of.
>
> >
> > Thanks.
> >
> >
> > On Tue, Apr 22, 2025 at 2:54=E2=80=AFPM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> >>
> >> On 4/22/25 18:37, Prasad Koya wrote:
> >>> Hi Christian
> >>>
> >>> Thanks for going over and replying.
> >>>
> >>> I couldn't find any ioctl() that changed host's block size in the 6.1=
4
> >>> tree. We are using 5.10 kernel.
> >>
> >> Works on any kernel since a long time.
> >> You can find a caller instance in mmc-utils: mmc_cmds.c, the field is
> >> called blksz, if you've already familiarized yourself with the test
> >> module I'd say don't bother though.
> >>
> >>>
> >>> I did try mmc_test module so I can modify an existing test case and
> >>> make it a simple one. Hacking this module, I could call CMD16 via
> >>> mmc_test_set_blksize() and set the block size to 514 (0x202). Below
> >>> are the eMMC traces for this test. A CMD16, followed by CMD25 with
> >>> data, stop opcode and then CMD13. The multi-block write seems to go
> >>> fine.
> >>
> >> Sorry, misunderstanding here. I meant changing the blocksize of the
> >> transfer for the host *without* letting the card know (by issuing CMD1=
6).
> >> So leave out the CMD16 part and you should achieve what you want.
> >>
> >>>
> >>>             bash-3958  [001] .... 34861.450688: mmc_request_start:
> >>> mmc0: start struct mmc_request[00000000fe878338]: cmd_opcode=3D16
> >>> cmd_arg=3D0x202 cmd_flags=3D0x95 cmd_retries=3D5 stop_opcode=3D0 stop=
_arg=3D0x0
> >>> stop_flags=3D0x0 stop_retries=3D0 sbc_opcode=3D0 sbc_arg=3D0x0 sbc_fl=
ags=3D0x0
> >>> sbc_retires=3D0 blocks=3D0 block_size=3D0 blk_addr=3D0 data_flags=3D0=
x0 tag=3D0
> >>> can_retune=3D0 doing_retune=3D0 retune_now=3D0 need_retune=3D0 hold_r=
etune=3D1
> >>> retune_period=3D0
> >>>        in:imklog-2971  [000] ..s. 34861.450737: mmc_request_done:
> >>> mmc0: end struct mmc_request[00000000fe878338]: cmd_opcode=3D16
> >>> cmd_err=3D0 cmd_resp=3D0x20000900 0x0 0x0 0x0 cmd_retries=3D5 stop_op=
code=3D0
> >>> stop_err=3D0 stop_resp=3D0x0 0x0 0x0 0x0 stop_retries=3D0 sbc_opcode=
=3D0
> >>> sbc_err=3D0 sbc_resp=3D0x0 0x0 0x0 0x0 sbc_retries=3D0 bytes_xfered=
=3D0
> >>> data_err=3D0 tag=3D0 can_retune=3D0 doing_retune=3D0 retune_now=3D0
> >>> need_retune=3D0 hold_retune=3D1 retune_period=3D0
> >>>             bash-3958  [001] .... 34861.451064: mmc_request_start:
> >>> mmc0: start struct mmc_request[00000000c2f30356]: cmd_opcode=3D25
> >>> cmd_arg=3D0x3a0000 cmd_flags=3D0x35 cmd_retries=3D0 stop_opcode=3D12
> >>> stop_arg=3D0x0 stop_flags=3D0x1d stop_retries=3D0 sbc_opcode=3D0 sbc_=
arg=3D0x0
> >>> sbc_flags=3D0x0 sbc_retires=3D0 blocks=3D128 block_size=3D512 blk_add=
r=3D0
> >>> data_flags=3D0x100 tag=3D0 can_retune=3D0 doing_retune=3D0 retune_now=
=3D0
> >>> need_retune=3D0 hold_retune=3D1 retune_period=3D0
> >>>           <idle>-0     [000] ..s1 34861.456533: mmc_request_done:
> >>> mmc0: end struct mmc_request[00000000c2f30356]: cmd_opcode=3D25
> >>> cmd_err=3D0 cmd_resp=3D0x900 0x0 0x0 0x0 cmd_retries=3D0 stop_opcode=
=3D12
> >>> stop_err=3D0 stop_resp=3D0xc00 0x0 0x0 0x0 stop_retries=3D0 sbc_opcod=
e=3D0
> >>> sbc_err=3D0 sbc_resp=3D0x0 0x0 0x0 0x0 sbc_retries=3D0 bytes_xfered=
=3D65536
> >>> data_err=3D0 tag=3D0 can_retune=3D0 doing_retune=3D0 retune_now=3D0
> >>> need_retune=3D0 hold_retune=3D1 retune_period=3D0
> >>>             bash-3958  [001] .... 34861.456562: mmc_request_start:
> >>> mmc0: start struct mmc_request[00000000e93d6161]: cmd_opcode=3D13
> >>> cmd_arg=3D0x10000 cmd_flags=3D0x15 cmd_retries=3D0 stop_opcode=3D0
> >>> stop_arg=3D0x0 stop_flags=3D0x0 stop_retries=3D0 sbc_opcode=3D0 sbc_a=
rg=3D0x0
> >>> sbc_flags=3D0x0 sbc_retires=3D0 blocks=3D0 block_size=3D0 blk_addr=3D=
0
> >>> data_flags=3D0x0 tag=3D0 can_retune=3D0 doing_retune=3D0 retune_now=
=3D0
> >>> need_retune=3D0 hold_retune=3D1 retune_period=3D0
> >>>    rs:main Q:Reg-2972  [000] ..s. 34861.456688: mmc_request_done:
> >>> mmc0: end struct mmc_request[00000000e93d6161]: cmd_opcode=3D13
> >>> cmd_err=3D0 cmd_resp=3D0x900 0x0 0x0 0x0 cmd_retries=3D0 stop_opcode=
=3D0
> >>> stop_err=3D0 stop_resp=3D0x0 0x0 0x0 0x0 stop_retries=3D0 sbc_opcode=
=3D0
> >>> sbc_err=3D0 sbc_resp=3D0x0 0x0 0x0 0x0 sbc_retries=3D0 bytes_xfered=
=3D0
> >>> data_err=3D0 tag=3D0 can_retune=3D0 doing_retune=3D0 retune_now=3D0
> >>> need_retune=3D0 hold_retune=3D1 retune_period=3D0
> >>>
> >>> What we believe could be happening is an SEU that flips a bit in the
> >>> data block after the host controller has sent the block on the DAT
> >>> lines. Card should reject that after CRC mismatch. Does the card
> >>> reject the command right when it sees a CRC mismatch or does it have
> >>> to wait till all blocks and CMD12 is sent by the host?
> >>
> >> Open writes with CMD25-CMD12 indeed send all blocks until the card
> >> can signal CRC error.
> >>
> >>>
> >>> Thank you.
> >>>
> >>>
> >>>
> >>> On Wed, Apr 16, 2025 at 2:13=E2=80=AFAM Christian Loehle
> >>> <christian.loehle@arm.com> wrote:
> >>>>
> >>>> On 4/16/25 01:13, Prasad Koya wrote:
> >>>>> Hi
> >>>>>
> >>>>> We use eMMC as a boot drive. At a random time, maybe a month or an
> >>>>> year of uptime, we run into an issue where we see the eMMC driver
> >>>>> prints this in the kernel logs and the drive no longer responds aft=
er
> >>>>> that. We see this issue in the field on linux kernel 4.19.142 and
> >>>>> 5.10.165. From the SDHCI register dump, it looks like CMD25 ran int=
o a
> >>>>> timeout first. After the first timeout, we see CMD12 in the second
> >>>>> SDHCI register dump. Status returned by the card at that point in
> >>>>> card_busy_detect() is 0xE00.
> >>>>>
> >>>>> I looked at the recent commits up to 6.15 and I do not see anything
> >>>>> obvious that addresses issue like below.
> >>>>>
> >>>>> We are trying to reproduce the issue in our lab and understand the
> >>>>> driver code. Is there a way I can send a block of data as part of
> >>>>> CMD25 with invalid CRC?  Appreciate any pointers.
> >>>>
> >>>> CRC is appended by hardware, so it will always be correct.
> >>>> What you can do though is change the blocksize of the transfer on th=
e
> >>>> host side (e.g. from 512 to 514 bytes) without changing it using CMD=
16.
> >>>> The 2 bytes will be latched in as CRC by the card. Of course you won=
't
> >>>> see the CRC ACK from the card in that case (as it clashes with the
> >>>> hardware CRC signal from the host).
> >>>> You can do all this using the ioctl interface in userspace btw.
> >>
>
