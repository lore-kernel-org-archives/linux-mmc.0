Return-Path: <SRS0=ypud=CJ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B5FC433E6
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Aug 2020 07:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D95162073A
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Aug 2020 07:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="fQpZacdn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgHaH6t (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 31 Aug 2020 03:58:49 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:23825 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbgHaH6s (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 31 Aug 2020 03:58:48 -0400
IronPort-SDR: aW48Qhm+twaX2qlVg3Do+gTihhJUNur1nE8Kt7Gox9N13xf9buBscX+fXgDBqQdU42JzyDm9/o
 2/6Zz1OgJHq8dr6yhAQ3/Tgaw1WYZW83B9gWxWTpRraLBYSDwQz8MxKlDcL24XwlHTEf1jJFun
 PaXlZrs7az5HmYVG8wxblRua1flbKqj5rwmOWsDIhSYhG0n2T+AdEL9rOqgXslUDV9UQ2IX/Br
 iWt3R5nQRKKlMIhhwazOPmBINS+BVFveCVkrm5WcdegVm4JY/WK22zR+yOMGybTGqGgEeW/zVM
 Pmg=
X-IronPort-AV: E=Sophos;i="5.76,374,1592863200"; 
   d="scan'208";a="13658304"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 31 Aug 2020 09:58:45 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 31 Aug 2020 09:58:45 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 31 Aug 2020 09:58:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1598860725; x=1630396725;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vyCow1rPqvLNj8Yuh9CZ0tVP0KoFa72Scu/pyJZGO20=;
  b=fQpZacdnZRyU92CerHJYvaJGJp5mNQ9h7q5s+1q1XnQnaj+jVWWWE2Gm
   X83cSSknF0GyM/QWRaunsvSahfpXEkZn08hXfz9/geDROnBRY55OwdNvg
   beW0ly3cJd0jjCfw/Y0XmkZ7L+0+DOV153xwC7zCG4VtFBzyK5jbAtq2s
   ar12i/jh0m/9JFO62AgvwFYgkMEtgIBzVxmwkBxeNOBUSdId9ajk4nfqa
   AZsZLufuJqdgCRyV6Bpw8O+7AxvQ/l6XkjTZuP0mgJPAOfN2BkqHIlQli
   tlHA0Q8FWT4NGavXo6PPzcBc/AOUlklEJPQfGK4wkuOjxAzTjHWFtdWts
   Q==;
IronPort-SDR: xSrRVFkECV8huYMhm5XOtvRW4br2dXyeq8ohB6S90OWRTpVT5ggO3W1Qn7yr+EUOgVHbFgFxUi
 bqNXXrN52QefdPgIhy/5eE18LzuZJWmIA6CJQr4ufLA2h5eJBuGUyCyfSECSuKxiRnbhgml28x
 KO+aQXlQbP1wtZjIFLBjsrBTk5Y4AoeUQ1ibcpsho3sE23c7LlECtIOMBdMraKrSVzsK7yt/y+
 g7qAMXBm/ysVECwCxqsgRE1R7jH6YCOIAYbYYPGLElF7/4ntC1ZAv5kfvITnRZ+9Ucrnn3KTlm
 D4c=
X-IronPort-AV: E=Sophos;i="5.76,374,1592863200"; 
   d="scan'208";a="13658303"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 31 Aug 2020 09:58:45 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id EDEC7280065;
        Mon, 31 Aug 2020 09:58:44 +0200 (CEST)
Message-ID: <4e1182d756a81e10b32b465bb36938cb62a98cdd.camel@ew.tq-group.com>
Subject: Re: [PATCH mmc-next v3 1/2] dt-bindings: mmc: add alias example
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 31 Aug 2020 09:58:42 +0200
In-Reply-To: <20200828222440.GA3507259@bogus>
References: <20200825134441.17537-1-matthias.schiffer@ew.tq-group.com>
         <20200828222440.GA3507259@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 2020-08-28 at 16:24 -0600, Rob Herring wrote:
> On Tue, Aug 25, 2020 at 03:44:40PM +0200, Matthias Schiffer wrote:
> > As for I2C and SPI, it now is possible to reserve a fixed index for
> > mmc/mmcblk devices.
> > 
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com
> > >
> > ---
> > 
> > v3: new patch
> > 
> >  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 8
> > ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/mmc-
> > controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-
> > controller.yaml
> > index b96da0c7f819..22ed4a36c65d 100644
> > --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> > @@ -367,6 +367,14 @@ examples:
> >      };
> >  
> >    - |
> > +    /*
> > +     * Optionally define an alias to reserve a fixed index for the
> > +     * mmc and mmcblk devices
> > +     */
> > +    aliases {
> > +        mmc0 = &mmc3;
> > +    };
> 
> This will break if we improve schemas because this node is actually 
> /example-1/aliases.
> 
> So please drop. If you want, I'd really like to have a defined set
> (i.e. 
> a schema) of alias names. This would require deleting a bunch on
> some 
> platforms that just made up a bunch of them.

Ulf suggested that I add some kind of documentation about the new mmc
alias support to the binding docs.

As long as we don't have a proper schema for aliases, should I just add
an explanation to the toplevel description of
Documentation/devicetree/bindings/mmc/mmc-controller.yaml, or maybe a
comment?


> 
> > +
> >      mmc3: mmc@1c12000 {
> >          #address-cells = <1>;
> >          #size-cells = <0>;
> > -- 
> > 2.17.1
> > 

