Return-Path: <SRS0=9I0v=2H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95504C2D0CD
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 14:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BEB02146E
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 14:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cw3f552w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfLQO4V (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:56:21 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:40153 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbfLQO4U (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Dec 2019 09:56:20 -0500
Received: by mail-il1-f193.google.com with SMTP id c4so4159848ilo.7
        for <linux-mmc@vger.kernel.org>; Tue, 17 Dec 2019 06:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bLWs/wd6D34VXv138fiD3C4WAkfxJpBi3ZAW7HjBL8c=;
        b=Cw3f552w0jI9cUaZYNlVyyEH9UFh8XoM7H124UVYAjbot5wooDlvogYx4OcN+jh3e7
         VKqmCY9lr8C/t92tUqYGNTxe/66dvYDMN4CFVLZovVETxVufwSrIwDIj43rdroiOjR9v
         0GtwFf0YVGIvlEVS/+o/E2CQ2AUBTo405s7Fb9dfVu8MLZZqfFWJrVlhmpShk8vDOKgl
         FZSdKO/BVKfCaxJ3sVEdJ8466NMPAcWFITjH+ZAUAFh8+SrukBqDfaII/em8ZiIf/SBy
         p/i5xoDXjaYTi5o4ZPqoVK2Zj+Y1KtSMjupHC94OJv5oFtcDpb/dU5sGSP3FmtBitJzH
         jtmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bLWs/wd6D34VXv138fiD3C4WAkfxJpBi3ZAW7HjBL8c=;
        b=ceXedxqHV7yrCvut3/wJ83bg/mF5feanKjqDCgDn9G+owy9MVX9NxBKUZRV76J7FcA
         voo4Y2daWjVYLPAI11grtwC6gX12NObVivlkhxGRS1ziobroG4xufQyAUN2N3yBgFsLx
         +LLkNn0+4tayO07DPLzkMv6xYX4XdgyMVpVOChr+cM7hpSEGH0XYBpVQiPOuCO3/MHVO
         0jv8aIkHdn1YZ24hrDR/lDxuVNPynDysa2KLpkaL/75Y504wB10Fy9nLnW9Te3YDi92X
         CP3cM4azDJ4qqV9a4V2hR/n9xS6YZvV+6FfhI3mruLFXcDfQp0lGixfHQzbZp/e7ijJT
         ox2w==
X-Gm-Message-State: APjAAAVxZHOqDP3zf0pjYrlW26YNdSXxE/bDdZNFATfSVTQ4jtwoJbQd
        MDEnLdAiFqTP5MCZegsIHCcQF6zTa14TuOEMUqdxIw==
X-Google-Smtp-Source: APXvYqxhC/Y7CyWDF3xIroMcRB3lWtq589/h5nwlDksFEV/5sd6lWme315cNRpOwTlhXY/StdhJUQsZrLt7Bni/cOHc=
X-Received: by 2002:a92:9107:: with SMTP id t7mr17497740ild.51.1576594579808;
 Tue, 17 Dec 2019 06:56:19 -0800 (PST)
MIME-Version: 1.0
References: <20191202144104.5069-1-jun.nie@linaro.org> <20191202144104.5069-3-jun.nie@linaro.org>
 <20191213230137.GA15696@bogus>
In-Reply-To: <20191213230137.GA15696@bogus>
From:   Jun Nie <jun.nie@linaro.org>
Date:   Tue, 17 Dec 2019 22:56:08 +0800
Message-ID: <CABymUCMgfx=O3-PHKJcaCrxxN0K6b1t2Y-XvOWwTMuDwZyVyVQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] mmc: sdhci: dt: Add DMA boundary and HS400 properties
To:     Rob Herring <robh@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, adrian.hunter@intel.com,
        linux-mmc <linux-mmc@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Rob Herring <robh@kernel.org> =E4=BA=8E2019=E5=B9=B412=E6=9C=8814=E6=97=A5=
=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=887:01=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Dec 02, 2019 at 10:41:02PM +0800, Jun Nie wrote:
> > DMA memory cannot cross specific boundary on some controller, such as 1=
28MB
> > on SDHCI Designware. Add sdhci-dma-mem-boundary property to split DMA
> > operation in such case.
> >
> > sdhci-ctrl-hs400 specify the HS400 mode setting for register
> > SDHCI_HOST_CONTROL2(offset 0x3E:bit[2:0]). Because this value is not
> > defined in SDHC Standard specification.
> >
> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/mmc/sdhci.txt | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/sdhci.txt b/Document=
ation/devicetree/bindings/mmc/sdhci.txt
> > index 0e9923a64024..e6d7feb9a741 100644
> > --- a/Documentation/devicetree/bindings/mmc/sdhci.txt
> > +++ b/Documentation/devicetree/bindings/mmc/sdhci.txt
> > @@ -11,3 +11,11 @@ Optional properties:
> >  - sdhci-caps: The sdhci capabilities register is incorrect. This 64bit
> >    property corresponds to the bits in the sdhci capability register. I=
f the
> >    bit is on in the property then the bit should be turned on.
> > +- sdhci-dma-mem-boundary: The sdhci controller DMA memory space bounda=
ry.
> > +  If the controller's DMA cannot cross a specific memory space boundar=
y,
> > +  such as 128MB, set this value in dt and driver will split the DMA
> > +  operation when crossing such boundary.
>
> This should be implied by the compatible string.
>
> > +- sdhci-ctrl-hs400: The HS400 is not defined in SDHC Standard specific=
ation
> > +  for SDHCI_HOST_CONTROL2(offset 0x3E:bit[2:0]). Different controllers=
 have
> > +  have different value for HS400 mode. If 0x5 is not the HS400 mode va=
lue
> > +  for your controller, you should specify the value with this property=
.
>
> This too, unless it needs to be tuned per board.
>
> Can you be more specific as to what the possible values are and what
> they do?

It is specific to SoC or specific to controller. HS400 mode value on
DWC3 of new Hisilicon
 SoC is 7, not 5. This same is to DMA buffer memory address boundary.
Do you mean you
want the boundary value and HS400 mode value should bundled with compatible=
,
ie. specific SoC or controller, to set a value in sdhci layer from
platform glue driver?

>
> Rob
