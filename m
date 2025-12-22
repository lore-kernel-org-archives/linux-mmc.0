Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7992F3C22
	for <linux-mmc@vger.kernel.org>; Mon, 22 Dec 2025 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766414053; cv=none; b=LeNYdqHQBux8fqJHg40X+Tg6pPTeCjtDR9ugvA21ME8ecwKRRKjrWf7jV7m0bJPPygnlsDnTnz41vYRKbOhQKBN/PAcT0MF8eXE1v4zd6L5fX88iHXHtXeSnl+ZRBJHn9C0DFNDT8SdnhvhvdFbC6RnscL8ZicEmurz9KGn18H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766414053; c=relaxed/simple;
	bh=lQy+mZKi5UggTVO+Sm8J/mQBT4hp+xc7B/gNeXEWEno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1pe2ObLYwhk4eXJDowkiRP2pbhEOZM0pd4Ee3dvjbsapB/RmPqTD7nb1EIwTjPP1IQoVkjTOvlnO/pxaq5zUgdHl9OvsePZKKnDBzc4dvtY4ueU7BKsyroTuh3VV5Kydc27Apf64Ua8WitNhng/cwwSIO/VfpnuFAiofIjGW6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CfQDxQ3V; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CfQDxQ3V"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-37fccf7035aso32643851fa.1
        for <linux-mmc@vger.kernel.org>; Mon, 22 Dec 2025 06:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766414049; x=1767018849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgxY+6gEj9UygqLRNsiMXRwa1dAq3NfGydbYraAyFIg=;
        b=CfQDxQ3VJ2rhE5+S9FABAC7tWaJL8aHWPQOtJE6rHvqphgM3lNR6TtJmAV7LC7NtIs
         aAbG2ZtZJin9L+4iTHKfvegdxpepvq9Gro3HHWB5JzNqrD8JmFn2ulFZXCZyfsjGsqRe
         o5mJ2DSQCNYnIVGHcc/LtYTQE5lPM9deYbLrgCLQGfHNKzyNcuk5THfbWcyCXQ+fQZ6R
         8RlfXL9Z3PWU7NlLuzla4bjp4RYK/p3M86k3XI+AoI/h8vXbkMa9qIk0XNSWE2yV8K/l
         9aLyyLMIyLZQ+CaGEbSJxtpAO5wYanjoSzo4h5bN5MfdKfv6Yh3nPnMNkHyxxJlkAwHE
         jJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766414049; x=1767018849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sgxY+6gEj9UygqLRNsiMXRwa1dAq3NfGydbYraAyFIg=;
        b=MKDHbrjHU6aCTmxn9VM31CwqSECzvdJWWTSiKII8YegYOiT9a/1Y7gGzTxUDUAl9OG
         K4PNhahaFU1COAkcpldqjMl81xbRKFXhljNm9OGzRMEInQ9eCPRq//WNzKxBxaEI/6f+
         TVEYQcq6+FCapZHMRPrs6Mzwa8EnI3ojHz1MZzGTQDWCaNFGx0hd5dkkpLYV67E32jFP
         uIw6qx+H+jZzsll5CrskwfF99XQpp23XHUtrjvIb+CyHvnXE1ySSmklmZp5kDfgk7ird
         tVoMjZvZl9hFZfjZONwU8Tl1/pUiVN7Ek/Gufa16eRRE+2zRLHU1OAQfhJsl/g78SyFN
         EP+w==
X-Gm-Message-State: AOJu0YxQhZ9GnFRrQmY2BWivGJ34wRNCbLOUldSz3xFQawmpfNcHo7NX
	oWv20d33MK7aC3scwy7r+b/WYyKLYuK8xkveOwkvx0UOL8TB5z+7Y7NqM0nDsnGqW4kWti33kks
	2Nft5jBdSNAmf5agLnnEIeIkU0kZgqM3TumLEx/wi7Q==
X-Gm-Gg: AY/fxX7N5EQLhWfqshWq6ti5cmb2+8i4nUB6StKxacpJflUGnjJ0xmW5ReXhmkymVt6
	q3+dKuK2m3N8p9UwTFP4sQF9vDvVr4MzoFtdQcpI8vAEcv+degfeSvak8q7YO9eucCfuFDf+ajO
	SX2VEaP2sqapZwBrmomP1YLT8H9atAsRxtEccbSEwVQKle2Ld9tPtG1OUmW/FFbSleXUsck3YmL
	HJKqgUFr21RLRS3lPHEZQzbDddWHUXcTj36tPveTwvgBwa8qBu9CkhWdNZWw7MTm+KOnNsf
