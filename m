Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794302721;
	b=dR7wW7QDpEIN1gFDVypE2RCQrkRdFG59Q0M2ZUgd37vcbu4s4CQ3sLitOWWHxbUDeUrm
	 qnU24QN9RXYjVH2+6CMa7OC5oM/UZ+0WAxzqT5dDRdrd4wtsqdzk0tmVwgvivnF20Rl8+
	 D+e71iVJ6cy3L3sf0z10yjTnFlKk0yAemFeZ5QAzEIBpWoPp3NJmGNhth8nUx9hlEevTt
	 fdh7zh14O0dchJBiADC0rkVWGAQStB9btpkdFQZNTXNq3ejhfhnq06Ka3LDlCrC5Fkmr5
	 nW72/SKS7LMjCNUCc+mYm3Hbz1y7RgIwSaVHwo86irpBs31LvXzxmRqrUze7uGQdrmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302721;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=YhvIJXuyquHMGSngmZ4O4PsxJ4Wvcj08h08CfdMbZgg=;
	b=wMbvUVhl5UFud4VYVG/7mRU//8d92nPKQsYPhD8uhLFsNY/GWJeK7OSWCVDr4xVw+qz7
	 0MWq6aX8S9J21XHbpCUi0QeNMwHPvwhn5lywIYN9IgXB+sXKx2+hBRcmC5pB0y5kjEcHl
	 pGyHToieShGYO8esIgqFWM/i2+R9y4yg5YYgU7tUk540IQ+jPiDKSNK7Pby2p7VS8nJUA
	 PFqDU7+TPdOhLbzqaTslaGkJ4zjjSfoKxVDlhCS68pc8QWLnqwN8ey23YU8yBAGtll5vm
	 2bfsTGcGkr2XPAan63Qsl4jrE2udVmdGGCwAr3JZpZ+9PUbcBHOblahR2bGB01ltUIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=thegoodpenguin.co.uk;
	spf=pass smtp.mailfrom=thegoodpenguin.co.uk;
	dkim=pass header.d=thegoodpenguin-co-uk.20260707.gappssmtp.com header.i=@thegoodpenguin-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=n7slP0Ke;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1420F6071E68
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 09:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1420F6071E68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=thegoodpenguin-co-uk.20260707.gappssmtp.com header.i=@thegoodpenguin-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=n7slP0Ke
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91ecbdf5343so20831356d6.0
        for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 01:25:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794302715; cv=none;
        d=google.com; s=arc-20260327;
        b=jFIigis1xdpKEaTRjTGSGhQ/w1szszBPYC8L3Ie7h1DPCZtdzpxmnOdSg2lWA4azyM
         PB6AKZj8C3sZSZGEG+SY7xZ1vIe22Wgfuv2oUm5ti1IChOgBvrdK1f/LiJZ4JbMkPaW7
         rKyABOUiM3SbQJbMJewaJWpxj4RRXoyvdhvjaTVm1k2LNdCa0rwtkrSLvSEX1JWaeFy0
         DEWYl5cBIT18akuVdH/JVpEHQvX2qnFLOWmm90em+KmCYG++xLouFkeKlzSXwgfofa5l
         74tOKHZTR132pShATPjP/xGHWQKuqkmgcnZ59GPTQnENuX6jWJNga6uN9eBerL983/eo
         kL9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YhvIJXuyquHMGSngmZ4O4PsxJ4Wvcj08h08CfdMbZgg=;
        fh=TkFdBZGD6LDJxWDcCoCsXdBXQLdL3Es2uFQK4gRb4VY=;
        b=oV5SQ9/BLbKXKPK4p8R1jB49KGVBasYaU5wPIslZpIV9rhZ3S9yfT0+qYy4khTSUX6
         zzHdVxrM+78fGZPUn5Y5FVUwfnRQkDqWoMsBml32g+34uBFs8PvOrdVWuwZS3fdcZksJ
         HkugABjIt3g5WdZ6mBTk78d/qkJGqjgHBslnAPUIfE0Nl/lWVpUYHm1rfhUTnpiB2xzV
         7RUwNpMqD6esX2idg/oz2VDoH+8vqnz/6lAtrv+ZeX0sDoDubmavJlpBWpG9OCKy04mn
         0HlbOjHFV8/ZCbXv2ztlmI/p9ctsoq3mKWcBdJq02/lBu3yVmD5ADNf/XIJGPm658K3W
         Vu1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20260707.gappssmtp.com; s=20260707; t=1794302715; x=1794907515; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YhvIJXuyquHMGSngmZ4O4PsxJ4Wvcj08h08CfdMbZgg=;
        b=n7slP0KenygAoCjVBvNuZsNg0b05HgsqPIttZGI+TGQZh2jwunKhFZgD1PTL4T9GpU
         DMlD+KGamGZIOrNvSvKQa8pguHk+4rAoEcTOEGUlvibglchaR8BpCVTlod3OK6eAhcVW
         TbvH3KxeqNjcckSp9lc1PyYn3/4Vvw16xFdv7YYtjtZz2bBpOqai6apx41ZchTcjJ6t8
         KrRSmhTb3GBQNdr8qMq0Psu3+oQqeC6n40apriiDxTibwQ3P1UQNp0XAXjHdjulwiseT
         5LaKKs2BhVCavBESP9OX9I46JxAD+eKBvozPYNZoo3Y2BjtR10zm5/UoX4CUVBJwaBqP
         miCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794302715; x=1794907515;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YhvIJXuyquHMGSngmZ4O4PsxJ4Wvcj08h08CfdMbZgg=;
        b=bH7lQ5Q8kQiJ1sLnX6HLvEzSiiV4AheaSM/OlitHcpruSnqeBU7ru2ZiVrJeXtkKCm
         D/z1FJLO0HqREuHHNpgK4+8YjAESjG6q02lJCfvBFBB3fBgIce+5dv5J6yFQLtZnQezN
         kvwFsAfQeqYBLeiRDMfF1SVbH1zazz27AolworfJ+ofiDTO6IaHeoB5tx+/akJMTK7u4
         s5O9xZmZOQNWJJ2J32Dn5/umZ7vGYp3WAx/0ZdUvnwGAUPCtOE3fmCbKnqFpwJSX348a
         2fHzQO/7dpY2QhDAB+ybnoMeN3joF3RS4vaLvGsBlKBbMnA0i/t6Dt+IMHOQtLItpkdG
         frkg==
