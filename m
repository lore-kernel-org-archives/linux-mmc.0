Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883477;
	b=jVwv3rd2SoyrVWJivUQexOPlB7xg5kBwho27V9ttITlHovg0P7NXK8zyZc/lSBbzkpDW
	 R2Bdh0pXg+9ctfqsA+tcSUGk7/Kk4bmVlwAMsUv6nMt8Z+db4ITkR1Zp5P938wX7L/Hcu
	 wA1/JS5tE1nx2ZdpbfUUreJmYzyoCBmyoGKSMQ+xVxS9zZrvwOCNIEeqJPrT8RgKLXL+x
	 SEJUUyqL4giVqWUVzNeDPelCkXiExZePVJCGOnqerzczeuGsv9p6QknUvxyClCtDXdHlQ
	 ZPLre3T44Q1Lx7Fd+7UXDhO+qnrOo/RwGF/ze4JpfrJofRZXa+oapvgWhO/Ko9tw41w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883477;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Nyw4uo1UMx2UMwcj5/86TrpcocSt85lTij3scmNGbos=;
	b=UOOvOTeBx0h6zThncsTXiW0YMASDKGgizoD7lsi/Ch9T8gZdWdhojJg5JFIBUWM1V3/n
	 7H8kmm+nyWGYMJ5+J2eQYWQwrrhtNXgC2OO9mN74tJJgTy/M9vtoWIPCbMrxrNCV+4TB9
	 dz0LY1TiT/vD2gRIX/LVHGc4biel1MpwFm0wtqtJVErG46p9ZK+eC2IItdkgpgHuTw1TQ
	 XCkXCvxRuyXgMN7UXnBWfZmkR1bVSFa87ZLVpqms8Tt2kITjfIBO3srbJkMdmmOUVzA2h
	 28AW+AgXGVgpUJzOhzvJJ1Ma6yqCPc1Sq8FNsDN4P4e78bcCsQv590bZ06J1LigwPXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cQrjd+q6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A72E606A331
	for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2026 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cQrjd+q6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674AD1F00A1F
	for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2026 12:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793883477;
	bh=Nyw4uo1UMx2UMwcj5/86TrpcocSt85lTij3scmNGbos=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cQrjd+q6nNpH2xoYNC3OC/u9iIITjUzXz6ZPttJw7Yk1JV+VJxUNiRy6fOdG4bo9h
	 GFL0O6lgYfzlBm/5jsmbAw21QmT0Eh8QxIptTWVhMwkCm4qXVZz/CshS+7P4QBCqq8
	 gW+LQNqBud8EGNAJrdghHpvGnQ4zBjEQH/6kSAzl4d1gRk88I0MYMfGmyR6M9rWkRX
	 UVdzwh0ZHGw+rb+WR7LAKULmUgS6ZY2jnsiYd6BSzAQRB9fL9iLfnR9M5XDOTbZ0wD
	 Lh4aQYThFILqsEH6JCp+daJ9LvCemhjVrSJ8c3hux1kPtLmdfD5BBANf0wCmCtwJUW
	 V/IbQPTgfpjvA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5bccecba199so1602848e87.1
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2026 04:57:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBylexWNpDBtKcShJTAYWwNXr/gPDdOc7WeJxx4psc9megh5p83AOqyC6ijtZuni1kY7mTjMoM87tHU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+QqoGa1UbYEe0mYVuJ5rmyR7lweQx5fzkZ0PYWafM7jbasGHsD
	1NNatfve5tqpqi4pnjasfRijZkI3HcEOZ83UqQWfbI7F3jUQy3YcyHfx9J1TTazValtN+D434Xw
	mWuNc9jLLHFPzweQtiNSMCc8Po+dVpyg=
X-Received: by 2002:ac2:4e0f:0:b0:5be:536e:cfbc with SMTP id
 2adb3069b0e04-5bfd9562ac4mr7119062e87.17.1793883475976; Thu, 05 Nov 2026
 04:57:55 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104152657.14909-1-mateusz.nowicki@posteo.net> <20261104152657.14909-2-mateusz.nowicki@posteo.net>
In-Reply-To: <20261104152657.14909-2-mateusz.nowicki@posteo.net>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 5 Nov 2026 13:57:43 +0100
X-Gmail-Original-Message-ID: <CAD++jLkYxFR89WGnQKvPgCLYaE7Le06U45Cqn9yR05fa5C_xTA@mail.gmail.com>
X-Gm-Features: AclHuK-1e9C4sXwoHJ54MvMjIKaAAfliTo1iA6pakb6j7gBlL_TeQYZIIK87yhs
Message-ID: <CAD++jLkYxFR89WGnQKvPgCLYaE7Le06U45Cqn9yR05fa5C_xTA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] mmc: mmci: do not count a data CRC error as a
 complete transfer
To: Mateusz Nowicki <mateusz.nowicki@posteo.net>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, Yann Gautier <yann.gautier@foss.st.com>, 
	Christophe Kerello <christophe.kerello@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 4:27=E2=80=AFPM Mateusz Nowicki
<mateusz.nowicki@posteo.net> wrote:

> With datacnt_useless (STM32 variants) success is 0 on a data error and
> a CRC error subtracts one from it. bytes_xfered becomes 0xfffffe00 and
> mmc_blk completes the whole request as successful, although the
> controller stopped at the failing block. Reads return stale data and
> writes are lost without any error.
>
> Tested on the STM32MP257F-DK eMMC in HS200 with a forced bad tuning:
> without this change 5 of 14 reads returned zeros, with it all 10 reads
> were correct.
>
> Fixes: b79220b3e0af ("mmc: mmci: add variant property to not read datacnt=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mateusz Nowicki <mateusz.nowicki@posteo.net>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
