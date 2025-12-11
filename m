Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028B7245031
	for <linux-mmc@vger.kernel.org>; Thu, 11 Dec 2025 10:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765450648; cv=none; b=IAF4SmZ5i+gfpuCy8cHlBfocWeVAgwRUyJAJ276HrSoWDc8oq+hec5BUKehi11UuQNe9MjecWijM3qHB7uZmcU6fonyk8BaGtzVKaZXapTwo8bgJZhB8VJr29XLJwWYxBm0PRsB5M8mbHgkkKzgPaZ1VmuYuaYi7kstd0sNmOBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765450648; c=relaxed/simple;
	bh=glrxtMjqkUBaCzlmvtbPhXHIQ7qRaXR9uQHY2oHJvrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d175GKAdqZzSFQxvdH3NLyQypVvxyKwBsXpW1ggnsEghAgqDeYmy7zWtnK9UDmMwhAzf8hkTqcCtJZE0UVDeVo0mhlfHZqu6x+fRrOXizY5s/o+aWWTMt2nQCBOrkg9LVsF8rFaY8+QgZoZwqezHNMCXitbg9dJEPr8hxbQ+dAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=REhkFIaL; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="REhkFIaL"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-78c696717dbso8056027b3.1
        for <linux-mmc@vger.kernel.org>; Thu, 11 Dec 2025 02:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765450646; x=1766055446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5YEEyH51RKxGYdVyGunjy0gRdxvGTIFaECJPQw5bos=;
        b=REhkFIaLPVXsQKYDTbZ+rePIZlVJHdEEhZzPX5BmFB9KmLUk5yGxHBO8U4ZLq1Jqds
         l2qWo6RLiey2BqcthxRsULvjPXThCQLyOKUXO1DdyL5SFnwZa655WfocWTlb9nuZJWMF
         AnfarOzS8VW+oMTp3dh503VKSSlcaZG/VIV+5pXZcVLoI3FYTSQ9/vFFHqCGUDR+OMtG
         WAf9kkAguW0NLwjuZraeGjZWDD2wU4jxWLwH4D3sHYjrkBJurOwDjRd638zWyHjUEOBu
         aE6C87xvZMRx43B5/0ZPElCsDSW4LBcdaLNwt2Y92xDMfcjkR6Pfcr6HQwdY2OpylFoB
         UIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765450646; x=1766055446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V5YEEyH51RKxGYdVyGunjy0gRdxvGTIFaECJPQw5bos=;
        b=Hmlz6f7t+GCViarXWknyRyYS8eVzr1S2TOMVG5qrE5rW1mgiVh0k/Q7fQpKwTlcoe9
         JSOFAfD6pF4fwu5Ycu00yrJjXmow4CWbAdymcItoo04koo4i1QJKXnBHmIQrlMtE9xEY
         o4kHB8OoebbdGaaqGdK5XAuoPjDdlM87FJJOQIVjVssQ9ekm5zbNvBHHFJWRC/GI48GH
         4C7HKA4YZ4eNvT0P3mDQDYB6LVdeQTMUlsQ7GgyOVJaZBxTqgnryy95E8ItkfkZTuydV
         4dNpY3JnI75fea8usBGrba29aoMTSZ7GCbz4iyzIvjZIoHyVMDtIFnm35yfo3fzk1hI5
         DpWQ==
X-Gm-Message-State: AOJu0YxkKaY3EG7vSf5FSPmBWOJtwXEOyxpUUjWfOqbI67pVM2DrpTId
	iP9ukcpiMCkLoPUrb4cxkEeH4JOJBzhO7vowUWMzZy54LeBUxfhiZPxWX2ddTgFuCn/Ag+R/MWZ
	tp3EjfmsbJXQlHJnhuq1f77/dhC8hV0z2nZpCuzbdDA==
