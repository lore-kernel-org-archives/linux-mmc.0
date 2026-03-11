Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD252FD7BE
	for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234114; cv=none; b=UlXgrN4CQs8Y7HKTkqiiU0rJD/ZbLyieGVnjVagCF/aUO2jq0Mnf6Ow67Cv7C1RfyenCL24tU/gqeUNRw7iUk5dgbHg2D++OGi4jU1ty5Q2YTJhY5qUveZfhvC0JymwwPlcU2EUKgCH9kc8lPCxPjIp+Xu72/i3s/Bgr7rs56PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234114; c=relaxed/simple;
	bh=cOdofdA9uxeFswZkahSYK7BRxl91B+cEYHK/tWphMDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLAKZQwXYcEDcMwaKUp0tlf1MQNJY7jP8BnM2gWjwze3pOlcemKwI3ETGEvpkho9bJoKhbxgrZrbsNkpF3X16g29bWOnjPJCdILq6+HXHo8D7JNMkfV5kqQpMff1JMAizQAydF+8C5d9ukhbvKN7Sh3ekwfwa3cFOggu6kkU9es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+bgIxa7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+bgIxa7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132CFC2BCAF
	for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 13:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773234114;
	bh=cOdofdA9uxeFswZkahSYK7BRxl91B+cEYHK/tWphMDY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G+bgIxa7t3nlkXL20QFf4bSD0834HRCsR77wDboRDuW+i5z9Ck7I1k/HNGYOInm4Q
	 meIBdFDrC1KzBWgdCRE8CCnoQOWIarF8Gdd+JaDUs0Ew5tquzpP9m6H+N73HLR10YS
	 hJPpAPOMKvd3BqXaR621hcRNXj0/EXbeXQQKgjUksn56TmnDzmOjvpjPKTCijaSUvQ
	 CxeQJE5qQb7sKdAy+dEacWHi/gjeHwoJpRwlk2Q3aynhNWLQ3oJBXAXWqCkbHbIZUf
	 h5tS2t9Dfy84yPitDPpIC2pu4uQYB3rQSSA5/iqWUOB1wtCfNN2/RFU9ARVgpxJboP
	 47ayGslIr1Pnw==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79800183233so14529317b3.1
        for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 06:01:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVF0W8ZAnywa6HVHrAqlIDccrpO3MhHIkxZfZiSDPWkA/XRNN9dv5tiFLoa4wImhqP00UBOS2C1hnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/T7xdjsLf4tcNDA6GTIU8l9OaGj5r+rmCqF2MpilWksXklk19
	jhy/lUcps2mSTE6avMSBMhfgtX6Qk41QApPd4gdghSY+y/SdyxGOF5SChnZvsAycFlfa0pTT3Pl
	nnvJtWxk7YZlpkuBNKi2yPnmbyFNuMZs=
X-Received: by 2002:a05:690c:6f02:b0:796:37bb:9eb1 with SMTP id
 00721157ae682-7990a8ce666mr69440887b3.29.1773234112878; Wed, 11 Mar 2026
 06:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>
In-Reply-To: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 11 Mar 2026 14:01:41 +0100
X-Gmail-Original-Message-ID: <CAD++jL=P+0nY3yVM9MCrRfG5xLtg=R6Xgpi1xrbzzLPD-Y8KKQ@mail.gmail.com>
X-Gm-Features: AaiRm53di8hZ7D-oR6Q7wA5Pyxd8PUFmpi5mGlcqDizSLxmOe_2ndnsU2oyjceM
Message-ID: <CAD++jL=P+0nY3yVM9MCrRfG5xLtg=R6Xgpi1xrbzzLPD-Y8KKQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] Add minimal boot support for Qualcomm IPQ5210
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Konrad Dybcio <konradybcio@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Robert Marko <robimarko@gmail.com>, 
	Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kathiravan,

thanks for your patches!

On Wed, Mar 11, 2026 at 10:45=E2=80=AFAM Kathiravan Thirumoorthy
<kathiravan.thirumoorthy@oss.qualcomm.com> wrote:

>       dt-bindings: pinctrl: qcom: add IPQ5210 pinctrl
>       pinctrl: qcom: Introduce IPQ5210 TLMM driver

Can you send these two separately?

It seems I can just apply them to the pinctrl tree after review,
no dependency on the other patches, right?

Yours,
Linus Walleij
