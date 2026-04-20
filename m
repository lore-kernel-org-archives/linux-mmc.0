Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F82F2BE05F
	for <linux-mmc@vger.kernel.org>; Mon, 20 Apr 2026 20:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776718029; cv=pass; b=pgN8Pa6km7zWn/HsFxsmMjC/Ok1pIxH+q32oQw6KekESo+Dy/ltWEfH/dB4QmFBt/UPe0FaeVYsAFDhGzd9zoOtBa7RCJ+PwBmqIim689aB6ZoEkXyU06wI81YkA1LCPqmDUTif2HNs16Q/W+wHmDYmRZG1pHR40qGMqexyiDS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776718029; c=relaxed/simple;
	bh=EQ381gyFls4AWTGtbPx+Abo8y02DoEXmdw8t9bbWC4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNUMQNMj8J3uEVK2wLmvoZ5Dx1bWw83CtuIGV90ATJZqvSPv7rbnnIkKimwZECTSNOlXu59agN8sh1coJ+rWOK/GZ70YbuyDiKFmiJYVjnM0AvXIy44uid6e4Wr6028xnlae+RqLkAlaHNQYw2bQRmd1gN1bwWDvqKjqg2uIBpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rs1FErZj; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rs1FErZj"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64eaf8aa893so2832384d50.3
        for <linux-mmc@vger.kernel.org>; Mon, 20 Apr 2026 13:47:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776718027; cv=none;
        d=google.com; s=arc-20240605;
        b=eK8AImEa8fjpd2ISzkJ678LY5+teTXkhkHog666foNbDCY41N+s2ZQB24IvueB3+Wr
         xYt/7ZfbVb+SPRe6mm7y0cUzxjxYHed13bwRA6ZNeUowYYBpNM93b9VM0wpnc/HPQUf5
         AGyUCJz4BOu/5j1q0OC4jnx3ERpN02ZLjCE4cZ82sgUMoR401Dv4/FKNcdO9qmzsZYFc
         41d36oVbIdkNC0QGL+hmGtC/0ZXK5pDIsx31oOrejs5VqGL/qlKcb8EsDgFRU6sKZN7z
         7CKl2frRTYvTLRVQWRqKNsJxb2FRWfrVk1/3JtPw+VkaPXv7e97EgwpDLytAKW3ETcFA
         Rn8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EQ381gyFls4AWTGtbPx+Abo8y02DoEXmdw8t9bbWC4w=;
        fh=Kyh7Zovfq01b2Co/EY1ja/jXvbskcb476rcVlRJFDuk=;
        b=BuJBcb0IAmYwzFkgyt+6nyjosC/8Fxkor51rYATox8sVqqCi2QU/s+YQ4ObSsn0mks
         N7MOjRkrNWQOvI7HCgjmXxKkZsN8D6WmvnMCJXw2UP7V82QbOBd3trrf3BJ/xZuSw5Jx
         OnMVBzP7f3wwX6CwZ9IrP2Sq++Ne9bXclnH+wJzL1tFJSnsu9dsLDxebWfS0Ea6URC7s
         ItAxxZn1cVXeLM5KiPJsY02iSR8fA68uqMIIGTBHvV3QSCReDy31AdVVeuw+7VmCsg/j
         BGZi0VXN8b/AEazfE/vep+WCBYHNI25Jn5eRbh/cuztxByp5x20Pt/meLXd9H6qFmfKc
         UlpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776718027; x=1777322827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQ381gyFls4AWTGtbPx+Abo8y02DoEXmdw8t9bbWC4w=;
        b=Rs1FErZjhllYj/zWS4WVS43ZHxW9+hPweM3fZm6XZprQfpZvSS4ZhNIM/j5VWF+GdQ
         B32kwXRa7FEj3O6Qyr84XDy3aocB3R3biyi4PKKft+LzMmeMnjn7wVX2FB9fLUB9si8h
         xKytzAaILhu4xym3bq46IHUcKIhmURBMjhHBcB/JX6KSqf2KYV3j8cigqWDLWljrc+ja
         PfdOiKi0s5NPgj/kMOqXyZFngFKFNKCagwnEnp8B7lez5dwLcueSPOqGbIazDovNqWv9
         lCjafUpjzczZXeJY32PnT0ci9+KLLu5H0jxOKW5aYblCR7yRJvBy8hmfyO6PLDHRKO4a
         yzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776718027; x=1777322827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EQ381gyFls4AWTGtbPx+Abo8y02DoEXmdw8t9bbWC4w=;
        b=jVphuWstkc7tSKTGJbWrHvTkyi6wHeI67lfXViVO+l3GfakfNtcWTOh3Ln8OaSI/+A
         cIvYieE1g81UtVuZ6WZJDCILLvk22Z62EJsYBy9I2mbZuB2qnkLIblKf7r/WUu+jpdAC
         nbWT2k/jSgSsg62/ptjtFZTi98xc91KgA7iitaAIFrvpWn4oBp0nu9Uw6Gqa40nWydXe
         +qaihaXc/WW4YH4UycwXB59g1WzfR49XgDBNCnE3X0/QV+h2IEAM2BvbEISLFg/mus7v
         I9qJHmdOPJcysmcSnLaXtVcD2KT9QqAO2iM35ZhnfgRi5AZobR26JfIsmKcATDuRGNQn
         rYNA==
