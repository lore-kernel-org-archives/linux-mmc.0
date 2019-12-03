Return-Path: <SRS0=3zNE=ZZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00D8C432C0
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 03:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787242071F
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 03:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bIhJpDrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfLCDd1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Dec 2019 22:33:27 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44834 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfLCDd1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Dec 2019 22:33:27 -0500
Received: by mail-io1-f67.google.com with SMTP id z23so2001093iog.11
        for <linux-mmc@vger.kernel.org>; Mon, 02 Dec 2019 19:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EvJt3gzlAO+oRtjqvbXcTygYaOTVm5IYaKaBT0d2KR0=;
        b=bIhJpDrr0wMFIUzju9Z65IyQMHbQhuWnaYHrvLukSGvNKjOPQwY7jZ/Sp0sbWmyDAd
         uFL8yMz5HZJn6WcB9VsIEVJBDXp+A6+o9Zvf1FQ9g9QGJtgmFskn/Px1iM+zJSNbiUU3
         1+Dip6Lgl9LdIq63/gkOqlI5bDdnlimXBpSLLuUx+Ie5+mbF+8kfd7H4kzZUGURQPEGf
         ZYI1StoNCDlzrvWCiI1xvedWy7IQz44/72KcxSBpTlp3eo+9uCHo232I58axeWKDnmX+
         7Y5BZBmErQgx5zWdFMDPDVBzdyaoWttl7ZYYi2Pcf67xKXpn5edxbj0VdIDxcUTdeLZw
         nkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EvJt3gzlAO+oRtjqvbXcTygYaOTVm5IYaKaBT0d2KR0=;
        b=j9tddWXBEpFju/B6ZFHk2o39RK+v3S3yXe0Eppn/PSCWMYVc+NUd7tjznHnTIDvfT0
         ag40dANnuOf9iF3VlbAHdDqFE+qC8QuEty8WN04QLhZUXFbk3/TACGSpKk38rOTRWi4h
         Lj17GKTT2MRFz1klAKQAnDK1GbiZ/1M2HnlXl3z3gIZasRNsyZ5uz0V5ZQ2bDCqdNuJ6
         TlTnhcIii89vwGKtII0J1hVj4akRqqW9nl0xh3DnVKYXw/Bg4n8uj8NDbXfcSozYLXGm
         qOhTDEs1G2cNd9L3YtIUSYYEEz/+YUTx85hpkL0XrKT7ZlvIZJBeVLkL2NgxJ1COq5AM
         HmPw==
X-Gm-Message-State: APjAAAV7w5VLVSHigHdtWsqKmrleMBWWzoixMauN9n/UTrD/qlG4A6u4
        QJBpwGLP796HG9drTm99BjKsoPnrcU38vxB/0JQZFw==
X-Google-Smtp-Source: APXvYqx5yVzLNaPqYrLRSFq+ahc8lvFvDSys1QX06Yk91gT/HgLu/uJBKD7Yp8n+VGgBSEQZksF6nDucKQ3kwhpqr7k=
X-Received: by 2002:a5e:df06:: with SMTP id f6mr804124ioq.84.1575344006859;
 Mon, 02 Dec 2019 19:33:26 -0800 (PST)
MIME-Version: 1.0
References: <20191202144104.5069-1-jun.nie@linaro.org> <20191202144104.5069-5-jun.nie@linaro.org>
 <20191203103320.273a7309@xhacker.debian>
In-Reply-To: <20191203103320.273a7309@xhacker.debian>
From:   Jun Nie <jun.nie@linaro.org>
Date:   Tue, 3 Dec 2019 11:33:15 +0800
Message-ID: <CABymUCMVi_N2Mt82YDt7wrys4Z_vnXYEu15-YBa+S1CejT9iZw@mail.gmail.com>
Subject: Re: [PATCH 4/4] mmc: sdhci: Add DMA memory boundary workaround
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Jisheng Zhang <Jisheng.Zhang@synaptics.com> =E4=BA=8E2019=E5=B9=B412=E6=9C=
=883=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8810:47=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Mon,  2 Dec 2019 22:41:04 +0800 Jun Nie wrote:
>
>
> >
> >
> > DMA memory cannot cross specific boundary for some SDHCI controller,
> > such as DesignWare SDHCI controller. Add DMA memory boundary dt
> > property and workaround the limitation.
>
> IMHO, the workaround could be implemented in each SDHCI host driver.
>
> eg. drivers/mmc/host/sdhci-of-dwcmshc.c
>
Thanks for the suggestion! Christoph's suggestion can prevent the the issue
from the block layer, thus the code can be shared across all
controllers. I prefer
his suggestions.

Jun
