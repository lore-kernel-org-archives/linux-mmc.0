Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF701EEA55;
	Thu, 14 Aug 2025 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755198633; cv=none; b=gc352XivqjK5e4imS27ZOML37Pk3IYqqWLG2KGbgNhWSsmZQYT0N0s122W2tkfKdD0OFa906Om3H8CytzPu3E0QihppxuJHi3mFFgq4GJzhRHjG35i9tpMy/JMu72cqtgkZGbjmiWMn6AX62LEC3PCpGUOWjsB7qShLW/lTR6RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755198633; c=relaxed/simple;
	bh=7Ic7fVgdgQ8MblQFjMCCiNuHrsFYD4KaCcqXjlfhrB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+/gTEjXO2uBdwBUOASes5I/GWcPl2CcLXkYRVeGUDBnze1DkRCtqVLnmxD5o89mM32yZ+qYeJstx0qFczcmeQO666OA1YQPVAbhLFM+LtaIAH67FtdHUBpNE+e1hXsLI5atg3L6d8fufwVHGhUR2zlPjrJjtBscJuKBrON4+nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=kpcbpTEP; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kpcbpTEP"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4716fb798dso813777a12.0;
        Thu, 14 Aug 2025 12:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1755198631; x=1755803431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ic7fVgdgQ8MblQFjMCCiNuHrsFYD4KaCcqXjlfhrB8=;
        b=kpcbpTEPjOfz1Y7B9JkjbpGvXBnF3XnA9rfDw+xrCrhXW70b/+56a7OtAYeDfSfyoW
         1XuUVI7MHLIisr8SSgVOnTCElbTrc8ZAsiiFpo72VaX/6QRJ4I8Ry2DYWzre/k5nvRhG
         pdcALgJhTgVE6VMKijy9gr92MSd9V5eXGrZYhvtsiPqf5TsD4fiyJIGM7/BACdv4MXF7
         udtbycaUPVnWmvojxuYHaTZVtpCVyLGDljsJTKYjVutLlNMfQeEs0jEf5zIFTCWZOQqI
         Z0VW4iP1ZpLUG81jFtkQtg4vaMIevm33eGE87ZTMzCz83zH81RjRdp3gpXaaRYdlfKHC
         bENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755198631; x=1755803431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Ic7fVgdgQ8MblQFjMCCiNuHrsFYD4KaCcqXjlfhrB8=;
        b=pjN+jvVuiW10zyU9wk5MhM2ppChaHxy3TB1SL5xj+VGvZJ9VKcjEZ+hgAGb7hjZi5M
         jTFxtOKCNd5wMw+9plL6zwgXofUj09R7bdrpGUzXo0FOkza2yqZLu+YSnDry0HVtlE03
         n2qtsa9Lad+wmu461lTclClh6JyTlfHmd33ZUAtiSrbifRwrR75tmcQ47bB1eOnFyiNb
         U6n5ynnB7Lb3ndRqAsaJTaIQlDb6+ZP60GCnYX5KoBNYoPgN9iGEfATcu8/s0RVA0j85
         xYfQ0TpP8BdfbPP4S92ARsTf4+5IRsOR6ar5G3mRWEAZrxkD7klIFL6vMTPWZiMe2TS8
         bqUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW0mrGq2fyHCmxelWiGF9oBS9uRI5rrLsqmL3jsSsn654ytBVLn366sYJ4jDlDY46Wm6mTQf7cK/co@vger.kernel.org, AJvYcCXH7rJcUtdnuxLMo0EaCBMwNRCTc4EAf91tljQ2a8ewPYCJGSWU6cIuy80Yt95gF4Can3N5E6zL+kJ2mFo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw2MVsbXeK580zT3lpKe6fGhCc0iGHkfqLOlZehSp+mr2XpxVQ
	9kYfYBoZe6QYlUplfPt7fosa/NfE1SU6kmd7UpGD3aUBWsqL5G6T7A5X0J7fj3s0Q84cvEiUiWp
	+nXzabrSlVrW8Ai+JnRbIoZQF1vbEcD4=
X-Gm-Gg: ASbGncteKYfAfES7g+/mBYQS0s5J9W6SqAY2XpgSRx2vpLg2avBxPK3qSCTDttEdS93
	3zDhDfuWOAvh+G12xW3E+AcDDkP4WbIysM42fwF2gkvgoTSvqAYeINJuWdf/8fzi7OkDwT1lKoM
	HYpKpIeDXy3UTIemwG9yLpaYnG7iZA8ToUsP08SXEEfAb7Oe+eTkk4jmo2s6WThOjbKzaflvaaq
	FfdQwSLHXLQIGWBOkVrtIyTbpMaBb71yU8tWLI4
X-Google-Smtp-Source: AGHT+IGCkVCFwHi3iu3RTkUkT3KWCaKedVBq8LMJeylvVrEEx6RjEVwapMlmkmou0xfA/EzyS/n8fJ+FeogGpmfch5s=
X-Received: by 2002:a17:902:cccf:b0:242:b315:dda7 with SMTP id
 d9443c01a7336-244589fefd4mr53592755ad.3.1755198631063; Thu, 14 Aug 2025
 12:10:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812092908.101867-1-zhao.xichao@vivo.com>
In-Reply-To: <20250812092908.101867-1-zhao.xichao@vivo.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Thu, 14 Aug 2025 21:10:20 +0200
X-Gm-Features: Ac12FXz3DsOF41iVXZ21DRUi5sZbQZVEuhx31cU5DqXvUGLAmoyIN49sur7oF4Q
Message-ID: <CAFBinCCrC02K8v3FbDzGTQYbPhC9RrJC3cnbuHLjJz8+AuV7jw@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-mx-sdhc: use PTR_ERR_OR_ZERO() to simplify code
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: ulf.hansson@linaro.org, neil.armstrong@linaro.org, khilman@baylibre.com, 
	jbrunet@baylibre.com, linux-mmc@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 11:29=E2=80=AFAM Xichao Zhao <zhao.xichao@vivo.com>=
 wrote:
>
> Use the standard error pointer macro to shorten the code and simplify.
>
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
