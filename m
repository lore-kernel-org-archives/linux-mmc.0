Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6C4227EAF;
	Fri, 23 May 2025 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747997047; cv=none; b=uVNtnn5UlJqLn0tcFZw1VDp0XkdmNpPEkNYfw8FDJCte89uJaiqx+jTCSyv9zIuNP6dSTFQrgVww2vbMvpo92OuzemaXBrIrhbPuscXyXJ0OWrns0cN0zzp+JoYikitmZGTb3bL50EkxhCoJcxCqrBRuNDzzRHgFwr5PekPzivE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747997047; c=relaxed/simple;
	bh=CALVRGFkRUMrpU+/auzhJ/sMI1jrA5CkHJVJ8Yp4CE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9NQARKkOOGiUaVNY0kLh4SYJLX57hJSvR6q9GEun1MzPuFlpcvpBqHAC+9C+GroZTB+2WNKPFfa0mF9ywNAqZijwDaV1rE+mLtnykSv4jp9v0F+0G9vqO1ZZHwHeMLsdTD1c9c6rD7VdfVOThGzwfmvQer5tbMqu701p3/MAJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeJNTPk6; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeJNTPk6"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-52eea8111easo1722476e0c.2;
        Fri, 23 May 2025 03:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747997044; x=1748601844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRltuIV1JclBPsVSQ1+d3NqVlSQG4Pq4+U0wRJnmlwI=;
        b=TeJNTPk63cE/nxUDBV3BDVkJtk/b61KYDPbXA2x3UM6QL7pD8yRMNi/kT+32TKHxhw
         Yd12pzaiyCoAnWQAnoX2f3vY75OD2Onw04LIS7KCHve8sIvap6YSj2up7KC7OFLSQj9A
         egFRrB7KuB7k60HzDecVC92ZtASpYNPEZOb04yWj0YH6dlcrLzKHCyaTuxtBtpOUMbQR
         F3STVQndIQTtynrIfypgZYmaCHQDNGfxj0UJYLWzXrW8D+KLP7QH3s6//CFSzwkWQw2M
         oRPn5vaTMh1URGj69lgEAqG+yI2XqKykYRsu4ZGDmb+yqoEsQmoRJR+HuxPOZsR5oGx6
         k8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747997044; x=1748601844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRltuIV1JclBPsVSQ1+d3NqVlSQG4Pq4+U0wRJnmlwI=;
        b=t0SRf9cjBmILkGPFWOTWpKOnOI2I5JTD0y1Qh1DcORWkEeW1kQdp1HS42e243gongt
         UUcGGjqkWR33CgiUrPVFBswMSk4YSQrbhrgxh+mmNM2dbbyruzY0n+q7try16iTVqQcr
         vyZem8HOxBlOemV/Fxzt03Ah4bEqSp22ap3Ft8NW7BmzAsuxj1bqKY+dKt3e6kZ8Off9
         Tjrn8WeZKKyiGM3NCLuIQSZfuNHkuyVSIoi4D9PB+QmjRs4gBlTmDhuIAeoeuqIYM+y6
         Me0loUECeIqaWnx67593Ck0u/3OBlxWhzwxARis2Y52bPgpWk7LdNetqNp7b5ukIgPrO
         X5TA==
X-Forwarded-Encrypted: i=1; AJvYcCUKqB+FbgFyic9y0FdDZ9FMs6SzckCOQuEvRTdIPRBz8QmcVlOZd0pnC0igclKLzazqYXXw6jtR7vjDh7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHBmoBNV6CDp5rF+vbAjq7g33ltUXIJsoYBJP8+kXp8j/iSQAB
	Djb8c5bsd945hUMp1FQ6JV+0rWBA6KlkAiJAEKC0uSNAaAYXYr0lahRQiNhBkg9ML4r0PNwS931
	8mAO3uGCJIvdcLzNHIGoc1Kau/GTr6xM=
X-Gm-Gg: ASbGncs55ww2Vnxb8VBaIEAFH4MR9VYfJ8oA35dmGNacFFVtRLGkIDGMXFcXtpoK0ho
	zF9tkuGYfka8YWMxGt4Hme8D1OrzsuclEqCp+BWr8veVLVXTRBHlZfkIF+7yaxAKOiHKQcPdnXe
	OkZdWYS9eSTd9o1dWhbQto1+vjk1+lOiYKu7q/eoYpUt68biD1Xu2SO+5rv337NKk0kQTdhNObs
	/qV
X-Google-Smtp-Source: AGHT+IG6Hk/9cuxiozqdqyafirfer2grNa9TAla3dLdL7dfsbkXj72wEIFIar2DsHvu77xhiQyvngjaxKXNU6rfne1I=
X-Received: by 2002:a05:6122:caa:b0:520:61ee:c815 with SMTP id
 71dfb90a1353d-52dbce4a585mr24174105e0c.10.1747997044283; Fri, 23 May 2025
 03:44:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523103152.6210-1-victorshihgli@gmail.com>
In-Reply-To: <20250523103152.6210-1-victorshihgli@gmail.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Fri, 23 May 2025 18:43:52 +0800
X-Gm-Features: AX0GCFuLVR3QZU-FFNff2IcHQHw0dP8s417NB4nwTwPxx6LtVaYaZIiw_aoY0MM
Message-ID: <CAK00qKApgRsN1U3F3tVPMVOVKKpDa_nDA22NAqUzvDUhgraG=w@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] Adjust some error messages for SD UHS-II
 initialization process
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, Ben.Chuang@genesyslogic.com.tw, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Ulf and Adrian

Sorry, please ignore this series of patches and I'll resend the
correct V2 version of the patch.

Thanks, Victor Shih

On Fri, May 23, 2025 at 6:32=E2=80=AFPM Victor Shih <victorshihgli@gmail.co=
m> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Summary
> =3D=3D=3D=3D=3D=3D=3D
> It is normal that errors will occur when using non-UHS-II card to enter
> the UHS-II card initialization process. We should not be producing error
> messages and register dumps. Therefore, switch the error messages to debu=
g
> mode and register dumps to dynamic debug mode.
>
> Patch structure
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> patch#1: for core
> patch#2: for sdhci
>
> Changes in v2 (May. 23, 2025)
> * Rebase on latest mmc/next.
> * Patch#1: Drop the use of DBG macro and use pr_debug() instead.
> * Patch#2: Drop the use of DBG macro in some function
>            and use pr_debug() instead.
>
> ----------------- original cover letter from v1 -----------------
> Summary
> =3D=3D=3D=3D=3D=3D=3D
> It is normal that errors will occur when using non-UHS-II card to enter
> the UHS-II card initialization process. We should not be producing error
> messages and register dumps. Therefore, switch the error messages to debu=
g
> mode and register dumps to dynamic debug mode.
>
> Patch structure
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> patch#1: for core
> patch#2: for sdhci
>
> Changes in v1 (May. 16, 2025)
> * Rebase on latest mmc/next.
> * Patch#1: Adjust some error messages for SD UHS-II cards.
> * Patch#2: Adjust some error messages and register dump for SD UHS-II car=
d
>
> Victor Shih (2):
>   mmc: core: Adjust some error messages for SD UHS-II cards
>   mmc: sdhci-uhs2: Adjust some error messages and register dump for SD
>     UHS-II card
>
>  drivers/mmc/core/sd_uhs2.c    |  8 ++++++--
>  drivers/mmc/host/sdhci-uhs2.c | 18 +++++++++---------
>  drivers/mmc/host/sdhci.h      | 16 ++++++++++++++++
>  3 files changed, 31 insertions(+), 11 deletions(-)
>
> --
> 2.43.0
>
