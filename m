Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883912E9EAD
	for <linux-mmc@vger.kernel.org>; Thu,  3 Jul 2025 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552305; cv=none; b=mHlsClWfjYhIR4aSmxmG6+O37OkjaikbwC0WvrEcUISiafsl75A0EV/83ewDXPbbbGj3G+8kKnG8oBTnD9vo7rPYiJStsw+B6d7f2WAkSMurhwQeNKif+G4sFdsUtIWEitd7Atx5N4KXtokhNszYhcjxwgkT3HpB5QwiYdNsJ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552305; c=relaxed/simple;
	bh=esHDcG+Fd2R01UIixorvKM1CIIyYwF/rF08rAwEJAM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rCpbI623KjsXH8cdau7WBmBQ5iJtk3bNr1LtyBe4z2R96DkZL95RopBYcuieqii+rZGNmlUnWb0GoBtDa6pzM1SgeSLPexyMkWozT7fRIpjgR+LTD3w+07ZWaNZnD3JT/Sa7+my5lkm5abqCGTlamWFXgDTM1Ruy/X5V/86Du54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YtI2OVVL; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YtI2OVVL"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71173646662so60399397b3.2
        for <linux-mmc@vger.kernel.org>; Thu, 03 Jul 2025 07:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751552302; x=1752157102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgN20ThRnhhSyCTCXxiKR/V5yEId2hnk/jbPxyM41ic=;
        b=YtI2OVVLxKq4hS2/5b4zr1xTWl8O+AKYq4OWihlvqwso2HxW2SOnITaQ2Rncmz9XMj
         8VVWOmdGD/O1ws2P10hf0ESx+IoG1XoEWZWMsIW4AnpkEIRTCfYDOcPPdMLPtonGOrOY
         PUqIil21ozldpKMQrvw5tefWUZWwufTtH+oZq5tUHs41Q2l7Awl7sebb44HOt2O9/Mfm
         HJVyiDY3QMAG0NZ1ii5Qhu0WCSadFgq6G9KTjsmUBVKekEZbpXmZ8ixDkRTbpGaYxidr
         Q8SuyJewBVcYt8xhSn2LJs3XpqyyuLxVRZlskeU+VTXFAitU1iVf9cn/7ktVgqIrfvlH
         mRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751552302; x=1752157102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LgN20ThRnhhSyCTCXxiKR/V5yEId2hnk/jbPxyM41ic=;
        b=w5tc5/Z3lcfMHmI5mXxScEpnQ2HnjbbIGfwXM0KiOiJlGT3TchxbkJonJmhJW/pp+W
         U0Jn7VvZ7lDQbhlnoi0f4H7IRqFvA9TjSqtRG4yaT/l6CxFugJAuzE/kP78SIJaiIC3+
         NCsmzRpySgDg4ZdQSjSJP89BT4JKfjWDu/3yWXhaokmLq4SX+CRm5g7MvwnSHWDiS8Xu
         N5B5YnHeyFy7mvlhvtQCBP1LgCLQL1ctAvHngJtqW+four0/CXN9lEBcBV0OJvpXOLCK
         yFpvwsEb4zkcLrjTgTbbMmX+oUcaeQZikwjuF5smSYZ8SFgAwFT5hQccwvPrya+tqueR
         UO2Q==
X-Gm-Message-State: AOJu0YyScmH+gPpeEerbxf9ZN/QO5lynEDHGlJAD0keAuWnCJWu4wh7H
	gmaYClpBKBt6aJwt6QTzQVo/ZjvryO6IWt838edgi0x8Gpa6wn057Wt6XGXA2XTVaUSzz9HPOjn
	n/pwzR0jrn3niDczHFlrY1I9pcflEcjW9KkW+wp6q3A==
X-Gm-Gg: ASbGncsbA6z3lBn+npjZdDUJa2mi9XFkCAgCYKAKeeML2h64Ug7TCQtTs6jyHluboZ1
	KkL0AKINWXmj5Jvj1lTUG0bI5yItidbMDC1PeMEVy17U9wgUcVuZnniroO0defbuIp98lMXQkkK
	GU2/i3CsCeCAbxwAxtsnFIZRSb2YKEjSjjoHblfDcc6/1r
X-Google-Smtp-Source: AGHT+IHTVMAbLnJYqA2Y29rcLX7sgrl6AAuo4wDyICnVOwVGQ7PB2H/kn8FGzXAE4cyx2p8bY/JnsVpkMv/DwOh2yvY=
X-Received: by 2002:a05:690c:6e04:b0:70a:2675:70b3 with SMTP id
 00721157ae682-716590c3752mr47926877b3.17.1751552302395; Thu, 03 Jul 2025
 07:18:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630072420.114967-1-avri.altman@sandisk.com>
In-Reply-To: <20250630072420.114967-1-avri.altman@sandisk.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Jul 2025 16:17:46 +0200
X-Gm-Features: Ac12FXzfLSnl2_8_ui8WZ6aogFAhcCirlNP4Zvzrt_ghVY9VeevZHwJ8rvNIqKg
Message-ID: <CAPDyKFqenCUTcdFM5T99b=+p-RjUthv0ujxAO_de_sEVr-EMgQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] mmc-utils: Improve version reporting
To: Avri Altman <avri.altman@sandisk.com>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Jun 2025 at 09:24, Avri Altman <avri.altman@sandisk.com> wrote:
>
> This series improves version reporting in mmc-utils to make it easier
> for users and developers to identify the exact build in use, which is
> especially helpful for debugging and support=E2=80=94particularly since m=
any
> users run pre-built binaries.
>
> These changes should make it easier to track and support mmc-utils
> deployments in the field.
>
> ---
> Changes since v1:
>  - Add a 3rd patch to print the version at program start
>
> Avri Altman (3):
>   mmc-utils: Add option to print version
>   mmc-utils: Makefile: Make version string to show commit date
>   mmc-utils: mmc.c: Print version at program start
>
>  Makefile |  4 +++-
>  mmc.c    | 12 +++++++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
>

Applied for mmc-utils master, thanks!

Kind regards
Uffe
