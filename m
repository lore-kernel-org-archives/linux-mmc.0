Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0221BDA8C
	for <linux-mmc@vger.kernel.org>; Mon, 28 Oct 2024 11:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116359; cv=none; b=sXYKojfkUFWsatnCr59KePCcgGfDOIR1tdvEWUJdiPGxPUsriRvHkpUTEsmnNZeJhFS8Y+mXmzVUbiPQXXCMXNXrLoys7KmpDtZVEF7KAlEoqSytyB+XfKSnw4/OjV57aaQKxdYNtNnryvDZOa1rSUeu65veDsPXtVu60dLLB4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116359; c=relaxed/simple;
	bh=fJzRSevgpRIm3AEFzCEdm+GziNOoyiviPN9I1rCpZ0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GqCn53+695BHqYQEtWusWUUxJN4CCdDH8FgT1k0bwTfIA4yAiTBeO8lDPrSXNzF5IB7/aXJCUQ8gH9UOEOXBHCe6emjW3j5xrTopK55br90JBsAHRP2yUU3KS6AFD4ChMXpS6AoAjMcbftYd1+28UbfNLwwbFQa0rrazPe0g0Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LxBLHctA; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LxBLHctA"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ea1407e978so4316277b3.1
        for <linux-mmc@vger.kernel.org>; Mon, 28 Oct 2024 04:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730116356; x=1730721156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KoCQbia54G4nxIzYls71RpgLTTqVGkgyKzKzAA6TlwE=;
        b=LxBLHctAv1vYf4eyZQr84U9ckaoisqFyrwVDWnNgm3T7fu+K1fv0SZjDYWZQ4Qu2qY
         KH3tvev+IwBmtNf+A800J3YyU9/0uhujtWGLVz6oT6oY6Pz1CocRrdFncMaX8IyB+co3
         1Yimv004583fo82tkay265d4un1cXhG9k4gGmI7LAB5FADGq8ZDvlxmpeWUf9tnBUR9a
         YYj7yJ/FYhpWpTekb+9l8G4HdtSliQ6TO2L8NkBL2d9gFauE1N9BNU0fLxHcXibhytAF
         xNyjmEopTmg8iYML4Z3oQHmsaEUrrBi//J9m5YKwjbRnMtb56ltEXvQVOTRrWxLrgBW5
         FK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730116356; x=1730721156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KoCQbia54G4nxIzYls71RpgLTTqVGkgyKzKzAA6TlwE=;
        b=OQ/XlOO7kR+tSNLg/Aq1olhvA1aCsZ6m03tsob7LjIF4LwReC6ttZxbHtHuWBvKLFB
         WV2WDOLt5fX/8mVLy6q1dgwcwVKR+Tv+I1+unPMU4ncP4TXiw/t4Nc7DRRVt87ZYo/OO
         VaRKmzJwPBZUJ6LET7gLeaOqiBBauoZ98cQVv84rgpDDUJ9/ogs0ba4ML95YE/pFmooK
         M5wTXRfM2C7gjE6iNSMoRJl1o4l7yhP5meFFEUnKkv6cuX3Ap92sWC3d1qc+BuV2zi45
         MQeavxh1rSxKDZcB8phGN4eL9FV55z7MNQ2nH0t2yJcabvRbjKW8zLxQpA32nRPXn4/m
         SF6g==
X-Forwarded-Encrypted: i=1; AJvYcCWzk5ctiRQJ9U3+4cTFgr9MFOrVhAMW9k1JkyHJMaTEhn0Gaf4oSOjzNaULv7TkZKO0sf0byznLe8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn/WWqqYGk1j6eeiba4VzxRCiREaMc3jyl++x6fR8mbKbTh4QD
	uYafEgnfR4ERPiUsIG7915JIecaMiLc8npci/f25v610vLaiYZJ2jhfV2J3xG0mWH3PQz+XoH8q
	fa4Q3XV9VTQfw0usxQWUf6GNejseGJcTOgQC9fhFjaou9ZXwJeQA=
X-Google-Smtp-Source: AGHT+IEE2aBSIgy8byIyg2l4p9ZPUVjQluqtmANmq+eODyck3I7WPPej0mD9y2DzA70ycDOntX2wkwMJ1q9LdOqEriY=
X-Received: by 2002:a05:690c:f06:b0:6e2:636:d9ed with SMTP id
 00721157ae682-6e9d891eb15mr55877867b3.3.1730116355765; Mon, 28 Oct 2024
 04:52:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025203454.162710-1-beanhuo@iokpp.de>
