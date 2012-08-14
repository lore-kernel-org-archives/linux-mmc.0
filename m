From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: card: Skip secure option for MoviNAND.
Date: Tue, 14 Aug 2012 10:03:24 +0200
Message-ID: <CACRpkdaC98DxifezD7-=ww2rjet5CnSiH2SN4UqgcyOsWa=MiA@mail.gmail.com>
References: <5028CDED.2020307@samsung.com>
	<CAKYAXd--Ta1xL2uMEsArmpsg99x+B21ScJOQAty=RFWWCQ6M2w@mail.gmail.com>
	<000e01cd79c2$4c6a8cc0$e53fa640$%cy.chen@samsung.com>
	<CAKYAXd9h5KG09zMm2gO_0keycfBQ-Pq5-Z+tXYrhfuSc0equLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:47302 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866Ab2HNIDZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Aug 2012 04:03:25 -0400
Received: by vcbfk26 with SMTP id fk26so81529vcb.19
        for <linux-mmc@vger.kernel.org>; Tue, 14 Aug 2012 01:03:24 -0700 (PDT)
In-Reply-To: <CAKYAXd9h5KG09zMm2gO_0keycfBQ-Pq5-Z+tXYrhfuSc0equLQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: IAN CHEN <ian.cy.chen@samsung.com>, cjb@laptop.org, adrian.hunter@intel.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, d.j.shin@samsung.com, jongtae22.kim@samsung.com, kyungmin.park@samsung.com, jh80.chung@samsung.com

On Tue, Aug 14, 2012 at 5:51 AM, Namjae Jeon <linkinjeon@gmail.com> wrote:

> So Would you change flag name to be neutral ?

MMC_QUIRK_SEC_ERASE_TRIM_BROKEN

It appears that mmc_blk_issue_secdiscard_rq() always use both
erase and trim (given helpers like mmc_can_secure_erase_trim())
so if either is broken we set this flag.

Yours,
Linus Walleij
