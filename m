Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EC2318128
	for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2025 10:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514527; cv=none; b=JFNa8lzfzoktg4UWrrUmjIpYCD8kuvp7pDWoXuLwsuOpWWmAsKTWLhTmROt6yUdpBeuMMmLo8RkRdaiNx3QGawYpxj/4VnU6AdHgK1El1ZIARkVETsm5LEm3gyhWwT+3FSf1EfU4OXqzHLxpfVb0+5/wRBIjhCoAZo9/ofH4sQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514527; c=relaxed/simple;
	bh=8v8TvRlAn2uDDJRIPEFDt6WoHdfXoTTVsusiQAdG50Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nU/gjSaQ45GgJbkuRm5X32uZSVDqaDaSplQ3bY+UVE2k3PO3ZryCJ0n6jox5EVbpjIpIyeYRXzBb3Rm8YjJDOXDHE6grUikVeueSo55K1Il1N3KCoU6C7Cp3S1aOXqxWyaAEYA+XMyIXGqdq0gi2K3bZO3zf88THGEhtjQddwmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ewRyiijY; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ewRyiijY"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d603f13abso34524537b3.0
        for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2025 03:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755514525; x=1756119325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5UfZNE0DRarpftqobVVVHwkS2MsbGM6sleGxn/cdL4=;
        b=ewRyiijYTZMMAwf6ga/lpPtwuDM+tQg9+coHGUV8hbAFABbNQPJgNv6Si4g/2XgiW7
         /BDYeqcMA35G/B508hB/JZJCRPEZ/MD11c3DLslCi5Mm1WdQYsQb7Z357VdHQ72EOyRk
         b2nqCKHJVX/KXGEV8u00TYpKyJmyIuZbaozKjZ13fNKk8/eUZ1PApNohCRw46V3v5kYZ
         IB5Fj0P+QEBeNQNGhClOCPkkC8BGnNRclnXaav7+D7Me8das38QFqNb87C3qGwyV5ojb
         tyxqkt5R1cJ/MzG++GlFTeSoR3J6nRZhzgzc5DBXL3rNnHt6xCqt5E69njC+yspnoi1I
         ulDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755514525; x=1756119325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5UfZNE0DRarpftqobVVVHwkS2MsbGM6sleGxn/cdL4=;
        b=NiLIQmq3CxUS85KVRCHAGLfkslqnIQUPLvHIHd82fiBmG5pcnC6WQmio6SrsOpREE/
         bbxdlD48sfOf4BdOn4lM7agACbc0EZ7MMeruCxou3bRjy1i7hZvN7nms6hqYWK5WZFLk
         QN/fMnlW7WVJ2iVkHUQCNVGyu2SKcDZeDlEvwBYjwNs8wWl4jotIdU7QdJn14jND/wg6
         pORKyytGc0QTctT+/UL+IZJ6hU3zslimy23NXY/XeqU6vihYJbGYzu0O+tNvII1enjeu
         7iP+O9boH+0e1RXp+FGxka6hZtlLJi/AX3VC9gbREKgjz0qPWLrc2akKgvn0zlYGCmS5
         ImmA==
X-Forwarded-Encrypted: i=1; AJvYcCXL6jdvqopm6xjFl7LNzM1VmW8A9++7+1hW4rHY5Viu1K5cR1qFNVzlnCOaIoQD/akSUzHrrwf7n/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWxzIdeyyMz0OEWE6+Paq8w091QIfN2jAvcXQRvhe5mKRY+ZBl
	RfxK+HIkdcQh4soVi0CmO61B7Qnnzqk98evru5aabgawPtqufbc6NcxdRqZCjeG2VnrRYw7KkpW
	fNzIjMvjZ7oLE36+7Xvmpun38LM4GNiVdOo4ONdmYQw==
X-Gm-Gg: ASbGnctEFbLjN0IwmcKWRi+GaxGwNtgTDm//K0Yy2iYjy4ZY1gRxHhraFBxR9AntyLn
	jdtNRs0SsSg4RahbzCvQS/HU8ueJE4pCbbwzlqZ3cNqhhcMMgkjcxRZ6OfVHX792xxzxff4z8hN
	kmP9DPOlLIXPQhoxd1IDbJ+xXlPmVW49CQLvc2GPo5/j6a9BeMpQnDCDiH1WwhsgSWrJhfVGfpy
	YWEPCoa
