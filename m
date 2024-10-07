Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD35433CA
	for <linux-mmc@vger.kernel.org>; Mon,  7 Oct 2024 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728294129; cv=none; b=UXWjtO178g8t+ipVaEKbr27MgWy2OiuKyKMZpGSbjfjbF+5Akqys4361a06E7hNp31GaL71Xm1PxyLILu40dt76c9YEhPhM0jBffO9MPDYKFjClysShvXuNOJkq2x5rB1QdViziocnRcf36uOLImW3T/m2FRocvo8qcK/bXLarY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728294129; c=relaxed/simple;
	bh=lEfYVFT3HbNF5XfS5lrGxJ4CBB9uhR9SXzL+cmVZen8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UCP/1N1v+H94rBxQ4uC3WIun0wrBWgTOeVIoXH4ED4fkmGr5+OWpJfkRNYIS8rBAPZiv096RWI9rBYR3GIsRpoIC2zxqI7khE+XHznL+Q6fg4sJArZ4/psskrfAKrT3AG6ZT1+bh1DNN2iE67BIMEqUksVNmhrB6ZDorqbh40MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jPIQ9259; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jPIQ9259"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e03caab48a2so3207078276.1
        for <linux-mmc@vger.kernel.org>; Mon, 07 Oct 2024 02:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728294127; x=1728898927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiatlVhaGBuayRJRI/DQzrQt1zknr0nqF+AyKHCS8FM=;
        b=jPIQ9259Ies4DQEv/s4iYo4lE9T2VORBnypMdd7TuYcRocbh+OLT06cKvWzFMkOiKu
         1I/5HrS2Gp+I8mhSG+55jLjKc0+hzVWIHz4JUr76bRVORtSm3z1AHO7h01zFEbcOPkV0
         cPUe3SuWX9esmgdpyNALjgLIjtw2T2D6EpzqquBBfH8+kNYS2mG8zFBYUC/YFjmoN1B5
         KdLgribAmsSbOcpRBx7GMyyQyw8bOyH2U/oJqQ/eJib6hiayv1ezS5I2a8xqHFRgiUdK
         dvaObYcAh6orZcutwgcoL2+0VUREYAXLI35xgXok3GnEQ02B9Xt5Cd0THlYtHlR5nOWd
         soSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728294127; x=1728898927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OiatlVhaGBuayRJRI/DQzrQt1zknr0nqF+AyKHCS8FM=;
        b=KZ35G1TbS0g5C/IakL+heBmdQ1tZ6bBbCGx79FisPhOQF9rlx5abUDAIHeLxl3N2Ef
         RyZIyhJHt9Da4ykZ6l6a/BfLoggNoaVR6crI//kI9nB80kYmczfu9Zq5wqG51Fd7TMIY
         4vX8Lcce7V2icRjyP4n4+D+8Wjku9FtL1KwaZch7vth6up6s302fpLOMnf3uSvESa6CU
         TyU+sJl3gCCNEaFIV3ngRENbA2+Sxp0FAW/eVp3hl03nUieiLpEPc6UZDKSLv2XFGX9V
         mb/9QL2L854xjyOT9jX6i5GzuHeQUOGb5CdjXbgFwH15FCF2PErX4dVS5rx7YkENsEKx
         cMLg==
X-Gm-Message-State: AOJu0YwXCi4cMXHIsjQYNmttcIQFNO9P8ustmFAP1Hf4JP+1QuR/Phjv
	4V7gzLo0cbrpBbTpd5eRLUfVyaIBDSufSmICL1cVG1o3GCiHNcWwkFJmCIEAKoj9lonn9Y5KSaj
	thWf76dmnEx+5CWBaas3rEyew6VyUX+A18dvtMg==
X-Google-Smtp-Source: AGHT+IGiOte+AA8rJQYGh/Eo36BWNxGVPtG7q/gbVdkGMhn9kLYun/HZVv0231tdLG7zDR70MzHc7SuhmWS4M8oV2pY=
X-Received: by 2002:a05:6902:d42:b0:e1d:91d4:3ddb with SMTP id
 3f1490d57ef6-e286fa8bf2cmr10426981276.20.1728294127018; Mon, 07 Oct 2024
 02:42:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006051148.160278-1-avri.altman@wdc.com>