X-Google-Smtp-Source: AGHT+IGIPsRxALBUVnYOYWNLB0WNW65j6NC13aWbk1SAhBORoZX4/yL+g8ZSROEA5Dom8QWAKwN/DPnOMa/o/SUXpp0=
X-Received: by 2002:a05:651c:210c:b0:37f:cd21:6ad2 with SMTP id
 38308e7fff4ca-3812162165cmr37841061fa.20.1766414049184; Mon, 22 Dec 2025
 06:34:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH1aAjJbA08ErU_NMhNDGcNfWgap+G0Fk-Ba-AgfpZcc8zHd=Q@mail.gmail.com>
 <CAPDyKFrzzLTCYZnr0RFDc0NnPbeUMZzb-2NjXJZa3Q1qQ+OpTg@mail.gmail.com> <ME6PR01MB10557F6B9C1FAF3760C56A2A6AAB7A@ME6PR01MB10557.ausprd01.prod.outlook.com>
In-Reply-To: <ME6PR01MB10557F6B9C1FAF3760C56A2A6AAB7A@ME6PR01MB10557.ausprd01.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 22 Dec 2025 15:33:32 +0100
X-Gm-Features: AQt7F2qP8ilrhBMmLj2emHB8eNHp8DzUto03N9FSiaG1_5NcZ-DVtthR66GKtV4
Message-ID: <CAPDyKFo0ZbEnpA0A8Qv+FEXctyM=UEak_vaD7_NFaw44oz3zoQ@mail.gmail.com>
Subject: Re: Issue with Realtek PCI SD card driver
To: JP Dehollain <jpdehollain@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, =?UTF-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 21 Dec 2025 at 04:19, JP Dehollain <jpdehollain@gmail.com> wrote:
>
> Thanks Uffe!
>
> It took me some effort to figure out how to make and load the patched dri=
ver properly in my system, but it seems to be working fine now!

That's great news! So we should probably send the corresponding patch
to stable kernels too, as currently it's included from v6.18 and
onwards.

Is it something that you want to look into? Otherwise I can certainly
do it, but it may take some time before I get to it.

>
> Thanks to all of you for all the maintaining work =E2=9D=A4=EF=B8=8F
>
> Cheers,
> JP

Thanks and kind regards
Uffe