X-Forwarded-Encrypted: i=1; AFNElJ/UyDdUdDeKNa6YhXbhVBxLAYxQYUpZRN1gmw+DBJ1FjabXyS5fXeIl/7RIiD9RiA7fG3g9W819+AM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9I1M9Wo6hizV5CPM62yCeVQoPAZwFnJvzrekaWbVth/Dokv8O
	EPk5FOJA1xe4a4Fc6RYIxr8BXfHaYueAEJNZXYXkcUaPsYAUkKAd14+2fTGAGt5uMGosMYZQZqn
	2AnO9GcWWEIlxDo89gzIJAx+fNsL+5a4=
X-Gm-Gg: AeBDieu3nR/E2tLh/3a4uApgNFa1pj2yv1gRZ13DXNyS/V//3PYRCoiaqPXRhcV3LP7
	Odw1WVyIgl3gzljptKSvpBEgbv8N2yy9COpn47lkZlKVoVECOtuMhXalbuh8c8Qfs19WYsjAOdY
	wCWjEdokdBXqkBPi2uXSAaEImAk+5xeXpgISqokbikXeHcvkO3+JO4QUcgedPnM/n96OcuQl+aU
	6o7WMJXvIOeCcH9+gVKVdRtpFSO6bO4U0eUqgDl6GdMFI9uGBJkGXedg5jSp5fyQ3uxwM56VqUK
	PoaP4qzYciehNx+PT8hVW+YChvIq6tL+YBSfQoMkQOtILROGOiK/uhUlTx7GVGOe2VvALCdVlYR
	pSzK8
X-Received: by 2002:a53:c049:0:20b0:651:ca41:3ce1 with SMTP id
 956f58d0204a3-65310870e0fmr11419676d50.26.1776718027650; Mon, 20 Apr 2026
 13:47:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776429984.git.u.kleine-koenig@baylibre.com>
 <c830049dcfcd99f005e2ff6742aace9341c61f13.1776429984.git.u.kleine-koenig@baylibre.com>
 <aeaMkfk_1t98e7SU@monoceros>
In-Reply-To: <aeaMkfk_1t98e7SU@monoceros>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Apr 2026 16:46:56 -0400
X-Gm-Features: AQROBzDn0VxgmPSE3vK5sUClFYZviCWKHJM6c6xPINx44xwN2GgHY3fLhlrfQ5s
Message-ID: <CABBYNZJzbEmYzTk2m+Y8SoHVouTMA6Gje_55iJsQ6cYtDLftbQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] sdio: Add syntactic sugar to store a pointer in sdio_driver_id
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Ulf Hansson <ulfh@kernel.org>, 
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, linux-mmc@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	linux-mediatek@lists.infradead.org, Ping-Ke Shih <pkshih@realtek.com>, 
	linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Brian Norris <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Mon, Apr 20, 2026 at 4:31=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Capable =
Hub)
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello,
>
> On Fri, Apr 17, 2026 at 03:10:47PM +0200, Uwe Kleine-K=C3=B6nig (The Capa=
ble Hub) wrote:
> > On all current Linux architectures sizeof(long) =3D=3D sizeof(void *) a=
nd
> > this is used a lot through the kernel. For example it enables the usual
> > practice to store pointers in sdio_driver_id's .driver_data member.
> >
> > This works fine, but involves casting and thus isn't type-safe.
> > Additionally with the CHERI architecture extension there are machines
> > with sizeof(void *) > sizeof(long) for with the traditional approach of
> > storing a pointer in .driver_data doesn't work.
> >
> > By replacing the plain unsigned long .driver_data by an anonymous union=
,
> > most of the casting can be dropped and it yields a working solution for
> > CHERI.
> >
> > All users of struct sdio_driver_id are initialized in a way that is
> > compatible with the new definition, so no adaptions are needed there.
>
> sashiko.dev found s/sdio_driver_id/sdio_device_id/ twice in the commit
> log and once in the short log. If you consider applying this patch
> please adapt the commit message accordingly.

No problem I can fix them up once applying.

> Many thanks to those who created sashiko.dev!
>
> Best regards
> Uwe

We only received 1-3 of the 6:

https://patchwork.kernel.org/project/bluetooth/list/?series=3D1082520

Or is this on purpose, and we should consider the set complete?

--=20
Luiz Augusto von Dentz
