Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA393F7ABD
	for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 12:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355423; cv=pass; b=QbBgV/CEKWQksUywSm0K12e/W4CdraDf+WpH+6H6M51mXn/4/bamG68UpC4sjUsiuTFqgdZdJnIr58pKJvxsztdWeIyWZDyhX66NCYkajTQ46kxemnn3qbvs3qH/lDYTxQx3aPL4UYuuasq5WW657SspBV3vWhtzdg7I3GnHF1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355423; c=relaxed/simple;
	bh=R1NQdatTO/DyCZ3+FrGoF0Dz4s9ctA0lirknSGwD09A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUdznBsktHG0W8T/Q56U+G63+vlUUbytMtJ6wgxR6d+xg4BpjNhSvH+/+yC1BNDM1TPXvaTQXhRD8BDf7vfRoos+Z7a/OZ7CimhwIqkJwBM92G5LTm0UDzHDubJQY7dk9QoiwrDPvprR6uDt4+BWPH2zrQfJ7ptRxR4b5GfhEYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=e4CIQB5i; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="e4CIQB5i"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64ea73e7b60so4601052d50.3
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 05:30:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774355420; cv=none;
        d=google.com; s=arc-20240605;
        b=QbfNqWCEKaI8v9vmkuYMgUHshBAEpneWmd3k0ThofA4Tr3HTi9Bu9NCiZVXJPK0ZK1
         IzgHmQaK+PLJZ/eidCBZlB1Ho8ScUXjckbmW+Z1yt2EdDEP3LrEFGSj6gy0O9rlFE6Ow
         xz9lRok9S/ZAqeIrw6oQnOAs2YITlFXfWQJT6VpPMNmD2N1Yo/hQNfl0QBWmtImrAhBy
         Fx+ugT2YqGxPRZBugxh2xX3h2oSWfN9B1MRASfahivhJTtJbLo66Xknbth/RlKGcbr7B
         8DIO+wylS+TuzX8VGUVzKh0q0svUJJj3fNwZ0qbYA3cqfM53N1VPzjBdcHHtJp+BztHJ
         yY+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=R1NQdatTO/DyCZ3+FrGoF0Dz4s9ctA0lirknSGwD09A=;
        fh=UsBDZ8BGWwNoJl1jXtLogux1uE6pDg5pmZgJ9dc7EiA=;
        b=F7F1IavJIPgVpTcjd6TiyNHstrs+aTGMZN5XXZYAYuKdkuQ+jnkKAnOWiwQ14ajgg2
         +PqqenxUfsmHTRkKnFjZMKu5vZCW9vODU/980xLUpc2qBjua0djvYgZ0/LIrRXSIw37+
         UHkItX72ZuCWmL7p2nyUyExp0DaFzGd5aYAoGN5xlgiCctOYCcx8KqW95+lWO1l6E2lA
         m+wpVTIUHydodAD5PA9BHWAqHAgkAE3fFWANTVLWUCeZXLKyeAhB7f44tWq529E0HIMr
         aVouV2tRh1vtFH5HgkNQMThexunI/Hn4OKMBkfXN06h913Xt8+6GetJVhxOvRtrEOjwf
         qqeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1774355420; x=1774960220; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R1NQdatTO/DyCZ3+FrGoF0Dz4s9ctA0lirknSGwD09A=;
        b=e4CIQB5ihc7096lRjCdJle/ZUMsK253yPZy10rQ6IFhHdKeQjmgMxxvkifgv5jxclm
         h3H23nCRy39dCN/KncuVHSibo2sRWStwLkwhZ1dvqoNh1C4pIC603kpaeorr9SfghIH/
         l9X6+xD0K2b82RGm/tqiEsCbujln2NHesNBIqTXy77AE/AzPKdFp/pd7eJTysaLxwKaP
         BQkaibH5lAVvb80HIAdqq/bHaOwAjrOK+D1guBm8xbpEtUe7/vvPDXM4+V6MBiXjQXgu
         TMhkdzq4wS1bIKq1essS8yg4cZYGrjlubfNRhINUwSq9b6ZnwxCx4UEqTbnHhlYjCxr8
         bp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774355420; x=1774960220;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1NQdatTO/DyCZ3+FrGoF0Dz4s9ctA0lirknSGwD09A=;
        b=i3eYdtHjOUOFy9KrwEDT04ZBVn/YpvSuMG6Cyw0d/8YAeisFP6kPstwdpsvW7Uevzv
         qs80biGcsXZvYHkhG4CTOUIonOQeH/4tXVdcVL1PBp+ZwbhjSpLgcmjTzsQP9iOayjVN
         yGS1CSBbh1cssdZAU0gLxti4weDERPcDJEdChpjn9TjSGisVbLH8QVSM5RT/41jEB0U/
         5H/ZZ5wzBNcaA4SKV5SP9aKfZmjUKYI3oks5IAWo3yoh2VQVHMmnozujyEWNoWCqZb2O
         C7F4gb+sxaDXBmCtH6rZQi5jM2SzuqFJgU/YlkRvDxCrFD0jyWvbQ/fsjLm5Tdj4iqAN
         KS+w==
X-Forwarded-Encrypted: i=1; AJvYcCUMmWcXL1/VD9NIFEtO/dcPYSVQ37NqSJnDG5h6HVsRzB1YgSlV2JaIrY6CN6Dj/botG0yg55kgt4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP8bIvEGlbS0Jk+3pIRMYBv8om4HMmzuBN8Mog9nFsgIrl+sci
	vOuXA9Us4yfBCj20ca+uVuzJE/4334vc3JUo3rG7WyiqfvTozkHjMBhWuTfM69K3TtKgzlrd6MX
	q/+r/Y3JLzkrSjtoBCMeMJ5ZlO/7FVwDkvquQJoY8aQOzFrxRNwdiggzU
