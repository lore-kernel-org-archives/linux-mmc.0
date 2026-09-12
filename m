Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE7536EAA4
	for <linux-mmc@vger.kernel.org>; Sat, 12 Sep 2026 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789199428; cv=none; b=lZTs0EbIb9dEUQRK/qsJ08i2tTTGO8ktRXmLmVbYWLFA9yf14wS5kwdBg86mfG7DWGboMNwWvaJ3lP2t4E5S90NCv5djKI8jJnRDg1wbqZCjG88kpLWB8sHAxJap1bqIxVQ59a0M4KxdO8nGd6IQYlHttbxfIC+LquzlbRXkUYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789199428; c=relaxed/simple;
	bh=bTBk2CBRDahK1Lh12GNmBkGqI1rSJ+RuEfJVc5A7eMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JFt8jXUOpishFcZOvqOeh4BjWagUxRig49jV1J3xIWc1ie8er2g2WVqX8zSqzLWcPDpy84JOLsKuL1De7Zd9BNZF1fASxQpFHL3ByPsPcpel3aNk1DGHHABVnbJUfFEBb4DYnNkKIRD5UquWp0Rny5cjUwtpcRzhIr9uDIUZU2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e50968489so368560d50.0
        for <linux-mmc@vger.kernel.org>; Sat, 12 Sep 2026 00:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789199425; x=1789804225;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bTBk2CBRDahK1Lh12GNmBkGqI1rSJ+RuEfJVc5A7eMs=;
        b=a2XtZdLieUgurFrYmfElJdf9vEF2LrdYAdaGkeuaJawRBfl1URIQVZGiq+CHuSf2gA
         NCbSkRYQYUWfqq3Mkv+PpX+d/pC9+NketW6Wnp5gIpty+YCq5bKTyhfVt1EiAzVdgjfb
         4t1UTKmzIWGF+OOk9fKaMg6oAWHgWYwkhGiRTMBuG6FqSpYSNry0m1/6gkY9xjxmUgNj
         s/V7QZ3ifA5pIU71MBXdgGf+YGYdv/G7g0E0Zz9RSm7gR+RCTvxNfgCV70AbeEm1uGL4
         dB0zov18dI7UcuEjjjMUqID8TmmZUvRBnf2HMlj8q+2Wzb2NPaSU/Sjqa3UFtFA5xXjy
         lSCw==
X-Forwarded-Encrypted: i=1; AKwUvBz3YvYAc+jNjDzMFlrhkqPIsp+I8ITeTbID4TWhmtKnqFu/qnkadXqdP596j+mMD2hXBBulmLaIWUA=@vger.kernel.org
X-Gm-Message-State: AFuF++n4X/hd0eipTCk/K2C3dW8Szh33a4TwBxd2g2yrg92tSCRk1w2q
	lu6t+9REtwOTPaHRIz8+ri8uEeG0jjliHOWeh2icd9zNYF0RLNTFT0DWoMvGUKHDdiI=
X-Gm-Gg: AYBFou0jlr6B2NNkQpE/QvMYCIPc1/2J90KXwxkKU2g1nAxFRqLDKEGLdWJHMNz1Ldo
	XMv1k8uF0ewfL3KDUb15TrJ9jdIThcA6nYDc7ByDVojQhDBKtIVUMHLaUgCsv5Fo/NgeS/vzRKg
	84v3gkvJP4uvMvHgZMfwZNytv0putg2wqXdCi+E6CWAJVLbTTa06x3mAWgYiiPLB7UlO14Tl0HV
	XGoAuVSln4uaXgB6Zxy3XmBggYTf+Du941szUVryRuewinLPblAsW+fgwWYMHMyOOkFU2WaD4zG
	6O5E1hnJxRA89rhT2ShA2wTLzFT84mAn9UM0INZY5h+dklcf9/3YxwXvTYQGp4h4heo2VCEIdnR
	gpfqpt8tI4oN3CNO9ZfFO2WZmisKiOzZgUdAK7yXe17rvoSLSoSSQ9GlKtVag5dfIpkWqwSbi+w
	ohl/dvXrGO5UO0FM0WKL5TzzoJw2nzUNAVWYAn7U49/MTSJAo1yLAH7SKaMBuMaAD71GvyEJO2V
	9V8ebPNHYjhtuiYuX92OrnOTAMFOaZBPuVStwM7nYkaGsgqx1nU4pcEFvkL9Td/
