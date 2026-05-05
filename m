Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D59E47ECF9
	for <linux-mmc@vger.kernel.org>; Tue,  5 May 2026 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777990224; cv=pass; b=mSfmsqyXkf91Fw4PKqnulMINeYZMDc+UfsF6ALu9W6lR985toArcllujEBeFXJYW+bHO+MzbNR+ReShuv8XExUQiXJFj63LVSoeYKBF3Ekoyhw03j4bHk/slg64LlmxB3mrJPOf7OmdrLWLcqKe/wiJ6n09g0cvLhvL+R4I4Isc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777990224; c=relaxed/simple;
	bh=PPSDH64hE+yjWtaNjgx/6aRpUtM2VuCIufmkn1cPfi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zt1pI6t/sNycNmMVtatD+e9aWQEEkn0ffqJunGft4XRHg3womCGljp7p6Ck8BcOBs+GM+vpVTT6UhUt39BslRQCCBY/XTsRYL8i0YttAPpvKYUXBCkFLgOpxo+9cBE21dUzvK5OLUfq5Q46Y0yIeCk3kADvFGaCbIoxdNFr3b5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJzI8cC0; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJzI8cC0"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ba6838e76f2so632084566b.2
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2026 07:10:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777990221; cv=none;
        d=google.com; s=arc-20240605;
        b=Y8iA+/9i5KRoYZcOTU0yO1WX+l2nFYfjgU6JWERO5PSNPDnjdncg2QOIRzm1/pBaa9
         Aky3DLno+0kinWPV1f8ggFQQGgANDmNpTo/sJiak7v/l6zYjJgAX1Ea7MBqid4PUKT33
         TxClNLOPeiWkm0jy9NzxSUio/V90AVr3ihraIfkaW8j8ZZRLiK080UtrqVKi+8Fgj6fg
         9O7bgNL24xzd99G/B7Y1khq1uWNlile4ZxDyh1CtM917eXllRsY4Lg+E1NDk3x7G9lct
         pObfItc38XCpDD6TZcYx3PTJiieFkfjm2U48CAf4znBTQAoxySs3q+0pGKcTahyOX5EX
         RhCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PPSDH64hE+yjWtaNjgx/6aRpUtM2VuCIufmkn1cPfi8=;
        fh=8QmPDyQTZ6WjJzS5Dqjt2Ig9jjIvId1OSu2Ih8SaqhE=;
        b=P8YCukz/ioW3trLr2N4XioCKS+WAGz46DcZm5IvZN98ZX/xL/DtYKEopqIT6gNLlxa
         7NICkq8ZcJJlTKHDx5wFQslaP1nv0mHoNqeOL0uY4VgcrxGeZCVFuGYSx80z8lWIP+oo
         iUfPXGKUsadj1jtH4+9e+Ecn+V7O7aQnyPL8OeDZIun9BYegAE4DcwxkP3XUW4WOv6h6
         SZqHAR/8IiOwNmf1fCCkVf5Er24UXaQiA+jDK4NUnYALqlQSEBdujz3uxVRBm+Kpmtrt
         iKmQuiHiQtNT71S93hklwh/i4q0+nHQO4L1JLEL2JfPrrEp3UASAiS+wgdZH2098G6Sc
         8Psw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777990221; x=1778595021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPSDH64hE+yjWtaNjgx/6aRpUtM2VuCIufmkn1cPfi8=;
        b=IJzI8cC09RD9OAS31ebTVYZKcLHl3brnV9jXhbik82siSSSSykc/YNVgFpnhSZYVDR
         jDAY3EuVReh7NZlelfU20sk7ogjZExuO0+nitHeSTkbN1UxW6FqVWR7udSy2zOPmEbkp
         qg9k9vWGVXVR/c5WC2bYLtKk0WwWyUc0gaEP5UoAJbKuUYW6tmAf8sO9kovAhf17hY3S
         X86ciG8t/mVJwoLVt6KSV3UmfyeoI5Xixvbx5dPYsZktvr/0OzdiPBt0332vuGIHTV2+
         7tgSBTgJhxaMRoNASp9kZI2JbY1toeO1DS9WXFtgi6gLOZuzHTR1ebyylftjDqhmJMcc
         gcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777990221; x=1778595021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PPSDH64hE+yjWtaNjgx/6aRpUtM2VuCIufmkn1cPfi8=;
        b=P0iw/XLpHB7fDzWjLKJTHghqtPmOzXLKYcUiCL8ChkFITtuP8NwA9MzbAljkHVA4zf
         MBL77OrDrI9tZ6NyNRil+TAVhaJtzhfTQkex+F0yLVeFZNYMSBZxx3HfWBUygxK4sY5z
         w/ZST1qUK5TR0vYV6h036VP2/elxYhxBfc3DlUsQi4/AuXpS7aDrKpL6oqlrVPL552L7
         QVDnCVRjGzLFiKxte4B1YAO8Cc07gLvONNulFAqeJXiTLnPJqFlpo4IimRCeOf2A+ioG
         9u76vvrEcWg0tfN3Kki5ffgaxBkuzaZ+IUpYrBXUBnsto30ka1vwp6eR8stfojUB9hQS
         zp5g==