X-Gm-Gg: ATEYQzwfcl3NgLXwQx+uBdv35s3o7AIUTCrNw3QeHduaHezbi1Nb4R/d0B0BGYmnlOt
	Oq/26zqpG/BgYKGzZ8IZFau+pMROaMEx39yqL+f/arjaKR7wfPP2ZNcE/fstHrGJT8jW++utoVR
	r1ZzT0yh3BY194pgl3w9Nm9G97wgFJhQGqD4DtYcZs/6bVqZ3djfhipXPPc8ylE92RtwMIoDs+L
	KWDw4zJe0K9YrQxfiEw2UtUUs095khPopuoTeMzGU7S3Q3ALAnO890KsMlPy/Pn5Z6hHaEnGKii
	IK+eu1urw85Uicl3pC0FvIZUnK52GFhR3Drt7xpe
X-Received: by 2002:a05:690e:44a2:b0:64e:a708:5aec with SMTP id
 956f58d0204a3-64eaa7080f2mr12581101d50.34.1774355419481; Tue, 24 Mar 2026
 05:30:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305194052.5120-1-sean@starlabs.systems> <20260312121559.19197-1-sean@starlabs.systems>
 <20260312121559.19197-2-sean@starlabs.systems> <CAPDyKFpueaHyaOGn5Fn_JdnD4kPeBsDcGx8ykgnuyJ=CFPyxyQ@mail.gmail.com>
 <CABtds-26cuCMZbRhAaioOOCcX=w6J_mpCxgxahjwz7QJEZqe5Q@mail.gmail.com> <CAPDyKFrjhNj38dvvf5AGjCxSKkX02C-B6h4+dX0iOxyOc+Hruw@mail.gmail.com>
In-Reply-To: <CAPDyKFrjhNj38dvvf5AGjCxSKkX02C-B6h4+dX0iOxyOc+Hruw@mail.gmail.com>
From: Sean Rhodes <sean@starlabs.systems>
Date: Tue, 24 Mar 2026 12:30:07 +0000
X-Gm-Features: AQROBzAF60qRXcAoAzeO1TS9w422pSEf6SylrD4UR3D5HAjQsK9h-GApgmi0PRo
Message-ID: <CABtds-2DjtJ=8GzNdi0ZOLPdBfGWdfeXX790o_gvNVE=d9+=Pw@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 1/6] mmc: rtsx_usb_sdmmc: avoid false
 card-detect on tray readers
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ricky Wu <ricky_wu@realtek.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Mar 2026 at 12:23, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 24 Mar 2026 at 12:59, Sean Rhodes <sean@starlabs.systems> wrote:
> >
> > Hi Uffe
> >
> > Thanks for the feedback - to answer your questions:
> >
> > > Would you mind elaborating on this so I can better understand the problem?
> >
> > SD_CD is used for presence, but that's asserted by trays or blanking cards.
> >
> > > What prevents the MMC core from handling this correctly?
> > >
> > > Don't some of the commands time out, eventually causing mmc_rescan() to bail out?
> >
> > It does bail out, but SD_CD is still asserted, so it tries again. The
> > main thing this breaks is S3 entry - it's either slow (like 100
> > seconds), or never gets there.
>
> First, please don't top post, but reply in-line below so we can follow
> the discussion.
>
> It's the mmc driver's ->runtime_resume() callback that calls
> mmc_detect_change(host->mmc, 0).
>
> It's sounds to me like the mmc host is being runtime resumed/suspended
> over and over again, hence we end up calling mmc_detect_change() many
> times when it's not really needed. Right?
>

Correct

> >
> > > I guess one key piece of information I'm missing is what happens when the mmc_recsan() work tries to send commands to initialize a card, when there is no card inserted?
> >
> > They fail, and we use that result.
> > On Tue, 24 Mar 2026 at 11:26, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > + Matthew Schwartz
> > >
> > > On Thu, 12 Mar 2026 at 13:16, Sean Rhodes <sean@starlabs.systems> wrote:
> > > >
> > > > Some Realtek USB SD readers with a tray can assert SD_CD even when no
> > > > card is present. This can make the MMC core believe a card exists and
> > > > trigger unnecessary initialization and suspend/shutdown failures.
> > >
> > > Would you mind elaborating on this so I can better understand the problem?
> > >
> > > >
> > > > Debounce the CD signal and validate a newly detected card by probing for
> > > > a response (CMD0 + CMD8/CMD55/CMD1) before reporting it present. Also
> > > > treat SD_INT as a removal indication even if SD_CD stays asserted.
> > >
> > > What prevents the MMC core from handling this correctly?
> > >
> > > Don't some of the commands time out, eventually causing mmc_rescan()
> > > to bail out?
> > >
> > > >
> > > > Tested: Realtek RTS5129 (0bda:0129), tray inserted, no card (2026-02-24)
> > > > Tested: Realtek RTS5129 (0bda:0129), tray + SDXC card, mmcblk0 (2026-02-24)
> > > >
> > > > Signed-off-by: Sean Rhodes <sean@starlabs.systems>
> > >
> > > I have looped in Matthew who recently worked on some similar problems
> > > for the PCI variant [1] of the driver. Perhaps he and Ricky have some
> > > input on this series too.
> > >
> > > [1]
> > > https://lore.kernel.org/all/20260105060236.400366-1-matthew.schwartz@linux.dev/
> > >
>
> [...]
>
> Kind regards
> Uffe