In-Reply-To: <20241006051148.160278-1-avri.altman@wdc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 7 Oct 2024 11:41:30 +0200
Message-ID: <CAPDyKFoMXU=+WG1Pv1F6v5dsFryFZhrjP0Cyi1rTahRXwoLsSA@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] Add SDUC Support
To: Avri Altman <avri.altman@wdc.com>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Christian Loehle <christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 6 Oct 2024 at 07:13, Avri Altman <avri.altman@wdc.com> wrote:
>
> Ultra Capacity SD cards (SDUC) was already introduced in SD7.0.  Those
> cards support capacity larger than 2TB and up to including 128TB. Thus,
> the address range of the card expands beyond the 32-bit command
> argument. To that end, a new command - CMD22 is defined, to carry the
> extra 6-bit upper part of the 38-bit block address that enable access to
> 128TB memory space.
>
> SDUC capacity is agnostic to the interface mode: UHS-I and UHS-II =E2=80=
=93 Same
> as SDXC.
>
> The spec defines several extensions/modifications to the current SDXC
> cards, which we address in patches 1 - 10.  Otherwise requirements are
> out-of-scope of this change.  Specifically, CMDQ (CMD44+CMD45), and
> Extension for Video Speed Class (CMD20).
>
> First publication of SDUC was in [1].  This series was developed and
> tested separately from [1] and does not borrow from it.
>
> [1] https://lwn.net/Articles/982566/
>
> ---
> Changes in v8:
>  - Attend some final comments (Ulf)
>
> Changes in v7:
>  - Minimizes the padding further in mmc_command (Christian)
>  - Set the SD_OCR_2T when enabling SDUC (Adrian)
>  - Remove unnecessary casting (Adrian)
>  - Remove redundant else and switch patches 3 & 4 (Adrian)
>  - Add patch to prevent HSQ from enabling (Adrian)
>  - Remove redundant variable and make use of clamp_val (Adrian)
>
> Changes in v6:
>  - Remove Ricky's tested-by tag - the series has changed greatly
>  - Call mmc_send_ext_addr from mmc_start_request (Adrian)
>
> Changes in v5:
>  - leave out the mask in mmc_send_ext_addr (Adrian)
>  - leave out close-ended SDUC support
>  - remove 500msec write delay as there is no busy indication (Adrian)
>  - disable mmc-test for SDUC
>  - move enabling SDUC to the last patch (Adrian)
>
> Changes in v4:
>  - Squash patches 1 & 2 (Ulf)
>  - Amend SD_OCR_2T to SD_OCR_CCS in mmc_sd_get_cid (Ulf)
>  - Use card state instead of caps2 (Ricky & Ulf)
>  - Switch patches 5 & 6 (Ulf)
>
> Changes in v3:
>  - Some more kernel test robot fixes
>  - Fix a typo in a commit log (Ricky WU)
>  - Fix ACMD22 returned value
>  - Add 'Tested-by' tag for the whole series (Ricky WU)
>
> Changes in v2:
>  - Attend kernel test robot warnings
>
> ---
>
> Avri Altman (10):
>   mmc: sd: SDUC Support Recognition
>   mmc: sd: Add Extension memory addressing
>   mmc: core: Don't use close-ended rw for SDUC
>   mmc: core: Add open-ended Ext memory addressing
>   mmc: core: Allow mmc erase to carry large addresses
>   mmc: core: Add Ext memory addressing for erase
>   mmc: core: Adjust ACMD22 to SDUC
>   mmc: core: Disable SDUC for mmc_test
>   mmc: core: Prevent HSQ from enabling for SDUC
>   mmc: core: Enable SDUC
>
>  drivers/mmc/core/block.c    | 37 +++++++++++++++++++++-------
>  drivers/mmc/core/bus.c      |  4 +++-
>  drivers/mmc/core/card.h     |  3 +++
>  drivers/mmc/core/core.c     | 48 +++++++++++++++++++++++++------------
>  drivers/mmc/core/core.h     | 16 +++++++++----
>  drivers/mmc/core/mmc_test.c |  6 +++++
>  drivers/mmc/core/sd.c       | 38 +++++++++++++++++++----------
>  drivers/mmc/core/sd.h       |  2 +-
>  drivers/mmc/core/sd_ops.c   | 15 ++++++++++++
>  drivers/mmc/core/sd_ops.h   |  1 +
>  drivers/mmc/core/sdio.c     |  2 +-
>  include/linux/mmc/card.h    |  2 +-
>  include/linux/mmc/core.h    |  4 ++++
>  include/linux/mmc/sd.h      |  4 ++++
>  14 files changed, 137 insertions(+), 45 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