X-Received: by 2002:a05:690e:12c2:b0:66e:5748:e04f with SMTP id 956f58d0204a3-671245d248fmr3722421d50.20.1789199425585;
        Sat, 12 Sep 2026 00:50:25 -0700 (PDT)
Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com. [74.125.224.141])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67125e3fa87sm2041240d50.14.2026.09.12.00.50.23
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2026 00:50:23 -0700 (PDT)
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85e68bdbcc1so4758907b3.2
        for <linux-mmc@vger.kernel.org>; Sat, 12 Sep 2026 00:50:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwG0Zo+aEWW2DqJN1ro4z5vJakTI7jpWLYkRSZCCTYNUt3LaXlkH9ordYWxKzjQ6gliFd4eEUN+ews=@vger.kernel.org
X-Received: by 2002:a05:690c:97:b0:81f:e85b:f9da with SMTP id
 00721157ae682-884b4b01ddamr30061107b3.33.1789199423193; Sat, 12 Sep 2026
 00:50:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905153234.133217-1-tanure@linux.com> <20260905153234.133217-5-tanure@linux.com>
 <aqSX-kUvYaixESxe@redhat.com>
In-Reply-To: <aqSX-kUvYaixESxe@redhat.com>
Reply-To: tanure@linux.com
From: Lucas Tanure <tanure@linux.com>
Date: Sat, 12 Sep 2026 08:50:12 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+2vpcFw-5evCkykwWo6jbHvKvQ4XjYt_EKFyJuQm_ES5g@mail.gmail.com>
X-Gm-Features: AcwNN1V-hZOzugyfoJiJeFS5rmMdeoAyBQ6wZJLEfk_Dvgzhb0zC99WtQCvbVRg
Message-ID: <CAJX_Q+2vpcFw-5evCkykwWo6jbHvKvQ4XjYt_EKFyJuQm_ES5g@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] clk: meson: t7: don't mark sys_ampipe_nand as critical
To: Brian Masney <bmasney@redhat.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, 
	Kevin Hilman <khilman@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Chuan Liu <chuan.liu@amlogic.com>, 
	Jian Hu <jian.hu@amlogic.com>, Ronald Claveau <linux-kernel-dev@aliel.fr>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 1:08=E2=80=AFAM Brian Masney <bmasney@redhat.com> w=
rote:
>
> Hi Lucas,
>
> On Sat, Sep 05, 2026 at 04:32:34PM +0100, Lucas Tanure wrote:
> > sys_ampipe_nand clocks the pipeline stage inserted in the bus path
> > between the SD/eMMC controllers and the NIC_MATRIX fabric. It does have
> > identifiable consumers - the three MMC controllers - so marking it
> > critical was the wrong tool: the clock should be referenced from the
> > consumer nodes and claimed by the mmc driver instead.
> >
> > Drop the CLK_IS_CRITICAL flag and update the comment accordingly.
> > sys_am2axi0..2 remain critical as they clock the AXI DMA bus itself and
> > have no single identifiable consumer.
> >
> > Assisted-by: Claude:claude-fable-5
> > Signed-off-by: Lucas Tanure <tanure@linux.com>
> > ---
> > This patch depends on the MMC controllers actually referencing the cloc=
k:
> > the dt-bindings, mmc driver and t7 DTS changes adding the "pipeline"
> > clock must land before this patch, otherwise the boot hangs and memory
> > corruption this clock caused are reintroduced.
>
> This series should be merged together in one tree? Which tree? I can
> provide an Acked-by if it should go through the mmc tree.
>
> Brian
>
It's definitely best to keep the series together in one tree to avoid
boot regressions,
but I think the clk tree is the better fit since the core changes
revolve around clock logic.
Could you accept it ?

thanks
lucas