X-Forwarded-Encrypted: i=1; AL+hErHvCG1VOQZ2/1i5BWd8FF62bhO35uRfZuWMjIZVePiMX3dEoV3Op3QHjzCb1X5RE20QXG1Y10iXqIY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/QNpEbUGbRmUUAMirtbrI7hl10z4j1c7MYBYMScihvXAWU8gl8
	m2jrqLauTcx3jiRZNI7/ISWvFngOtLiOuc+/LTONTUeLvV24zGsOVjKL0lLZNFip4aOsDPAY1Af
	Wt25Tk55g2WSspMk7COIoU8e2iU8O9GwLxj1a53MpkA==
X-Gm-Gg: AYBFou3JTEFCTBw1XXNqnIm9/AY/1Hk0Xoeg0VknO5wf8x2l/HiabTNRaRXT2K9TAJ3
	zbIEG2cKDS033QZSDNQr265D3qSaR5xvhyfJuam6T0uCbpx0OaTuG1mEUTdXiSeq5jYx9CcdPf+
	MJWY8KvAddMvZnD2HobGyX2K/ahoQGkPQitDeL/LgelLysqK3ekjJ0xcfdFkJRoa7mBzVyQ07C2
	z9b6o7JUbAVIMKqk4Seh5l6wXo6Wp30+uj5oKDf5NmzIUvN2JYjq6tqVHz1e0R3bSnrC5rgcOsf
	EZIOlAbf1f9plZFbMSm4hGIb1w0zqVeOAsU9LSa/TUIMLz+QA4lC641bqNcPjSters2Eccm1+PH
	QegPWwZcFCbjdZg2hwf5JVUy31vmU6kB5F95miuOOzK2JOZHpjmNH5sa8YUocuFxJokU8OB2g
X-Received: by 2002:ad4:5aed:0:b0:91e:7939:dda5 with SMTP id
 6a1803df08f44-91ef04aae41mr26184836d6.23.1794302714950; Tue, 10 Nov 2026
 01:25:14 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106-acpi-mmc-v1-1-00934babd69e@thegoodpenguin.co.uk> <2ba59618-e537-4593-a840-744b2f26eb4b@intel.com>
In-Reply-To: <2ba59618-e537-4593-a840-744b2f26eb4b@intel.com>
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Tue, 10 Nov 2026 09:25:04 +0000
X-Gm-Features: AclHuK_6-XdyXM_BOekPeBuf7gmeMV5bzRDqK9Cg_lReAyOew94cN51o5FgzEf0
Message-ID: <CAA6zWZL1bSYNkOsRpANDwHSAK+Cp8GvbXnNHiP9fecA3ZP+Ctg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Use named initializers for acpi_device_id
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Hu Ziji <huziji@marvell.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

> Why is there a different explanation above the "---" than below "---" ?
 b4 will put the cover letter in the dropped section of a single patch
series, for more information please see [1]. There is no requirement
for them to be equal. The answer to your question is in the cover
letter itself: first series is a refactor pass to allow for the future
intended change in the acpi_device_id struct to go ahead without
triggering build errors. Describing future events in a git message
makes no sense to me.

> > Unify the list terminator to have a single space between the brackets and
> > no trailing comma.
>
> Why?
This seems to be explained in the paragraph above in the commit
message? I can repeat myself if it's not obvious.

[1] https://b4.docs.kernel.org/en/latest/contributor/prep.html#what-if-the-series-only-has-a-single-patch
