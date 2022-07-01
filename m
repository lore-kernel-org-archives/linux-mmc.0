Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654EACCA479
	for <linux-mmc@archiver.kernel.org>; Fri,  1 Jul 2022 19:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbiGATty (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 1 Jul 2022 15:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiGATty (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Jul 2022 15:49:54 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BAA24F11
        for <linux-mmc@vger.kernel.org>; Fri,  1 Jul 2022 12:49:52 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id p11so2555588qkg.12
        for <linux-mmc@vger.kernel.org>; Fri, 01 Jul 2022 12:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u6fPAgM8gi/RJI8YuKyRjChuGCO5jCSEWC0CBzNffV0=;
        b=ByfbfV2q6QbOnkjD39rDX3vW30bOrecwJhGvEHJzy5JQ/s934vXaj9cLQ9w0HT7ewk
         dvx4xjT5TlZTxJ8LWAUp5DJ3HZnM6sYHf/Q5nRt5bv2Uf8SiSx9odeglVNB6rjCs7cgX
         4UD6GljcU0u+QNeS8Sz4D281+08LbQJ8iUPe8a0e0GHMW+MnvDyP5SUppa9qndiB+nt2
         M/GHSOqGlEBUZYAYrT2cIuovkV/rBEI0RQ7SlQsOY6ogtJt6ygSXnsNBVLKkfVTq/gT4
         oPTL4dGhrujdy7vKT7Q07GIz5K76g7AKv/I0weag9+QqzgJeqs85YQYWu5qqAN6tIdU1
         MTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u6fPAgM8gi/RJI8YuKyRjChuGCO5jCSEWC0CBzNffV0=;
        b=yMS2Avu7+ZJoamiwfL2p/xI4R3WQHxpByDrgtkPfm1otLnVLocRduH1gTOhwsyn68A
         zRe4/kjUcvpcQRNA2ysySFVGaecON1CooOfkYnLno5oHD0QFgcKTVpEh1j7lmX9uxvPk
         IHA+zqL1SiKAW/JfkDxsZXHKOgxBs5kigGxghweZfMOP0iihjmmU/pNkPxOk4oTzkigv
         2Cpnhyt5AsscTHBXF6rg88YtasvDiQRdRT81mMSJAB9RzlPlXbsxrgFICe2KZNx2bX65
         jlss72/89Z+Rx2bRIFTkazTVnbu4ClW8SwAd5C0BEvq0h/w0qz0BcSQvKkyNbQ+YI3Md
         Zgzw==
X-Gm-Message-State: AJIora/Z4eulG58lkRKWNZ0NtwpQH2vSJj/3BFYIfUqm7BN9pDadHbgU
        K+7t56zCIjF5rF/oicNTuQtXly0xhqVa8NYiY1tYrBalz7I=
X-Google-Smtp-Source: AGRyM1s1AY7XBEABePvu0AwdCbeRlv4PSrgMczV/kpgOfIvJvzVm2yQHPAjRjjG9DAkpsWyd7uKVstLy75J/STwM7js=
X-Received: by 2002:a05:620a:46ab:b0:6b1:6550:9062 with SMTP id
 bq43-20020a05620a46ab00b006b165509062mr10580150qkb.80.1656704991257; Fri, 01
 Jul 2022 12:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <CABMhjYp3xUyQ9q6nXHvEA2zuzhYi0ETn6UETeH1apWf2n2eP7A@mail.gmail.com>
 <7ba0c325-bc1f-f6e4-dd8a-b5d13a04ef93@microchip.com>
In-Reply-To: <7ba0c325-bc1f-f6e4-dd8a-b5d13a04ef93@microchip.com>
From:   Atul Khare <atulkhare@rivosinc.com>
Date:   Fri, 1 Jul 2022 12:49:40 -0700
Message-ID: <CABMhjYrDyOoDusE4-y4VzM87Vg=NhPbow_dQ+1C4EcX50LrMHw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] dt-bindings: sifive: fix dt-schema errors
To:     Conor Dooley <Conor.Dooley@microchip.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Conor,

Apologies for the delay, but my laptop died a couple of weeks ago, and
I have been scrambling to get things up and running on the
replacement. I will try and get back to it ASAP.

On Sat, Jun 18, 2022 at 5:40 AM <Conor.Dooley@microchip.com> wrote:
>
> On 09/06/2022 00:39, Atul Khare wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > The patch series fixes dt-schema validation errors that can be reproduced
> > using the following: make ARCH=riscv defconfig; make ARCH=riscv
> > dt_binding_check dtbs_check
> >
> > This is a rebased version of https://tinyurl.com/yvdvmsjd, and excludes
> > two patches that are now redundant.
>
> Hey Atul,
> Any word on (an applicable) v3? Would like to get rid of this last
> couple of warnings.
> Thanks,
> Conor.
>
> >
> > Atul Khare (2):
> >   dt-bindings: sifive: add cache-set value of 2048
> >   dt-bindings: sifive: add gpio-line-names
> >
> >  Documentation/devicetree/bindings/gpio/sifive,gpio.yaml      | 3 +++
> >  Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml | 4 +++-
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> >
> > --
> > 2.34.1
>
