Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54D6C433F5
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Dec 2021 20:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhLIU2p (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Dec 2021 15:28:45 -0500
Received: from smtp1.axis.com ([195.60.68.17]:21265 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhLIU2p (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 9 Dec 2021 15:28:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1639081512;
  x=1670617512;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=KsLGd+fvLjUQT9yme4SsjhX9IfMavzsFuYGxo1t5j7o=;
  b=MgOMpaZN3rEdSbbcOFoBQtWzTg944XZsZwXB6RPbGn8unY+P8aDhiAk3
   ziW4jlhUAApmPp1txN64sguG5HfEU8jUYUGhqsCOKyyaL67oo05ZfcArM
   s0K/ZpiaeRuPR7ZBl0QCS2TSyN8VpsD1Mxm2rw79qzT969G7j/baeABIg
   bO2JN41RMUwLM03tnNSVrw1TSugTpgktWOQ2GwI7kMJvCeJUqUGgM56ih
   cDJnRqFHvyZ07tUBDvuiQl801dGf38Jejwlmdw83lKkwwYz9sR5W0z62K
   zBYmYFWvcehXzPGL0JcvmDYxnwrFEmaiqBCEF5Fr+2ChXvsRq5tG9XlhA
   g==;
Date:   Thu, 9 Dec 2021 21:25:09 +0100
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
Subject: Re: [PATCH v3 1/4] dt-bindings: mmc: exynos-dw-mshc: Add support for
 ARTPEC-8
Message-ID: <20211209202509.GA8509@axis.com>
References: <20211209164558.13729-1-marten.lindahl@axis.com>
 <20211209164558.13729-2-marten.lindahl@axis.com>
 <5f74a62f-fb94-72d3-341c-e2921faa4282@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f74a62f-fb94-72d3-341c-e2921faa4282@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   Marten Lindahl <martenli@axis.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Dec 09, 2021 at 07:27:25PM +0100, Krzysztof Kozlowski wrote:
> On 09/12/2021 17:45, Mårten Lindahl wrote:
> > The ARTPEC-8 SoC has a DWMMC controller that is compatible with the
> > Exynos 7 version v2.70a. The main differences from Exynos 7 is that it
> > does not support HS400 and has extended data read timeout.
> > 
> > Add compatibility string "axis,artpec8-dw-mshc" for ARTPEC-8.
> > 
> > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> > ---
> > 
> > v2:
> >  - Change compatible string vendor prefix
> > 
> >  Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> > index 0419a63f73a0..753e9d7d8956 100644
> > --- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> > +++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> > @@ -22,6 +22,8 @@ Required Properties:
> >  	  specific extensions.
> >  	- "samsung,exynos7-dw-mshc-smu": for controllers with Samsung Exynos7
> >  	  specific extensions having an SMU.
> > +	- "axis,artpec8-dw-mshc": for controllers with ARTPEC-8 specific
> > +	  extensions.
> >

Hi Krzysztof!
> 
> Any reason why you ignored my tag?

I'm sorry. It was a misstake by me. I will of course add it right away.

Kind regards
Mårten
> 
> 
> Best regards,
> Krzysztof
