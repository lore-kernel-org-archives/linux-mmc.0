Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795774052;
	b=lpU1cqEIZxSeL31asH8BCl48Pg0PB2k9rw4zFtnE4oTYiQ65YeUDeKwNzUd0JCKq2lYO
	 aX/pk9DGUPsihb5mp5NiQh4cNBmBs4NyG7lqTzkz4feMC7lBDi5OeenugyWN5bvefvgj5
	 587YDSt/fyz/0Y77lvVpjoHpOuBmmZjvtl6+qTNd0nTqtlaHgTnFGtfEHDaE2sNEmUGFZ
	 Qs7V3Z4mAk3oi+dIto63nf8aWGzwts+qktXBgsvoEoRLTm/uAl+xyZkED1mQx6F8oFVy5
	 zgH7Y+0DWf7Uamg4bmUtp0dsr4N6RM/vi3GWAlT6R4EhG8hdgBXqPY9JLoYansCvqRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774052;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=S/PXjXpl1KxRCCiW3qKqRyfY2HAeEsAmwu7iETB2+Lk=;
	b=atT0x1IKbtGMHqXDBfHfgVefGqMbjvkvPOsAlqhWS1nsFNiw7jaJ0EXK9p3gQHJUVlKb
	 uar+SPf314D6I48y4JkNRGwYISDJ+LDBUTTaIjv1mwV1eJ69w3j5t8qqHGN1m4VHitIc6
	 WCCoP6q0q+prBg36qlii7gE4fTz2ELKX9El+cAiRE8sbC1qHbm5jmlBaC3jCwCKFWCGBs
	 njaQV8oClgQ8Y6jWHc9fPifAg5Uen45iVPA59zW2rfkphZzxFkwtFFDX4agrp6RMcBk2c
	 oTZvzKHmyOz3ddEuYkqM7WseN890lsK3oBktt6DJDmDpLOc7KfCQt5C75dSZvWtzhJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T8ZERY7z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64212606A334
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 10:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64212606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T8ZERY7z
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5c08539c827so6168441e87.2
        for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 02:07:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795774050; cv=none;
        d=google.com; s=arc-20260327;
        b=TU8gi5UJkiaaKq/3mZj68m4vF9GFRva0XWa97HbTsuUCOX1RUPpg/g5xjt+ZvOj1Vb
         0OGvfKbh+QojzIY3f/0c29zEAwTabzuuikp7MX2hcDn+djI9e/3WIHavdEzinoEU3bBk
         YC3DxHZjy3TqGCV83OimviWIwxGX+Rg1VEVIllGGPPdEj3oxYXJGrxOz9SXaGEJQvLsx
         olzV3hUd8krosvYXTR+YZOowmY7VywHSIc/LzTJGqhQnC3fpIqXlKZkbPX91sD9hospG
         twF6MuqCbsFf+U3uJYsjsfBvSgb9ucJSkYWRh52kpInQoqpdZ5xSQHOQSc76L9JtfHZP
         KJtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S/PXjXpl1KxRCCiW3qKqRyfY2HAeEsAmwu7iETB2+Lk=;
        fh=JisjFVXzP58WPeVj76Rg/FMjfcZLgorcwq6OGHVj3CU=;
        b=F7cZaFyJpvaS7nf77Cy6qZ64FrUua/Xe6Dpjz6IDEyT7r9Vmo5nwaikvY5gnbaU3Un
         hws4ePvxkrCoe/lqy96yv5tfI6ik4w8lLPj7MG58Qqikwsa/AFdJs0SWqB7FWIEX3IVa
         //RzLFquLTAPAmMt8q9VWgCtrpVmKv0h88IBFxRZgk2u1GRtBQCCLcdILLccdHdCZIfE
         308D3WUb8nK6Yy+2XZOWcxgiiylcyv9AegEImhVAPaxamFUS1CEc5x8x3duWQ7ZH1QUb
         hIA38ZRPKdWuZma9c22Ml1+YlhnaJwauftjk+uJjR9AztPpC/7Bo1FfGXs8slb/w73dN
         3U+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795774050; x=1796378850; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S/PXjXpl1KxRCCiW3qKqRyfY2HAeEsAmwu7iETB2+Lk=;
        b=T8ZERY7zD/vy0H1Rb2du90/b67CWcF96NyZsqFxOi/RYxzLhB+qwyRH8qcWPBraa8v
         mW2zbzSP49Foraqc+NQDAmXZ1wubTXXFWND6ZtkJhZsKeALOmqaWo2ukNLoEvE2+62ZK
         6cLWHCumugFsUXIOtnP1I6tOsdCFTb7E+KqpznZQ9CJe95VPa1CX5Q3G6qZlNTsxFj7I
         +oKRx6WVXOXR0C9HVFtpTdRHu+eXoKolZFYEVFXpOd1/gQmHnPvjxoxPAEZfwuB0CqQj
         ZwCKClrm4FF4FjWeUhiqnMc9RPcBVLJs6R10KN7KtdHAmOMrEx1LzrMDpPSd3zjZIM7o
         EtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795774050; x=1796378850;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S/PXjXpl1KxRCCiW3qKqRyfY2HAeEsAmwu7iETB2+Lk=;
        b=c0ncgpk3ssxvWff2Fdnr/B62kHxMJ7puG+J5g250AGMFcbD7u+zMWqNW6WDjJjyM5h
         QRv+PJmt0Y8IDI/RIwzeBsPC0/Xu9UPzG7xYC9GMrUkjX15dk6D65p2VW9eOhDFBT9m0
         eBWUpCyGaF5JFuAfga3BsmSTAdaYX5Cg1K29+o6ZJsk2vtMAaCq7RWMmJCiB+SghNOQb
         jvYQqwpJGTSJZC2ujFAYCIeK0qvr67jVl93np9DPXGkm++mdc7qd/ydNpuUm0W+VMIu7
         53hqNaDaUg5Gknwi69aIJB8hTQ++fBLYaazXXQsOhu13v4K92jBPDPd+3s3/Yk1TKhDu
         BfdA==
