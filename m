Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C514A01
	for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 13:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785510; cv=none; b=NWQ73sMNlVRAQIMtcWr5fbL7faRBOZN9fQq4sgaWM0OOwcSctLwinQ2/HqLjJFR4u9I8WJnzLxEnaLwXj1EkUggKBRdAKOOn1a16swCLHxPzAe/N7mjdJZ0u2kFBkoHbJ6V7SGljt1qIFscU4ke8ngNBVMk2pz/KQ/16ye8sFRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785510; c=relaxed/simple;
	bh=O06P188+t5IkMOcphaknKbtZTwStMyYbeSy3ILdznBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/TY3cd9aEvY/oQ+5j4DMf8bG+unzH+0HXBtMnld9j6LxxzFbzUVZsX4AQVF/LzxcCp+/s4485h8fdgrMom9WxufhWHiIJSGQbmyYcv6Upsjskv/+3nP6hhv/WCVivbFptE4xilg4fSGQhi89Y6Vvw+CALCxMxXmrFeWT4Jj8Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cW5znQm+; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cW5znQm+"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6fead317874so59255527b3.0
        for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 06:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741785508; x=1742390308; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O06P188+t5IkMOcphaknKbtZTwStMyYbeSy3ILdznBw=;
        b=cW5znQm+YxZyBL0gizrTuUF7/JJWjsLGDEk+z/sV+cjcSGsUCu8y/P2ZUjtL+Dn+9v
         kZaEGRg+7q8kh6gssOPWckEfU6p0QQ2BECfUL0BANWwotvHE5nLPRKj8uJmH4oL94gO1
         Q4d02SZrn3bpjd1rEOGRW9+u9slnGvIJrgxYNf7MzDNVo1BmFZI/uqls+OMg08dg+uh0
         a38xa3eJ1Ce14K0G0i8K+telHcyS+KfLV778SzDMVeG2BklzKh+iXEaKCqTj7GvGv+HO
         c6k+gg60Dstgt8D17722d1ERF/C7FWZa/NHd8To2yxIpgoIzqeY2A7Df1HusIB474MOc
         QrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741785508; x=1742390308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O06P188+t5IkMOcphaknKbtZTwStMyYbeSy3ILdznBw=;
        b=tK68dpIW92BUNTcccqoQCveMC1WGQWm0JUD1TxtD7eVhM3rpcYcTee/8/m2PLiRRct
         Y57Cf6BtazyfoAML3F0O2WPx8fHd/CVMksZtXD7Oz3WDeEsaGfmvy5br5oUbJl8+OqD+
         P4OQJ8d/zATuv+cqHRvBslNdKkFb4Dbp8fZ4h/Pg/PjcrE45PSdHGyD11/7KF3QtVQAR
         RjYcTIta9+ZZA2QPrQTJ7cQxSPvqi9tZqqL7+KCMZOucbShdXfha2P/qZAEMyKRqh6tV
         AI8MeLoFCJmJOwc3QIuxU7AYC6LuVNhXxYwuCaG0b0lUiaDs0tLQz9BL8H4Gka0deHdw
         +IRA==
X-Forwarded-Encrypted: i=1; AJvYcCVA09yN9qnNiXdGjHNut/vAdxp7XqPK6kZZLka6LA0ImBLZvvf4HRT5RENVgqcmWecmbB1wrieYkTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXTA3XWeShF5k7AkEkru0atGcky6vYifMMDeY8cwM3PUgxa6B7
	GiQxBl+QgdIGV3P2hVBcAWqLX5TUPQei8NuncrhsarYG/S4kVQyk6SgYGFAMGx6hkiiEdiQlg1o
	4m0JaUh4I3thMvLTm2NQRXnAV3STrIrufbsL9og==
X-Gm-Gg: ASbGnctShn5+XJpUHH916gdsMI7n68RZmPYdWj/Z0bsxMz4wd34wJONuEd+S/VeG/1H
	RyQ9W29m/5TvGQy0X4+du2OCHfv6wFFqJgE25XDf3nOvwUpjpOPUYDLMYIjhMaOhKFssGAu7gGB
	GBIhIDtQjNeaX4/UdU57B6rp5G0DQ=
X-Google-Smtp-Source: AGHT+IGyzl7GwHaLZh3ygs+nju2rxMd7dGI+ZgAL00mTmKBqCqVGTlKAadXsmQ+m/M2fSAfYzFe/Q76nG6skzC09EPE=
X-Received: by 2002:a05:690c:6c02:b0:6e9:e097:718c with SMTP id
 00721157ae682-6febf2a450bmr305445347b3.6.1741785507753; Wed, 12 Mar 2025
 06:18:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206220940.10553-1-kamal.dasu@broadcom.com>
 <CAPDyKFq1ZbP4c9ECfM1SY+MEopf+dC19w9PkqXaUjevf=bPjcw@mail.gmail.com>
 <115a59e1-75b2-4d09-bbf9-50dfcd2b62dd@broadcom.com> <PH7PR16MB61967C18645C64E582B222B6E5FD2@PH7PR16MB6196.namprd16.prod.outlook.com>
 <d51a9d7a-b942-4c3b-93d2-65b1bb04c8da@broadcom.com>
In-Reply-To: <d51a9d7a-b942-4c3b-93d2-65b1bb04c8da@broadcom.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 14:17:52 +0100
X-Gm-Features: AQ5f1JqTx3pgXMeqFgFpSDIaSNIKY2an6JSCt033D3YeuQR5aENCOVJYaG8WOzA
Message-ID: <CAPDyKFrCjo8gGnxmXWP6V39N+b1o62VQH9zwMUNb2_+D3-qrdw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] mmc: sdhci-brcmstb: Add rpmb sharing support
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Avri Altman <Avri.Altman@sandisk.com>, Kamal Dasu <kamal.dasu@broadcom.com>, 
	Jens Wiklander <jens.wiklander@linaro.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>, 
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, 
	"bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Feb 2025 at 18:01, Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> On 2/11/25 00:13, Avri Altman wrote:
> >>>> This patch set adds support for Broadcom TZOS to read and write to
> >>>> RPMB partition using synchronized access to the controller hardware.
> > Practically it establishes a communication channel between the trust zone and the host controller regardless of the rpmb protocol.
> > Or did I get it wrong?
>
> Rather than communication channel, I would describe it as an arbitration
> scheme between N participants, with guaranteed forward progress and
> fairness between all participants.

A scheduler in the MMC controller HW?

Nevertheless, it means bypassing the I/O scheduler in Linux and the
mmc block layer, kind of breaking "fairness" from Linux point of view.

>
> The interest here is for one of those participants to own the eMMC
> controller for a certain amount of time and indicate when it is done
> with it. This is not specific to eMMC as this could scale to virtually
> any piece of HW that is driven by transactions from a CPU, but the main
> application is for allowing the Trusted OS to own the eMMC controller
> for a short period of time in order to do its RPMB access, and then give
> it back in the same state it found it to the next participant.

Honestly, I think this is a really terrible idea, sorry.

Data and communication with an eMMC needs to be synchronized and
managed by a single owner. Having multiple clients with their own
channel to the eMMC sounds prone to problems. Is each client going to
have its own mmc protocol stack, dealing with eMMC initialization,
data-synchronization and power-management, etc?

As I said, we now have the RPMB subsystem for in-kernel access. Please
use it instead.

Kind regards
Uffe
