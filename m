Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k7+YvcLW"
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C13110F9
	for <linux-mmc@vger.kernel.org>; Fri,  1 Dec 2023 05:19:23 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5d3efc071e2so9615177b3.0
        for <linux-mmc@vger.kernel.org>; Fri, 01 Dec 2023 05:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701436762; x=1702041562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TV4RE4cHNpakye744+P99xHdpE2/iAr/FBdxm7x4r+g=;
        b=k7+YvcLWgiIpFeZv4E6dFYbAwzp6qzf0OwdULmKHfCwnOeKRrERw+/fncxBdnWu6Mg
         k+VFF/Y1hv4iGa+4Eo5VMZQEJin0y9769rCzYfwBL0W/u8UdtOn+5JLGKsm8E22hCObQ
         QPwQFoZ1fxi2LvbyRfzKGfT6MtPqSAvdoPqiKbOLHusiGlyafxS2SYWz84N3jc5DaMys
         gCeOQdQv3mEXA3hA699C5TpZU8tU6n2o/EJb1JXHQ1uqF0GUbQCf9X0m7nW1Dh6uZx2i
         f5MX9ohIUwVDObiOcxD2zx4H8liQ2STNYQ6xvPLA9TCgvKsfNtpYRAedINwSORJlkoBn
         a+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701436762; x=1702041562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TV4RE4cHNpakye744+P99xHdpE2/iAr/FBdxm7x4r+g=;
        b=qgmHvN/Ly/nM98Xv+4Gd44QZ/p8/hyUuP7Q1UXVtfJ19mazHnZWMJ31kRhkZ98WWzM
         NRr3GHYWluVs0V+V4LjT92QcYokljPVN9ZISG9v/VZIey2JftGxnGvrkp+TOLaI7qgjq
         U8L6mMpbhcSJTwRXcAfGTQymDgz2vaE8dJZ6Lf9JFK732wrRvsN2d6eVyIoR2j7S8AiX
         o646gsrbZtgs/cocxblHLiJTnZzwABCpACBumgBFpUxR48MtMwiIG5SQ81U8lc/AIE+1
         ErkzGSj4OqaX4N6YrkyeAni3BZeRNOyoQSJQvcKZ1RhQVw/DADtN7ZjwlOPlRIsqUlmi
         CINw==
X-Gm-Message-State: AOJu0YxdOaD37NW6Sx+zubwkpoDe3ICkOBgd2ISaJCF3Jvaz4SlO/7z0
	47dUgBtyen6vd3+ngq53CELl5ro7rz7tJDiswOwkZA==
X-Google-Smtp-Source: AGHT+IFEWzRE5D+JX5v6BYxdEGsQDVSfXG3gspfyC4M3wp8CNF5TLeciexwuvK9psgzwpfJl7ggu9HKOx77eKmwNPuI=
X-Received: by 2002:a81:9242:0:b0:5d3:cfc1:2df2 with SMTP id
 j63-20020a819242000000b005d3cfc12df2mr3380112ywg.14.1701436762501; Fri, 01
 Dec 2023 05:19:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201100527.1034292-1-jorge@foundries.io>
In-Reply-To: <20231201100527.1034292-1-jorge@foundries.io>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 1 Dec 2023 14:19:10 +0100
Message-ID: <CACRpkdbbV_mCT-P6mK8=S4rR7=ZKV=LKYmoH1dGsG3PAR2HjaA@mail.gmail.com>
Subject: Re: [PATCHv3] mmc: rpmb: fixes pause retune on all RPMB partitions.
To: Jorge Ramirez-Ortiz <jorge@foundries.io>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 11:05=E2=80=AFAM Jorge Ramirez-Ortiz <jorge@foundrie=
s.io> wrote:

> When RPMB was converted to a character device, it added support for
> multiple RPMB partitions (Commit 97548575bef3 ("mmc: block: Convert RPMB
> to a character device").
>
> One of the changes in this commit was transforming the variable
> target_part defined in __mmc_blk_ioctl_cmd into a bitmask.
>
> This inadvertedly regressed the validation check done in
> mmc_blk_part_switch_pre() and mmc_blk_part_switch_post().
>
> This commit fixes that regression.
>
> Fixes: 97548575bef3 ("mmc: block: Convert RPMB to a character device")
> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> Cc: <stable@vger.kernel.org> # v6.0+

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
