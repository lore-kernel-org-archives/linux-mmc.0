Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD6E288C03
	for <linux-mmc@vger.kernel.org>; Tue, 24 Jun 2025 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760918; cv=none; b=ga5/Y/hPX8rJpyCK2oIckhnl1zpckuO2ADqviCtS4cLCPS83zvKFE5IGCvT2q4LJ/espUhIYzOQsXuupsz7IweLqCqtvMAK2KzMzvaxhhxkHPHNqm1wXAD8CXijqaEc4OA3bNp1Z5O3mLJsSl5/E5pa3VyDP3OKD8JlaNTfOTQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760918; c=relaxed/simple;
	bh=P+F7HuhJyYeiaubVVEerRYRyB03ab1vaisUkvGUc6+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5EOI9HQXnb1bPPR/iPSY6QP2S/4JYMbfrQqGEuSQlHwSr1yf7TEBdKUan3RJ+PEB4ixPJpse2lpY4wD01ho+zVs5HZVA0Xo9ItOGiEGxYk2XAphGwKVAFKQNC/gMBC8tprrfLt9MRMpZbSqeeIC+JF+v/u9Mf2eWTLykU7fyrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iavHCBtB; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iavHCBtB"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e8276224c65so236777276.0
        for <linux-mmc@vger.kernel.org>; Tue, 24 Jun 2025 03:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750760914; x=1751365714; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8emxUm9JZ1T+xhGBk0hQUdklOQOUFG5o3v3YHWkfMvs=;
        b=iavHCBtBl6FXPnI7zURL0eYLITt1aPSP+5KzvS3HBKFwBst4/MDAvsXzkjg3a6wRiw
         3MYjbr6wZnJB1wadu5dHjTywR8G9t5O3DiT1o/J74aqRR+R11DMpCaGvFEx/L8Lspuaw
         WXOFvUrToE/gfOoPb5+EHj2a2QCgHCyk+aqDKoHiSRZgwG4jClYLaBhp+fWNbTnkyR36
         x3xwl1YgDFK+AarpYjJIcZK2zSRHH3qfM3LcioWJg5lvFC/pyVQ+6kAT4/Jcmjt4WiJF
         DWfDU4DzApO753lETRc9uflFHD5HM9ZEJikgOSdNS2TLPjZXeSAU4s+qkD/v3WJ91nbR
         HTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750760914; x=1751365714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8emxUm9JZ1T+xhGBk0hQUdklOQOUFG5o3v3YHWkfMvs=;
        b=c0S2upE/t9A5xOXObk6Tomt5FVU0lOUqPq7iWPkUpG2C4DXDazDfzzlmngg5XDEwdk
         TYv5kImI2pBgY1UX3QRBL/+kXkKnlnSMRA4qYzLVxWq9bWdNpZ8jM5aBTG36ILXT351k
         kbP5s5VQUdtMYEXu5R5+KyrdRlSYUpUIFw//EPoo1xPAYVhiAaZSREnritm/I5Amr6C+
         G6LJO2J1qp2d8LsSKaDmIQXKv+LKbZFcYNwVi+kMxtOs1bW6ETxW5VT/d0yCtsf9ChtI
         +0+WVFXgK/hyILP6Yl6HmMsIq1PL8sTAZrW5GNkaF0MWJ62sPvp4EZKoFl6VHjPrUq0x
         k/tw==
X-Forwarded-Encrypted: i=1; AJvYcCV4S6+Hn7aSeovirpl1AowupQUXTWCZkU6YkHDsDywPTjxIqoQ4eVCejF4uRCTxjq/ZgX+C8iyPuR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYHUiPYRCmW1aJoblDhE15Wn4JcBNa9OKNUT5qVEIdrQt5vHL8
	5Ly23wTO7RCW54OdPKUTODjYLiG9mytog+2tdt/xfMNHRMI3U2yOjd+ghT/FvZcdy+00smJLjlS
	Zaz0ZKMgD3TkstMIJp9tq2uHzBhp+AdD1PzLfBa/9zNdkSvQnObi7
X-Gm-Gg: ASbGncvsFZqV8AXTj3VvQjkIN231sUtJyzu14SAA2byLd+OU9tHQGPZW+xTwEZDQpOR
	tYyfiW+vKSNFbSq8TP196SnAlkTL3K0mYUnySuRjutVmHyZ1LL08hEGDJl88qxj45gJRkYRwOz6
	O6ys8JBi5Cx0yIQN6SRjdnmS8hpziKGSX9Yw15q/9Eo5w1
X-Google-Smtp-Source: AGHT+IEdThWTmLLNfiUtG3VUyHRE25V0kv1+A12ExLxP2tkk5Vks/Nzew7mWqvXUeRq44AMQqivzbKBdiLtcHSJaEaU=
X-Received: by 2002:a05:6902:100f:b0:e81:9e3b:fd16 with SMTP id
 3f1490d57ef6-e842bc888f8mr21351556276.20.1750760914494; Tue, 24 Jun 2025
 03:28:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250510-b220103c0-216fec070bba@bugzilla.kernel.org>
 <20250622-b220103c2-e5b82e240db0@bugzilla.kernel.org> <0159771a-8e3b-4be3-99f8-b660830560f6@intel.com>
In-Reply-To: <0159771a-8e3b-4be3-99f8-b660830560f6@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 24 Jun 2025 12:27:58 +0200
X-Gm-Features: AX0GCFs8eRuE8_-0v2dYubsdynQy0Xdn5QEDbvBanRvovL4h5558hwzRSpl49Ys
Message-ID: <CAPDyKFoB0P-ctChpAhQUjYbEU85K2yh+KrAgA+-uHDee=1E1xw@mail.gmail.com>
Subject: Re: UHS2 init fail
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: raoul via Bugspray Bot <bugbot@kernel.org>, ben.chuang@genesyslogic.com.tw, 
	victor.shih@genesyslogic.com.tw, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Jun 2025 at 10:26, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 22/06/2025 09:40, raoul via Bugspray Bot wrote:
> > raoul writes via Kernel.org Bugzilla:
> >
> > With kernel 6.15.3 and the latest linux-firmware (20250613), same sd card, I'm seeing this now:
> >
> > [  396.669202] mmc0: UHS2 Lane sync fail in 150ms.
> ...
> > [  396.679712] mmc0: failed to initial phy for UHS-II!
>
> There are 3 patches that make all these messages debug-only.
> The patches are queued for 6.17 but can be found in linux-next (1)
> or mmc tree 'next' branch (2).
>
> 6f3a2f9fd8161cb6a04d982ab1027321f7c8709c mmc: sdhci-uhs2: Adjust some error messages and register dump for SD UHS-II card
> 757611fc4bc52d9e2986e54df1d12c914e2da08c mmc: sdhci: Add a helper function for dump register in dynamic debug mode
> 790dc30477f2dec029a47ca536bc945557541395 mmc: core: Adjust some error messages for SD UHS-II cards
>
> (1) https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> (2) https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next
>
> > [  396.925968] mmc0: new UHS-I speed SDR104 SDXC card at address 59b4
> > [  396.947290] mmcblk0: mmc0:59b4 ED2S5 119 GiB
> > [  396.948374]  mmcblk0: p1
>
> IIRC the card was not a UHS-II card, so initializing
> UHS-I is success.  The messages may be ignored, but
> will not appear from 6.17 onward.

Let me add a stable tag to those commits above. It seems really
annoying to get bugreports for something that really isn't a problem.

>
> >
> > View: https://bugzilla.kernel.org/show_bug.cgi?id=220103#c2
> > You can reply to this message to join the discussion.
>

Kind regards
Uffe
