Return-Path: <SRS0=ptsr=4A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9727CC3B186
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Feb 2020 23:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6571021734
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Feb 2020 23:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AemS5zWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgBLXVY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 12 Feb 2020 18:21:24 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36361 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729119AbgBLXVY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Feb 2020 18:21:24 -0500
Received: by mail-vs1-f68.google.com with SMTP id a2so2732319vso.3
        for <linux-mmc@vger.kernel.org>; Wed, 12 Feb 2020 15:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jlwJqZlmg2Pq8Yopr2kegkbYDEQUzThKQ0YhKQN2ALg=;
        b=AemS5zWdhTduXMrNYr/OFdwikKA7Ff5sD01XNEAGdP7TT/DQcFDAED+SNbXyob/w0K
         ppbYsWNy9vNt+ToBU5peypNJ3KldRC/pt3mktLlJpFIMriLdauH5WojsuGRqh9LtlGGR
         3372K7fHo8QKg3X+te3pYd/ul9ZKU3ip1YyDye6F5AIm9mXx+WT0mYPFofW9FAPbV5c/
         HPvDA3GAKHAP4C8xm6uROrPlNFwxZ0tSE7YB7yue6Zj38gyWzpoC9RHZ/DxNfzDylJqc
         fe7KU8ugjP1/Pu9EzW0IpMr5InjEwpIAOmajVOPHoXsdh5irsAYwAWKdg6zE+1e5hfPf
         7qGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jlwJqZlmg2Pq8Yopr2kegkbYDEQUzThKQ0YhKQN2ALg=;
        b=SWChhVQLbFMmOohsxI8ylYjmrbyyZpQgdYNozvD5tuatdH3onW7bcNdZgtjbJpPIdC
         3fK4W+ZVbDYrRAXJvCBMbrxlT3LCeRDlfZ1++nWpWaehKyNAhDUWuU8YHPAbBk1hztev
         b1JzO4G0Q+5eMHbGZZ3hzA6PAm2/HGIPjXso0b3dI27i9FaFcPNYTrFsITETbz6fM39P
         Oaj3ogKACgDnpvh+M13pSZroaI8ff0+3rl7bVeU2J0oTJRKGNX9UOHGk3MgZGinTyLdd
         M4GzXwQFL7ypbou3UMcCJliq4VfXEjwNdDUC6WnsWykMBPQhZVrJppbUqu4RHPo0GZgS
         6E0A==
X-Gm-Message-State: APjAAAU2TCyVS8g1w8A2q3OuKgm+yyLETjAhY7TgqbAQN0FZyY88bn9a
        hkXQN+EDoQpSn+5ZyFfdApTB54AmJMMKCnqq3h3C7w==
X-Google-Smtp-Source: APXvYqwPNT7zmnFi7TS5yBiNSU7K3aVRYzuwT0FE6NfsT0SqwNwrBT2rX0bv333crkAsq9RJICKFtj5NoxsLtQFRozg=
X-Received: by 2002:a67:e342:: with SMTP id s2mr623210vsm.198.1581549682671;
 Wed, 12 Feb 2020 15:21:22 -0800 (PST)
MIME-Version: 1.0
References: <1581434955-11087-1-git-send-email-vbadigan@codeaurora.org>
 <CAD=FV=X6-aWM_fSfLE0ySuM04FvQCTKpM-A87k3xMXBMRzNXFQ@mail.gmail.com> <1e3f8fc3-dde9-5aaf-12a9-0eb0bc5ceb83@codeaurora.org>
