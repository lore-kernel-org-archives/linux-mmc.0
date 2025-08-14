Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3833D321423;
	Thu, 14 Aug 2025 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180704; cv=none; b=jieb0eFm8R8s6/nxTv8qpPLNmiSubEjRYzdiCmNuRckW+xkzXE9SSpwkDb1b3WEqU9XASvGHmrrqOOt7iuDyI2FNza/FGoMTJu4kT9AKro23HrAreyL8a/mttET7NkHwN8mL7kZK+3/A5eoP+VgA6Y7nosF9oU9V/40HN245/1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180704; c=relaxed/simple;
	bh=vBZs5p9a6kfXe/2QUcnM8YpnGgjkxpBvaOlK39hjGxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GvVYzQZkPbJRbqdf7xLWomgTUtAhTQs1Y/W2zvqPvWaDFO4YERcXHuTWyjSinZWV/WeJxMNCjqQCtNu0LKLUIeP5OUvhdx+sZhL9D7U/JEOKbFpDuxaO9BhZU0MlWIFGvh+xUSwz55rv7DeVNnc2ns0c3AlE5XFwt39fp11QZa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErOiAwfi; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErOiAwfi"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-53b1717c562so731379e0c.0;
        Thu, 14 Aug 2025 07:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755180702; x=1755785502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDj5ATn40XEd/bbOphW/tzB9rio0vvd0q3Gg5MgYsjk=;
        b=ErOiAwfiYrKbs4GGQZBkNKcKKPO+wAFaO79BJL2UgBjmTIMeMt1cRrCBPmrqaI4wVo
         fJ5e9243hGla9EbGykxrkhx/lsnNWjl5g61o0XholHYfNk3fnc/Ri7NOOvCZScVneOW0
         DV9sCDbzSrOFoayHq1J0yC/Znz6hl98kOVtfxgS0Lk3sghrWx2epZxCUO4pHKsxJXGKp
         jhnFIeqh4gLqwLS77t7Moj9HwZz/PMZ/+tdyCMVanDMvBbJyB4LqH98WmGp9oYdK+fvU
         WpLcdVMwI7XSsjGplxCCrpzdhSicQ/KO2KZyqwt2qGesYCRPkgOvJ4ZDiwkJMVV6M+As
         X8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755180702; x=1755785502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDj5ATn40XEd/bbOphW/tzB9rio0vvd0q3Gg5MgYsjk=;
        b=iwKLM4qo+nWWaMe8n5rPdl4aWcQ1tGb3xCAbvYQpo+w3KZk09AmP7DHSCsGfX28Hdy
         +lSss0Hh1U9e3MbAEpJ97/JXfWvAznaka5XgZSAaplogaVubA+TUIoS0svVgemGHcJic
         8sem5k4UGWIIyu6UqtUp9OeVr0L4HmTPziks//fWxo0tWBLM6tdE4yQ8GuqSBRvwiQY2
         y/OMGAzvzIwW4w9nINE5lEwDhpz05onyHnzcDpPZAxJqNZhQKEDOl/+9atCrLBrekw91
         PT24KhZsyxdiZjh5YHx2yfvZyXtKXFLQrNk5IYLtsBla0XUfpbIpOGDl7GrLHaU0TtbY
         5wlg==
X-Forwarded-Encrypted: i=1; AJvYcCVE8y3pl/6Ml87ZVhI0THAyEH+QqV42fppPy57fDliOuXDdEaCLWFoJDCzdzHVTEMhgP/JlYfHbwPASv4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLKwGAKLvZFOvq3OS6zWpWcHqRiLklUV9J+/6m+MYvPH7GFimY
	gBg3Jp31iQ757TXNBXGpbJA/yiI91b/WCF06uQNZ4S7IfqjaSCyJYklOnc7sPjvhfdbGFtRJ8Wb
	H8Mnx/wTne8HEEbEKcG04p6jAgjrHWbs=
X-Gm-Gg: ASbGncsIOtpSOx9c6queE5kHAWH8l3igpJ8YuSPPhJ0iZOWg8LgsLecv8WXsAzBfaAy
	yawfQE/Ty+NN8vQJ7tFgQ2f3l7S23vP7D88416+efmhAKdj0ivV1krguRGYKv+JKge61GAyRTRn
	hDJKCJ3nMQFRbSSe0CzJcJTPz3JLmHfDDA4lzYAccW6kMm7bye3By+k6LuSmmx0BoixpzbEyVyO
	bSPTEtOLoBLRdUEXOWrWTgJ6KClFou6JYDE6HanIV3frCNnYPI=
