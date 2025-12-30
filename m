Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659411DF736
	for <linux-mmc@vger.kernel.org>; Tue, 30 Dec 2025 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767108837; cv=none; b=lvBUBr/EZb5EHMxVYLdmcOXDVlqmwYiEhMJ/Nu3SANsbNZbgIowgleI95nQSGlHwQUv2S9zIX44CyIpAKh/l736G+LVIKJJ4TBr9353VkrJ87ILzOyfMYShvOWj6/LjaHgx1lIUEYLh2+9FmqIaFLfg+Yv3NXZKkBWl6yIlsiZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767108837; c=relaxed/simple;
	bh=OSSJDBSmqDWMmNZLsaHKCjFMixLVoFpCKDiw4VTK//o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZSLJ4dP631ysj6529GKg505yGHEXrnZiaX7DXHgsp+u0hH5loWmzM3QcEsPihq6q2LhsQeZYLhpJ8tXhdO2VAQKmf0EIJz7tjJA7MwGK5O/zjJwHWfEVl7Epa9oUDKsedHtAXuISKkjN8F6OhOIqEgz+TgXnzZyDyqmFJ5BUy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ePP5oPdx; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ePP5oPdx"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-596ba05aaecso10896439e87.0
        for <linux-mmc@vger.kernel.org>; Tue, 30 Dec 2025 07:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767108833; x=1767713633; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TYxaROQKxWcRTHR3znN8SgtkCp/+smLe2y5BzbdH+W0=;
        b=ePP5oPdxA4n7hi5CuF+rq3SNWeRXpZuyw3kGXse2S6WxsY2FyzSHysHzC+IAIRFBqc
         L1ZR5RI4/DDgwjoQAjYC/YIb1+qCGv6VR4+YroswfYwVT20+wjkxSCmDVRMhWIFm4W2a
         z7Cq5J4E40b46ugOBxImFCCeZCm9wID9MxQKlGLSs/VzHJrzj6iwIIclIx+gTgDkm7rv
         60r+9DNp8H+zybBXeyds4SyA9UL/vVlb2VPs06VEQ9o8B5yztPbupgetg+HQmUunlk4f
         +wvl0Hx3YAE6nzFjNJYp0+hxeZnRtwxUszfNx6p8p/nRKtRIRIvn/nY6y7HydEWJqKUx
         +8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767108833; x=1767713633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYxaROQKxWcRTHR3znN8SgtkCp/+smLe2y5BzbdH+W0=;
        b=Q6DxzqqK2vD0Glzf8FaaVNxKLcwWXfxWaqxesBGUtd1loVAbaAmJPb1OztPTbltZj4
         yv87uE0JQJGdOsmjJqxvlBskw7NTZV2/D9WOzd8PRYZri2fdsXgWsT3kSvJFmMrzbkPI
         34+U3Mgi9yKL4TukHtNInRixjODq6TGzZ5Bd/TDSB9ltO3mu9pTlObr72giGdhO8EuOR
         pNiJBGBZ20KoqgorZ64bk18i7y4gTxBvGZ4vkz72bZW7Rx76U+1QNWSFc+SRCrx/hOmj
         rKZJ+HB9kKFa/SNVldNa5aKqYpGw9mGr8wsrwXGOWkPPM6iXo0PZXnj1IuqmTHCU0HkZ
         D8FA==
X-Gm-Message-State: AOJu0YyhQ7sZRzIzzoSFIae9AXny2MJ14MgeMvMa89JmEIFJ0Lqi4NIL
	xY9OKOTUrm9HJIaUOF6KRf38uORfKxrqXqNeDw8cF/DGTDysXApPSrqQMs4VQMmMo6qajmRBwuY
	IpSvntAyJk+vfjPw3bYTF9DdHmjCSWn3qL1VU7cdNeg==
X-Gm-Gg: AY/fxX6+jjxW0fmjvA2MHupy/jkzGwCt5z+LyBHkrEDqBfBItF6iiPIEJoTmxE+Iu+m
	6cpG238Y1Zf7FullHhL5i+eK6ITNQfTsgJ+sRj3x9b8gaNbI0yG44jPf5r2cwL3M0DOFG+bPMnL
	cTKrNV9LfGgkSAyaqDG9c4QRLX9wRFVM7diiI4BQYbfWXY5JbwFTmYfzcv3yybh3+jVETVo/KOz
	WLAzbm/Cx/pOWGWp8tKfyI4rXbQpf5uIal9PsGycLywqUxFqnN3pktr7jwX5QhUelTZsByN
X-Google-Smtp-Source: AGHT+IH2dT6/NzAqkSzuEM+m91/RcJVyafUNz4GNUxXl2AjfCw38ypa6+HhCMapwNFygiyrIYqSrrT0fObZPdesCHaI=
X-Received: by 2002:a05:6512:3985:b0:595:83fe:6994 with SMTP id
 2adb3069b0e04-59a17d4ed37mr12112327e87.33.1767108831591; Tue, 30 Dec 2025
 07:33:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221080020.4532-1-avri.altman@gmail.com>
In-Reply-To: <20251221080020.4532-1-avri.altman@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 30 Dec 2025 16:33:15 +0100
X-Gm-Features: AQt7F2pocKbsiqOYn28Ee7OJuRIQxiWfFnniOceW89jBey_6vKP_d6WrxU2t2NY
Message-ID: <CAPDyKFqDn=2ovsr9CtHjSp7PUSsxDPMoJxd8wndNUV2b2UxSZg@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc-utils: lsmmc: Fix Manufacturing Date decoding
To: avri.altman@gmail.com
Cc: linux-mmc@vger.kernel.org, Avri Altman <avri.altman@sandisk.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 21 Dec 2025 at 09:00, <avri.altman@gmail.com> wrote:
>
> From: Avri Altman <avri.altman@sandisk.com>
>
> This series fixes the decoding of the Manufacturing Date (MDT) field in
> the CID register within `lsmmc`.
>
> The MDT year field is a 4-bit value relative to a base year. To determine
> the correct base year (1997, 2013, or 2029), the tool must consult the
> Extended CSD Revision (EXT_CSD_REV).
>
> Previously, `lsmmc` processed registers in isolation and often lacked
> access to the EXT_CSD revision, leading to incorrect dates (e.g.,
> interpreting a 2022 card as 2006).
>
> Patch 1 updates the CID printing logic to select the correct base year
> based on the cached EXT_CSD revision.
>
> Patch 2 ensures that `lsmmc` successfully retrieves and caches the
> EXT_CSD revision.
>
> Avri Altman (2):
>   mmc-utils: lsmmc: fix CID manufacturing date decoding
>   mmc-utils: lsmmc: cache ext_csd revision for MMC devices
>
>  lsmmc.c    | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  mmc_cmds.c |  2 +-
>  mmc_cmds.h |  3 +++
>  3 files changed, 62 insertions(+), 3 deletions(-)
>
> --
> 2.34.1
>

The series applied for mmc-utils master, thanks!

Kind regards
Uffe