X-Gm-Gg: AY/fxX7Hfgss5K1bmcjeWdzZsJo65EVaa7XU/W694JCafBbogBs4USbZTjJUjFZ2IUi
	Rx3ry12jVhKCHLtSPPpgVksXOlDGPxub7cGUr9LvR0ZNJdr6OkI4AL5HFLw5WCHKjoRH2CiHuNR
	uiFihscVDC052Dlj/8h9cq4e8t72hJ5vvW2hBZMx7b9wr7lvEJEIiDqFqEMGA1cNUoNF+WUUhcu
	5xVTqmFyOVzGrbsxxorvkwqUbO+raTOZUmHCfGbe3TLklHVDCH+1cqAUTX/ndcB5V8YMNWm
X-Google-Smtp-Source: AGHT+IEK/ayXaIWC8j9ZcW0gKnrjpuRe6rNjQ7mkHYL6O76rQr7niJ/xofziEKAfs45lkgPwyM+WGOcfkG91xHsPjmk=
X-Received: by 2002:a05:690c:7489:b0:788:14a2:8bba with SMTP id
 00721157ae682-78c9d7e9e7amr45792777b3.44.1765450645786; Thu, 11 Dec 2025
 02:57:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH1aAjJbA08ErU_NMhNDGcNfWgap+G0Fk-Ba-AgfpZcc8zHd=Q@mail.gmail.com>
In-Reply-To: <CAH1aAjJbA08ErU_NMhNDGcNfWgap+G0Fk-Ba-AgfpZcc8zHd=Q@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Dec 2025 11:56:49 +0100
X-Gm-Features: AQt7F2oiNdNv1i-0GtKxmKFRMHuiMbzS88U9UMKwa-QZKcCU7uYyNk6WjgHiyVs
Message-ID: <CAPDyKFrzzLTCYZnr0RFDc0NnPbeUMZzb-2NjXJZa3Q1qQ+OpTg@mail.gmail.com>
Subject: Re: Issue with Realtek PCI SD card driver
To: JP Dehollain <jpdehollain@gmail.com>
Cc: linux-mmc@vger.kernel.org, =?UTF-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ Ricky Wu (the main developer of the driver)

On Thu, 11 Dec 2025 at 10:05, JP Dehollain <jpdehollain@gmail.com> wrote:
>
> Dear mmc kernel driver mantainers,
>
> When I insert an SD card in the integrated card reader in my laptop, most=
 of the time the card gets recognised as read-only, even though the physica=
l switch is in the unlocked position. If I remove and reinsert the card sev=
eral times without unmounting it in the OS, I can eventually get it to load=
 in rw mode.
>
> I am using Zorin 18, with linux kernel 6.14.
> Attached below is the output of dmesg showing several attempts to remove =
and reload, until it reloads in rw in line [10281.365508].
>
> Please let me know if there any other logs and tests I can send or perfor=
m to help resolve the issue.

I found one interesting commit that may be worth trying:

commit 807221d3c5ff ("misc: rtsx_pci: Add separate CD/WP pin polarity
reversal support").

Not sure if it applies on v6.14 kernel, but I suggest giving it a try.
Or try the latest kernel, v6.18. I have also looped in Ricky Wu, to
see if he is able to help out.

Kind regards
Uffe

>
> Best regards,
> JP
> jpdehollain
>
>  [ 9367.567443] Generic FE-GE Realtek PHY r8169-0-201:00: attached PHY dr=
iver (mii_bus:phy_addr=3Dr8169-0-201:00, irq=3DMAC)
> [ 9367.568438] Bluetooth: MGMT ver 1.23
> [ 9367.738206] r8169 0000:02:00.1 enp2s0f1: Link is Down
> [ 9375.195026] wlp3s0: authenticate with c0:fd:84:c2:04:ac (local address=
=3D40:b8:9a:b9:34:e1)
> [ 9375.195036] wlp3s0: send auth to c0:fd:84:c2:04:ac (try 1/3)
> [ 9375.195935] wlp3s0: authenticated
> [ 9375.196946] wlp3s0: associate with c0:fd:84:c2:04:ac (try 1/3)
> [ 9375.198285] wlp3s0: RX AssocResp from c0:fd:84:c2:04:ac (capab=3D0x101=
1 status=3D0 aid=3D6)
> [ 9375.200886] wlp3s0: associated
> [ 9377.256424] rfkill: input handler enabled
> [ 9377.260100] rfkill: input handler disabled
> [ 9378.855243] lockdown_is_locked_down: 2 callbacks suppressed
> [ 9378.855248] Lockdown: systemd-logind: hibernation is restricted; see m=
an kernel_lockdown.7
> [ 9842.321650] mmc0: cannot verify signal voltage switch
> [ 9842.474907] mmc0: new UHS-I speed SDR104 SDHC card at address 0001
> [ 9842.475878] mmcblk0: mmc0:0001 SD32G 29.1 GiB (ro)
> [ 9842.478394]  mmcblk0: p1
> [ 9842.672905] /dev/mmcblk0p1: Can't open blockdev
> [ 9884.098398] mmc0: card 0001 removed
> [ 9898.560801] mmc0: cannot verify signal voltage switch
> [ 9898.716638] mmc0: new UHS-I speed SDR104 SDHC card at address 0001
> [ 9898.717583] mmcblk0: mmc0:0001 SD32G 29.1 GiB (ro)
> [ 9898.720430]  mmcblk0: p1
> [ 9898.901398] /dev/mmcblk0p1: Can't open blockdev
> [ 9926.650920] mmc0: card 0001 removed
> [ 9932.079104] mmc0: cannot verify signal voltage switch
> [ 9932.233022] mmc0: new UHS-I speed SDR104 SDHC card at address 0001
> [ 9932.233814] mmcblk0: mmc0:0001 SD32G 29.1 GiB (ro)
> [ 9932.236526]  mmcblk0: p1
> [ 9932.417077] /dev/mmcblk0p1: Can't open blockdev
> [ 9945.675206] mmc0: card 0001 removed
> [ 9954.348559] mmc0: cannot verify signal voltage switch
> [ 9954.505148] mmc0: new UHS-I speed SDR104 SDHC card at address 0001
> [ 9954.505892] mmcblk0: mmc0:0001 SD32G 29.1 GiB (ro)
> [ 9954.508907]  mmcblk0: p1
> [ 9954.688774] /dev/mmcblk0p1: Can't open blockdev
> [ 9969.099540] mmc0: card 0001 removed
> [ 9975.967776] mmc0: cannot verify signal voltage switch
> [ 9976.123568] mmc0: new UHS-I speed SDR104 SDHC card at address 0001
> [ 9976.124400] mmcblk0: mmc0:0001 SD32G 29.1 GiB (ro)
> [ 9976.127501]  mmcblk0: p1
> [ 9976.308274] /dev/mmcblk0p1: Can't open blockdev
> [ 9989.339754] mmc0: card 0001 removed
> [ 9998.751059] mmc0: cannot verify signal voltage switch
> [ 9998.908154] mmc0: new UHS-I speed SDR104 SDHC card at address 0001
> [ 9998.909036] mmcblk0: mmc0:0001 SD32G 29.1 GiB (ro)
> [ 9998.911611]  mmcblk0: p1
> [ 9999.088417] /dev/mmcblk0p1: Can't open blockdev
> [10039.268493] mmc0: card 0001 removed
> [10046.108371] perf: interrupt took too long (3167 > 3166), lowering kern=
el.perf_event_max_sample_rate to 63000
> [10049.398057] mmc0: cannot verify signal voltage switch
> [10049.554751] mmc0: new UHS-I speed SDR104 SDHC card at address 0001
> [10049.555751] mmcblk0: mmc0:0001 SD32G 29.1 GiB (ro)
> [10049.558524]  mmcblk0: p1
> [10049.735565] /dev/mmcblk0p1: Can't open blockdev
> [10069.188896] mmc0: card 0001 removed
> [10076.400515] mmc0: cannot verify signal voltage switch
> [10076.556156] mmc0: new UHS-I speed SDR104 SDHC card at address 0001
> [10076.556990] mmcblk0: mmc0:0001 SD32G 29.1 GiB (ro)
> [10076.559495]  mmcblk0: p1
> [10076.744822] /dev/mmcblk0p1: Can't open blockdev
> [10097.512910] capability: warning: `gvfsd-admin' uses 32-bit capabilitie=
s (legacy support in use)
> [10160.142113] mmc0: card 0001 removed
> [10166.327484] mmc0: cannot verify signal voltage switch
> [10166.483689] mmc0: new UHS-I speed SDR104 SDHC card at address 0001
> [10166.484452] mmcblk0: mmc0:0001 SD32G 29.1 GiB (ro)
> [10166.486831]  mmcblk0: p1
> [10166.673519] /dev/mmcblk0p1: Can't open blockdev
> [10209.382671] mmc0: card 0001 removed
> [10213.541830] mmc0: cannot verify signal voltage switch
> [10213.698167] mmc0: new UHS-I speed SDR104 SDHC card at address 0001
> [10213.698682] mmcblk0: mmc0:0001 SD32G 29.1 GiB (ro)
> [10213.701071]  mmcblk0: p1
> [10213.879510] /dev/mmcblk0p1: Can't open blockdev
> [10233.767001] mmc0: card 0001 removed
> [10241.604535] mmc0: cannot verify signal voltage switch
> [10241.760000] mmc0: new UHS-I speed SDR104 SDHC card at address 0001
> [10241.760727] mmcblk0: mmc0:0001 SD32G 29.1 GiB (ro)
> [10241.763414]  mmcblk0: p1
> [10241.942084] /dev/mmcblk0p1: Can't open blockdev
> [10253.143302] mmc0: card 0001 removed
> [10257.346355] mmc0: cannot verify signal voltage switch
> [10257.501510] mmc0: new UHS-I speed SDR104 SDHC card at address 0001
> [10257.502301] mmcblk0: mmc0:0001 SD32G 29.1 GiB (ro)
> [10257.504889]  mmcblk0: p1
> [10257.685511] /dev/mmcblk0p1: Can't open blockdev
> [10262.447439] mmc0: card 0001 removed
> [10281.209724] mmc0: cannot verify signal voltage switch
> [10281.365508] mmc0: new UHS-I speed SDR104 SDHC card at address 0001
> [10281.366289] mmcblk0: mmc0:0001 SD32G 29.1 GiB
> [10281.369004]  mmcblk0: p1
> [10281.589067] FAT-fs (mmcblk0p1): Volume was not properly unmounted. Som=
e data may be corrupt. Please run fsck.
> [10345.088596] mmc0: cannot verify signal voltage switch
> [10346.904393] mmcblk0: recovery failed!
> [10346.904422] I/O error, dev mmcblk0, sector 2049 op 0x1:(WRITE) flags 0=
x100000 phys_seg 1 prio class 2
> [10346.904438] Buffer I/O error on dev mmcblk0p1, logical block 1, lost a=
sync page write
> [10366.548533] mmc0: tuning execution failed: -22
> [10366.548618] mmc0: card 0001 removed
> [10370.618162] mmc0: cannot verify signal voltage switch
> [10370.773816] mmc0: new UHS-I speed SDR104 SDHC card at address 0001
> [10370.774592] mmcblk0: mmc0:0001 SD32G 29.1 GiB (ro)
> [10370.777138]  mmcblk0: p1
> [10370.967092] /dev/mmcblk0p1: Can't open blockdev
> [10397.449106] mmc0: card 0001 removed
> [10401.424032] mmc0: cannot verify signal voltage switch
> [10401.580344] mmc0: new UHS-I speed SDR104 SDHC card at address 0001
> [10401.581107] mmcblk0: mmc0:0001 SD32G 29.1 GiB (ro)
> [10401.583533]  mmcblk0: p1
> [10401.758441] /dev/mmcblk0p1: Can't open blockdev