X-Forwarded-Encrypted: i=1; AL+hErGjGYymRc7ZANvxJaeRCE3RDr4QlnrCAKETu0UF625it0p7OPbPtZ3+blwTsCxEeplsiA7m/EY5rgU=@vger.kernel.org
X-Gm-Message-State: APuU4Z92MQqa1Pa9dZN2yfYEDDHbjeIl8NkR7B9hKRyfK+UNMfdtayty
	Vz8h+T7gKjYL8zBldgCcacZrtuqahUHzrtmt+kO07g0UtH9bRFgGR9LdtG2SdjQ8o84QhqCsKq9
	GZXoQHNHdmXqoCymVXEzj9Ybztrevc24=
X-Gm-Gg: AZFdTZeH1VI0mTqtJ/YxTmBJT+bKGCvDP5ioZ9OidhVHayPPXTDdbtlO/GUKOBTMSvh
	+ec21Z254Dfh8uQfXB4ZjwoSt9ew1TxLFwg6DB5nPSLAppePc22Yz4aUKJvXszPYljutRwoD4sg
	i2iod3gz4b4/Gg9UGHRnCx05UF4AOISMOUL9ep15n+fTzcX5wgdfl8tLaq0HVcjafoic3XKW61e
	LJcJSJo9rF3+yRQyPevs69/C6hvjRUHPBAbgMG8xll+WuBK+KY6nRDQguGTdCXpbw0K5+9PQfA3
	gHmsQZjuF7tq9nA1UVTOFhqFqVkeNWcAZW/JE7OAX4R70nneb5iIELL4fjIuZsL1fMc5842arpU
	ow/Q41H/BZ9//R0miTVZMdxMsHmn4Go9zS/aJp77UpWfPGpq0MYypS2ncy5cStdUlW6ZqT4hhHI
	FvC+K/Z0k5jjvweej69DQvdYq73onEy3w=
X-Received: by 2002:a05:6512:10cd:b0:5bf:f8fc:7b5e with SMTP id
 2adb3069b0e04-5c1bc89c61fmr6700305e87.55.1795774050347; Fri, 27 Nov 2026
 02:07:30 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121-at550-rfc-v1-v2-0-b0309d0789b2@gmail.com>
 <20261121-at550-rfc-v1-v2-8-b0309d0789b2@gmail.com> <awQEP9bHA0RPfRUA@monoceros>
In-Reply-To: <awQEP9bHA0RPfRUA@monoceros>
From: =?UTF-8?B?57Gz55Sw5oKg56KB?= <yogo.0917.sabu@gmail.com>
Date: Fri, 27 Nov 2026 19:07:18 +0900
X-Gm-Features: Aa3M54o3XA2vGbw-lT3h-QsKcDE27T0mWx-80FMotXTw-keuMBkBtHCZ9WsWU5c
Message-ID: <CAJGK9zaVJ-42c-AnZuXBW1uskvmRQv1ePHQsx=BMz55RfznomA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 08/13] Input: add polled SiRF AT550 resistive
 touchscreen driver
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ulf Hansson <ulfh@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Russell King <linux@armlinux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-doc@vger.kernel.org, soc@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 10:16:56AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>
> On Sat, Nov 21, 2026 at 09:43:18PM +0900, Yuugo Yoneda via B4 Relay wrote=
:
> > diff --git a/drivers/input/touchscreen/at550-ts.c b/drivers/input/touch=
screen/at550-ts.c
> > new file mode 100644
> > index 000000000..89c2d2701
> > --- /dev/null
> > +++ b/drivers/input/touchscreen/at550-ts.c
> > @@ -0,0 +1,124 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* SiRF AT550 coordinate acquisition. Layout cross-checked with AT551 =
draft. */
> > +#include <linux/bits.h>
> > +#include <linux/input.h>
> > +#include <linux/input/touchscreen.h>
> > +#include <linux/io.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
>
> <linux/platform_device.h> already provides of_device_id without the
> implied dependencies you get by including <linux/mod_devicetable.h>. So
> please drop the latter.

Hi Uwe,

Thanks for pointing this out. I verified both built-in and modular
builds without <linux/mod_devicetable.h>, and I'll drop it in v3.

Best regards,
Yuugo
