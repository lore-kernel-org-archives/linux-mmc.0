Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBFC1CF5FF;
	Mon, 21 Oct 2024 19:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729539175; cv=none; b=FDIUGWEwcLfAPSuzTTsPFx5UUiI9EUiwkKcCCXgmeKbFBXHxXvfkdBCNBPC5ywjlKdfZezUnQtmnGNiI2fBrNSlrU6MHbolUpSBvtOuCSGsuhQHS+fQ7uRmQrzVX5E6U8TUI7tSoRnvrkyjmUUFQ8hSeqNmJHXDD17LPKsiVGx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729539175; c=relaxed/simple;
	bh=4V0XjPga2xSDbOxPLy28D8hsComjHbPPkvsqyU7inZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ICosUMD1Srix4ZNbpc2tyf7K1gteM8BpW4SWQnrJ/9t66eFytPY+i2JmBQRwAYuhkwnAoFaET1e0VomZcfFrnUleHmGHcJId8kMtJ9pvwmKRVRPwSBnsh8uYGidnc2oqcglEyuGzRqnhGhx/BX/jw4M9UuedNa53unK/D3K3fjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jg1tVtvc; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jg1tVtvc"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a850270e2so401347966b.0;
        Mon, 21 Oct 2024 12:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729539171; x=1730143971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mEFsjrwg2muYYcaLlxcwnMxP+84IdSFbixovGhqXIY=;
        b=jg1tVtvcpp59yyOqxIpyEVOFcKJBhhiHzV8OI8kZ3oZkV2cq1uo+Nrc0v2daNmRt4Z
         vuTEenkDNDnQLfoZxLI1aavHQ4nMXbA4VhguY0B/9ks6g727ybmvIwiH/j8TyQVr/Anm
         cBub5biSTW/1haOMx5+M7zViRoHIg6xob+tKmPNmvKddV99mdUCWgWGsJ9Ck7TbiSP8n
         hsT9ApD9r3+a0ddWCz5ShJ677gIuzEMOEUSZcRtTVe5a2wFsC2UJgGeaXN2c37PVEOOa
         4d+7bNtkWpJf4uxy4AvsiLUfxz5mCoh/8dAwEWttxjds59xSIgQElJbb3n2BGRkLoiTx
         h+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729539171; x=1730143971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mEFsjrwg2muYYcaLlxcwnMxP+84IdSFbixovGhqXIY=;
        b=w6i6QPRt0UtVOhFdPtZnoYSFnfZ68sbcE3KNC5d7ithm81CYdxVJX/m0YHYNcyWhrX
         55oGAZtpLOgeLA1HR4FHFsfJdQv3ynZGWjxPvfeDNUCduOnl2eZaz2e7chs42QSs3dea
         fyBj0dH9vMNwrJfvpp61p4Lzel/AItsd4aM5/5IZe8jOAXo1zN39ggESVjP5Ezu9SYYu
         yJ4kS4XlaZhdisaLfVwZZK9iEQhy2tzO7UVclsR9cJC8JiipSefwLMI1sVtkU+TQgBBl
         ew5slu0DbAHHIzpA4ORYEo52pDPrLPYO5HKnwXfJHyoZrzgPeqozPy/lyEdabK7aWR4v
         xEhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe2crqm+JnihhPeXBuLDD7VUABnAb+B+/A/iBkv9mLTxv5f5vfbrlIQ0IUfrVts4839LA4iT0UTZwC@vger.kernel.org, AJvYcCXi412gjxLfOxG+AavulEl8jQEuenYNpeh2xuPnchqvlEfmlAYExaPRjX2/wr066qdhoq7va3F7MWm7Jvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkm9ymaiC3f9xdiNG7QTtimtl5o8DXb8rZTW1d67qfJPBdaWXC
	Nq8fCi8q5fbbOkpq2kboyD4k+GQqjWJ3kHNPw83dQ/N6Ls0dIIpBe4Jprcpcs12cVtstoshZHMG
	bH7Ww2ca4bltchmkw9BITLHS623fDH0N2Luk=
X-Google-Smtp-Source: AGHT+IFAMNL98PLu/k+jvmf7Yek3FMK4f/dR36xw0cjFwF39PNW5JD+YHqfnsaaGB0pBSLcqlkcepqOlVX6xXZKXLOo=
X-Received: by 2002:a17:907:3f1c:b0:a9a:161:7863 with SMTP id
 a640c23a62f3a-a9a69de760fmr1151459366b.58.1729539171233; Mon, 21 Oct 2024
 12:32:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC8uq=Ppnmv98mpa1CrWLawWoPnu5abtU69v-=G-P7ysATQ2Pw@mail.gmail.com>
 <3748add3-18e5-42ef-9d48-93650cfc0682@rock-chips.com> <CAC8uq=O=519iRpcs7p+jZaKngkCDuawLz8NVZYORY6qfGPifZg@mail.gmail.com>
 <eb1d15dd-8e85-4a9b-9b8b-ee005c446bf6@rock-chips.com> <CAPDyKFr6oDxdc2UhMvAh885dofF1EeT17Ch_Fp-9f2Yvf-654A@mail.gmail.com>
