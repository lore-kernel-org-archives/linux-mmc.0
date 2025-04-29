Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED631219A71
	for <linux-mmc@vger.kernel.org>; Tue, 29 Apr 2025 21:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745960445; cv=none; b=T6/5nvPjEKGywP//HslQadvI5+NG5vlHT4FoFlbVgk5tfS14jH+jn5KZPzOLlSh3Cqxdqior1bkobOtxjGllTV9hrttPD9Z68M3oIHsKdj6yyDwKukHF35o1XM7sU2sNCp/GbvDr3MlrdMpWRWkJXFBBBsYgGR+JXh9jeKMMHKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745960445; c=relaxed/simple;
	bh=+bnXZCEUtmmVeIlVTWwPA7pd5/HhhSVeAMftGFtZmqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lf8EQOT/FvRym9fpy5wNmxkydBmLDHocDAecdbFMiOf6xz/SlesAioQUmuo3HZByIoWETZSWv9u68uhcyP76xOzhFb9+v1d3CAiTojsIcMOIp6AvHw4x7BVcGx2khj4sZ4NgJoEm4ByEfsoJMy821oK5wNlMicJifLNcgf0a918=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DN0C4oNS; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DN0C4oNS"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-707d3c12574so2335607b3.1
        for <linux-mmc@vger.kernel.org>; Tue, 29 Apr 2025 14:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745960443; x=1746565243; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MVeEYeda7/Kr92CUZBosRiy0fPSKQM/Qm6UzBvWmMQw=;
        b=DN0C4oNSoQSZI+3FfEPhOWzYz83LD/TnewpQPMYdEPNQau+csi7N5oprxThb+4TV3f
         /KuzmI+JmnEJ1korom6Atz2k6Lg1MomE5Ao8VIb5MDG4npoWEPaVJkNxq7GjL6KGnRJb
         RSJBqWFB+VYDtjJNSrUnHJ4b68ufB4HUSJlcCzanO4lzpeGrjIG1Omd3QLLFLNi3MNZO
         QSCaud1G7rgdF8eVxP6b4JEZlYAsCis6GQEWsSC0EyW6TvWKHf4BsV1q3FrZ6JKpHBSp
         WLwwWnyDimKHOHQoR5AqO2wByXqTSob0hlk6W1mzc7n8lDZHd0bzqbGDYJiLwLXKkuxs
         fFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745960443; x=1746565243;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MVeEYeda7/Kr92CUZBosRiy0fPSKQM/Qm6UzBvWmMQw=;
        b=HKp8LDbHssiWf5Jz663BbVXtBlCqZZ8KCJfuXKxbzad6nhFYx1S8dTOiffnXIF204G
         Nd0pjQjbL33wBbgfxPtsKD9n4Q/eRqaIigkd06ytgdvLy6aHldpaHnTD/LFt6JsLvuFQ
         o8DaUDMl3yrOxqJhTGHJhefzPQOSUT5i7v87mGKw9C+ls3bKhJGmFzyxDkN5d5PhSifv
         LoxIKR4WhbTLM/WfEVCFrcERVQSoiym3jHXoT0aDiq6tS6x4AtcgJ3usArfmwS/E5AZu
         0Oqs+uUoZbQn0e8QfJ0siRV9eT5Y33Fzn0z6qxFb6oNxfjNT6TXqW9zbgUMnVTKKTCv3
         oJnA==
X-Gm-Message-State: AOJu0YwvPPuwrAV2XlEM9UvLo8BapbnmX/3igtSNUB5KoRp4GkyUoEjt
	OmPiw0ra38yvlZfmSEbvkwZf2o8fq14GQYC3ssIExxptQBLFMZ9zA/a2wXEA00PRvnrTAX0aP1l
	Xh45y52HHx/tTjRp6sS8ZQkaM4gGHcUMoYmblwTOIoq3L8D8iKVU=
X-Gm-Gg: ASbGncs/YcwFGbXqZN8duxIY9TgAbJ2OlGQcSFYVgf+rku45R4HoQP+T6lLpTq6lU1+
	uzu7HimH9UXLq0lAZ/16WrSHzdQCf5o8XB+flCgBzSKMnsrlHBPrflrkFPo3bsMcqz6y3Zcngqt
	f+bfbEOin4FJnb+NwpHbqS9bCdPNrYLl2XaA==
X-Google-Smtp-Source: AGHT+IGhi91vAMaFnvdHReU0ME/lPjFHo68+7Qc1LSbmtiQrT5XZ7CZ0HnPqfrBbzMJ9CDpKCbtvauI/wyyesdoFTAs=
X-Received: by 2002:a05:690c:3708:b0:702:5886:7804 with SMTP id
 00721157ae682-708ad197302mr5150327b3.19.1745960442545; Tue, 29 Apr 2025
 14:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428122951.317055-1-avri.altman@sandisk.com>
In-Reply-To: <20250428122951.317055-1-avri.altman@sandisk.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 29 Apr 2025 23:00:06 +0200
X-Gm-Features: ATxdqUFJcDeReM_ZAtFp84acAa40FJQVB3MyFRPnj1xWiNK-4_9SZs_Px14uyZs
Message-ID: <CAPDyKFptPQzyu5UebX0mY7Gn_mCxSHUn+euqFj-8szgW3R31zw@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc-utils: Reuse the 'help' section for command usage handling
To: Avri Altman <avri.altman@sandisk.com>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Apr 2025 at 14:34, Avri Altman <avri.altman@sandisk.com> wrote:
>
> There is this custom in mmc-utils that has existed since time
> immemorial, to add a 'usage' print for each command, should it has been
> called with invalid arguments etc. Nonetheless, the `help` field of the
> `struct Command` exist for each command and is much more informative.
> Let's use it instead of all those per-command usage prints.
>
> Avri Altman (4):
>   mmc-utils: Remove unused adv_help member from struct Command
>   mmc-utils: Simplify and streamline print_help function
>   mmc-utils: Introduce a generic print_usage function
>   mmc-utils: Start to use the generic print_usage function
>
>  mmc.c      |  98 ++++++++++---------------------------
>  mmc_cmds.c | 139 ++++++++++++++++++++++++++++++-----------------------
>  mmc_cmds.h |   4 ++
>  3 files changed, 110 insertions(+), 131 deletions(-)
>

Applied for mmc-utils master, thanks!

Kind regards
Uffe
