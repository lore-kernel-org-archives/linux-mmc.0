Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDEEC433FE
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Dec 2021 12:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238939AbhLCMDd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 3 Dec 2021 07:03:33 -0500
Received: from smtp2.axis.com ([195.60.68.18]:27975 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380653AbhLCMDd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 3 Dec 2021 07:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1638532810;
  x=1670068810;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=58eYs3C3XZxcIoL4sUUVPSKpBAma5YmWgb+uL4b9UBI=;
  b=IqE2FKgPgUqd654mIdt0B8FjI0372WwTZDTkYTPqX3e1wA48yKFjw3ih
   KO6Se6hjQLZI3R2Tt2v0jXmb6RQeTJYjwq9QDwF5Ftv/axADWFY85uVJK
   J87a9sNBpCnuvkkvA8g7fTaAYVbwRAuYZwlb+I8zKBl1dy7PpYoHCBt+n
   qFKy+T2re8rMYdExMoZFvR6op2dMmG+KNYTs2slNV6bFrKiK+NfqslcE0
   XllzDLeOUKxzMQ/KnDMvet3tXhphHsEkX/OYOtSX+/0Dz2LkHxoII23Oq
   kz4d7JKcIuveQtNLRHRrVQisf3VBg8RCvQLE//NMtmmgJ3SJwtGE/wt+Q
   g==;
Date:   Fri, 3 Dec 2021 13:00:07 +0100
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Doug Anderson <dianders@google.com>, kernel <kernel@axis.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: mmc: exynos-dw-mshc: Add support for
 ARTPEC-8
Message-ID: <20211203120007.GA23260@axis.com>
References: <20211201153804.27655-1-marten.lindahl@axis.com>
 <20211201153804.27655-2-marten.lindahl@axis.com>
 <c6a44fd1-ad48-06cc-4a96-818ca124afca@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6a44fd1-ad48-06cc-4a96-818ca124afca@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   Marten Lindahl <martenli@axis.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Dec 02, 2021 at 09:41:05AM +0100, Krzysztof Kozlowski wrote:

Hi Krzysztof!
Thanks for looking at this!

> On 01/12/2021 16:38, Mårten Lindahl wrote:
> > The ARTPEC-8 SoC has a DWMMC controller that is compatible with the
> > Exynos 7 version v2.70a. The main differences from Exynos 7 is that it
> > does not support HS400 and has extended data read timeout.
> > 
> > Add compatibility string "samsung,artpec8-dw-mshc" for ARTPEC-8.
> > 
> > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> > ---
> >  Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> > index 0419a63f73a0..161be451a1f0 100644
> > --- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> > +++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> > @@ -22,6 +22,8 @@ Required Properties:
> >  	  specific extensions.
> >  	- "samsung,exynos7-dw-mshc-smu": for controllers with Samsung Exynos7
> >  	  specific extensions having an SMU.
> > +	- "samsung,artpec8-dw-mshc": for controllers with ARTPEC-8 specific
> > +	  extensions.
> 
> Artpec8 does not look like Samsung, so vendor prefix does not match.

Since the IP is very similar, I just copied the vendor prefix from the others,
but ok, I will change it to 'axis'.

Kind regards
Mårten

> 
> Best regards,
> Krzysztof
