Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793867135;
	b=xpo6sHoPINTlwv+6VzvrSFPPfuiwAhzznxCTVfVGuHnEWfQUOjdCKyhDdqsWjBgGhEZG
	 8sRr0mQL8y4ji1O9Zk65NkelrWBpvr53Qz0lAW3QbyYlX16ucDCR8EAPk6kQPFb17F8F5
	 QvJwXjS+xktatsSPUA8Bn/qanlt5sQBYaxlQyVTM7Yghz42GUh1/44sXtA0a4WjEalium
	 vhR9Xl8iQBIRE37OoflqhsRTvdDt/iv86MxnkPFpsB2ic5YyGH/h1i1Fw2Yrjq95HpqWe
	 jek9aJ32NVgmQ6FJpc8iDmEVKxqBYTZHQQo5vEMdR/3lN+c2wkFTc2AlHC1YZh2DLDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793867135;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=MXajDzcXzw8HFrD8vEhPMO3rOmoG3zJCn9w9dmNaD30=;
	b=etipoDUxEvHSvHi9Z71GCr0MectDXzBQw7er8E2WnyIMAiGJHPAFWzHDKSYbC77Ezj9J
	 SZLmcMerakoyhXz+r4CZU8Cm6v3T21wFGh0ztrbvh/k5Z2f1gwLT1IoFFUUokAUgWuVKi
	 5dIUw32cO30wIPgLqUZxpflDheD2y4DkP2Lk+5KX36xoPc37nGJvfuCWs2ln4/IPj0Xp0
	 dYDM4Kxv2EWRn3j3LbfP5ujXVw01V9Afgl+zwN2T3ORCzezH6r0BCwN+Jsc7aYDhEdl4Y
	 4UrGJXADKucO09xgEboBo2PwS2lX+uB0yfN4C3hfDypPKaqoJQbimjqaraF40MK1zgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cWeb/I3C";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B52606A326
	for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2026 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cWeb/I3C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597EA1F00A1A
	for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2026 08:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793867134;
	bh=MXajDzcXzw8HFrD8vEhPMO3rOmoG3zJCn9w9dmNaD30=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cWeb/I3CUOf6GV6EV+or+YbPD42zxND5eYvgZmaTp1vxDwPhjrYTcTmDFXOiPPUAf
	 xnzXOLVNszc/Vv+Utbzhhj8hnvCik/aTr5MdC44PX0h6eExGOZDfHzCLvfe0XIsg7u
	 0ypBEHuzN4JlkRzZbNjrPIB5Ue1hlf4/7++sPCYwOcYz/ilel4OzvBLq95TGL12Rh8
	 f6MhWCmjO5hUEd/a/xAtgiNa/FjVZb5nb5g23/LdUpFH3lXWdOyhFU29jqEyS9BUuz
	 AAiPVPE0OQpKhxtwOlZQ2Y0BnTerZHROjRrxuGgLeEZ7EvE/Iwpl+uOMFKpD0o35Hn
	 dS3uWKT7106Kw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5be4d648aacso1330732e87.3
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2026 00:25:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBy5AM3FlzjLSjPXQWzRSERVa7O+0B0IkQGSBLIR0ts86Z631cYWpJe6igjEjvBfi9aSu3S5emuc9so=@vger.kernel.org
X-Gm-Message-State: APuU4Z911Re2yLnD191li86bn6jMDSatD/4J/mF1ka+DYmsc8Z1GQcSp
	WVrPplLS16NGqM2IxS3qydj5f5OtyPYZCCeYsp3MEQrjWSuBieGN2snKyNFV13yIyXJr8MF5xwM
	BsGDhp2LhI/pQTGLGt2fVhzJjlu/ZUno=
X-Received: by 2002:a05:6512:6694:20b0:5bf:d9ca:657c with SMTP id
 2adb3069b0e04-5bfd9ca65d0mr3770360e87.27.1793867133080; Thu, 05 Nov 2026
 00:25:33 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031120700.42576-1-mateusz.nowicki@posteo.net> <20261031120700.42576-2-mateusz.nowicki@posteo.net>
In-Reply-To: <20261031120700.42576-2-mateusz.nowicki@posteo.net>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 5 Nov 2026 09:25:21 +0100
X-Gmail-Original-Message-ID: <CAD++jLmJnxdJ9-X4hThz==Q8ZJScb567VwdAYebGsSqA_KJsjQ@mail.gmail.com>
X-Gm-Features: AclHuK_tVeDfi38_WWdEZ3DB94ymBMDKaW_qe7crMyvj_c5Kzm5MMFqKOFgn5mw
Message-ID: <CAD++jLmJnxdJ9-X4hThz==Q8ZJScb567VwdAYebGsSqA_KJsjQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: mmci: do not count a data CRC error as a
 complete transfer
To: Mateusz Nowicki <mateusz.nowicki@posteo.net>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org, 
	Christophe Kerello <christophe.kerello@foss.st.com>, Russell King <linux@armlinux.org.uk>, 
	Yann Gautier <yann.gautier@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 1:07=E2=80=AFPM Mateusz Nowicki
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

Looks right but we really managed to make this code hard to
read, we should think about readability improvements.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