In-Reply-To: <20241025203454.162710-1-beanhuo@iokpp.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 28 Oct 2024 12:52:00 +0100
Message-ID: <CAPDyKFrhcLHo5pVW1ZmuEBnHdkTkFG9yCcyWuQy4pTYWe=_sMQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Add multiple FFU modes based on eMMC specification
 6.6.18 for flexible firmware updates
To: Bean Huo <beanhuo@iokpp.de>
Cc: avri.altman@wdc.com, linux-mmc@vger.kernel.org, vfazio@xes-inc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Oct 2024 at 22:35, Bean Huo <beanhuo@iokpp.de> wrote:
>
> Following the discussions with Avri at the 2024 ALPSS, I am submitting th=
ese patches to
> introduce multiple FFU modes, as defined in the eMMC specification 6.6.18=
.
>
> The new FFU implementation can support diverse vendor requirements and op=
erational conditions.
> The key benefits include:
>
> 1, The host can select the most appropriate update mode based on device c=
apabilities and
> firmware size.
> 2, The patches ensure that firmware downloads are treated as a single, un=
interrupted operation,
> preventing partial updates that could compromise device stability.
> 3, Some new modes keep the device in FFU mode throughout the process, red=
ucing the risk of
> premature exits and update failures.
>
> By supporting these modes, we can better accommodate varying firmware siz=
es and ensure smoother,
> more reliable firmware updates across different scenarios.
>
>
> Summary of Changes:
>
> Default FFU mode: "mmc ffu"
> Uses CMD6 to enter FFU mode, CMD23 to set the block count, CMD25 for mult=
iple-block write, and
> CMD6 to exit FFU mode. This mode may exit FFU mode during the download if=
 the firmware size exceeds
> the chunk size.
>
> Optional FFU mode 1:
> Similar to default FFU mode, but repeats CMD23+CMD25 for each chunk, ensu=
ring FFU mode is maintained
> throughout the firmware download. FFU mode is only exited after the entir=
e firmware has been
> successfully downloaded.
>
> Optional FFU mode 2: use CMD25+CMD12 for open-ended multiple-block write
> Introduces a method using CMD25 for open-ended multiple-block writes foll=
owed by CMD12 to stop
> the transmission. This allows for a smoother and more continuous firmware=
 bundle download.
>
> Optional FFU mode 3: use CMD6 and CMD24 for single-block write
> A new mode that uses CMD6 to enter FFU mode, CMD24 for single-block write=
s, and CMD6 to exit FFU
> mode after each write cycle. This ensures granular control over each bloc=
k but may introduce more
> frequent mode transitions.
>
> Optional FFU mode 4: use CMD6 and repeated CMD24 sequence
> In this mode, CMD6 is used to enter FFU mode, followed by repeated CMD24 =
single-block writes.
> After all firmware data is written, CMD6 is used to exit FFU mode, ensuri=
ng an atomic and
> uninterrupted download process.
>
>
> Changelog:
>
>  v1 -- v2:
>         1. Added memset() to clean command structure
>  v2 -- V3:
>         1. Refactor patch, and remove ffu dedicated file mmc_ffu.c
>  v3 -- v4:
>         1. Incorporated Avri=E2=80=99s comments
>         2. Due to "ERROR: in command 'ffu', 'ffu' is ambiguous" when usin=
g "mmc ffu", update
>            default FFU mode 'ffu' to 'ffu1'
> v4 -- v5:
>         1. Retain the default FFU mode as 'ffu' and rename the other FFU =
modes to 'opt_ffux' for consistency.
> v5 -- v6:
>         1. Fix a typo in patch [4/5] commit subject
>
> Bean Huo (5):
>   mmc-utils: Refactor common FFU code into functions to support
>     additional FFU modes
>   mmc-utils: Add FFU optional mode 1
>   mmc-utils: Add FFU optional mode 2 using CMD25+CMD12 for Open-ended
>     write download FW
>   mmc-utils: Add FFU optional mode 3 that uses CMD6 and CMD24
>     single-block write to download firmware
>   mmc-utils: Add FFU optional mode 4 for firmware download using
>     repeated CMD24 single-block write command
>
>  mmc.1      |  12 ++
>  mmc.c      |  20 +++
>  mmc.h      |   1 +
>  mmc_cmds.c | 492 ++++++++++++++++++++++++++++++++++++++---------------
>  mmc_cmds.h |   4 +
>  5 files changed, 389 insertions(+), 140 deletions(-)
>

The series applied to git.kernel.org/pub/scm/utils/mmc/mmc-utils.git
master, thanks!

Kind regards
Uffe