X-Google-Smtp-Source: AGHT+IFIkic7VQeFkO+cxnCkWqNMeyV+EPEh3o+DVB54sudGxTRKxvw80/DAtEKXY550Y9Oqwc+PI45Z9IPOC/KAAVU=
X-Received: by 2002:a05:690c:9a0c:b0:71c:1de5:5d9f with SMTP id
 00721157ae682-71e6de4edb9mr140911667b3.41.1755514525210; Mon, 18 Aug 2025
 03:55:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731065752.450231-1-victorshihgli@gmail.com> <CAK00qKBzeXJMkYsz7zZTkLDgQ=EAoHvOzPrzmAbJeyUsMZZq0g@mail.gmail.com>
In-Reply-To: <CAK00qKBzeXJMkYsz7zZTkLDgQ=EAoHvOzPrzmAbJeyUsMZZq0g@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 18 Aug 2025 12:54:49 +0200
X-Gm-Features: Ac12FXzg7qrQCxBT_ZKH9q0IQdGRfAERuYgkqmKFbh45UhoXCJmL4J54ucRZJyo
Message-ID: <CAPDyKFoiq2YPZ0Ka8v_of_rPwPf3pU96kiK+_Nf=uwKixobppA@mail.gmail.com>
Subject: Re: [PATCH V4 0/3] Mask the replay timer timeout of AER for GL9763e
To: Victor Shih <victorshihgli@gmail.com>
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	ben.chuang@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Aug 2025 at 16:11, Victor Shih <victorshihgli@gmail.com> wrote:
>
> Hi, Ulf
>
> I'm embarrassed to bother you, but could you help to  please review
> this series of patches?
> If there are any parts that need to be modified, please let me know.

No worries for pinging me, I have been off for a while and catching up
on everything.

The series looks great and I have applied it for fixes, thanks!

Kind regards
Uffe


>
> Thanks, Victor Shih
>
>
> On Thu, Jul 31, 2025 at 2:57=E2=80=AFPM Victor Shih <victorshihgli@gmail.=
com> wrote:
> >
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > These patches add a sdhci_gli_mask_replay_timer_timeout() function
> > to simplify some of the code and mask the replay timer timeout of AER
> > for the GL9763e chipset.
> >
> > Changes in v4 (July. 31, 2025)
> > * Rebase on latest mmc/next.
> > * Patch#2: Add new message to the commit message to explain
> >            why it has a stable tag.
> >
> > ----------------- original cover letter from v3 -----------------
> > These patches add a sdhci_gli_mask_replay_timer_timeout() function
> > to simplify some of the code and mask the replay timer timeout of AER
> > for the GL9763e chipset.
> >
> > Changes in v3 (July. 29, 2025)
> > * Rebase on latest mmc/next.
> > * Split patch#2 in V2 into patch#2 and patch#3.
> > * Patch#1: Correct the wrong parameters in the
> >            sdhci_gli_mask_replay_timer_timeout() function.
> >            Add new message to the commit message to explain
> >            why it has a stable tag.
> >            Add fixes tag to the commit message.
> > * Patch#2: Add fixes tag to the commit message.
> > * Patch#3: Add fixes tag to the commit message.
> >
> > ----------------- original cover letter from v2 -----------------
> > These patches add a sdhci_gli_mask_replay_timer_timeout() function
> > to simplify some of the code and mask the replay timer timeout of AER
> > for the GL9763e chipset.
> >
> > Changes in v2 (July. 25, 2025)
> > * Rebase on latest mmc/next.
> > * Patch#1: Add a sdhci_gli_mask_replay_timer_timeout() function
> >            to simplify some of the code.
> > * Patch#2: Mask replay timer timeout of AER for the GL9763e.
> > * Patch#2: Rename the gli_set_gl9763e() to gl9763e_hw_setting()
> >            for consistency.
> >
> > ----------------- original cover letter from v1 -----------------
> > Due to a flaw in the hardware design, the GL9763e replay timer frequent=
ly
> > times out when ASPM is enabled. As a result, the warning messages will
> > often appear in the system log when the system accesses the GL9763e
> > PCI config. Therefore, the replay timer timeout must be masked.
> >
> > Changes in v1 (July. 16, 2025)
> > * Rebase on latest mmc/next.
> > * Mask replay timer timeout of AER for the GL9763e.
> >
> > Victor Shih (3):
> >   mmc: sdhci-pci-gli: Add a new function to simplify the code
> >   mmc: sdhci-pci-gli: GL9763e: Rename the gli_set_gl9763e() for
> >     consistency
> >   mmc: sdhci-pci-gli: GL9763e: Mask the replay timer timeout of AER
> >
> >  drivers/mmc/host/sdhci-pci-gli.c | 37 ++++++++++++++++++--------------
> >  1 file changed, 21 insertions(+), 16 deletions(-)
> >
> > --
> > 2.43.0
> >