X-Google-Smtp-Source: AGHT+IGWT84dUFhKnxmUTSxuImwlw7Qhs7B3QGRQqKNHZ32sHUFfrvR1LAaidKbn2MZq1Ju5AYhsCIPsDoY6DVzR92A=
X-Received: by 2002:a05:6122:8c0d:b0:531:2906:7525 with SMTP id
 71dfb90a1353d-53b189b6976mr1316662e0c.6.1755180701809; Thu, 14 Aug 2025
 07:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731065752.450231-1-victorshihgli@gmail.com>
In-Reply-To: <20250731065752.450231-1-victorshihgli@gmail.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Thu, 14 Aug 2025 22:11:29 +0800
X-Gm-Features: Ac12FXwz-1M3A1J090DuDyIfg2Q7VO0BQHLIiCI6caS3FzjN8XCAtCqqJ_oklyQ
Message-ID: <CAK00qKBzeXJMkYsz7zZTkLDgQ=EAoHvOzPrzmAbJeyUsMZZq0g@mail.gmail.com>
Subject: Re: [PATCH V4 0/3] Mask the replay timer timeout of AER for GL9763e
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	benchuanggli@gmail.com, ben.chuang@genesyslogic.com.tw, 
	HL.Liu@genesyslogic.com.tw, Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Ulf

I'm embarrassed to bother you, but could you help to  please review
this series of patches?
If there are any parts that need to be modified, please let me know.

Thanks, Victor Shih


On Thu, Jul 31, 2025 at 2:57=E2=80=AFPM Victor Shih <victorshihgli@gmail.co=
m> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> These patches add a sdhci_gli_mask_replay_timer_timeout() function
> to simplify some of the code and mask the replay timer timeout of AER
> for the GL9763e chipset.
>
> Changes in v4 (July. 31, 2025)
> * Rebase on latest mmc/next.
> * Patch#2: Add new message to the commit message to explain
>            why it has a stable tag.
>
> ----------------- original cover letter from v3 -----------------
> These patches add a sdhci_gli_mask_replay_timer_timeout() function
> to simplify some of the code and mask the replay timer timeout of AER
> for the GL9763e chipset.
>
> Changes in v3 (July. 29, 2025)
> * Rebase on latest mmc/next.
> * Split patch#2 in V2 into patch#2 and patch#3.
> * Patch#1: Correct the wrong parameters in the
>            sdhci_gli_mask_replay_timer_timeout() function.
>            Add new message to the commit message to explain
>            why it has a stable tag.
>            Add fixes tag to the commit message.
> * Patch#2: Add fixes tag to the commit message.
> * Patch#3: Add fixes tag to the commit message.
>
> ----------------- original cover letter from v2 -----------------
> These patches add a sdhci_gli_mask_replay_timer_timeout() function
> to simplify some of the code and mask the replay timer timeout of AER
> for the GL9763e chipset.
>
> Changes in v2 (July. 25, 2025)
> * Rebase on latest mmc/next.
> * Patch#1: Add a sdhci_gli_mask_replay_timer_timeout() function
>            to simplify some of the code.
> * Patch#2: Mask replay timer timeout of AER for the GL9763e.
> * Patch#2: Rename the gli_set_gl9763e() to gl9763e_hw_setting()
>            for consistency.
>
> ----------------- original cover letter from v1 -----------------
> Due to a flaw in the hardware design, the GL9763e replay timer frequently
> times out when ASPM is enabled. As a result, the warning messages will
> often appear in the system log when the system accesses the GL9763e
> PCI config. Therefore, the replay timer timeout must be masked.
>
> Changes in v1 (July. 16, 2025)
> * Rebase on latest mmc/next.
> * Mask replay timer timeout of AER for the GL9763e.
>
> Victor Shih (3):
>   mmc: sdhci-pci-gli: Add a new function to simplify the code
>   mmc: sdhci-pci-gli: GL9763e: Rename the gli_set_gl9763e() for
>     consistency
>   mmc: sdhci-pci-gli: GL9763e: Mask the replay timer timeout of AER
>
>  drivers/mmc/host/sdhci-pci-gli.c | 37 ++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 16 deletions(-)
>
> --
> 2.43.0
>
