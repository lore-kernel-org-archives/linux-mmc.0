Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36AB4F4736
	for <linux-mmc@vger.kernel.org>; Mon, 12 Oct 2026 21:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791840869; cv=pass; b=U73sRQZ68dOeQsa0frGMQB0giC6aAaL8G0bNdmm2V0oOB/btN4jcAC31LlLO8qStUGetH+BSofXGPd0p0Vcag98cjh6913uhQIIgL0q5NAfeAg+hBSZqfRB2Krsa6+QzELCg7kAYNiD1ovRGWtLaMKH7JJL+s712mdN/npIaHro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791840869; c=relaxed/simple;
	bh=/bJ5PQP4uoYZBIo22Fzx5lB/ygVpuCF+t05OUgq3nrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HFxF2Nzdc2uKocRw9yDLNFGc7qDJ+3b7Z8maPnS7vAcqeujZ3l5aPC7Gz9RgPqQemS9lSNoyQUQzwxr1NHi74DVO3m4LfBGfiDMJQEEXG5yfHMeKE6JcyZEyiMMz71nwuxMUL9ESqZ6h17n01pYMrbGe3C/Tchd/BdWgVLuioew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=hyslrloe; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="hyslrloe"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8ab37e44643so13191727b3.0
        for <linux-mmc@vger.kernel.org>; Mon, 12 Oct 2026 14:34:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791840865; cv=none;
        d=google.com; s=arc-20260327;
        b=VVrRt5JAEsBR2tBZSb10WH2EmcDDRcSuvw++uOPGkM7Nef28mD3e11LIDrWSmdbYq5
         tw1Ea3bzbfCShyL71SrdMF2cAuzyySWI8ftRXIxKumE/2rtGRMRc/cgKehII7qQMf1it
         L3M/Qr05H3H5R0UkONF9Kec3uv43byhpEy8+TLAlV0Tqch4gbUpHUDfNgjSnnI2uFals
         ehh5NZcsJE5mIz5kWE1DsIDQRwfu9tLaOCDNtT6bHhva3eWBydwfrr8b/sDTaCrQJiRu
         gACLtnHxbIt7cZueu9BayPyxq+K53gKRKOZRLAtB2TQ44Q8L3DXP5SSiwk/+IOUu2L8h
         9t+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ysmRiqiC15vYpG/lYmDhf4jWZxZpBo2Htczu87XzkBA=;
        fh=3tMgWDJfuVZuL88F1fju0kjJK19KxG7L9tFJnifBMic=;
        b=is+8jieW1yCEf3dpd5xtcqmLS9wklvMpC+J/rYrz70HvUk+AjW//Sdouy7SNaadmbP
         H2Lyab5Egueua5hBSKYUB0bmZGxAppKVU2QaUw25qhIKm8VsO112iKYC8/drHnpYwXL+
         ruXIaDrLlL8Q2+D0agBgs3Z9wd6i0EzrhQWmfZRKEqjHSdhSimz2KGLO3UNubGMC60lg
         CQyOFToK9fiDuCwtYtv1She+1wu8eHmGtA4CdsNmOt0Nv2qG3fef5K681UvasBMPrZdp
         7iEJFUEvi324bIo3SnG0eEdnNIpUznXQQ7dwYYaSjOnRwB4zQWd2rF0gnG36AEIw+fUY
         uEzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1791840865; x=1792445665; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ysmRiqiC15vYpG/lYmDhf4jWZxZpBo2Htczu87XzkBA=;
        b=hyslrloec1zhakASu16CVHaH1MEMPk4jP+epSDIEaD3BxKb48lqPSzFO9cJWpZDqiP
         lw25luTM7J8GC2qkLio35jeqIm/ZbsJqVEH7NsP+qAbYjFmn8fVwtkL3+7AU2GNkgMy+
         yq3L9M4ZyCdiBOHVJORO+Wg7Seutmz64XxSn+c2LHcyqFcnrpxovLrCWyG8R7I2XEUYL
         2L5ZpstCoKqyVcOP1ygcCzWdI8nrma0/lBgMd3DIi6htavNicO6PkmmiLp4KGzYvg7Ig
         8DY+Tqj81qtuMxTP0k18k/w6we/1jHfUO25ZVGwolJk75uS+w2Q71IZGYpHHz+bCD5N9
         TebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791840865; x=1792445665;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ysmRiqiC15vYpG/lYmDhf4jWZxZpBo2Htczu87XzkBA=;
        b=tYAMzS9ORZOR7K5xM8IjFedfDvAg5TLUI6WqEeXDjzPLcnDVvrnBAJc/zgsFIAw7sX
         CQPAHFvVCy395W0jFXGNxiAptZhYz9QtrEBPL02qPj6aq+ma57/vgkGsx/SrVuGIssAs
         QJHYbCAdokJCWduzMSJKYSuaqX7cajP30JZCUdAhBY/CdsQe/MfpyjngkLEfaqxq/P+x
         J2xr9eITOUclFw2Ig5OvJPpyuGAeex9NXbyYS1Vx6pfrZlmZI6f5FP6mikDvjITzSBfd
         yZh+NdC4jz+AWRe4r1FJmq0ZCJl4yn6yufYgM/+H7fltyAIj15iPUu3svkjP0Wa9Q3UK
         HYag==