> ________________________________
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Sent: Thursday, December 11, 2025 9:56:49 PM
> To: JP Dehollain <jpdehollain@gmail.com>
> Cc: linux-mmc@vger.kernel.org <linux-mmc@vger.kernel.org>; =E5=90=B3=E6=
=98=8A=E6=BE=84 Ricky <ricky_wu@realtek.com>
> Subject: Re: Issue with Realtek PCI SD card driver
>
> + Ricky Wu (the main developer of the driver)
>
> On Thu, 11 Dec 2025 at 10:05, JP Dehollain <jpdehollain@gmail.com> wrote:
> >
> > Dear mmc kernel driver mantainers,
> >
> > When I insert an SD card in the integrated card reader in my laptop, mo=
st of the time the card gets recognised as read-only, even though the physi=
cal switch is in the unlocked position. If I remove and reinsert the card s=
everal times without unmounting it in the OS, I can eventually get it to lo=
ad in rw mode.
> >
> > I am using Zorin 18, with linux kernel 6.14.
> > Attached below is the output of dmesg showing several attempts to remov=
e and reload, until it reloads in rw in line [10281.365508].
> >
> > Please let me know if there any other logs and tests I can send or perf=
orm to help resolve the issue.
>
> I found one interesting commit that may be worth trying:
>
> commit 807221d3c5ff ("misc: rtsx_pci: Add separate CD/WP pin polarity
> reversal support").
>
> Not sure if it applies on v6.14 kernel, but I suggest giving it a try.
> Or try the latest kernel, v6.18. I have also looped in Ricky Wu, to
> see if he is able to help out.
>
> Kind regards
> Uffe
>
> >
> > Best regards,
> > JP
> > jpdehollain
> >
> >  [ 9367.567443] Generic FE-GE Realtek PHY r8169-0-201:00: attached PHY =
driver (mii_bus:phy_addr=3Dr8169-0-201:00, irq=3DMAC)
> > [ 9367.568438] Bluetooth: MGMT ver 1.23
> > [ 9367.738206] r8169 0000:02:00.1 enp2s0f1: Link is Down
> > [ 9375.195026] wlp3s0: authenticate with c0:fd:84:c2:04:ac (local addre=
ss=3D40:b8:9a:b9:34:e1)
> > [ 9375.195036] wlp3s0: send auth to c0:fd:84:c2:04:ac (try 1/3)
> > [ 9375.195935] wlp3s0: authenticated
> > [ 9375.196946] wlp3s0: associate with c0:fd:84:c2:04:ac (try 1/3)
> > [ 9375.198285] wlp3s0: RX AssocResp from c0:fd:84:c2:04:ac (capab=3D0x1=
011 status=3D0 aid=3D6)
> > [ 9375.200886] wlp3s0: associated
> > [ 9377.256424] rfkill: input handler enabled
> > [ 9377.260100] rfkill: input handler disabled
> > [ 9378.855243] lockdown_is_locked_down: 2 callbacks suppressed
> > [ 9378.855248] Lockdown: systemd-logind: hibernation is restricted; see=
 man kernel_lockdown.7
> > [ 9842.321650] mmc0: cannot verify signal voltage switch
> > [ 9842.474907] mmc0: new UHS-I speed SDR104 SDHC card at address 0001
> > [ 9842.475878] mmcblk0: mmc0:0001 SD32G 29.1 GiB (ro)
> > [ 9842.478394]  mmcblk0: p1
> > [ 9842.672905] /dev/mmcblk0p1: Can't open blockdev
> > [ 9884.098398] mmc0: card 0001 removed
> > [ 9898.560801] mmc0: cannot verify signal voltage switch
> > [ 9898.716638] mmc0: new UHS-I speed SDR104 SDHC card at address 0001
> > [ 9898.717583] mmcblk0: mmc0:0001 SD32G 29.1 GiB (ro)
> > [ 9898.720430]  mmcblk0: p1
> > [ 9898.901398] /dev/mmcblk0p1: Can't open blockdev
> > [ 9926.650920] mmc0: card 0001 removed
> > [ 9932.079104] mmc0: cannot verify signal voltage switch
> > [ 9932.233022] mmc0: new UHS-I speed SDR104 SDHC card at address 0001
> > [ 9932.233814] mmcblk0: mmc0:0001 SD32G 29.1 GiB (ro)
> > [ 9932.236526]  mmcblk0: p1
> > [ 9932.417077] /dev/mmcblk0p1: Can't open blockdev
> > [ 9945.675206] mmc0: card 0001 removed
> > [ 9954.348559] mmc0: cannot verify signal voltage switch
> > [ 9954.505148] mmc0: new UHS-I speed SDR104 SDHC card at address 0001
> > [ 9954.505892] mmcblk0: mmc0:0001 SD32G 29.1 GiB (ro)
> > [ 9954.508907]  mmcblk0: p1
> > [ 9954.688774] /dev/mmcblk0p1: Can't open blockdev
> > [ 9969.099540] mmc0: card 0001 removed
> > [ 9975.967776] mmc0: cannot verify signal voltage switch
> > [ 9976.123568] mmc0: new UHS-I speed SDR104 SDHC card at address 0001
> > [ 9976.124400] mmcblk0: mmc0:0001 SD32G 29.1 GiB (ro)
> > [ 9976.127501]  mmcblk0: p1
> > [ 9976.308274] /dev/mmcblk0p1: Can't open blockdev
> > [ 9989.339754] mmc0: card 0001 removed
> > [ 9998.751059] mmc0: cannot verify signal voltage switch
> > [ 9998.908154] mmc0: new UHS-I speed SDR104 SDHC card at address 0001
> > [ 9998.909036] mmcblk0: mmc0:0001 SD32G 29.1 GiB (ro)
> > [ 9998.911611]  mmcblk0: p1
> > [ 9999.088417] /dev/mmcblk0p1: Can't open blockdev
> > [10039.268493] mmc0: card 0001 removed
> > [10046.108371] perf: interrupt took too long (3167 > 3166), lowering ke=
rnel.perf_event_max_sample_rate to 63000
> > [10049.398057] mmc0: cannot verify signal voltage switch
> > [10049.554751] mmc0: new UHS-I speed SDR104 SDHC card at address 0001
> > [10049.555751] mmcblk0: mmc0:0001 SD32G 29.1 GiB (ro)
> > [10049.558524]  mmcblk0: p1
> > [10049.735565] /dev/mmcblk0p1: Can't open blockdev
> > [10069.188896] mmc0: card 0001 removed
> > [10076.400515] mmc0: cannot verify signal voltage switch
> > [10076.556156] mmc0: new UHS-I speed SDR104 SDHC card at address 0001
> > [10076.556990] mmcblk0: mmc0:0001 SD32G 29.1 GiB (ro)
> > [10076.559495]  mmcblk0: p1
> > [10076.744822] /dev/mmcblk0p1: Can't open blockdev
> > [10097.512910] capability: warning: `gvfsd-admin' uses 32-bit capabilit=
ies (legacy support in use)
> > [10160.142113] mmc0: card 0001 removed
> > [10166.327484] mmc0: cannot verify signal voltage switch
> > [10166.483689] mmc0: new UHS-I speed SDR104 SDHC card at address 0001
> > [10166.484452] mmcblk0: mmc0:0001 SD32G 29.1 GiB (ro)
> > [10166.486831]  mmcblk0: p1
> > [10166.673519] /dev/mmcblk0p1: Can't open blockdev
> > [10209.382671] mmc0: card 0001 removed
> > [10213.541830] mmc0: cannot verify signal voltage switch
> > [10213.698167] mmc0: new UHS-I speed SDR104 SDHC card at address 0001
> > [10213.698682] mmcblk0: mmc0:0001 SD32G 29.1 GiB (ro)
> > [10213.701071]  mmcblk0: p1
> > [10213.879510] /dev/mmcblk0p1: Can't open blockdev
> > [10233.767001] mmc0: card 0001 removed
> > [10241.604535] mmc0: cannot verify signal voltage switch
> > [10241.760000] mmc0: new UHS-I speed SDR104 SDHC card at address 0001
> > [10241.760727] mmcblk0: mmc0:0001 SD32G 29.1 GiB (ro)
> > [10241.763414]  mmcblk0: p1
> > [10241.942084] /dev/mmcblk0p1: Can't open blockdev
> > [10253.143302] mmc0: card 0001 removed
> > [10257.346355] mmc0: cannot verify signal voltage switch
> > [10257.501510] mmc0: new UHS-I speed SDR104 SDHC card at address 0001
> > [10257.502301] mmcblk0: mmc0:0001 SD32G 29.1 GiB (ro)
> > [10257.504889]  mmcblk0: p1
> > [10257.685511] /dev/mmcblk0p1: Can't open blockdev
> > [10262.447439] mmc0: card 0001 removed
> > [10281.209724] mmc0: cannot verify signal voltage switch
> > [10281.365508] mmc0: new UHS-I speed SDR104 SDHC card at address 0001
> > [10281.366289] mmcblk0: mmc0:0001 SD32G 29.1 GiB
> > [10281.369004]  mmcblk0: p1
> > [10281.589067] FAT-fs (mmcblk0p1): Volume was not properly unmounted. S=
ome data may be corrupt. Please run fsck.
> > [10345.088596] mmc0: cannot verify signal voltage switch
> > [10346.904393] mmcblk0: recovery failed!
> > [10346.904422] I/O error, dev mmcblk0, sector 2049 op 0x1:(WRITE) flags=
 0x100000 phys_seg 1 prio class 2
> > [10346.904438] Buffer I/O error on dev mmcblk0p1, logical block 1, lost=
 async page write
> > [10366.548533] mmc0: tuning execution failed: -22
> > [10366.548618] mmc0: card 0001 removed
> > [10370.618162] mmc0: cannot verify signal voltage switch
> > [10370.773816] mmc0: new UHS-I speed SDR104 SDHC card at address 0001
> > [10370.774592] mmcblk0: mmc0:0001 SD32G 29.1 GiB (ro)
> > [10370.777138]  mmcblk0: p1
> > [10370.967092] /dev/mmcblk0p1: Can't open blockdev
> > [10397.449106] mmc0: card 0001 removed
> > [10401.424032] mmc0: cannot verify signal voltage switch
> > [10401.580344] mmc0: new UHS-I speed SDR104 SDHC card at address 0001
> > [10401.581107] mmcblk0: mmc0:0001 SD32G 29.1 GiB (ro)
> > [10401.583533]  mmcblk0: p1
> > [10401.758441] /dev/mmcblk0p1: Can't open blockdev