In-Reply-To: <1e3f8fc3-dde9-5aaf-12a9-0eb0bc5ceb83@codeaurora.org>
From:   Doug Anderson <dianders@google.com>
Date:   Wed, 12 Feb 2020 15:21:10 -0800
Message-ID: <CAD=FV=XO=xd-BRaXrJ4-L2gaMX6=njV35CSnMV153-DLN8dwvA@mail.gmail.com>
Subject: Re: [PATCH V1] dt-bindings: mmc: sdhci-msm: Add CQE reg map
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>, cang@codeaurora.org,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Wed, Feb 12, 2020 at 4:00 AM Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
>
> On 2/11/2020 10:12 PM, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Feb 11, 2020 at 7:29 AM Veerabhadrarao Badiganti
> > <vbadigan@codeaurora.org> wrote:
> >> CQE feature has been enabled on sdhci-msm. Add CQE reg map
> >> that needs to be supplied for supporting CQE feature.
> >>
> >> Change-Id: I788c4bd5b7cbca16bc1030a410cc5550ed7204e1
> >> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> >> ---
> >>   Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 5 +++++
> >>   1 file changed, 5 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> >> index 7ee639b..eaa0998 100644
> >> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> >> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> >> @@ -27,6 +27,11 @@ Required properties:
> >>   - reg: Base address and length of the register in the following order:
> >>          - Host controller register map (required)
> >>          - SD Core register map (required for msm-v4 and below)
> >> +       - CQE register map (Optional, needed only for eMMC and msm-v4.2 above)
> > I did a quick search and it appears that SD cards implementing 6.0 of
> > the spec can also use CQE.  Is that correct?  If so, maybe remove the
> > part about "eMMC"?
> On qcom platforms, only SDHC instance meant for eMMC has the CQE support.
> So mentioned that its needed only for eMMC.

Ah, got it.  Maybe mention this in the bindings?  Like "Optional, CQE
is only implemented on controllers meant for eMMC and version v4.2 and
above"


> > Maybe also change "needed" to "useful" to make it clear that this
> > entry isn't actually required for all msm-v4.2 controllers?
> sure.
> >
> >> +- reg-names: When CQE register map is supplied, below reg-names are required
> >> +       - "hc_mem" for Host controller register map
> >> +       - "core_mem" for SD cpre regoster map
> > s/regoster/register

Oh, also s/cpre/core


> >> +       - "cqhci_mem" for CQE register map
> > I'm at least slightly confused.  You say that reg-names are there only
> > if CQE register map is supplied.  ...and that requires 4.2 and above.
> > ...but "core_mem" is only there on 4.0 and below.  So there should
> > never be a "core_mem" entry?
> core_mem is present till <v5.0
> cqhci_mem is present on >=v4.2
> Say, for version v4.2 both are present; .... and for v5.0 only cqhci_mem
> is present.
>
> Both hc reg-map and core reg-map are being accessed through index.
> So no need to list the reg names 'hc_mem' & 'core_mem' in general.
>
> But coming to cqhci reg-map we can't access it with fixed index, since
> its index varies between 1/2
> based on controller version.
>
> So we are accessing it through reg-names. Since reg-names has to be
> associated with corresponding
> reg maps, other two reg-names (hc_mem & core_mem) also need to br listed
> when cqhci_mem is listed.
>
> That is the reason, I mentioned it like these are needed only cqe reg
> map is supplied.
> If it is creating confusion, i will remove that statement.

Ah.  I think I got confused!  When I saw "msm-v4 and below" in the
description of "SD Core register map", I assumed that means that
"v4.2" didn't have it.  Maybe would be less confusing to change to:

- SD Core register map (required for controllers earlier than msm-v5)

Then I think what you have can be fine.



> > Trying to specify that sanely in free-form text seems like it's gonna
> > be hard and not worth it.  You should probably transition to yaml
> > first?
> >
> >
> > I will also note that Rob isn't a huge fan of "reg-names".  In a
> > different conversation I think you mentioned you had a reason for
> > having it.  I guess just be prepared to defend yourself against Rob if
> > you feel strongly about keeping reg-names.
> Sure. Its the same reason mentioned in above comment.

OK.  You've convinced me.  It's still up to Rob but it seems like you
have a good justification now that I understand it better..  ;-)

I think you could send out a v2 with the small wording changes and
maybe it would be landable, but you'd want to follow up rather soon
with the yaml conversion.


-Doug