X-Forwarded-Encrypted: i=1; AKwUvBzfKXyKEPsnZoajBA/eGyS0ls6olu4kAA0C5LvWuqLJFfJqTMBbTWndtHtSUQcROPmblpxd+8bOHZ8=@vger.kernel.org
X-Gm-Message-State: AFq9FYI0apyn2slhEitlrAQWeNZwpJ+W6cC+3dffdAwSYo1+V1o5SvYz
	kJXCaN+s36RgCw5OsSHFDRg1Wq8DNj0cG/H45pRjcRRAkgF8U3b2cjt/FGz1jXXQY4HMxKhfBeO
	qoa5F6if/0q8haE/VvVPThIro41A1PvpgCpsFDa83
X-Gm-Gg: AYBFou0d174sGlK8Bmc21oJs1LEJnkpcCoCBWmYzsK0Tt2fPMdeFqaBGXuyiYNmfVLJ
	NA4URiCLPiOasQheREeoDmYqFzjm7sFY9TjIKVrpolZeA2XBQPove1LQa+OT6hGcopzC004tgoI
	yeUi+9TPVLgIXZVXXq4wtdQdjrE95MHDDckvnoMBVH2T1/3kUY3sMY+WhMUzqy1iiUswSnBU+hm
	Z2y3+FaAbJMlbQfn2J1UVJKQ0eqmy6SCMkzLDtzEbZkIeUUzFDrhka3EONqD8Hplr1fHGJ74Q0Z
	c/eWJr1YOnKn2DJ0T/LmjCzUtpFOlNqqbNTSDDykx+p0P+kDMbhxLiNiiB+Wg/07ixDYQcXhf5X
	+8g5y1oK1NAS8RXQLb3PI
X-Received: by 2002:a05:690c:a652:b0:89a:63da:fab0 with SMTP id
 00721157ae682-8b07ee4c479mr23157817b3.107.1791840865295; Mon, 12 Oct 2026
 14:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783352430.git.sean@starlabs.systems> <7acac70a471452a6ccf23b7ccc557f3c3861e0ad.1783352430.git.sean@starlabs.systems>
 <20261005103011.03175826.michal.pecio@gmail.com>
In-Reply-To: <20261005103011.03175826.michal.pecio@gmail.com>
From: Sean Rhodes <sean@starlabs.systems>
Date: Mon, 12 Oct 2026 22:34:14 +0100
X-Gm-Features: AclHuK-f_thTWraeWd7Wac9OHXbR64A-8Mn1b6vg99UV8M_3MiTAJtpOrwS45N0
Message-ID: <CABtds-3t+ECCPeFShq__iNa9niRAge=WOED4cHtNZAFVw6kPzw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] misc: rtsx_usb: avoid USB I/O in runtime autosuspend
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ricky Wu <ricky_wu@realtek.com>, 
	Lee Jones <lee@kernel.org>, Roger Tseng <rogerable@realtek.com>, 
	Dan Carpenter <error27@gmail.com>, Jisheng Zhang <jszhang@kernel.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> How is the driver supposed to detect card insertion after the last poll
but before the reader goes to suspend and can issue remote wakeup?

The reader uses remote wake; what hardware are you testing on?

On Mon, 5 Oct 2026 at 09:30, Michal Pecio <michal.pecio@gmail.com> wrote:
>
> On Mon,  6 Jul 2026 16:40:43 +0100, Sean Rhodes wrote:
> > The runtime autosuspend callback currently queries card status and
> > clears OCP by issuing USB register accesses. This can run from the
> > USB runtime-PM path itself, which is the wrong place to start more
> > device I/O.
> >
> > Keep a cached copy of the card-status bits from normal status reads
> > instead. During runtime autosuspend, use that cached value only to
> > preserve the existing Memory Stick autosuspend deferral.
>
> How is the driver supposed to detect card insertion after the last poll
> but before the reader goes to suspend and can issue remote wakeup?
>
> This is exactly what happens now: if I insert a new card within two
> seconds of the "card removed" message showing up (which itself happens
> up to a second after removal) the insertion is never detected and the
> reader enters suspend with the card in.
>
> It seems that not only was "starting more I/O in the runtime-PM path"
> actually a good idea, but polling should only stop when the parent USB
> device suspends, not the child MMC host, because there is a two second
> delay between them. And even with this patch reverted, insertion never
> works if USB autosuspend is simply disabled altogether.
>
> Also, does anyone know if there is any way to utilize the interrupt
> endpoint instead of polling? I tried submitting a URB to it and got
> regular responses, but only zeros. Can this be changed?
>
> > Do not treat raw SD_CD as an autosuspend blocker, because tray-based
> > SD readers can assert SD_CD with an empty tray. A real SD card is
> > protected by the SD/MMC child runtime-PM usage once powered.
>
> Sounds like the proper condition is to ignore the card if and only if
> it failed to initialize and has not been swapped for a new one.
>
> Hence the question about interrupts: this would vastly reduce the risk
> that a swap for an actual working card remains undetected.
>
> Regards,
> Michal