In-Reply-To: <CAPDyKFr6oDxdc2UhMvAh885dofF1EeT17Ch_Fp-9f2Yvf-654A@mail.gmail.com>
From: Adam Green <greena88@gmail.com>
Date: Mon, 21 Oct 2024 20:32:40 +0100
Message-ID: <CAC8uq=NNBCmtNamvcSHbdv7U99iE6L=teRz9eZ-nJDKx4PMuFw@mail.gmail.com>
Subject: Re: Unable to handle kernel paging request at virtual address ffffffc08058e000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org, sydarn@proton.me, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uffe,

I have tried the linked patch on both 6.11.4 and next-20241021 and can
confirm that the problem is still present,

Best regards,

Adam

On Mon, 21 Oct 2024 at 14:30, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 18 Oct 2024 at 05:43, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> >
> > + Sam
> >
> > =E5=9C=A8 2024/10/18 8:06, Adam Green =E5=86=99=E9=81=93:
> > > Hi Shawn,
> > >
> > > I can confirm that after reverting
> > >
> > > commit 8396c793ffdf28bb8aee7cfe0891080f8cab7890
> > > Author: Sam Protsenko <semen.protsenko@linaro.org>
> > > Date:   Wed Mar 6 17:20:52 2024 -0600
> > >
> > >      mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K
> > >
> > > that the problem does appear to have resolved itself, I tested this o=
n
> > > a variety of devices.
> > >
> >
> > I'm confused about the patch. Doesn't max_seg_size stand for max bytes
> > per IDMA descriptor can handle?  How can it be equal to max_req_size
> > which should be max_seq_size * max_segs=EF=BC=88max_segs is IDMAC descr=
iptors
> > number can be used=EF=BC=89 ?
> >
> >   /* Each descriptor can transfer up to 4KB of data in chained mode */
> >   #define DW_MCI_DESC_DATA_LENGTH 0x1000
> >
>
> Does the below patch fix the problem too?
>
> https://lore.kernel.org/lkml/20241020142931.138277-1-aurelien@aurel32.net=
/T/
>
> Kind regards
> Uffe
>
> >
> > > Best regards,
> > >
> > > Adam
> > >
> > > On Wed, 16 Oct 2024 at 11:13, Shawn Lin <shawn.lin@rock-chips.com> wr=
ote:
> > >>
> > >> =E5=9C=A8 2024/10/16 17:55, Adam Green =E5=86=99=E9=81=93:
> > >>> Good morning,
> > >>>
> > >>> I would like to report a regression that appears to have been
> > >>> introduced into the linux kernel since v6.9.
> > >>>
> > >>
> > >> I didn't see many patches for dw_mmc since 6.9. So I guess the faste=
st
> > >> way is to do a bisect. Or maybe you could try reverting this commit
> > >> first to see what will happen.
> > >>
> > >> commit 8396c793ffdf28bb8aee7cfe0891080f8cab7890
> > >> Author: Sam Protsenko <semen.protsenko@linaro.org>
> > >> Date:   Wed Mar 6 17:20:52 2024 -0600
> > >>
> > >>       mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K
> > >>
> > >>
> > >>> My device is currently experiencing a panic booting the kernel/root=
fs
> > >>> from an SD card.
> > >>>
> > >>> The device is a Powkiddy RGB30 which is a portable handheld gaming
> > >>> console with a Rockchip RK3566 SoC (arm64).
> > >>>
> > >>> I have tested a variety of devices from a couple of manufacturers w=
ith
> > >>> the same SoC and they all have the same issue,
> > >>> I have also tested, 6.12-rc3 and linux-next and the same issue appe=
ars present.
> > >>>
> > >>> A full UART dump can be found here: https://clbin.com/zLZAW
> > >>>
> > >>> [   41.547983] Unable to handle kernel paging request at virtual
> > >>> address ffffffc08058e000
> > >>> [   41.553426] Mem abort info:
> > >>> [   41.558231]   ESR =3D 0x0000000096000007
> > >>> [   41.563115]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > >>> [   41.568135]   SET =3D 0, FnV =3D 0
> > >>> [   41.572882]   EA =3D 0, S1PTW =3D 0
> > >>> [   41.577575]   FSC =3D 0x07: level 3 translation fault
> > >>> [   41.582404] Data abort info:
> > >>> [   41.586995]   ISV =3D 0, ISS =3D 0x00000007, ISS2 =3D 0x00000000
> > >>> [   41.591848]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > >>> [   41.596664]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > >>> [   41.601457] swapper pgtable: 4k pages, 39-bit VAs, pgdp=3D000000=
000363e000
> > >>> [   41.606359] [ffffffc08058e000] pgd=3D1000000000225003,
> > >>> p4d=3D1000000000225003, pud=3D1000000000225003, pmd=3D1000000000c8c=
003,
> > >>> pte=3D0000000000000000
> > >>> [   41.616442] Internal error: Oops: 0000000096000007 [#1] PREEMPT =
SMP
> > >>> [   41.621544] Modules linked in: hci_uart btrtl bluetooth rfkill
> > >>> [   41.626678] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.1=
2.0-rc2 #1
> > >>> [   41.631922] Hardware name: Powkiddy RGB30 (DT)
> > >>> [   41.636951] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSB=
S BTYPE=3D--)
> > >>> [   41.642330] pc : dw_mci_idmac_start_dma+0xa0/0x358
> > >>> [   41.647585] lr : __dw_mci_start_request+0x21c/0x6a0
> > >>> [   41.652827] sp : ffffffc080003da0
> > >>> [   41.657882] x29: ffffffc080003da0 x28: ffffff8001f06d80 x27: fff=
fffc08058d000
> > >>> [   41.663399] x26: ffffffc08058e000 x25: 0000000000002711 x24: 000=
0000000002000
> > >>> [   41.668864] x23: ffffff800167dc80 x22: 0000000080000012 x21: 000=
0000000001000
> > >>> [   41.674257] x20: 000000003b5d1000 x19: 0000000000001000 x18: 000=
0000972073a81
> > >>> [   41.679654] x17: ffffff9c39b47000 x16: ffffffc080000000 x15: 000=
0000000000001
> > >>> [   41.685074] x14: 0000000000000004 x13: 000001ba5087c8e8 x12: 000=
00000000001a8
> > >>> [   41.690506] x11: 0000000000000040 x10: ffffffe40628d890 x9 : 000=
0000000000000
> > >>> [   41.695972] x8 : ffffff803fd44080 x7 : 0000000008f0d180 x6 : 000=
000003b9ac9ff
> > >>> [   41.701495] x5 : 0000000000fffffe x4 : ffffffc08058de80 x3 : 000=
00000b2d05e00
> > >>> [   41.707073] x2 : ffffffe40546ab08 x1 : ffffffc08058e000 x0 : 000=
0000000001000
> > >>> [   41.712686] Call trace:
> > >>> [   41.717857]  dw_mci_idmac_start_dma+0xa0/0x358
> > >>> [   41.723266]  __dw_mci_start_request+0x21c/0x6a0
> > >>> [   41.728719]  dw_mci_work_func+0x4c8/0x4d8
> > >>> [   41.734144]  process_one_work+0x148/0x284
> > >>> [   41.739587]  bh_worker+0x224/0x278
> > >>> [   41.744985]  workqueue_softirq_action+0x78/0x88
> > >>> [   41.750545]  tasklet_action+0x14/0x3c
> > >>> [   41.756023]  handle_softirqs+0x100/0x23c
> > >>> [   41.761506]  __do_softirq+0x14/0x20
> > >>> [   41.766917]  ____do_softirq+0x10/0x20
> > >>> [   41.772301]  call_on_irq_stack+0x24/0x54
> > >>> [   41.777689]  do_softirq_own_stack+0x1c/0x40
> > >>> [   41.783106]  irq_exit_rcu+0x94/0xd0
> > >>> [   41.788455]  el1_interrupt+0x38/0x68
> > >>> [   41.793799]  el1h_64_irq_handler+0x18/0x24
> > >>> [   41.799200]  el1h_64_irq+0x68/0x6c
> > >>> [   41.804532]  default_idle_call+0x28/0x58
> > >>> [   41.809931]  do_idle+0x1fc/0x260
> > >>> [   41.815152]  cpu_startup_entry+0x34/0x40
> > >>> [   41.820346]  kernel_init+0x0/0x140
> > >>> [   41.825437]  console_on_rootfs+0x0/0x6c
> > >>> [   41.830477]  __primary_switched+0x80/0x88
> > >>> [   41.835501] Code: 54000280 d294f8c0 940e1f8c d503203f (b9400340)
> > >>> [   41.840748] ---[ end trace 0000000000000000 ]---
> > >>> [   41.845896] Kernel panic - not syncing: Oops: Fatal exception in=
 interrupt
> > >>> [   41.851321] SMP: stopping secondary CPUs
> > >>> [   41.856502] Kernel Offset: 0x2384800000 from 0xffffffc080000000
> > >>> [   41.861840] PHYS_OFFSET: 0x0
> > >>> [   41.866814] CPU features: 0x0c,00000014,00280928,4201720b
> > >>> [   41.872087] Memory Limit: none
> > >>> [   41.877119] Rebooting in 1 seconds..
> > >>>
> > >>> Best regards,
> > >>>
> > >>> Adam Green
> > >>
> >