X-Forwarded-Encrypted: i=1; AFNElJ/f9md89ZfWWdDZHQgVwZlfBaCKB35EHg2EKiiIl/+5AyWizwDkUTiDZDRWEVoa6jK4SxWJncEQPg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkk6hrCE22VrW9QII415dcDqA1RKfYY1sRS9WcHJyFK/HCHLOo
	PTd406fGiNZ1Ez83ozDMy1cHTKsiqXl5S453mzQsYOpQ/OmycZGyghWvqYwkAUep9ZvmXP8oF9L
	e40P9wwxTMPKfTp+pxH8xpR+H1NEIgnU=
X-Gm-Gg: AeBDieuVSFQE49ATvZhdz6j8b5d0yb7X9Yb0aABmyvMsDnBU91vewr2ngAi7TO4W3vS
	FHddVpO9w7ro/4b1WGLZN9Da8rPrEFfshO8wrHhRXACm7nC9MutLN9oeoUmLA9PuGveiI4akO4u
	np4WFoxOlUCRx0z4eN/SqgRAWtX6dlo42bxDV2BoGRVSAdOaUgbWgXguD1Xd5uDzEux9n5ymyo5
	eUNu1LGsXmeKlVJB28wUiYGcQRDZcfNSutJhaDc6YKbwXUAdxbVApqupd2tWV6l/Y2IP/IC6sW6
	LAuW0wPtPoqf+aIpzVo=
X-Received: by 2002:a17:907:a0a:b0:ba7:34cb:388b with SMTP id
 a640c23a62f3a-bbffbf78e40mr853441866b.42.1777990220002; Tue, 05 May 2026
 07:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505133731.383544-1-a.shimko.dev@gmail.com> <17e8cf3c-6984-4711-98de-1d795e6268fb@intel.com>
In-Reply-To: <17e8cf3c-6984-4711-98de-1d795e6268fb@intel.com>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Tue, 5 May 2026 17:10:08 +0300
X-Gm-Features: AVHnY4KaAlkjSTQTDF0Dg4jrE-4PCwCcVPTwKs49KmV1kjkmtehh2T20PMIU360
Message-ID: <CAOPX747+AVs7SjdtHYidsog-gyGOS6y4+2=3O86XCDyOvkX3rA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-of-dwcmshc: add reset control support in suspend/resume
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jisheng.Zhang@synaptics.com, hehuan1@eswincomputing.com, 
	andriy.shevchenko@intel.com, yifeng.zhao@rock-chips.com, 
	Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

On Tue, May 5, 2026 at 5:05=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
> Changes cannot be accepted unless there is a user for new
> functionality i.e. you must add support for a device that
> has needs_reset_on_pm set to true.

Understood, thank you for the clarification. Unfortunately I cannot
upstream the device that would set needs_reset_on_pm to true at this
time.

Please drop this patch. I will keep it in our internal tree for now,
and resubmit together with the corresponding device support when
that becomes possible.

Regards,
Artem
