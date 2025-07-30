Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1134126CE1D
	for <linux-mmc@vger.kernel.org>; Wed, 30 Jul 2025 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753870294; cv=none; b=Ow+Itlvs30zQmNE7ZYDXXWfnok7L5nju1tFWiK++2EjoOZfwaK9FkF4JV05P7DPvBb36KnmbGg0CyxqRS5epab03XEL/PRpNfzLQcuTO0gQ8UREBwk+bDa1k3D/KUley3yyDJw4QjKctPy93zkHD61QZg+4WQXXi+beQNGQ4GOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753870294; c=relaxed/simple;
	bh=rHJp2LMtPMka2osjSmJcL8x7CrDwT39C9ONAOwFG+KQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KmDmI06BLu3hHD9u7TfeDMOoAa88LjUaRu95RQ6zPdXrrvs2T7R8OMjgx25tpebwLDYPheAunb8n3Qy2SOjV7i7Z7YET/cmsytJDx2H1weSVxHDabu2lrz3PieNUaT5Kaij7HQ6jCfUAFIN48MjwJOXQLtXrgqACvftV8NAcTCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LwsfZ89b; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LwsfZ89b"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71a206ec3a0so9503877b3.0
        for <linux-mmc@vger.kernel.org>; Wed, 30 Jul 2025 03:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753870292; x=1754475092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHJp2LMtPMka2osjSmJcL8x7CrDwT39C9ONAOwFG+KQ=;
        b=LwsfZ89bSCAjZ9to22dfD7zGiqmMWc8Rn9EYJDqcOjTuKIWQpS6yzMwoHlCV9Tw3pI
         4CzxakkdaKk7pcwCauHxBwCk69jYUf4zs39FvRy89yBYCDQHVGGW/+tnfXZY3qUF+6Cr
         GaSH251fSqM6vmY5Q39/m7F8zXykGfUs8XtTVmp4TYnJLqOiMBFUSWqtbA0rTANGq67S
         YcSwHwZljp7mbO5N61demGIN+kGGLKhfLiZvtM8qKjsEkMG2XheKSnpTDMzZnRH9/sUX
         TdbsuwDIZ+IQ1SBLEpVgU9KQC2NtxFrJOjRcEUPek2p1doj7BLvEijz5U/m7VLEb7kWt
         SzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753870292; x=1754475092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHJp2LMtPMka2osjSmJcL8x7CrDwT39C9ONAOwFG+KQ=;
        b=Ra6gq4Ti45+krB69e9tmuYvzFB8Ir0vLysXDwijZ+b6i4+zWDDpOksiehOHQ0TUeQT
         rv9Vq00frt+bz0KneT0XHQzZXiNxgmEXfSLG6k3ZyKzr3hvqomzcHxAcTALKf5Q0MY1w
         GMHVZtZdhiZhTcjZbmV4JYIcjYkUPFuI2y6CTSGo/cUDZTnpiyWABiGIiXvVOKSslv9x
         GdAGmXwdhoHsm1qWLaOcqMZodd9Yh0y0fy9Z79S4b8W634LALebeXq6KmGsoZs+x7WLt
         1dEZ0yu5JF7Sn5yNdhPHrKroq2uD+xjrA9/Y9xYz919Vi6nQYXi3lUVwghs0koR2DHpg
         qk9w==
X-Gm-Message-State: AOJu0YxGasE3NvKxZuVp/g+kBKCtUvCfKKBlqaa32253Ow1rM1fCqbHh
	vo4HGxLNTfVYnd1zTUrxUgJwc8x31q+JnxrzfVl3ffGPOMdVV5g7u2yJ71dRqBomJKqySsncLHs
	yg/UgZa5WMGGE9JiyvgUeTB0/7+eHHf6+YC6odoDP2Q==
X-Gm-Gg: ASbGncufJ0xAR04xZLFIkBQ+U2Iue0MskoVzEJIetPwquxOyYgvdVCdOyTyY3H2aLrj
	RhE49dQcdm0HTZke6Yj8xT91agKOiz5nQ6VdgzsYvv/R3vqD6p2AA0MSjje2X/2nkDtJwXU9eMe
	2eA96W5VHl1zwk6mVRgW2sFW7ZHQqqCabQnLX1DQV743wsvinnWGj4RSsh61eTCvRy7YzROk8hn
	UHtGLOg
X-Google-Smtp-Source: AGHT+IHrJ4VF2CntYtYVBWk6V0wpyZff7GRTQCnWLcAs9un0vKxcj8KuH2qMJtrKtI4vdY3JSSOWUn3JvWrn3PVjLHU=
X-Received: by 2002:a05:690c:a088:10b0:70e:404f:6714 with SMTP id
 00721157ae682-71a34a6c15cmr56967137b3.19.1753870291849; Wed, 30 Jul 2025
 03:11:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-b220362c0-fd0fdb0c86b1@bugzilla.kernel.org>
In-Reply-To: <20250723-b220362c0-fd0fdb0c86b1@bugzilla.kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 30 Jul 2025 12:10:56 +0200
X-Gm-Features: Ac12FXxrw6Z5zkJXAAHinqxtY3J6HIPoUgCRh9-jTUWs4Ox4XvlPZthb3NbB2WE
Message-ID: <CAPDyKFp-4zmeitLD7hp6SvkokEZE9e8-JvPBOowRHQ0CADY3Nw@mail.gmail.com>
Subject: Re: rtsx_pci driver is blocking s2idle
To: Laurent Bigonville via Bugspray Bot <bugbot@kernel.org>, =?UTF-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ Ricky

On Wed, 23 Jul 2025 at 15:09, Laurent Bigonville via Bugspray Bot
<bugbot@kernel.org> wrote:
>
> Laurent Bigonville added an attachment on Kernel.org Bugzilla:
>
> Created attachment 308404
> s0ix-selftest-tool -s output
>
> Hello,
>
> I've a Dell latitude 5530 that has no S3 suspend, it only has s2idle
>
> I initially opened bug #218500 regarding the lack of support for S3. Whil=
e trying to debug this, I start using s0ix-selftest-tool and I realized tha=
t the driver for Realtek Semiconductor Co., Ltd. RTS525A PCI Express Card R=
eader was blocking the suspend (rtsx_pci(_sdmmc) is then not loaded)
>
> If I disable the SD card reader in the Bios, the script is more happy (it=
 also complains about the Raid/intel RST thing, but I guess that's an other=
 issue)
>
> Is there a bug in rtsx_pci(_sdmmc)?
>
> File: 20250722-16-27-s0ix-output.log (text/plain)
> Size: 1.85 KiB
> Link: https://bugzilla.kernel.org/attachment.cgi?id=3D308404
> ---
> s0ix-selftest-tool -s output
>
> You can reply to this message to join the discussion.
> --
> Deet-doot-dot, I am a bot.
> Kernel.org Bugzilla (bugspray 0.1-dev)
>

Thanks for reporting!

I have looped in Ricky to see if he may have some thoughts around this prob=
lem.

Kind regards
Uffe
