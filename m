Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C6F86122
	for <linux-mmc@vger.kernel.org>; Tue,  5 Mar 2024 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709648208; cv=none; b=N0cWDNcF3gNlCJNbR20p1/tB3BIwdOo+mvE4v88qxJ3i4Qp8X2tN34A4HoUaZi7nuHUvuZm8cU6/srEYLqwYncsAYrKJlBG3ajhs2dGVoffSyYYF9vneMz8dxLkaQ7DNmYG/qAvEfccdoe1vy5GzhUCrRgnlX0WO7bT4UHYIsdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709648208; c=relaxed/simple;
	bh=5e8RyFZB6uK5xAt4LzJ2CHaCyI7HgnYjNdG/wsdLGUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sq7Mp4kFLM6C5mEghG0tGU/lYlHKB9IlaEUoX5dMRqT5+BAu0XHbfs8CPTTsxRq7NVZtLZN0OJxo2tG9ZqtQ+gw2gArT0R/oeZ1juIUMAYVoLlThJwxJJ9T/N4FpojWRwpQdPTC+vN3RgVITGjtUWN9Blq2xwsO9wM+2kdOgXDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XnihEjqw; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XnihEjqw"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso5446082276.0
        for <linux-mmc@vger.kernel.org>; Tue, 05 Mar 2024 06:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709648206; x=1710253006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pH6ao14eXyStRIsXpQqXQUUaYQVBQF/CrmMchFPm6Y=;
        b=XnihEjqwoNincZDOGc7DDbRrAG+oiem+1EXxR1OumtK6iUVjcpJhAY9mYx10W/JICj
         nmLE9KqCx7bySQd1IvWLT8CqVACTiB1hHr0Jtr68uQdpn0POcA/MWO99EpI++G2/TcAS
         2wSvhQ16/jGfYQe2VZnuBtahW4ipNRpkeBvuKLq/ZMOeaoAher8AS4gZBLnO4nYVN5O5
         1MmnNh7tXNFRRmZR1GUznkJ58eA1y+j/9K6hMdKVHvidAQ5WBdL2PLVTEyOxDO+L0il/
         C2PWb4qaQP/9glmeMO4TAAhxKDZt86mrCOilDNmwPPZ8nEWClx9Y2p0b6vnos4zb1SIn
         TSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709648206; x=1710253006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pH6ao14eXyStRIsXpQqXQUUaYQVBQF/CrmMchFPm6Y=;
        b=jARbZ/S++T6cBdyLW6PguNDHkioXcyyfCygqcFUEbC9MmrYFpEEUnEpi1RmxGC+85S
         3xptN2quGzgWZgxS+QigSl60v6A+TifDcnE/lNKj+jeTt/6G7mF4RODBJZiwe9D23EJR
         rJ+fM/zU14PtZfXBLIgajGdTZy279aUVZNuPHKzPK7qfOpg3OzJSgyWXPnYm6bnOltlg
         dmgFeNM6tKK/RG07DLMCkFoA7ezx9UQtINzG6nnGIw9IXlYiABQJbc1oJ/jrML6H/0qX
         3G64R03ApFmjs3UlIYFs7OZ5rTLjHYzcFFg4uZJ8UUXPVIyJLxt8uS7UTE6wbsl95Rcn
         2OnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLZ8xTTo5G31CNJI+ACLxu5fC8yE5zF2lH0cJ8rwr1zJf2KblJ+TljriSEV5QUJ1Q4v+FWFLVuRkgwqPxSjubTNmdq/tWaMv6e
X-Gm-Message-State: AOJu0YympCETIu4GGjad0hgOcJs4wpGCikBsc38u47A/ZUnr9sHyY2kI
	5HV6ySs3niqidCbIy8HnybJ6dgI9DwR6TuwFbI/mj7dr+0kWM4U9WI64iNeFK4BlauW2rgEwCwy
	IttPoINsU3VGbk1anb0E2DZVJQlxXgw2XdHCISg==
X-Google-Smtp-Source: AGHT+IF0QE2eCgnKzPX7Lzulyl8LNxaoMkz8j136SkagCThiX4WET+LmP/hJRSwK65wX3P+LcjLSWXZvzp6Wx9/mLO0=
X-Received: by 2002:a05:6902:250d:b0:dcd:5187:a032 with SMTP id
 dt13-20020a056902250d00b00dcd5187a032mr10587042ybb.43.1709648205832; Tue, 05
 Mar 2024 06:16:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227153132.2611499-1-jens.wiklander@linaro.org>
 <20240227153132.2611499-2-jens.wiklander@linaro.org> <CACRpkdbhhZ9+Jy_tvWy1RSnyZMjqUhh0ARpS+WRtgWTH3AYCPw@mail.gmail.com>
 <PH7PR11MB7605493349915A168A80CDD8E5222@PH7PR11MB7605.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB7605493349915A168A80CDD8E5222@PH7PR11MB7605.namprd11.prod.outlook.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 5 Mar 2024 15:16:34 +0100
Message-ID: <CACRpkdaOnbUmk1q_BBWkPYGriNHfZBUmGxtH+sQmw6U0rxicMg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 1:54=E2=80=AFPM Winkler, Tomas <tomas.winkler@intel.=
com> wrote:

> > On Tue, Feb 27, 2024 at 4:31=E2=80=AFPM Jens Wiklander <jens.wiklander@=
linaro.org>
> > wrote:
> >
> > > +struct rpmb_frame {
> > > +       u8     stuff[196];
> > > +       u8     key_mac[32];
> > > +       u8     data[256];
> > > +       u8     nonce[16];
> > > +       __be32 write_counter;
> > > +       __be16 addr;
> > > +       __be16 block_count;
> > > +       __be16 result;
> > > +       __be16 req_resp;
> > > +} __packed;
> >
> > I didn't quite get why these things are encoded big-endian?
>
> By the spec.

So a kerneldoc comment above the struct with a reference to the spec
it is mirroring should be appropriate?

As it stands now it will be misunderstood by people like me as "just some
other Linux struct".

Yours,
Linus Walleij
